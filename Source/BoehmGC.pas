﻿namespace RemObjects.Elements.System;

uses gc;

[assembly:DefaultObjectLifetimeStrategy(typeOf(BoehmGC), typeOf(ForeignBoehmGC))]

type
  GC<T> = public lifetimestrategy (BoehmGC) T;
  BoehmGC<T> = public lifetimestrategy (BoehmGC) T;

  DefaultGC = public BoehmGC;

  // Same as boehm gc, but works in foreign object models
  ForeignBoehmGC = public record(ILifetimeStrategy<ForeignBoehmGC>)
  private
    {$HIDE H6} // DO NOT REMOVE!!
    fInst: IntPtr;
    {$SHOW H6} // DO NOT REMOVE!!

    class var fGC: Dictionary<Object, Integer> := new Dictionary<Object, Integer>(new ObjectReferenceComparer<Object>);
    class var fLock: Monitor := new Monitor;
  public
    class method Release(var Dest: ForeignBoehmGC);
    begin
      var lValue := InternalCalls.Exchange(var Dest.fInst, 0);
      Release(lValue);
    end;

    class method Init(var Dest: ForeignBoehmGC);
    begin
      Dest.fInst := 0;
    end;

    class method Copy(var aDest: ForeignBoehmGC; var aSource: ForeignBoehmGC);
    begin
      aDest.fInst := aSource.fInst;
      AddRef(aDest.fInst);
    end;

    class method Assign(var aDest: ForeignBoehmGC; var aSource: ForeignBoehmGC);
    begin
      if (@aDest) = (@aSource) then exit;
      var lSrc := aSource.fInst;
      var lOld := InternalCalls.Exchange(var aDest.fInst, lSrc);
      if lSrc = lOld then exit;
      AddRef(lSrc);
      Release(lOld);
    end;

    constructor;
    begin
      fInst := 0;
    end;

    class method &New(aTTY: ^Void; aSize: IntPtr): ^Void;
    begin
      exit BoehmGC.New(aTTY, aSize);
    end;

    [GCSkipIfOnStack]
    constructor Copy(var aValue: ForeignBoehmGC);
    begin
      fInst := aValue.fInst;
      AddRef(fInst);
    end;

    [GCSkipIfOnStack]
    class operator Assign(var aDest: ForeignBoehmGC; var aSource: ForeignBoehmGC);
    begin
      if (@aDest) = (@aSource) then exit;
      var lSrc := aSource.fInst;
      var lOld := InternalCalls.Exchange(var aDest.fInst, lSrc);
      if lSrc = lOld then exit;
      AddRef(lSrc);
      Release(lOld);
    end;

    [GCSkipIfOnStack]
    finalizer;
    begin
      var lValue := InternalCalls.Exchange(var fInst, 0);
      Release(lValue);
    end;

    class method AddRef(aVal: Object);
    begin
      if aVal = nil then exit;
      locking fLock do begin
        var i:  Integer;
        if fGC.TryGetValue(aVal, out i) then inc(i) else i := 1;
        fGC[aVal] := i;
      end;
    end;

    class method Release(aVal: Object);
    begin
      if aVal = nil then exit;
      locking fLock do begin
        var i:  Integer;
        if fGC.TryGetValue(aVal, out i) then begin
          dec(i);
          if i = 0 then fGC.Remove(aVal) else fGC[aVal] := i;
        end;
      end;
    end;

  end;

  BoehmGC = public record(ILifetimeStrategy<BoehmGC>)
  assembly

    {$HIDE H6} // DO NOT REMOVE!!
    var fInst: IntPtr;
    {$SHOW H6}
    class var fFinalizer: ^Void;
    class var fLoaded: Integer; assembly;
    class var fLocal: Boolean;
    class var fLock: Integer;
    {$IFDEF POSIX}[LinkOnce]{$ENDIF}
    class var fSharedMemory: SharedMemory; assembly;

    {$IFDEF POSIX}[LinkOnce, DllExport]{$ENDIF}
    [SkipDebug]
    class method LocalGC; private;
    begin
      fLocal := true;
      {$IF DARWIN}
      GC_set_pages_executable(0);
      {$ENDIF}
      GC_init;
      GC_allow_register_threads();
      fSharedMemory.collect := @GC_gcollect;
      fSharedMemory.register := @GC_my_register_my_thread;
      fSharedMemory.unregister := @GC_unregister_my_thread;
      fSharedMemory.malloc := @GC_malloc;
      fSharedMemory.setfinalizer := @SetFinalizer;
      fSharedMemory.unsetfinalizer := @UnsetFinalizer;
    end;

    {$IFDEF WINDOWS}class var fMapping: rtl.HANDLE;{$ENDIF}

    [SkipDebug]
    class method LoadGC; assembly;
    begin
      Utilities.SpinLockEnter(var fLock);
      try
        if InternalCalls.CompareExchange(var fLoaded, 1, 0 ) = 1 then begin
          exit;
        end;
        //Utilities.RegisterThreadHandlers(@RegisterThread, @UnregisterThread);
        {$IFDEF WINDOWS}
        var FN: array[0..29] of Char;
        FN[0] := '_';
        FN[1] := '_';
        FN[2] := 'R';
        FN[3] := 'e';
        FN[4] := 'm';
        FN[5] := 'O';
        FN[6] := 'b';
        FN[7] := 'j';
        FN[8] := 'e';
        FN[9] := 'c';
        FN[10] := 't';
        FN[11] := 's';
        FN[12] := 'I';
        FN[13] := 's';
        FN[14] := 'l';
        FN[15] := 'a';
        FN[16] := 'n';
        FN[17] := 'd';
        FN[18] := '2'; // Version, increase when adding stuff or making the class layout incompatible
        var lID := rtl.GetCurrentProcessId;
        FN[19] := Char(Integer('a')+Integer((lID shr 0) and $f));
        FN[20] := Char(Integer('a')+Integer((lID shr 4) and $f));
        FN[21] := Char(Integer('a')+Integer((lID shr 8) and $f));
        FN[22] := Char(Integer('a')+Integer((lID shr 12) and $f));
        FN[23] := Char(Integer('a')+Integer((lID shr 16) and $f));
        FN[24] := Char(Integer('a')+Integer((lID shr 20) and $f));
        FN[25] := Char(Integer('a')+Integer((lID shr 24) and $f));
        FN[26] := Char(Integer('a')+Integer((lID shr 28) and $f));
        FN[27] := 'A'; // boehm
        FN[28] := #0;

        fMapping := rtl.CreateFileMappingW( rtl.INVALID_HANDLE_VALUE, nil, rtl.PAGE_READWRITE, 0, 8, @FN[0]);

        if fMapping = nil then begin
          LocalGC;
          raise new Exception('Cannot create file mapping for memory sharing, this should not happen!');
        end;
        var lNew := rtl.GetLastError <> rtl.ERROR_ALREADY_EXISTS;
        var p: ^NativeInt := ^NativeInt(rtl.MapViewOfFile(fMapping, rtl.FILE_MAP_WRITE, 0, 0, 8));
        if p = nil then begin
          LocalGC;
          raise new Exception('Cannot create file mapping for memory sharing, this should not happen!');
        end;
        if lNew then begin
          LocalGC;
          InternalCalls.VolatileWrite(var p^, NativeInt(@fSharedMemory));
        end else begin
          loop begin
            var lData: ^SharedMemory := ^SharedMemory(InternalCalls.VolatileRead(var p^));
            if lData = nil then Thread.Sleep(1) else begin
              fSharedMemory := lData^;
              break;
            end;
          end;
        end;
        rtl.UnmapViewOfFile(p);
        if not lNew then begin
          rtl.CloseHandle(fMapping);
          fMapping := rtl.INVALID_HANDLE_VALUE;
        end;
        {$ELSE}
        LocalGC;
        {$ENDIF}
        Utilities.RegisterThreadHandlers(@RegisterThread, @UnregisterThread);
      finally
        Utilities.SpinLockExit(var fLock);
      end;
    end;

    class method SetFinalizer(aVal: ^Void);
    begin
      GC_register_finalizer_no_order(aVal, @GC_finalizer, nil, nil, nil);
    end;

    class method UnsetFinalizer(aVal: ^Void);
    begin
      GC_register_finalizer_no_order(aVal, nil, nil, nil, nil);
    end;

    class method SuppressFinalize(o: Object); public;
    begin
      if o = nil then exit;
      fSharedMemory.unsetfinalizer(InternalCalls.Cast(o));
    end;

    class method GC_my_register_my_thread: Integer;
    begin
      {$IFDEF WINDOWS}
      var sb: GC_stack_base;
      GC_get_stack_base(@sb);
      exit GC_register_my_thread(@sb);
      {$ELSE}
      var sb: __struct_GC_stack_base;
      GC_get_stack_base(@sb);
      exit GC_register_my_thread(@sb);
      {$ENDIF}
    end;

  public

    class method Collect(c: Integer);
    begin
      for i: Integer := 0 to c -1 do
        fSharedMemory.collect;
    end;

    [SymbolName('boehmregisterthread')]
    class method RegisterThread;
    begin
      fSharedMemory.register();
    end;

    [SymbolName('boehmunregisterthread')]
    class method UnregisterThread;
    begin
      fSharedMemory.unregister;
    end;

    class method &New(aTTY: ^Void; aSize: NativeInt): ^Void;
    begin
      if fFinalizer = nil then begin
        fFinalizer := ^^Void(InternalCalls.GetTypeInfo<Object>())[Utilities.FinalizerIndex]; // keep in sync with compiler!
      end;
      result := ^Void(-1);
      if fLoaded = 0 then LoadGC;
      result := fSharedMemory.malloc(aSize);
      ^^Void(result)^ := aTTY;
      memset(^Byte(result) + sizeOf(^Void), 0, aSize - sizeOf(^Void));
      if ^^Void(aTTY)[Utilities.FinalizerIndex] <> fFinalizer then begin
        fSharedMemory.setfinalizer(result);
      end;
    end;

    class method Assign(var aDest, aSource: BoehmGC);
    begin
      aDest := aSource;
    end;

    class method Copy(var aDest, aSource: BoehmGC);
    begin
      aDest := aSource;
    end;

    class method Init(var Dest: BoehmGC); empty;
    class method Release(var Dest: BoehmGC); empty;
    class method UnloadGC;
    begin
      if fLocal then begin
        GC_gcollect_and_unmap();
        GC_deinit();
      end;
      Utilities.SpinLockEnter(var fLock);
      try
        {$IFDEF WINDOWS}
        if (fMapping <> nil) and (fMapping <> rtl.INVALID_HANDLE_VALUE) then begin
          rtl.CloseHandle(fMapping);
          fMapping := rtl.INVALID_HANDLE_VALUE;
        end;
        {$ENDIF}
        fLoaded := 0;
        fSharedMemory.collect := nil;
        fSharedMemory.register := nil;
        fSharedMemory.unregister := nil;
        fSharedMemory.malloc := nil;
        fSharedMemory.setfinalizer := nil;
        fSharedMemory.unsetfinalizer := nil;
      finally
        Utilities.SpinLockExit(var fLock);
      end;
    end;
  end;

  BoehmGCExt = public extension class(Utilities)
  public
    class method Collect(c: Integer);
    begin
      BoehmGC.Collect(c);
    end;

    class method SuppressFinalize(c: Object);
    begin
      BoehmGC.SuppressFinalize(c);
    end;
  end;

end.