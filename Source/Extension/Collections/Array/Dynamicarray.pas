namespace RemObjects.Elements.System;

interface

type  
  TMemBlock<T> = private record
    Next: ^TMemBlock<T>;
    Previous: ^TMemBlock<T>;
    Start: TArray<T>;
		operator Equal(this, other: TMemBlock<T>): Boolean;
		operator NotEqual(this, other: TMemBlock<T>): Boolean;
  end;

  DynamicArray<T> = class(Object)
	const
	  FACTOR = 10;
  private	
		fCapacity_lvl: CapacityLevel;
		fIsCapacityLvlSet: Boolean;
    fFirst: ^TMemBlock<T>;
    fCurrent: ^TMemBlock<T>;
    fIndexofNewArray: TIndex;
    fEmpty: Boolean;
    fLength: Capacity;
    fCurrentBlockCapacity: Capacity;
    fTotalCapacity: Capacity;
    fExtraItems: Capacity;
    fInitFactor: Capacity;
    fIsFirstBlock: Boolean;

    method GetBlock(initial: Capacity): ^TMemBlock<T>;
    method LinkEachOther(const &old, &new: ^TMemBlock<T>);
    method Free(var memory_block: ^TMemBlock<T>);
    method ReInitializeFields();
    method ReComputeCapacity(var initial_capa: Capacity);
    method GetDoublyLinkedMemoryBlock(const initial: Capacity): ^TMemBlock<T>;
		method MoveToNextMemoryBlock(var entry: ^TMemBlock<T>; var position: TIndex);
		method IsInsideBorder(const entry: ^TMemBlock<T>; const position: TIndex): Boolean;
		method AssignedPtr(const entry: ^TMemBlock<T>) : Boolean;

  public
    constructor (initialCapacity: Capacity);
		constructor (capacity_lvl: CapacityLevel);

    property &Empty: Boolean 
			read fEmpty;

    property Length: Capacity 
			read fLength;

    property Capacity: Capacity 
			read fTotalCapacity;

    property ExtraItems: Capacity 
			read fExtraItems 
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
operator TMemBlock<T>.Equal(this, other: TMemBlock<T>): Boolean;
begin
	exit
     ((this.Start.Capacity) <> (this.Start.Capacity)) and
	   ((this.Start.Count) <> (this.Start.Count));
end;

operator TMemBlock<T>.NotEqual(this, other: TMemBlock<T>): Boolean;
begin
	 exit(not (this = other));
end;
{OPERATOR OVERLOADING}

{PRIVATE DECLARATION}
method DynamicArray<T>.AssignedPtr(const entry: ^TMemBlock<T>) : Boolean;
begin
	NEXT_BLOCK:;
	var tmp := entry;

	if (tmp<> nil) and (tmp^ <> &default(TMemBlock<T>)) then
	  exit(true)

	else
  begin
		tmp := tmp^.Next;
		goto NEXT_BLOCK;
	end;
end;

method DynamicArray<T>.GetBlock(initial: Capacity): ^TMemBlock<T>;
begin
	var mem_block := new TMemBlock<T>[1];
	mem_block[0].Next := nil;
	mem_block[0].Previous := nil;
	mem_block[0].Start := new TArray<T>(initial);
  exit(@mem_block[0]);
end;

method DynamicArray<T>.LinkEachOther(const &old, &new: ^TMemBlock<T>);
require
	AssignedPtr(&old);
	AssignedPtr(&new);
begin
  &old^.Next := &new;
  &new^.Previous := &old;
end;

method DynamicArray<T>.Free(var memory_block: ^TMemBlock<T>);
begin
  memory_block^.Start := nil;
	memory_block := nil;
end;

method DynamicArray<T>.ReComputeCapacity(var initial_capa: Capacity);
require 
	fInitFactor >= 2;
begin
  if fInitFactor = 0 then
    fInitFactor := 2;

  initial_capa := initial_capa * fInitFactor;
  fInitFactor := (fInitFactor div 2);
end;

method DynamicArray<T>.GetDoublyLinkedMemoryBlock(const initial: Capacity): ^TMemBlock<T>;
begin
	var newBlock := GetBlock(initial);
  LinkEachOther(fCurrent, newBlock);
  exit(newBlock);
end;

method DynamicArray<T>.ReInitializeFields();
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

method DynamicArray<T>.MoveToNextMemoryBlock(var entry: ^TMemBlock<T>; var position: TIndex);
require
	position <= fTotalCapacity;
begin
	NEXT_BLOCK:;		
	begin
		if IsInsideBorder(entry, position) then
		  exit

		else
		begin									
			position := position - entry^.Start.Count;
			entry := entry^.Next;
			GOTO NEXT_BLOCK;				
		end;							
	end;
end;

method DynamicArray<T>.IsInsideBorder(const entry: ^TMemBlock<T>; const position: TIndex): Boolean;
require
	(position <= fTotalCapacity);
	AssignedPtr(entry);
begin
	exit position < entry^.Start.Count;
end;
{PRIVATE DECLARATION}
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
{PUBLIC DECLARATION}
constructor DynamicArray<T>(initialCapacity: Capacity);
begin
  fCurrentBlockCapacity := initialCapacity;
  fTotalCapacity := initialCapacity;
  fInitFactor := FACTOR;
  fFirst := GetBlock(initialCapacity);
  fCurrent := fFirst;
  fEmpty := true;
	fIsFirstBlock := true;	
	fIsCapacityLvlSet := false;
  fLength := 0;
  fIndexofNewArray := 0;
end;

constructor DynamicArray<T>(capacity_lvl: CapacityLevel);
begin
	fIsCapacityLvlSet := true;
	fIsFirstBlock := true;
	fEmpty := True;
  fIndexofNewArray := 0;  
	fLength := 0;
	fCapacity_lvl := capacity_lvl;
  fCurrent := fFirst;
	fFirst := GetBlock(Int32(fCapacity_lvl));
	fInitFactor := Int32(fCapacity_lvl);
end;

method DynamicArray<T>.Write(position: TIndex; value: T);
require	
	assigned(Value);
	AssignedPtr(fFirst);
begin
	var current := fFirst;

  if position < fCurrentBlockCapacity then
  begin
    //Writing to the first-block
    if fIsFirstBlock then
    begin
      fIndexofNewArray := position;
      current^.Start.Write(fIndexofNewArray, value);
      fLength := fLength + 1;
			fEmpty := False;
      exit;
    end

    else
    begin
      //Continue Writing to the new-block, when a new one has been created
      current^.Start.Write(fIndexofNewArray, value);
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
      fCurrentBlockCapacity := current^.Start.Capacity;
      fTotalCapacity := fTotalCapacity + fCurrentBlockCapacity;
      fIsFirstBlock := false;
      self.Write(fIndexofNewArray, value);
    end

    else
    begin
      //---->New block is created!
      fIndexofNewArray := 0;
      current := GetDoublyLinkedMemoryBlock(fExtraItems);
      fCurrentBlockCapacity := current^.Start.Capacity;
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

method DynamicArray<T>.Read(position: TIndex): T;
require 
	position <= fTotalCapacity;
	AssignedPtr(fFirst);
begin
	var curr_block_ptr := fFirst;
	var curr_array_pos := position;

	MoveToNextMemoryBlock(var curr_block_ptr, var curr_array_pos);
	exit curr_block_ptr^.Start.Read(curr_array_pos);
end;

method DynamicArray<T>.Delete(position: TIndex): Boolean;
require 
	(position <= fTotalCapacity);
	AssignedPtr(fFirst);
begin
	var curr_block_ptr := fFirst;
	var curr_array_pos := position;

	MoveToNextMemoryBlock(var curr_block_ptr, var curr_array_pos);
	exit curr_block_ptr^.Start.Delete(curr_array_pos);
end;

method DynamicArray<T>.Insert(const position: TIndex; const value: T);
begin
	raise new NotimplementedException();
end;

finalizer DynamicArray<T>();
begin
	var next, start: ^TMemBlock<T>;
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
