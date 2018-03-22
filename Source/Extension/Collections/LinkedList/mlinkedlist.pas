{$mode objfpc}
{$H+}
unit mLinkedList;

interface

uses
  sysutils;

const
  MAX_ITEMS = High(LongWord);

type
  Bool = Boolean;

  TOrigin = (&Begin, Middle, &End);

  TDirection = (Descending, Ascending);

  TOrder = (Previous, After);

  TMaxCount = 0..MAX_ITEMS;  //0 indicates: [no item found]

  TIndex = TMaxCount;

  TNodePtr = ^TNode;

  TNode = packed record
    Index: TIndex;
    Next: TNodePtr;
    Previous: TNodePtr;
    Value: integer
  end;

  TDoublyLinkedList = class
  strict private
    f_root: TNodePtr;
    f_last: TNodePtr;
    f_count: TMaxCount;

    function CreateNode(input: integer): TNodePtr;
    function CreateEmptyNode(): TNodePtr;

    function GetAbsoluteDifference(index1, index2: TIndex) : TIndex;
    function FindItemAtIndex(wanted_pos: TIndex): integer;
    function FindNodeAtIndex(index: TIndex) : TNodePtr;
    function FindItemAtOrigin(origin: TOrigin; offset: longint = 0): integer;
    function RunFromPositionToSpecificNode(source: TOrigin; destination: TIndex): TNodePtr;
    function GetCentralElement(): TNodePtr;
    procedure ResetIndices(const entry: TNodePtr; direction: TDirection);

    function Insert(const current: TNodePtr; value: integer; order: TOrder) : boolean;

    procedure Delete(var node: TNodePtr);

    procedure RelinkNodeBeforeDeleting(const toDelete: TNodePtr);

    procedure UpdateIndices(const entry_node: TNodePtr; direction: TDirection);

  public
    constructor Init();
    destructor Kill();

    procedure AddToEnd(value: integer);

    procedure AddToBegin(value: integer);

    function Insert(current: integer; new: integer; order: TOrder) : bool;

    function Insert(index: TIndex; new: integer; order: TOrder) : bool;

    function Insert(origin: TOrigin; new: integer; order: TOrder; offset: longint = 0) : bool;

    procedure Remove(value: integer);

    procedure Remove(index: TIndex);

    procedure Remove(origin: TOrigin; offset: TIndex = 0);

    function Contains(index: TIndex) : Bool;

    function Contains(value: integer): Bool;

    procedure Reverse();

    property Item[i: TIndex]: integer read FindItemAtIndex;

    property Element[origin: TOrigin; offset: longint] : integer read FindItemAtOrigin;

    property Count: TMaxCount read f_count;
  end;


implementation

  {PRIVATE IMPLEMENTATION}
  //----------------------------------------------------------------------------//
  function TDoublyLinkedList.CreateNode(input: integer): TNodePtr;
  var
    newNode: TNodePtr;
  begin
    New(newNode);
    newNode^.Value := input;
    newNode^.Next := nil;
    newNode^.Previous := nil;
    exit(newNode);
  end;

  function TDoublyLinkedList.CreateEmptyNode(): TNodePtr;
  begin
    Result := CreateNode(Default(integer));
  end;

  procedure TDoublyLinkedList.Delete(var node: TNodePtr);
  begin
    Dispose(node);
    node^ := Default(TNode);
  end;

  function TDoublyLinkedList.GetAbsoluteDifference(index1, index2: TIndex) : TIndex;
  begin
    if index1 > index2 then
      exit(index1 - index2)

    else
      exit(index2 - index1)
  end;

  function TDoublyLinkedList.GetCentralElement() : TNodePtr;
  var
    middle: TNodePtr;
    tmp_count: TMaxCount;
    mid_count: TMaxCount;
  begin
    middle := f_root;
    mid_count := (f_count div 2);

    for tmp_count := 1 to mid_count do
    begin
      middle := middle^.Next;
    end;

    exit(middle);
  end;

  procedure TDoublyLinkedList.RelinkNodeBeforeDeleting(const toDelete: TNodePtr);
  var
    isLinked: bool;
  begin
    isLinked := false;

    if toDelete = f_root then
    begin
      f_root^.Previous := nil;
      f_root := f_root^.Next;
      isLinked := true;
    end;

    if (toDelete = f_last) and (not isLinked) then
    begin
      f_last := f_last^.Previous;
      f_last^.Next := nil;
      isLinked := true;
    end

    else if not isLinked then
    begin
      toDelete^.Previous^.Next := toDelete^.Next;
      isLinked := true;
    end;
    exit;
  end;

  procedure TDoublyLinkedList.ResetIndices(const entry: TNodePtr; direction: TDirection);
  var
    i: TMaxCount;
    tmp: TNodePtr;
  begin
    tmp := entry;
    if direction = Ascending then
    begin
      for i := 1 to f_count do
      begin
        tmp^.Index := i;
        tmp := tmp^.Next;
      end;
    end;
    if direction = Descending then
    begin
      for i := f_count downto 1 do
      begin
        tmp^.Index := i;
        tmp := tmp^.Previous;
      end;
    end;
  end;

  procedure TDoublyLinkedList.UpdateIndices(const entry_node: TNodePtr; direction: TDirection);
  var run_ptr: TNodePtr;
  begin
    run_ptr := entry_node;
    case direction of
      Descending:
      begin
        while run_ptr^.Next <> nil do
        begin
          Dec(run_ptr^.Index);
          run_ptr := run_ptr^.Next;
        end;
      end;
      Ascending:
      begin
        while run_ptr^.Next <> nil do
        begin
          Inc(run_ptr^.Index);
          run_ptr := run_ptr^.Next;
        end;
      end;
    end;
  end;

  function TDoublyLinkedList.Insert(const current: TNodePtr; value: integer; order: TOrder) : bool;
  var
    new: TNodePtr;
  begin
    if current <> nil then
    begin
      case order of
        Previous:
        begin
          new := CreateNode(value);
          new^.Index := current^.Index;
          current^.Previous^.Next := new;
          new^.Previous := current^.Previous;
          new^.Next := current;
          current^.Previous := new;
          UpdateIndices(current, Ascending);
          f_count += 1;
          exit(true);
        end;
        After:
        begin
          new := CreateNode(value);
          new^.Index := current^.Index;
          current^.Next^.Previous := new;
          new^.Next := current^.Next;
          new^.Previous := current;
          current^.Next := new;
          UpdateIndices(current^.Next, Ascending);
          f_count += 1;
          exit(true);
        end;
      end;
    end;
    exit(false);
  end;

  function TDoublyLinkedList.RunFromPositionToSpecificNode(source: TOrigin; destination: TIndex): TNodePtr;
  var entry_node: TNodePtr = nil;
      state: TDirection;
  begin
    case source of
      &Begin:
      begin
        entry_node := f_root;
        while entry_node <> nil do
        begin
          if entry_node^.Index = destination then
            exit(entry_node)

          else
            entry_node := entry_node^.Next;
        end;
      end;
      Middle:
      begin
        entry_node := GetCentralElement();

        if entry_node^.Index < destination then //check, in which direction the pointer should move
          state := Ascending //right direction

        else
          state := Descending; //left direction

        while entry_node <> nil do
        begin
          if entry_node^.Index = destination then // "node" found
            exit(entry_node)

          else  // if not found, check the direction in which to iterate
          begin
            if state = Descending then
              entry_node := entry_node^.Previous

            else
              entry_node := entry_node^.Next;
          end;
        end;
      end;
      &End:
      begin
        entry_node := f_last;
        while entry_node <> nil do
        begin
          if entry_node^.Index = destination then
            exit(entry_node)

          else
            entry_node := entry_node^.Previous;
        end;
      end;
    end;
    exit(entry_node);
  end;

  function TDoublyLinkedList.FindItemAtOrigin(origin: TOrigin; offset: longint = 0): integer;
  var
    run_ptr: TNodePtr;
  begin
    case origin of
      &Begin:
        begin
          run_ptr := f_root;

          if offset < 0 then
            raise Exception.Create('Item out of range');

          if offset = 0 then
            exit(run_ptr^.Value);

          if offset > 0 then
             run_ptr := RunFromPositionToSpecificNode(&Begin, 1 + offset);
        end;

      Middle:
        begin
          run_ptr := GetCentralElement();

          if offset = 0 then
            exit(run_ptr^.Value);

          if (offset > 0) or (offset < 0) then
            run_ptr := RunFromPositionToSpecificNode(&Middle, run_ptr^.Index + offset);
        end;

      &End:
        begin
          run_ptr := f_last;

          if offset > 0 then
            raise Exception.Create('Item out of range');

          if offset = 0 then //no movement in a direction wanted
            exit(f_last^.Value);

          if (offset < 0) then
             run_ptr := RunFromPositionToSpecificNode(&End, f_last^.Index + offset);
        end;
    end;
    exit(run_ptr^.Value);
  end;

  function TDoublyLinkedList.FindNodeAtIndex(index: TIndex): TNodePtr;
  var
    tmp: TNodePtr = nil;
    mid_count: TMaxCount = 0;
    last_to_index: TIndex = 0;
    root_to_index: TIndex = 0;
    mid_to_index: TIndex = 0;
  begin

    if index > f_count then
      raise Exception.Create('Index out of Range');

    if index = 0 then
      inc(index);

    mid_count := (f_count div 2);
    last_to_index := GetAbsoluteDifference(f_last^.index, index);
    mid_to_index:= GetAbsoluteDifference(mid_count, index);;
    root_to_index := index - 1;

    if root_to_index <= mid_to_index then
    begin
      if root_to_index < last_to_index then
      begin
        tmp := RunFromPositionToSpecificNode(&Begin, index);
        exit(tmp);
      end;

      if last_to_index < mid_to_index then
      begin
        tmp := RunFromPositionToSpecificNode(&End, index);
        exit(tmp);
      end

      else
      begin
        tmp := RunFromPositionToSpecificNode(Middle, index);
        exit(tmp);
      end
    end;

    if mid_to_index < root_to_index then
    begin
      if mid_to_index < last_to_index then
        tmp := RunFromPositionToSpecificNode(Middle, index)

      else
        tmp := RunFromPositionToSpecificNode(&End, index);
    end;
    exit(tmp);
  end;

  function TDoublyLinkedList.FindItemAtIndex(wanted_pos: TIndex): integer;
  var tmp: TNodePtr;
  begin
    tmp := FindNodeAtIndex(wanted_pos);

    if tmp = nil then
      raise Exception.Create('Item not found');

    exit(tmp^.Value);
  end;
  {PRIVATE IMPLEMENTATION}
  //----------------------------------------------------------------------------//


  {PUBLIC IMPLEMENTATION}
  //----------------------------------------------------------------------------//
  constructor TDoublyLinkedList.Init();
  begin
    f_root := CreateEmptyNode();
    f_last := f_root;
    f_root^.Index := 0;
    f_count := 0;
  end;

  procedure TDoublyLinkedList.AddToEnd(value: integer);
  var
    node_before: TNodePtr;
  begin
    f_last^.Next := CreateNode(value);

    node_before:= f_last;
    f_last := f_last^.Next;

    if node_before <> f_last then
      f_last^.Previous := node_before

    else
      f_last^.Previous := nil;

    if f_count = 0 then
      f_root := f_last;

    f_count += 1;
    f_last^.Index := f_count;
    f_last^.Next := nil;
  end;

  procedure TDoublyLinkedList.AddToBegin(value: integer);
  begin
    f_root^.Previous := CreateNode(value);
    f_root^.Previous^.Next := f_root;
    f_root := f_root^.Previous;
    f_count += 1;
    f_root^.Index := f_count;

    if f_count = 1 then
    begin
      f_last := f_root;
      f_root^.Next := nil;
    end
  end;

  function TDoublyLinkedList.Contains(index: TIndex) : bool;
  begin
    if FindNodeAtIndex(index) = nil then
      exit(false)

    else
      exit(true);
  end;

  function TDoublyLinkedList.Contains(value: integer) : bool;
  var
    current: TNodePtr;
  begin
    current := f_root;

    while current <> nil do
    begin
      if current^.Value = value then
        exit(true)

      else
        current := current^.Next;
    end;
    exit(false);
  end;

  function TDoublyLinkedList.Insert(current: integer; new: integer; order: TOrder) : bool;
  var
    tmp: TNodePtr;
  begin
    tmp := f_root;

    while tmp <> nil do
    begin
      if tmp^.Value = current then
        exit(Insert(tmp, new, order))

      else
        tmp := tmp^.Next;
    end;
    exit(false);
  end;

  function TDoublyLinkedList.Insert(origin: TOrigin; new: integer; order: TOrder; offset: longint = 0) : bool;
  var
    current: integer;
  begin
    current := FindItemAtOrigin(origin, offset);
    exit(Insert(current, new, order));
  end;

  function TDoublyLinkedList.Insert(index: TIndex; new: integer; order: TOrder) : bool;
  var
    tmp: TNodePtr;
  begin
    tmp := FindNodeAtIndex(index);
    exit(Insert(tmp, new, order));
  end;

  procedure TDoublyLinkedList.Remove(value: integer);
  var current: TNodePtr;
  begin
    current := f_root;

    while current <> nil do
    begin
      if current^.Value = value then
      begin
        RelinkNodeBeforeDeleting(current);
        Delete(current);
        current := nil;
        f_count -= 1;
        exit;
      end
      else
        current := current^.Next;
    end;
  end;

  procedure TDoublyLinkedList.Remove(origin: TOrigin; offset: TIndex = 0);
  begin
    Remove(FindItemAtOrigin(origin, offset));
    exit;
  end;

  procedure TDoublyLinkedList.Remove(index: TIndex);
  var
    toDelete: TNodePtr;
  begin
    toDelete := FindNodeAtIndex(index);
    RelinkNodeBeforeDeleting(toDelete);
    UpdateIndices(toDelete, Descending);
    Delete(toDelete);
    f_count -= 1;
    exit;
  end;

  procedure TDoublyLinkedList.Reverse();
  var
    i, tmp_count: TMaxCount;
  begin
    {Tausche alle Indizes}
    tmp_count := f_count;

    for i := 1 to tmp_count do
    begin
      f_root^.Index := tmp_count;
      f_last^.Index := i;
      f_root := f_root^.Next;
      f_last:= f_last^.Previous;
      Dec(tmp_count);
    end;
  end;

  destructor TDoublyLinkedList.Kill();
  var
    start, next: TNodePtr;
  begin
    start := f_root;
    while start <> nil do
    begin
      next := start^.Next;
      Delete(start);
      start := next;
    end;
    f_count := 0;
    f_root := nil;
    f_last := nil;
  end;
  //----------------------------------------------------------------------------//
  {PUBLIC IMPLEMENTATION}

end.
