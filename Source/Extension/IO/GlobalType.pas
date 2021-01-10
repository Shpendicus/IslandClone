    namespace RemObjects.Elements.System;

    method fast_memcpy(const dst, src: ^Void; const size: Capacity);
    begin
      const SMALLCHUNK = 128;

      {points to the first 64-byte of a given array}
      var cur_dst64: ^B64 := ^B64(dst); 
      var cur_src64: ^B64 := ^B64(src); 

      var cnt64: Int64 := size div sizeOf(B64);
      var rest64: Int64 := size mod sizeOf(B64);

      COPY_REST:;
      for x: Int64 := (cnt64 - 1) downto 0 do 
        begin
        cur_dst64^ := cur_src64^; 
        cur_dst64 := cur_dst64 + 1;
        cur_src64 := cur_src64 + 1;
      end;  

      if rest64 > SMALLCHUNK then
      begin
        cnt64 := rest64 div sizeOf(B64);
        rest64 := rest64 mod sizeOf(B64);
        goto COPY_REST;
      end

      else
        memcpy(dst, src, rest64);
    end;

    const
      MAX_POS_ALIGNED = 9223372036854775800;

type  
    B64 = array[0..63]of Byte;
	    
    Capacity    =       public 0..MAX_POS_ALIGNED;

    Position    =       public -1..MAX_POS_ALIGNED;
                          
    BinarySize = public record      
    public
      property Size: Capacity; readonly;

      constructor(const amount: Capacity);
      begin
        Size := Capacity(if (amount = 0) then 0 else Math.Pow(2.0, Double(amount)));
      end;
    end;  

    SafeChunkPosition = sealed unit class
    public
      property SafePos: Position;

      constructor(const fixSize: ^Capacity; const startPos: ^Position; const howMuchBytes: ^Capacity);
      begin
        if (howMuchBytes^ > fixSize^) or 
           ((startPos^ + howMuchBytes^) > fixSize^) then
          raise new ArgumentOutOfRangeException('Out of Bounds');
           
        SafePos := fixSize^ - (startPos^ + howMuchBytes^);
      end;
    end;

    PossibleChunkCount = sealed unit class
      property PossibleCapacity: Capacity; readonly;

      constructor(const fixSize: ^Capacity; const safePosPtr: SafeChunkPosition; const howMuchBytes: ^Capacity);
      begin 
        PossibleCapacity := if (fixSize^ > howMuchBytes^){Enough Space}
        then (if (safePosPtr.SafePos + howMuchBytes^) > fixSize^ 
        then (fixSize^ - (safePosPtr.SafePos + howMuchBytes^)) 
      else (safePosPtr.SafePos + howMuchBytes^)) else 0;
      end;
    end;
      
    /// <summary>
    /// Represents the internal buffer of the Chunk
    /// </summary>
    ChunkBuffer = sealed unit class
    unit    
      property Current:        Position; readonly; 
      property Amount:         Capacity; readonly;         
      property Space:          Capacity; readonly;    
      property Data:           array of Byte;  
  
      constructor(space: Capacity; pos: Position; countBytes: Capacity);
      begin                   
        Data := if (space = 0) then nil 
      else new array of Byte(space);

        Space := space;        
      
        var scp := new SafeChunkPosition(@space, @pos, @countBytes);          
        var pc := new PossibleChunkCount(@space, scp, @countBytes); 

        Amount := pc.PossibleCapacity;
        Current := scp.SafePos;
      end;  

      class operator Equal(const a: ChunkBuffer; const b: ChunkBuffer): Boolean;
      begin          
        exit (a.Amount = b.Amount) or (a.Current = b.Current);          
      end;

      class operator NotEqual(const a: ChunkBuffer; const b: ChunkBuffer): Boolean;
      begin
        exit not (a = b);
      end;

      class operator Greater(const a: ChunkBuffer; const b: ChunkBuffer): Boolean;
      begin
        exit a.Amount > b.Amount;
      end;

      class operator Less(const a: ChunkBuffer; const b: ChunkBuffer): Boolean;
      begin
        exit (not (a > b)) and (not (a = b));
      end;

      class operator LessOrEqual(const a: ChunkBuffer; const b: ChunkBuffer): Boolean;
      begin
        exit not (a > b);
      end;    
    
      method IsValid: Boolean;
      begin
        exit Data <> nil;
      end;
    end;
    
    /// <summary>
    /// Represents a <chunk> from a byte-buffer or stream
    /// </summary>     
    ByteChunk = public record   
    private         
      fTotalRead: Capacity;
      fTotalWrite: Capacity;
      fCache: ChunkBuffer;
      
    public
      property RWCycle:           Capacity; readonly;
      property RWUnit:            Capacity  read fCache.Amount;
      property Space:             Capacity  read fCache.Space;
      property Current:           Position  read private write;
      property CacheFullyRead:    Boolean   read (fTotalRead = Space);
      property CacheFullyWritten: Boolean   read (fTotalWrite = Space);

      constructor(const aSpace: Capacity; const start: Position; size: Capacity);
      begin
        fTotalRead := 0;
        fTotalWrite := 0;  
        RWCycle := Capacity(aSpace div size);            
        size := if (size > aSpace) then aSpace else size;
        fCache := new ChunkBuffer(aSpace, start, size);  
        Current := fCache.Current;
      end;

      /// <summary>
      /// /// Deep Copy when assining ByteChunk to ByteChunk
      /// </summary>
      /// <param name="other"></param>
      /// <returns>Returns a deep copy of a bytechunk</returns>
      class operator Implicit(const other: ByteChunk): ByteChunk;
      begin
        var deepCopy := new ByteChunk(other.Space, other.Current, other.RWUnit);
        var src : ^Void;
        other.ReadTo(src);
        deepCopy.Write(src);
        exit deepCopy;
      end;
       
      method Aggregate(const another: ^ByteChunk): ByteChunk;
      require
        (another <> nil) and (not another^.Equals(&default(ByteChunk)));           
        begin      
          var merged := new ByteChunk
          (
            self.Space	 + another^.Space, 
            self.Current + another^.Current,         
            self.RWUnit  + another^.RWUnit
          );
                        
          inc(merged.fTotalRead, (self.fTotalRead + another^.fTotalRead));
          inc(merged.fTotalWrite, (self.fTotalWrite + another^.fTotalWrite));

          if not self.fCache.Data.Length = 0 then
          begin
            {Copys the ENTIRE content of [self] to [merged]} 
            fast_memcpy(@merged.fCache.Data[0], 
            @self.fCache.Data[self.Current], 
            Capacity(self.Space - self.Current));
          end;
             
          if not another^.fCache.Data.Length = 0 then
          begin
            {Copys the ENTIRE content from [another] to [merged] begininng where the [self] memcpy finished}
            fast_memcpy(@merged.fCache.Data[self.fCache.Data.Length], 
            @another^.fCache.Data[0], 
            Capacity(another^.Space));
          end;
        end; 
    
      method UseCacheOf(const newChunkLoc: ^ByteChunk);
      require
        (newChunkLoc <> nil) and (not newChunkLoc^.Equals(&default(ByteChunk)))
        begin
          fCache := nil;
          fCache := newChunkLoc^.fCache; 
        end;

      method UseContentOf(const newChunkLoc: ^ByteChunk);
      begin
        self.fCache.Data := nil;
        self.fCache.Data := newChunkLoc^.fCache.Data;          
      end;
   
      method &Write(const src: ^void);
      require
        src <> nil;
        (fCache.IsValid) and (RWUnit > 0): 'Cannot write to fCache';
        begin                  
          fast_memcpy(@fCache.Data[0], (src + Current), RWUnit);            
          inc(fTotalWrite, RWUnit);
          Current := fCache.Current + fTotalWrite;       
          ensure 
            fCache.Data.Length >= RWUnit;
        end;

      method &ReadTo(dst: ^Void);
      require          
        (fCache.IsValid) AND (RWUnit > 0): 'Cannot read from fCache';
        begin                                           
          fast_memcpy(dst, @fCache.Data[Current], RWUnit);
          inc(fTotalRead, RWUnit);  
          Current := {Initial position}fCache.Current +{Read-count}fTotalRead   
          ensure 
            fCache.Data.Length >= RWUnit;
        end;

    end;

end.
