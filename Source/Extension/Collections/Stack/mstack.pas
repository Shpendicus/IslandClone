unit mStack;

{$mode objfpc}{$H+}

interface

uses
  mLinkedList;

type
  //LIFO
  TStack = class
    strict private
      f_intern_list: TDoublyLinkedList;
      f_empty: boolean;
      f_count: TMaxCount;
      f_top: integer;

    public
      constructor Create();
      destructor Kill();

      procedure Push(value: integer);
      function Pop(): integer;

      property Empty: boolean read f_empty;
      property Top: integer read f_top;
      property Count: TMaxCount read f_count;
  end;

implementation
  constructor TStack.Create();
   begin
    f_intern_list := TDoublyLinkedList.Init();
    f_empty := True;
    f_count := 0;
    f_top := 0
  end;

  procedure TStack.Push(value: integer);
  begin
    f_intern_list.AddToEnd(value);
    f_count += 1;
    f_empty := false;
    f_top := value;
  end;

  function TStack.Pop(): integer;
  begin
    if f_empty then
      exit(-1);

    f_top := f_intern_list.Item[f_count];
    f_intern_list.Remove(f_top);
    f_count -= 1;
    exit(f_top);
  end;

  destructor TStack.Kill();
  begin
    f_intern_list.Kill();
    f_intern_list := nil;
    f_count := 0;
    f_empty := true;
    f_top := -1;
  end;

end.

