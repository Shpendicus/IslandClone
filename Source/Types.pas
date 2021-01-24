﻿namespace RemObjects.Elements.System;

interface

type
  va_list = public record
  public
    {$IF WINDOWS}
    val: ^Void;
    {$ELSEIF AARCH64 and not DARWIN}
    __stack, __gr_top, __vr_top: ^Void;
    __gr_offs, __vr_offs: Integer;
    {$ELSEIF x86_64}
    gp_offset, fp_offset: Integer;
    overflow_arg_area: ^Void;
    reg_save_area: ^Void;
    {$ELSE}
    val: ^Void;
    {$ENDIF}
  end;

  ValueType = public abstract class
  end;

  DummyEnum = class(&Enum)
    public fValue: Int64;
  end;

  &Enum2 = public record(ISoftObject<&Enum>)//(IEquatable<&Enum>, IComparable<&Enum>)
  public
      property EnumSize: Integer
        read self.GetType.SizeOfType;

      {ISoftObject<Enum> implementation aka NO heapallocation?}
      method AsString: String;
      begin
        var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
        var memberName := self.GetType.Constants.FirstOrDefault(a -> a.IsStatic and (a.Value = lSelf.fValue)):Name;
        //result := result.AllocString(1 + memberName.Length + 1 + 1 + lValue.AsString.Length + 1);
        //the result enum shall look like this: (NAME, VALUE) => (A, 23);
        {var pair : tuple of (String, Int64) := (memberName, lSelf.fValue);
        result := pair.ToString();}
        result := memberName;
        //if result = nil then exit lSelf.fValue.AsString;
      end;

      property HashCode: TNumeric
        read begin
          var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
          writeLn("Here the value of the lSelf is: " + lSelf.fValue.AsString);

          case EnumSize of
            1: exit ^Byte(@lSelf.fValue)^;
            2: exit ^Word(@lSelf.fValue)^;
            4: exit ^Int32(@lSelf.fValue)^;
            8: exit ^Int64(@lSelf.fValue)^;
          end;
        end;

    method IsEqual(other: &Enum): Boolean;
    begin
      case EnumSize of
        1: begin
          var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
          var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(other));
          exit ^Byte(@lSelf.fValue)^ = ^Byte(@lOther.fValue)^;
        end;
        2: begin
          var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
          var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(other));
          exit ^Int16(@lSelf.fValue)^ = ^Int16(@lOther.fValue)^;
        end;
        4: begin
          var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
          var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(other));
          exit ^Int32(@lSelf.fValue)^ = ^Int32(@lOther.fValue)^;
        end;
        8: begin
          var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
          var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(other));
          exit lSelf.fValue = lOther.fValue;
        end;
      end;
    end;

    //Object - Code aka Boxing code//
    method ToString: String; override;
    begin
      exit AsString;
    end;

    method &Equals(aOther: Object): Boolean; override;
    begin
      exit (aOther = nil) and not (aOther.GetType = GetType) and IsEqual(&Enum(aOther));
    end;

    method GetHashCode: Integer; override;
    begin
      exit Integer(HashCode);
    end;

    method CompareTo(a: &Enum): Integer;
    begin
      var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
      var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(a));
      exit lSelf.fValue.CompareTo(lOther.fValue);
    end;
  end;

  &Enum = public abstract class(ISoftObject<&Enum>)//(IEquatable<&Enum>, IComparable<&Enum>)
  public
    property EnumSize: Integer
      read self.GetType.SizeOfType;

    {ISoftObject<Enum> implementation aka NO heapallocation?}
    method AsString: String;
    begin
      var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
      var memberName := self.GetType.Constants.FirstOrDefault(a -> a.IsStatic and (a.Value = lSelf.fValue)):Name;
      //result := result.AllocString(1 + memberName.Length + 1 + 1 + lValue.AsString.Length + 1);
      //the result enum shall look like this: (NAME, VALUE) => (A, 23);
      {var pair : tuple of (String, Int64) := (memberName, lSelf.fValue);
      result := pair.ToString();}
      result := memberName;
      //if result = nil then exit lSelf.fValue.AsString;
    end;

    property HashCode: TNumeric
    read begin
      var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
      writeLn("Here the value of the lSelf is: " + lSelf.fValue.AsString);

      case EnumSize of
        1: exit ^Byte(@lSelf.fValue)^;
        2: exit ^Word(@lSelf.fValue)^;
        4: exit ^Int32(@lSelf.fValue)^;
        8: exit ^Int64(@lSelf.fValue)^;
      end;
    end;

    method IsEqual(other: &Enum): Boolean;
    begin
      case EnumSize of
        1: begin
            var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
            var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(other));
            exit ^Byte(@lSelf.fValue)^ = ^Byte(@lOther.fValue)^;
           end;
        2: begin
            var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
            var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(other));
            exit ^Int16(@lSelf.fValue)^ = ^Int16(@lOther.fValue)^;
           end;
        4: begin
            var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
            var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(other));
            exit ^Int32(@lSelf.fValue)^ = ^Int32(@lOther.fValue)^;
           end;
        8: begin
            var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
            var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(other));
            exit lSelf.fValue = lOther.fValue;
           end;
      end;
    end;

   //Object - Code aka Boxing code//
    method ToString: String; override;
    begin
      exit AsString;
    end;

    method &Equals(aOther: Object): Boolean; override;
    begin
      exit (aOther = nil) and not (aOther.GetType = GetType) and IsEqual(&Enum(aOther));
    end;

    method GetHashCode: Integer; override;
    begin
      exit Integer(HashCode);
    end;

    method CompareTo(a: &Enum): Integer;
    begin
      var lSelf := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(self));
      var lOther := InternalCalls.Cast<DummyEnum>(InternalCalls.Cast(a));
      exit lSelf.fValue.CompareTo(lOther.fValue);
    end;
  end;

  Void = public record
  public
    method ToString: String; override; empty; // not callable
    method GetHashCode: Integer; override; empty; // not callable
  end;

  Boolean = public record/*(IEquatable<Boolean>, IComparable, IComparable<Boolean>)*/
  public
    method ToString: String; override;
    method GetHashCode: Integer; override;
    method &Equals(obj: Object): Boolean; override;

    method &Equals(other: Boolean): Boolean;
    begin
      exit self = other;
    end;

    method CompareTo(a: Object): Integer;
    begin
      if a is Boolean then
        exit CompareTo(Boolean(a));
      exit CompareTo(a);
    end;

    method CompareTo(a: Boolean): Integer;
    begin
      if self = a then exit 0;
      if self then exit 1;
      exit -1;
    end;

    method AsString: String;
    begin
      exit TNumeric(self).AsString;
    end;

    method HashCode: Integer;
    begin
      exit 0; //change!
    end;

    operator Implicit(const a: TNumeric): Boolean;
  end;

  Char = public record//(IEquatable<Char>, IComparable, IComparable<Char>)
  public
    method ToString: String; override;
    method GetHashCode: Integer; override;
    method &Equals(obj: Object): Boolean; override;
    class method IsWhiteSpace(aChar: Char): Boolean;
    class method IsNumber(aChar: Char): Boolean;
    method ToLower(aInvariant: Boolean := false): Char;
    method ToUpper(aInvariant: Boolean := false): Char;
    operator &Add(const a, b: Char): Char;
    operator &Subtract(const a, b: Char): Char;

    method &Equals(other: Char): Boolean;
    begin
      exit self = other;
    end;

    method CompareTo(a: Object): Integer;
    begin
      if a is Char then
        exit CompareTo(Char(a));
      exit CompareTo(a);
    end;

    method CompareTo(a: Char): Integer;
    begin
      if self < a then exit -1;
      if self > a then exit 1;
      exit 0;
    end;
  end;

  AnsiChar = public record//(IEquatable<AnsiChar>, IComparable, IComparable<AnsiChar>)
  public
    method ToString: String; override;
    method GetHashCode: Integer; override;
    method &Equals(obj: Object): Boolean; override;
    operator &Add(const a, b: AnsiChar): AnsiChar;
    operator &Subtract(const a, b: AnsiChar): AnsiChar;

    method &Equals(other: AnsiChar): Boolean;
    begin
      exit self = other;
    end;

    method CompareTo(a: Object): Integer;
    begin
      if a is AnsiChar then
        exit CompareTo(AnsiChar(a));
      exit CompareTo(a);
    end;

    method CompareTo(a: AnsiChar): Integer;
    begin
      if self < a then exit -1;
      if self > a then exit 1;
      exit 0;
    end;
  end;

  Debug = public static class
  public
    [Conditional('DEBUG')]
    class method Assert(aCheck: Boolean; aMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber());
    begin
      if not aCheck then
        raise new AssertionException('Assertion failed: '+aMessage+' at '+aFile+'('+aLine+')');
    end;
    class method Throw(s: String);
    begin
      raise new Exception(s);
    end;
  end;

implementation

  method Boolean.ToString: String;
  begin
    exit if self then 'True' else 'False';
  end;

  method Boolean.GetHashCode: Integer;
  begin
    exit if self then 1 else 0;
  end;

  method Boolean.&Equals(obj: Object): Boolean;
  begin
    if assigned(obj) and (obj is Boolean) then
      exit self = Boolean(obj)
    else
      exit False;
  end;

  operator Boolean.Implicit(const a: TNumeric): Boolean;
  begin
    exit Boolean(a);
  end;

  operator Char.&Add(const a, b: Char): Char;
  begin
    exit Char(ord(a) + ord(b));
  end;

  operator Char.&Subtract(const a, b: Char): Char;
  begin
    exit Char(ord(a) - ord(b));
  end;

  method Char.ToString: String;
  begin
    exit String(self);
  end;

  method Char.GetHashCode: Integer;
  begin
    exit Integer(self);
  end;

  method Char.&Equals(obj: Object): Boolean;
  begin
    if assigned(obj) and (obj is Char) then
      exit self = Char(obj)
    else
      exit False;
  end;

  class method Char.IsWhiteSpace(aChar: Char): Boolean;
  begin
    // from https://msdn.microsoft.com/en-us/library/system.Char.iswhitespace%28v=vs.110%29.aspx
    exit Word(aChar) in
          ($0020, $1680, $2000, $2001, $2002, $2003, $2004, $2005, $2006, $2007, $2008, $2009, $200A, $202F, $205F, $3000, //space separators
           $2028, //Line Separator
           $2029, //Paragraph Separator
           $0009, $000A, $000B, $000C, $000D,$0085,$00A0 // other special symbols
          );
  end;

  class method Char.IsNumber(aChar: Char): Boolean;
  begin
    exit aChar in ['0'..'9'];
  end;

  method Char.ToLower(aInvariant: Boolean := false): Char;
  begin
    {$HINT Non-Invariant ToLower is not implemented, yet}
    {$IFDEF WINDOWS}
    var ch: Char := self;
    var temp: NativeInt := ord(ch);
    temp := NativeInt(rtl.CharLower(rtl.LPWSTR(temp)));
    result := chr(temp);
    {$ELSEIF POSIX OR WINDOWS}
    var b := Encoding.UTF32LE.GetBytes(self);
    var ch := b[0] + (Int32(b[1]) shl 8) + (Int32(b[2]) shl 16) + (Int32(b[3]) shl 24);
    var u := rtl.towlower(ch);
    b[0] := u and $ff;
    b[1] := (u shr 8) and $ff;
    b[2] := (u shr 16) and $ff;
    b[3] := (u shr 24) and $ff;
    result := Encoding.UTF32LE.GetString(b)[0];
    {$ELSE}
    var str := String.FromChar(Self).ToLower(aInvariant);
    if length(str) > 0 then exit str.Item[0];
    exit #0;
    {$ENDIF}
  end;

  method Char.ToUpper(aInvariant: Boolean := false): Char;
  begin
    {$HINT Non-Invariant ToUpper is not implemented, yet}
    {$IFDEF WINDOWS}
    var ch: Char := self;
    var temp: NativeInt := ord(ch);
    temp := NativeInt(rtl.CharUpper(rtl.LPWSTR(temp)));
    result := chr(temp);
    {$ELSEIF POSIX OR WINDOWS}
    var b := Encoding.UTF32LE.GetBytes(self);
    var ch := b[0] + (Int32(b[1]) shl 8) + (Int32(b[2]) shl 16) + (Int32(b[3]) shl 24);
    var u := rtl.towupper(ch);
    b[0] := u and $ff;
    b[1] := (u shr 8) and $ff;
    b[2] := (u shr 16) and $ff;
    b[3] := (u shr 24) and $ff;
    result := Encoding.UTF32LE.GetString(b)[0];
    {$ELSE}
    var str := String.FromChar(Self).ToUpper(aInvariant);
    if length(str) > 0 then exit str.Item[0];
    exit #0;
    {$ENDIF}
  end;

  method AnsiChar.ToString: String;
  begin
    exit String(Char(self));
  end;

  operator AnsiChar.&Add(const a, b: AnsiChar): AnsiChar;
  begin
    exit AnsiChar(ord(a) + ord(b));
  end;

  operator AnsiChar.&Subtract(const a, b: AnsiChar): AnsiChar;
  begin
    exit AnsiChar(ord(a) - ord(b));
  end;

  method AnsiChar.GetHashCode: Integer;
  begin
    exit Integer(self);
  end;

  method AnsiChar.&Equals(obj: Object): Boolean;
  begin
    if assigned(obj) and (obj is AnsiChar) then
      exit self = AnsiChar(obj)
    else
      exit False;
  end;
end.