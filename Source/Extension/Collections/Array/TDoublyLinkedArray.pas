namespace OwnDynamicArrayImplementation;

	interface

	uses OwnArrayImplementation, GLOBALS;

	type
		TBlock<T> = record
		public
			Next: ^TBlock<T>;
			Previous: ^TBlock<T>;
			Data: TArray<T>;
			operator Equal(this, other: TBlock<T>): Boolean;
			operator NotEqual(this, other: TBlock<T>): Boolean;
		end;

		TDoublyLinkedArray<T> = public record
		const
			FACTOR = 10;
		private	
			f_ShallGrow: boolean;
			fCapacity_lvl: TCapacityLvl;
			fIsCapacityLvlSet: Boolean;
			fFirst: ^TBlock<T>;
			fCurrent: ^TBlock<T>;
			fIndexofNewArray: TIndex;
			fEmpty: Boolean;
			fLength: TMaxCapacity;
			fCurrentBlockCapacity: TMaxCapacity;
			fTotalCapacity: TMaxCapacity;
			fExtraItems: TMaxCapacity;
			fInitFactor: TMaxCapacity;
			fIsFirstBlock: Boolean;

			method BlockAlloc(const cnt: TMaxCapacity; const shallGrow: Boolean): ^TBlock<T>;
			method LinkEachOther(const &old, &new: ^TBlock<T>);
			method Free(var memory_block: ^TBlock<T>);
			method ReInitializeFields();
			method ReComputeCapacity(var initial_capa: TMaxCapacity);
			method GetDoublyLinkedMemoryBlock(const initial: TMaxCapacity): ^TBlock<T>;
			method PointToNextBlock(var entry: ^TBlock<T>; var position: TIndex);
			method IsInsideBorder(const entry: ^TBlock<T>; const position: TIndex): Boolean;
			method IsCurrentBlockValid(const entry: ^TBlock<T>) : Boolean;

		public
			constructor (const initialCapacity: TMaxCapacity; const shallGrow: Boolean);
			constructor (const capacity_lvl: TCapacityLvl; const shallGrow: Boolean);

			property &Empty: Boolean read fEmpty;

			property Length: TMaxCapacity read fLength;

			property Capacity: TMaxCapacity	read fTotalCapacity;

			property ExtraItems: TMaxCapacity read fExtraItems
																		write fExtraItems;

			method &Write(const position: TIndex; const value: T);		
			method &Read(const position: TIndex): T;

			method Delete(const position: TIndex): Boolean;
			method Insert(const position: TIndex; const value: T);

			finalizer();

			private invariants
				fFirst <> nil;
				fCurrent <> nil;
				fInitFactor >= 2;
				fLength <= fTotalCapacity;
				fIsCapacityLvlSet <> false;
		end;

	implementation
		{OPERATOR OVERLOADING} 
		operator TBlock<T>.Equal(this, other: TBlock<T>): Boolean;
		begin
			exit
				 ((this.Data.Capacity) <> (this.Data.Capacity)) and
				 ((this.Data.Count) <> (this.Data.Count));
		end;

		operator TBlock<T>.NotEqual(this, other: TBlock<T>): Boolean;
		begin
			 exit(not (this = other));
		end;
		{OPERATOR OVERLOADING}

		{PRIVATE DECLARATION}
		method TDoublyLinkedArray<T>.IsCurrentBlockValid(const entry: ^TBlock<T>) : Boolean;
		begin
			exit (entry <> nil) and (entry^ <> &default(TBlock<T>));
		end;

		method TDoublyLinkedArray<T>.BlockAlloc(const cnt: TMaxCapacity; const shallGrow: Boolean): ^TBlock<T>;
		begin
			var mem_block := new TArray<TBlock<T>>(1);
			var first := mem_block.Item[0];
			first.Next := nil;
			first.Previous := nil;
			first.Data := new TArray<T>(cnt);
			exit @first;
		end;

		method TDoublyLinkedArray<T>.LinkEachOther(const &old, &new: ^TBlock<T>);
		require
			IsCurrentBlockValid(&old);
			IsCurrentBlockValid(&new);
		begin
			&old^.Next := &new;
			&new^.Previous := &old;
		end;

		method TDoublyLinkedArray<T>.Free(var memory_block: ^TBlock<T>);
		begin
			//memory_block^.Start := nil;
			memory_block := nil;
		end;

		method TDoublyLinkedArray<T>.ReComputeCapacity(var initial_capa: TMaxCapacity);
		require 
			fInitFactor >= 2;
		begin
			if fInitFactor = 0 then
				fInitFactor := 2;

			initial_capa := initial_capa * fInitFactor;
			fInitFactor := (fInitFactor div 2);
		end;

		method TDoublyLinkedArray<T>.GetDoublyLinkedMemoryBlock(const initial: TMaxCapacity): ^TBlock<T>;
		begin
			var next := BlockAlloc(initial, f_ShallGrow);
			LinkEachOther(fCurrent, next);
			exit next;
		end;

		method TDoublyLinkedArray<T>.ReInitializeFields();
		begin
			fFirst := nil;
			fCurrent := nil;
			fEmpty := true;
			fLength := 0;
			fExtraItems := 0;
			fTotalCapacity := 0;
			fIsFirstBlock := true;
			fInitFactor := FACTOR;
			fIndexofNewArray := 0;
			fCurrentBlockCapacity := 0;
		end;

		method TDoublyLinkedArray<T>.PointToNextBlock(var entry: ^TBlock<T>; var position: TIndex);
		require
			position <= fTotalCapacity: 'Out of Bounds';
		begin
			NEXT_BLOCK:;		
			begin
				if IsInsideBorder(entry, position) then
					exit

				else
				begin									
					position := position - entry^.Data.Count;
					entry := entry^.Next;
					GOTO NEXT_BLOCK;				
				end;							
			end;
		end;

		method TDoublyLinkedArray<T>.IsInsideBorder(const entry: ^TBlock<T>; const position: TIndex): Boolean;
		require
			(position <= fTotalCapacity): 'Out of Bounds';
			IsCurrentBlockValid(entry + position);
		begin
			exit position < entry^.Data.Count;
		end;
		{PRIVATE DECLARATION}
		//------------------------------------------------------------------------------


		//------------------------------------------------------------------------------
		{PUBLIC DECLARATION}
		constructor TDoublyLinkedArray<T>(const initialCapacity: TMaxCapacity; const shallGrow: Boolean);
		begin
			fCurrentBlockCapacity := initialCapacity;
			fTotalCapacity := initialCapacity;
			fInitFactor := FACTOR;
			fFirst := BlockAlloc(initialCapacity, shallGrow);
			fCurrent := fFirst;
			fEmpty := true;
			fIsFirstBlock := true;	
			fIsCapacityLvlSet := false;
			fLength := 0;
			fIndexofNewArray := 0;
		end;

		constructor TDoublyLinkedArray<T>(const capacity_lvl: TCapacityLvl; const shallGrow: Boolean);
		begin
			fIsCapacityLvlSet := true;
			fIsFirstBlock := true;
			fEmpty := True;
			fIndexofNewArray := 0;  
			fLength := 0;
			fCapacity_lvl := capacity_lvl;
			fCurrent := fFirst;
			fFirst := BlockAlloc(Int32(fCapacity_lvl), f_ShallGrow);
			fInitFactor := Int32(fCapacity_lvl);
		end;

		method TDoublyLinkedArray<T>.Write(const position: TIndex; const value: T);
		require	
			assigned(Value);
			IsCurrentBlockValid(fFirst);
		begin
			var current := fFirst;

			if position < fCurrentBlockCapacity then
			begin
				//Writing to the first-block
				if fIsFirstBlock then
				begin
					fIndexofNewArray := position;
					current^.Data.Write(fIndexofNewArray, value);
					fLength := fLength + 1;
					fEmpty := False;
					exit;
				end

				else
				begin
					//Continue Writing to the new-block, when a new one has been created
					current^.Data.Write(fIndexofNewArray, value);
					fIndexofNewArray := fIndexofNewArray + 1;
					fLength := fLength + 1;
					fEmpty := False;
					exit;
				end;
			end

			else
			begin
				if fExtraItems = 0 then
				begin
					//---->New block is created!
					fIndexofNewArray := 0;

					if fIsCapacityLvlSet then
						fCurrentBlockCapacity := Int64(fCapacity_lvl)

					else				
      			ReComputeCapacity(var fCurrentBlockCapacity);

					current := GetDoublyLinkedMemoryBlock(fCurrentBlockCapacity);
					fCurrentBlockCapacity := current^.Data.Capacity;
					fTotalCapacity := fTotalCapacity + fCurrentBlockCapacity;
					fIsFirstBlock := false;
					self.Write(fIndexofNewArray, value);
				end

				else
				begin
					//---->New block is created!
					fIndexofNewArray := 0;
					current := GetDoublyLinkedMemoryBlock(fExtraItems);
					fCurrentBlockCapacity := current^.Data.Capacity;
					fTotalCapacity := fTotalCapacity + fCurrentBlockCapacity;
					fIsFirstBlock := false;
					self.Write(fIndexofNewArray, value);
				end;
			end;

			if fLength < position then
			begin
				self.Write(fLength + 1, value);
			end;
		end;

		method TDoublyLinkedArray<T>.Read(const position: TIndex): T;
		require 
			position <= fTotalCapacity;
			IsCurrentBlockValid(fFirst);
		begin
			var curr_block_ptr := fFirst;
			var curr_array_pos := position;

			PointToNextBlock(var curr_block_ptr, var curr_array_pos);
			exit curr_block_ptr^.Data.Read(curr_array_pos);
		end;

		method TDoublyLinkedArray<T>.Delete(const position: TIndex): Boolean;
		require 
			(position <= fTotalCapacity);
			IsCurrentBlockValid(fFirst);
		begin
			var curr_block_ptr := fFirst;
			var curr_array_pos := position;

			PointToNextBlock(var curr_block_ptr, var curr_array_pos);
			exit curr_block_ptr^.Data.Delete(curr_array_pos);
		end;

		method TDoublyLinkedArray<T>.Insert(const position: TIndex; const value: T);
		begin
			raise new NotimplementedException();
		end;

		finalizer TDoublyLinkedArray<T>();
		begin
			var next, start: ^TBlock<T>;
			start := fFirst;

			while start <> nil do
			begin
				next := start^.Next;
				Free(var start);
				start := next;
			end;
			ReInitializeFields(); 
		end;
		{PUBLIC DECLARATION}
end.
