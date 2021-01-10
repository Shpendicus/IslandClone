namespace OwnArrayImplementation;

	interface

	uses GLOBALS, CRUNTIME;

	type				
		TBlock<T> = private packed tuple of (Value: T, 
																				 DeletedAt: TIndex, SwapedAt: TIndex, 
																				 Origin: tuple of(TIndex, T));	

		TArray<T> = public record(IDisposable)	 		  
		private
			DEF_T := &default(T); readonly;
			DEF_TBLOCK := &default(TBlock<T>); readonly;

			fCount: TMaxCapacity := 0;
			f_currentCapacity: TMaxCapacity := 10;
			f_first: ^TBlock<T>; 			
			method IsDeletedAt(const position: TIndex): Boolean;
			method IsCurrentBlockValid(const entry: ^TBlock<T>) : Boolean;
			
		public
			constructor(const cnt: TMaxCapacity);
			finalizer;

			property Count: TMaxCapacity read fCount;
			property Capacity: TMaxCapacity	read f_currentCapacity;
			property Item[const value: TIndex]: T read &Read write &Write;

			//STANDARD-METHODS
			method &Read(const position: TIndex): T;
			method &Write(const position: TIndex; const Value: T);
			method Dispose;

			//EXTRA-METHODS
			method Swap(const position1, position2: TIndex);
			method Delete(const position: TIndex): Boolean;
			method ResetAllChanges;
  						
			private invariants
				f_first <> nil;
				fCount <= f_currentCapacity;
			
		end;

	implementation		
	{--------------------------------PRIVATE METHODS------------------------------------------------}
	method TArray<T>.IsCurrentBlockValid(const entry: ^TBlock<T>) : Boolean;
	begin
		exit (entry <> nil) and (entry^ <> DEF_T);
	end;

	method TArray<T>.IsDeletedAt(const position: TIndex): Boolean;
	require
		0 <= position <= fCount: 'Out of Bounds';
		IsCurrentBlockValid((f_first + position));
	begin
		exit ((f_first + position)^.DeletedAt > -1);
	end;

	{--------------------------------PRIVATE METHODS------------------------------------------------}
	

	{--------------------------------PUBLIC METHODS------------------------------------------------}
	constructor TArray<T>(const cnt: TMaxCapacity);
	require
	  cnt > 0;
	begin		
		f_first := ^TBlock<T>(malloc(sizeOf(TBlock<T>) * cnt));
		f_currentCapacity := cnt;
	end;

	method TArray<T>.Write(const position: TIndex; const value: T);
	require
		0 <= position <= f_currentCapacity: position.ToString + ' is out of Bounds';
		IsCurrentBlockValid((f_first + position));
		not IsDeletedAt(position);
	begin
		(f_first + position)^ := (value, -1, -1, (position, Value));
		fCount := fCount + 1;
	end;

	method TArray<T>.Read(const position: TIndex): T;
	require
		0 <= position <= f_currentCapacity: position.ToString + ' is out of Bounds';
		IsCurrentBlockValid((f_first + position));
		not IsDeletedAt(position);
	begin
		exit((f_first + position)^.Value);
	end;

	method TArray<T>.Swap(const position1, position2: TIndex);
	require
		0 <= position1 <= f_currentCapacity: 'Out of Bounds'; 
		0 <= position2 <= f_currentCapacity: 'Out of Bounds'; 

		IsCurrentBlockValid((f_first + position1)): 'Invalid Item Access';
		IsCurrentBlockValid((f_first + position2)): 'Invalid Item Access';

		not IsDeletedAt(position1): 'Access on deleted item is impossible';
		not IsDeletedAt(position2): 'Access on deleted item is impossible';
	begin
		var (firstBlock, secondBlock) := ((f_first + position1), (f_first + position2));		
		firstBlock^ := (secondBlock^.Value, -1, position2, (position1, firstBlock^.Value));
		secondBlock^ := (firstBlock^.Value, -1, position1, (position2, secondBlock^.Value));
	end;

	method TArray<T>.Delete(const position: TIndex): Boolean;
	require
		0 <= position <= f_currentCapacity: 'Out of Bounds';
		IsCurrentBlockValid((f_first + position)) : 'Access Violation';
		not IsDeletedAt(position): 'Access on deleted items is not allowed'; 
	begin		
		(f_first + position)^ := (DEF_T, position, -1, (position, (f_first + position)^.Value));
		result := true;
	end;

	method TArray<T>.ResetAllChanges();
	begin		
		var start, current_block: ^TBlock<T>;
		start := f_first;
		current_block := nil;
  
		//loop through the array 
		for curr_pos: TMaxCapacity := 0 to (fCount - 1) do
		begin
			current_block := (start + curr_pos);	
				
			if (IsCurrentBlockValid(current_block)) and	(not IsDeletedAt(curr_pos)) then
			begin
				//"> -1" indicates that "current" has been swaped
				if current_block.SwapedAt > -1 then 
				begin
					//reswap the both elements with each other
					self.Swap(current_block.Origin.Item1, current_block.SwapedAt);
				end;  

				//"DeletedAt > -1" marks: the "old inserted value" now is being replaced with the previous value
				if current_block.DeletedAt > -1 then
				begin
					var oldDeletedValue: T := current_block.Origin.Item2;
					current_block^ := (oldDeletedValue, -1, -1, (current_block.DeletedAt, oldDeletedValue));
				end;	
			end;			
		end;
	end;

	method TArray<T>.Dispose;
	begin
		fCount := 0;
		f_currentCapacity := 10;
		free(f_first);
	end;

	finalizer TArray<T>;
	begin
		Dispose;
	end;
{--------------------------------PUBLIC METHODS------------------------------------------------}
end.
