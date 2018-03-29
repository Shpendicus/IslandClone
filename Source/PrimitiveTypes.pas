namespace RemObjects.Elements.System;

  type
    INumber = public interface
      {$REGION Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        method &Subtract(const a: INumber): INumber;
        method &Multiply(const a: INumber): INumber;
        method &Divide(const a: INumber): INumber;

        class operator Add(const a, b: INumber): INumber; inline;
        begin
          exit a.&Add(b);
        end;

        class operator Subtract(const a, b: INumber): INumber; inline;
        begin
          exit a.&Subtract(b);
        end;

        class operator Multiply(const a, b: INumber): INumber; inline;
        begin
          exit a.&Multiply(b);
        end;

        class operator Divide(const a, b: INumber): INumber; inline;
        begin
          exit a.&Divide(b);
        end;
        {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      method &LessOrEqual(const a: INumber): Boolean;

      class operator Less(const a, b: INumber): Boolean; inline;
      begin
        exit a.&Less(b);
      end;

      class operator LessOrEqual(const a, b: INumber): Boolean; inline;
      begin
        exit a.&LessOrEqual(b);
      end;

      {$ENDREGION}
    end;

//    IIntegerNumber = public interface(INumber)
//    end;

    ValueType = public abstract class
    end;

    &Enum = public abstract class
    end;

    Void = public record
    end;

    IntegerExtension = public extension record(Integer, INumber)
      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + Integer(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - Integer(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * Integer(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          Integer(a) <> 0;
        begin
          exit INumber(Double(self / Integer(a)));
        end;

        class operator Implicit(const a: INumber): Integer;
        begin
          exit Integer(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp := Integer(a);
        exit tmp < self;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp := Integer(a);
        exit tmp <= self;
      end;
      {$ENDREGION}
    end;

    Boolean = public record(IEquatable<Boolean>, IComparable<Boolean>)
    public
      method ToString: String; override;
      begin
        exit if self then 'True' else 'False';
      end;

      method GetHashCode: Integer; override;
      begin
        exit
          if self then 1 else 0;
      end;

      method &Equals(other: Boolean): boolean;
      begin
        result :=
          if self then
            true
          else
            false;

      end;

      method CompareTo(const a: Boolean): Integer;
      begin
        result := 1;

        result := if self = a then 0
                  else if self = false then -1;
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is Boolean) then
          exit self = Boolean(obj)
        else
          exit False;
      end;
    end;

    Char = public record(INumber, IComparable<Char>, IEquatable<Char>)
    public
      method ToString: String; override;
      begin
        exit String(self);
      end;

      method GetHashCode: Integer; override;
      begin
        exit ord(self);
      end;

      method &Equals(const other: Char): boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: Char): Integer;
      begin
        result := ord(self) - ord(a);
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is Char) then
          exit self = Char(obj)
        else
          exit False;
      end;

      class method IsWhiteSpace(aChar: Char): Boolean; override;
      begin
        // from https://msdn.microsoft.com/en-us/library/system.Char.iswhitespace%28v=vs.110%29.aspx
        exit Word(aChar) in
              ($0020, $1680, $2000, $2001, $2002, $2003, $2004, $2005, $2006, $2007, $2008, $2009, $200A, $202F, $205F, $3000, //space separators
               $2028, //Line Separator
               $2029, //Paragraph Separator
               $0009, $000A, $000B, $000C, $000D,$0085,$00A0 // other special symbols
              );
      end;

      class method IsNumber(aChar: Char): Boolean; override;
      begin
        exit aChar in ['0'..'9'];
      end;

      method ToLower(aInvariant: Boolean := false): Char;
      begin
        {$HINT Non-Invariant ToLower is not implemented, yet}
        {$IFDEF WINDOWS}
        var ch: Char := self;
        var temp: NativeInt := ord(ch);
        temp := NativeInt(rtl.CharLower(rtl.LPWSTR(temp)));
        result := chr(temp);
        {$ELSEIF POSIX OR WINDOWS}
        var b := TextConvert.StringToUTF32LE(self);
        var ch := b[0] + (Int32(b[1]) shl 8) + (Int32(b[2]) shl 16) + (Int32(b[3]) shl 24);
        var u := rtl.towlower(ch);
        b[0] := u and $ff;
        b[1] := (u shr 8) and $ff;
        b[2] := (u shr 16) and $ff;
        b[3] := (u shr 24) and $ff;
        result := TextConvert.UTF32LEToString(b)[0];
        {$ELSE}
        var str := String.FromChar(Self).ToLower(aInvariant);
        if length(str) > 0 then exit str.Item[0];
        exit #0;
        {$ENDIF}
      end;

      method ToUpper(aInvariant: Boolean := false): Char;
      begin
        {$HINT Non-Invariant ToUpper is not implemented, yet}
        {$IFDEF WINDOWS}
        var ch: Char := self;
        var temp: NativeInt := ord(ch);
        temp := NativeInt(rtl.CharUpper(rtl.LPWSTR(temp)));
        result := chr(temp);
        {$ELSEIF POSIX OR WINDOWS}
        var b := TextConvert.StringToUTF32LE(self);
        var ch := b[0] + (Int32(b[1]) shl 8) + (Int32(b[2]) shl 16) + (Int32(b[3]) shl 24);
        var u := rtl.towupper(ch);
        b[0] := u and $ff;
        b[1] := (u shr 8) and $ff;
        b[2] := (u shr 16) and $ff;
        b[3] := (u shr 24) and $ff;
        result := TextConvert.UTF32LEToString(b)[0];
        {$ELSE}
        var str := String.FromChar(Self).ToUpper(aInvariant);
        if length(str) > 0 then exit str.Item[0];
        exit #0;
        {$ENDIF}
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          var charCode1: Integer := ord(self);
          var charCode2: Integer := ord(Char(a));
          var codeResult := Char(charCode1 + charCode2);
          exit INumber(codeResult);
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          var charCode1: Integer := ord(self);
          var charCode2: Integer := ord(Char(a));
          var codeResult := Char(charCode1 - charCode2);
          exit INumber(codeResult);
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          var charCode1: Integer := ord(self);
          var charCode2: Integer := ord(Char(a));
          var codeResult := Char(charCode1 * charCode2);
          exit INumber(codeResult);
        end;

        method &Divide(const a: INumber): INumber;
        require
          ord(Char(a)) <> 0;
        begin
          var charCode1: Integer := ord(self);
          var charCode2: Integer := ord(Char(a));
          var codeResult := Char(charCode1 div charCode2);
          exit INumber(codeResult);
        end;

        class operator Implicit(const a: INumber): Char;
        begin
          exit Char(a);
        end;

        class operator Implicit(const a: Integer): Char;
        begin
          exit Char(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := ord(self);
        var tmp2 := ord(Char(a));
        exit tmp1 < tmp2;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp1 := ord(self);
        var tmp2 := ord(Char(a));
        exit tmp1 <= tmp2;
      end;
      {$ENDREGION}

    end;

    AnsiChar = public record(INumber, IComparable<AnsiChar>, IEquatable<AnsiChar>)
    public
      method ToString: String; override;
      begin
        exit String(self);
      end;

      method GetHashCode: Integer; override;
      begin
        exit Integer(self);
      end;

      method &Equals(const other: AnsiChar): boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: AnsiChar): Integer;
      begin
        result := ord(self) - ord(a);
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is AnsiChar) then
          exit self = AnsiChar(obj)
        else
          exit False;
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          var charCode1: Integer := ord(self);
          var charCode2: Integer := ord(AnsiChar(a));
          var charCodeResult := AnsiChar(charCode1 + charCode2);
          exit INumber(charCodeResult);
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          var charCode1: Integer := ord(self);
          var charCode2: Integer := ord(AnsiChar(a));
          var charCodeResult := AnsiChar(charCode1 - charCode2);
          exit INumber(charCodeResult);
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          var charCode1: Integer := ord(self);
          var charCode2: Integer := ord(AnsiChar(a));
          var charCodeResult := AnsiChar(charCode1 * charCode2);
          exit INumber(charCodeResult);
        end;

        method &Divide(const a: INumber): INumber;
        require
          ord(AnsiChar(a)) <> 0;
        begin
          var charCode1: Integer := ord(self);
          var charCode2: Integer := ord(AnsiChar(a));
          var charCodeResult := AnsiChar(charCode1 div charCode2);
          exit INumber(charCodeResult);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := ord(self);
        var tmp2 := ord(AnsiChar(a));
        exit tmp1 < tmp2;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp1 := ord(self);
        var tmp2 := ord(AnsiChar(a));
        exit tmp1 <= tmp2;
      end;
      {$ENDREGION}
  end;

    SByte = public record(INumber, IComparable<SByte>, IEquatable<SByte>)
    private
      class method DoTryParse(s: String; out Value: SByte; aRaiseOverflowException: Boolean):Boolean;
      begin
        var sValue : Int64;
        if not Convert.TryParseInt64(s,out sValue, aRaiseOverflowException) then exit False;
        if sValue >= 0 then begin
          if sValue > MaxValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end
        else begin
          if sValue < MinValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end;
        Value := sValue;
        exit True;
      end;

    public
      const MinValue: SByte = $80;
      const MaxValue: SByte = $7f;

      method ToString: String; override;
      begin
        exit Int64(self).ToString;
      end;

      method GetHashCode: Integer; override;
      begin
        exit self;
      end;

      method &Equals(const other: SByte): Boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: SByte): Integer;
      begin
        result := self - a;
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is SByte) then
          exit self = SByte(obj)
        else
          exit False;
      end;

      class method Parse(s: String): SByte;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: SByte):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + SByte(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - SByte(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * SByte(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          SByte(a) <> 0;
        begin
          exit INumber(Double(self / SByte(a)));
        end;

        class operator Implicit(const a: INumber): SByte;
        begin
          exit SByte(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := SByte(self);
        var tmp2 := SByte(a);
        exit tmp1 < tmp2;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp1 := SByte(self);
        var tmp2 := SByte(a);
        exit tmp1 <= tmp2;
      end;
      {$ENDREGION}
    end;

    Byte = public record(INumber, IComparable<Byte>, IEquatable<Byte>)
    private
      class method DoTryParse(s: String; out Value: Byte; aRaiseOverflowException: Boolean):Boolean;
      begin
        var sValue: UInt64;
        if not Convert.TryParseUInt64(s,out sValue, aRaiseOverflowException) then exit False;
        if sValue > MaxValue then
          if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        Value := sValue;
        exit True;
      end;
    public
      method ToString: String; override;
      begin
        exit UInt64(self).ToString;
      end;

      method GetHashCode: Integer; override;
      begin
        exit self;
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is Byte) then
          exit self = Byte(obj)
        else
          exit False;
      end;

      method &Equals(const other: Byte): Boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: Byte): Integer;
      begin
        result := (self - a);
      end;

      class method Parse(s: String): Byte;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: Byte):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + Byte(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - Byte(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * Byte(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          Byte(a) <> 0;
        begin
          exit INumber(Double(self / Byte(a)));
        end;

        class operator Implicit(const a: INumber): Byte;
        begin
          exit Byte(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := Byte(self);
        var tmp2 := Byte(a);
        exit tmp1 < tmp2;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp1 := Byte(self);
        var tmp2 := Byte(a);
        exit tmp1 <= tmp2;
      end;
      {$ENDREGION}

      const MinValue: Byte = $0;
      const MaxValue: Byte = $ff;
    end;

    Int16 = public record(INumber, IComparable<Int16>, IEquatable<Int16>)
    private
      class method DoTryParse(s: String; out Value: Int16; aRaiseOverflowException: Boolean):Boolean;
      begin
        var sValue : Int64;
        if not Convert.TryParseInt64(s,out sValue, aRaiseOverflowException) then exit False;
        if sValue >= 0 then begin
          if sValue > MaxValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end
        else begin
          if sValue < MinValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end;
        Value := sValue;
        exit True;
      end;
    public
      method ToString: String; override;
      begin
        exit Int64(self).ToString;
      end;

      method GetHashCode: Integer; override;
      begin
        exit self;
      end;

      method &Equals(const other: Int16): boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: Int16): Integer;
      begin
        result := (self - a);
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is Int16) then
          exit self = Int16(obj)
        else
          exit False;
      end;

      class method Parse(s: String): Int16;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: Int16):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + Int16(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - Int16(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * Int16(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          Int16(a) <> 0;
        begin
          exit INumber(Double(self / Int16(a)));
        end;

        class operator Implicit(const a: INumber): Int16;
        begin
          exit Int16(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := Int16(self);
        var tmp2 := Int16(a);
        exit tmp1 < tmp2;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp1 := Int16(self);
        var tmp2 := Int16(a);
        exit tmp1 < tmp2;
      end;
      {$ENDREGION}

      const MinValue: Int16 = $8000;
      const MaxValue: Int16 = $7fff;
    end;

    UInt16 = public record(INumber, IComparable<UInt16>, IEquatable<UInt16>)
    private
      class method DoTryParse(s: String; out Value: UInt16; aRaiseOverflowException: Boolean):Boolean;
      begin
        var sValue: UInt64;
        if not Convert.TryParseUInt64(s,out sValue, aRaiseOverflowException) then exit False;
        if sValue > MaxValue then
          if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        Value := sValue;
        exit True;
      end;
    public
      method ToString: String; override;
      begin
        exit UInt64(self).ToString;
      end;

      method GetHashCode: Integer; override;
      begin
        exit self;
      end;

      method &Equals(const other: UInt16): Boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: UInt16): Integer;
      begin
        result := (Integer(self) - Integer(a));
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is UInt16) then
          exit self = UInt16(obj)
        else
          exit False;
      end;

      class method Parse(s: String): UInt16;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: UInt16):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + Int16(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - UInt16(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * UInt16(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          UInt16(a) <> 0;
        begin
          exit INumber(Double(self / UInt16(a)));
        end;

        class operator Implicit(const a: INumber): UInt16;
        begin
          exit UInt16(a);
        end;

      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := UInt16(self);
        var tmp2 := UInt16(a);
        exit tmp1 < tmp2;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp1 := UInt16(self);
        var tmp2 := UInt16(a);
        exit tmp1 < tmp2;
      end;
      {$ENDREGION}

      const MinValue: UInt16 = $0;
      const MaxValue: UInt16 = $ffff;
    end;

    Int32 = public record(INumber, IComparable<Int32>, IEquatable<Int32>)
    private
      class method DoTryParse(s: String; out Value: Int32; aRaiseOverflowException: Boolean):Boolean;
      begin
        var sValue : Int64;
        if not Convert.TryParseInt64(s,out sValue, aRaiseOverflowException) then exit False;
        if sValue >= 0 then begin
          if sValue > MaxValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end
        else begin
          if sValue < MinValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end;
        Value := sValue;
        exit True;
      end;
    public
      method ToString: String; override;
      begin
        exit Int64(self).ToString;
      end;

      method GetHashCode: Integer; override;
      begin
        exit self;
      end;

      method &Equals(const other: Int32): Boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: Int32): Integer;
      begin
        result := 0;

        if self < a then
         result := -1
        else if (a > self) then
          result := 1;
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is Int32) then
          exit self = Int32(obj)
        else
          exit False;
      end;

      class method Parse(s: String): Int32;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: Int32):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + Int32(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - Int32(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * Int32(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          Int32(a) <> 0;
        begin
          exit INumber(Double(self / Int32(a)));
        end;

        class operator Implicit(const a: INumber): Int32;
        begin
          exit Int32(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := Int32(self);
        var tmp2 := Int32(a);
        exit tmp1 < tmp2;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp1 := Int32(self);
        var tmp2 := Int32(a);
        exit tmp1 < tmp2;
      end;
      {$ENDREGION}

      const MinValue: Int32 = $80000000;
      const MaxValue: Int32 = $7fffffff;
    end;

    UInt32 = public record(INumber, IEquatable<UInt32>, IComparable<UInt32>)
    private
      class method DoTryParse(s: String; out Value: UInt32; aRaiseOverflowException: Boolean):Boolean;
      begin
        var sValue: UInt64;
        if not Convert.TryParseUInt64(s,out sValue, aRaiseOverflowException) then exit False;
        if sValue > MaxValue then
          if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        Value := sValue;
        exit True;
      end;
    public
      method ToString: String; override;
      begin
        exit UInt64(self).ToString;
      end;

      method GetHashCode: Integer; override;
      begin
        exit self;
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is UInt32) then
          exit self = UInt32(obj)
        else
          exit False;
      end;

      method &Equals(const other: UInt32): Boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: UInt32): Integer;
      begin
        result := 0;

        result := if (self < a) then -1
                  else if (self > a) then 1;
      end;

      class method Parse(s: String): UInt32;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: UInt32):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + UInt32(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - UInt32(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * UInt32(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          UInt32(a) <> 0;
        begin
          exit INumber(Double(self / UInt32(a)));
        end;

        class operator Implicit(const a: INumber): UInt32;
        begin
          exit UInt32(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := UInt32(self);
        var tmp2 := UInt32(a);
        exit tmp1 < tmp2;
      end;

      method &LessOrEqual(const a: INumber): Boolean;
      begin
        var tmp1 := UInt32(self);
        var tmp2 := UInt32(a);
        exit tmp1 < tmp2;
      end;
      {$ENDREGION}

      const MinValue: UInt32 = 0;
      const MaxValue: UInt32 = $ffffffff;
    end;

    Int64 = public record(INumber, IEquatable<Int64>, IComparable<Int64>)
    private
      class method DoTryParse(s: String; out Value: Int64; aRaiseOverflowException: Boolean):Boolean; inline;
      begin
        exit Convert.TryParseInt64(s,out Value, aRaiseOverflowException);
      end;

    public
      method ToString: String;  override;
      begin
        if self = 0 then exit '0';
        var lBuffer: array[0..50] of Char;
        var i := 50;
        var isNeg := self < 0;
        var n1: UInt64 := if isNeg then -self else self;

        while n1 <> 0 do begin
          lBuffer[i] := Char(ord('0') + (n1 mod 10));
          dec(i);
          n1 :=n1 /10;
        end;

        if isNeg then begin
          lBuffer[i] := '-';
          dec(i);
        end;
        exit String.FromPChar(@lBuffer[i+1], 50 -i);
      end;

      method GetHashCode: Integer; override;
      begin
        exit Integer(Self xor (Self shr 32) * 7);
      end;

      method &Equals(other: Int64): Boolean;
      begin
        result := (self = other);
      end;

      method CompareTo(const a: Int64): Integer;
      begin
        result := 0;

        result := if (self < a) then -1
                  else if (self > a) then 1;
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is Int64) then
          exit self = Int64(obj)
        else
          exit False;
      end;

      class method Parse(s: String): Int64;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: Int64):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + Int64(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - Int64(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * Int64(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          Int64(a) <> 0;
        begin
          exit INumber(Double(self / Int64(a)));
        end;

        class operator Implicit(const a: INumber): Int64;
        begin
          exit Int64(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := Int64(self);
        var tmp2 := Int64(a);
        exit tmp1 < tmp2;
      end;
      {$ENDREGION}

      const MinValue: Int64 = $8000000000000000;
      const MaxValue: Int64 = $7fffffffffffffff;
    end;

    UInt64 = public record(INumber, IEquatable<UInt64>, IComparable<UInt64>)
    private
      class method DoTryParse(s: String; out Value: UInt64; aRaiseOverflowException: Boolean):Boolean;inline;
      begin
        exit Convert.TryParseUInt64(s,out Value, aRaiseOverflowException);
      end;
    public
      method ToString: String; override;
      begin
        if self = 0 then exit '0';
        var lBuffer: array[0..50] of Char;
        var i := 50;
        var n1: UInt64 := self;

        while n1 <> 0 do begin
          lBuffer[i] := Char(ord('0') + (n1 mod 10));
          dec(i);
          n1 :=n1 /10;
        end;
        exit String.FromPChar(@lBuffer[i+1], 50 -i);
      end;

      method GetHashCode: Integer; override;
      begin
        exit Integer(Self xor (Self shr 32) * 7);
      end;

      method &Equals(const other: UInt64): boolean;
      begin
        result := (self = other);
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        if assigned(obj) and (obj is UInt64) then
          exit self = UInt64(obj)
        else
          exit False;
      end;

      method CompareTo(const a: UInt64): Integer;
      begin
        result := 0;

        result := if (self < a) then -1
                  else if (self > a) then 1;
      end;

      class method Parse(s: String): UInt64;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: UInt64):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

      {$Region Aritmethical Operators}
        method &Add(const a: INumber): INumber;
        begin
          exit INumber(self + UInt64(a));
        end;

        method &Subtract(const a: INumber): INumber;
        begin
          exit INumber(self - UInt64(a));
        end;

        method &Multiply(const a: INumber): INumber;
        begin
          exit INumber(self * UInt64(a));
        end;

        method &Divide(const a: INumber): INumber;
        require
          UInt64(a) <> 0;
        begin
          exit INumber(Double(self / UInt64(a)));
        end;

        class operator Implicit(const a: INumber): UInt64;
        begin
          exit UInt64(a);
        end;
      {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := UInt64(self);
        var tmp2 := UInt64(a);
        exit tmp1 < tmp2;
      end;
      {$ENDREGION}

      const MinValue: UInt64 = $0;
      const MaxValue: UInt64 = $ffffffffffffffff;
    end;

    NativeInt = public record(INumber, IEquatable<NativeInt>, IComparable<NativeInt>)
    private
      class method DoTryParse(s: String; out Value: NativeInt; aRaiseOverflowException: Boolean):Boolean;
      begin
        var sValue : Int64;
        if not Convert.TryParseInt64(s,out sValue, aRaiseOverflowException) then exit False;
        {$IFNDEF cpu64}
        if sValue >= 0 then begin
          if sValue > MaxValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end
        else begin
          if sValue < MinValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end;
        {$ENDIF}
        Value := sValue;
        exit True;
      end;

    public
      method ToString: String; override;
      begin
        exit Int64(self).ToString;
      end;

      method GetHashCode: Integer; override;
      begin
        exit Integer({$ifdef cpu64}Self xor (Self shr 32) * 7{$else}Self{$endif});
      end;

      method CompareTo(a: NativeInt): Integer;
      begin
        result := Integer( {$IFDEF cpu64}
                     Int64(self).CompareTo(Int64(a))
                   {$ELSE}
                   Int32(self).CompareTo(Int32(a))
                   {$ENDIF}
                  );
      end;

      method &Equals(obj: NativeInt): Boolean;
      begin
        result := {$IFDEF cpu64}
                    (self = Int64(obj))
                  {$ELSE}
                    (self = Int32(obj))
                  {$ENDIF}
      end;

      method &Equals(obj: Object): Boolean; override;
        begin
          {$IFDEF cpu64}
            if assigned(obj) and (obj is Int64) then
              exit self = Int64(obj);
          {$else}
            if assigned(obj) and (obj is Int32) then
              exit self = Int32(obj);
          {$ENDIF}
            if assigned(obj) and (obj is NativeInt) then
              exit self = NativeInt(obj)
          else
            exit False;
        end;

      class method Parse(s: String): NativeInt;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: NativeInt):Boolean;
        begin
          exit DoTryParse(s, out Value, false);
        end;

    {$Region Aritmethical Operators}
      method &Add(const a: INumber): INumber;
      begin
        exit INumber(self + ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF}));
      end;

      method &Subtract(const a: INumber): INumber;
      begin
        exit INumber(self - ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF}));
      end;

      method &Multiply(const a: INumber): INumber;
      begin
        exit INumber(self * ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF}));
      end;

      method &Divide(const a: INumber): INumber;
      require
        ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF}) <> 0;
      begin
        exit INumber(Double(self / ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF})));
      end;

      class operator Implicit(const a: INumber): NativeInt;
      begin
        exit ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF});
      end;
    {$ENDREGION}

    {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := ({$IFDEF cpu64}Int64(self){$ELSE}Int32(self){$ENDIF});
        var tmp2 := ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF});
        exit tmp1 < tmp2;
      end;
    {$ENDREGION}

    const MinValue: NativeInt = {$IFDEF cpu64}$8000000000000000{$ELSE}$80000000{$ENDIF};
    const MaxValue: NativeInt = {$IFDEF cpu64}$7fffffffffffffff{$ELSE}$7fffffff{$ENDIF};
    end;

    NativeUInt = public record(INumber, IEquatable<NativeUInt>, IComparable<NativeUInt>)
    private
      class method DoTryParse(s: String; out Value: NativeUInt; aRaiseOverflowException: Boolean):Boolean;
      begin
        var sValue: UInt64;
        if not Convert.TryParseUInt64(s,out sValue, aRaiseOverflowException) then exit False;
        {$IFNDEF cpu64}
        if sValue > MaxValue then
          if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        {$ENDIF}
        Value := sValue;
        exit True;
      end;
    public
      method ToString: String; override;
      begin
         exit UInt64(self).ToString;
      end;

      method GetHashCode: Integer; override;
      begin
        exit Integer({$ifdef cpu64}Self xor (Self shr 32) * 7{$else}Self{$endif});
      end;

      method &Equals(const other: NativeUInt): boolean;
      begin
        result :=
          {$IFDEF cpu64}
             (self = UInt64(other))
          {$else}
            (self = UInt32(other))
          {$Endif}
      end;

      method CompareTo(a: NativeUInt): Integer;
      begin
        result := Integer
               (
                 {$IFDEF cpu64}
                  UInt64(self).CompareTo(UInt64(a))
                 {$ELSE}
                  UInt32(self).CompareTo(UInt32(a))
                 {$ENDIF}
               );
      end;

      method &Equals(other: NativeInt): Boolean;
      begin
        result := (self = other);
      end;

      method &Equals(obj: Object): Boolean; override;
      begin
        {$IFDEF cpu64}
        if assigned(obj) and (obj is UInt64) then
          exit self = UInt64(obj);
        {$else}
        if assigned(obj) and (obj is UInt32) then
          exit self = UInt32(obj);
        {$ENDIF}
        if assigned(obj) and (obj is NativeUInt) then
          exit self = NativeUInt(obj)
        else
          exit False;
      end;

      class method Parse(s: String): NativeUInt;
      begin
        if not DoTryParse(s, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: NativeUInt):Boolean;
      begin
        exit DoTryParse(s, out Value, false);
      end;

    {$Region Aritmethical Operators}
      method &Add(const a: INumber): INumber;
      begin
        exit INumber(self + ({$IFDEF cpu64}UInt64(a){$ELSE}UInt32(a){$ENDIF}));
      end;

      method &Subtract(const a: INumber): INumber;
      begin
        exit INumber(self - ({$IFDEF cpu64}UInt64(a){$ELSE}UInt32(a){$ENDIF}));
      end;

      method &Multiply(const a: INumber): INumber;
      begin
        exit INumber(self * ({$IFDEF cpu64}UInt64(a){$ELSE}UInt32(a){$ENDIF}));
      end;

      method &Divide(const a: INumber): INumber;
      require
        ({$IFDEF cpu64}UInt64(a){$ELSE}UInt32(a){$ENDIF}) <> 0;
      begin
        exit INumber(Double(self / ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF})));
      end;

      class operator Implicit(const a: INumber): NativeUInt;
      begin
        exit ({$IFDEF cpu64}UInt64(a){$ELSE}UInt32(a){$ENDIF});
      end;
    {$ENDREGION}

    {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := ({$IFDEF cpu64}UInt64(self){$ELSE}UInt32(self){$ENDIF});
        var tmp2 := ({$IFDEF cpu64}UInt64(a){$ELSE}UInt32(a){$ENDIF});
        exit tmp1 < tmp2;
      end;
    {$ENDREGION}

    const MinValue: NativeInt = $0;
    const MaxValue: NativeInt = {$IFDEF cpu64}$ffffffffffffffff{$ELSE}$ffffffff{$ENDIF};
    end;

    IntPtr = public NativeInt;
    UIntPtr = public NativeUInt;

    Single = public record(INumber, IEquatable<Single>, IComparable<Single>)
    private
      const SignificantBitmask: UInt32      = $80000000;
      const ExponentBitmask: UInt32         = $7F800000;
      const FractionBitmask: UInt32         = $007FFFFF;

      const UInt32_MinValue: UInt32         = $FF7FFFFF;
      const UInt32_MaxValue: UInt32         = $7F7FFFFF;
      const UInt32_PositiveInfinity: UInt32 = $7F800000;
      const UInt32_NegativeInfinity: UInt32 = $FF800000;
      const UInt32_NAN: UInt32              = $FFC00000;

      class method DoTryParse(s: String; aLocale: Locale; out Value: Single; aRaiseOverflowException: Boolean): Boolean;
      begin
        var sValue : Double;
        if not Convert.TryParseDouble(s, aLocale, out sValue, aRaiseOverflowException) then exit False;
        if sValue >= 0 then begin
          if sValue > MaxValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end
        else begin
          if sValue < MinValue then
            if aRaiseOverflowException then Convert.RaiseOverflowException else exit False;
        end;
        Value := sValue;
        exit True;
      end;

    public
      method ToString: String;
      begin
        exit ToString(Locale.Current);
      end;

      method ToString(aLocale: Locale): String;
      begin
        if Self = 0 then exit '0';
        if IsNaN(Self) then exit 'NaN';
        if IsNegativeInfinity(Self) then exit '-Infinity';
        if IsPositiveInfinity(Self) then exit 'Infinity';
        exit FloatToString.Convert(self, 8, aLocale);
      end;

      method GetHashCode: Integer;
      begin
        exit ^Integer(@self)[0];
      end;

      class method IsNaN(Value: Single): Boolean;
      begin
        //FFC#####
        var c := ^UInt32(@Value)^;
        exit (c and ExponentBitmask = ExponentBitmask) and (c and FractionBitmask <> 0);
      end;

      class method IsInfinity(Value: Single): Boolean;
      begin
        //$7F800000 or $FF800000 only
        var c := ^UInt32(@Value)^;
        exit (c = UInt32_PositiveInfinity) or (c = UInt32_NegativeInfinity);
      end;

      class method IsPositiveInfinity(Value: Single): Boolean;
      begin
        //$7F800000 only
        exit ^UInt32(@Value)^ = UInt32_PositiveInfinity;
      end;

      class method IsNegativeInfinity(Value: Single): Boolean;
      begin
        //$FF800000 only
        exit ^UInt32(@Value)^ = UInt32_NegativeInfinity;
      end;

      class method MinValue: Single;
      begin
        var k: UInt32 := UInt32_MinValue;
        exit ^Single(@k)^;
      end;

      class method MaxValue: Single;
      begin
        var k: UInt32 := UInt32_MaxValue;
        exit ^Single(@k)^;
      end;

      class method PositiveInfinity: Single;
      begin
        var k: UInt32 := UInt32_PositiveInfinity;
        exit ^Single(@k)^;
      end;

      class method NegativeInfinity: Single;
      begin
        var k: UInt32 := UInt32_NegativeInfinity;
        exit ^Single(@k)^;
      end;

      class method NAN: Single;
      begin
        var k: UInt32 := UInt32_NAN;
        exit ^Single(@k)^;
      end;

      method &Equals(const other: Single): Boolean;
      begin
        raise new NotImplementedException('Needs an optimized Equal-logic');
      end;

      method CompareTo(const a: Single): Integer;
      begin
       result :=
            if (self < a) then -1 else
            if (self = a) then 0 else
            if (self > a) then 1 else

            // At least one of the values is NaN.
            if (IsNaN(self)) then
                (if IsNaN(a) then 0 else -1)
            else // f is NaN.
                1;
      end;

      method &Equals(obj: Object): Boolean;
      begin
        if assigned(obj) and (obj is Single) then
          exit self = Single(obj)
        else
          exit False;
      end;

      class method Parse(s: String): Single;
      begin
        if not DoTryParse(s, Locale.Invariant, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: Single): Boolean;
      begin
        exit DoTryParse(s, Locale.Invariant, out Value, false);
      end;

      class method TryParse(s: String; aLocale: Locale; out Value: Single): Boolean;
      begin
        exit DoTryParse(s, aLocale, out Value, false);
      end;

      {$Region Aritmethical Operators}
      method &Add(const a: INumber): INumber;
      begin
        exit INumber(self + Single(a));
      end;

      method &Subtract(const a: INumber): INumber;
      begin
        exit INumber(self - Single(a));
      end;

      method &Multiply(const a: INumber): INumber;
      begin
        exit INumber(self * Single(a));
      end;

      method &Divide(const a: INumber): INumber;
      require
        ({$IFDEF cpu64}Int64(a){$ELSE}Int32(a){$ENDIF}) <> 0;
      begin
        exit INumber(Single(self / Single(a)));
      end;

      class operator Implicit(const a: INumber): Single;
      begin
        exit Single(a);
      end;
    {$ENDREGION}

      {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := Single(self);
        var tmp2 := Single(a);
        exit tmp1 < tmp2;
      end;
    {$ENDREGION}
    end;

    Double = public record(INumber, IEquatable<Double>, IComparable<Double>)
    private
      class method DoTryParse(s: String; aLocale: Locale; out Value: Double; aRaiseOverflowException: Boolean): Boolean; inline;
      begin
        exit Convert.TryParseDouble(s, out Value, aRaiseOverflowException);
      end;

    assembly
      const SignificantBitmask: UInt64      = $8000000000000000;
      const ExponentBitmask: UInt64         = $7FF0000000000000;
      const FractionBitmask: UInt64         = $000FFFFFFFFFFFFF;

      const UInt64_MinValue: UInt64         = $FFEFFFFFFFFFFFFF;
      const UInt64_MaxValue: UInt64         = $7FEFFFFFFFFFFFFF;
      const UInt64_PositiveInfinity: UInt64 = $7FF0000000000000;
      const UInt64_NegativeInfinity: UInt64 = $FFF0000000000000;
      const UInt64_NAN: UInt64              = $FFF8000000000000;

      method IsInt: Boolean;
      begin
        var pIEEE_754_raw := ^UInt64(@self)^;
        var tmp := pIEEE_754_raw and not SignificantBitmask;
        var exponent: Int32 := (tmp shr 52)-1023;
        if exponent >= 0 then
          exit (tmp and (FractionBitmask shr exponent)) = 0
        else
          exit false;
      end;

    public
      method ToString: String;
      begin
        exit ToString(Locale.Current);
      end;

      method &Equals(const other: Double): boolean;
      begin
        raise new NotImplementedException('Needs an optimized Equal-logic');
      end;

      method CompareTo(const a: Double): Integer;
      begin
        exit if (self < a) then -1
             else if (self = a) then 0
             else if (self > a) then 1 else
             {At least one of the values is NaN.}
             if (IsNaN(self)) then
               if IsNaN(a) then 0
                 else -1
             else 1; // f is NaN.
      end;

      method ToString(aLocale: Locale): String;
      begin
        exit FloatToString.Convert(self, 16, aLocale);
      end;

      method GetHashCode: Integer;
      begin
        exit ^Integer(@self)[0] xor ^Integer(@self)[1];
      end;

      class method IsNaN(Value: Double): Boolean;
      begin
        //7FF#############;
        var c := ^UInt64(@Value)^;
        exit (c and ExponentBitmask = ExponentBitmask) and (c and FractionBitmask <> 0);
      end;

      class method IsInfinity(Value: Double): Boolean;
      begin
        //$7FF0000000000000 or $FFF0000000000000 only
        var c := ^UInt64(@Value)^;
        exit (c = UInt64_PositiveInfinity) or (c = UInt64_NegativeInfinity);
      end;

      class method IsPositiveInfinity(Value: Double): Boolean;
      begin
        //$7FF0000000000000 only
        exit ^UInt64(@Value)^ = UInt64_PositiveInfinity;
      end;

      class method IsNegativeInfinity(Value: Double): Boolean;
      begin
        //$FFF0000000000000 only
        exit ^UInt64(@Value)^ = UInt64_NegativeInfinity;
      end;

      class method MinValue: Double;
      begin
        var k: UInt64 := UInt64_MinValue;
        exit ^Double(@k)^;
      end;

      class method MaxValue: Double;
      begin
        var k: UInt64 := UInt64_MaxValue;
        exit ^Double(@k)^;
      end;

      class method PositiveInfinity: Double;
      begin
        var k: UInt64 := UInt64_PositiveInfinity;
        exit ^Double(@k)^;
      end;

      class method NegativeInfinity: Double;
      begin
        var k: UInt64 := UInt64_NegativeInfinity;
        exit ^Double(@k)^;
      end;

      class method NaN: Double;
      begin
        var k: UInt64 := UInt64_NAN;
        exit ^Double(@k)^;
      end;

      method &Equals(obj: Object): Boolean;
      begin
        if assigned(obj) and (obj is Double) then
          exit self = Double(obj)
        else
          exit False;
      end;

      method ToString(aNumberOfDecimalDigits: UInt32): String;
      begin
        exit FloatToString.ConvertToDecimal(self, aNumberOfDecimalDigits, Locale.Current);
      end;

      method ToString(aNumberOfDecimalDigits: UInt32; aLocale: Locale): String;
      begin
        exit FloatToString.ConvertToDecimal(self, aNumberOfDecimalDigits, aLocale);
      end;

      class method Parse(s: String): Double;
      begin
        if not DoTryParse(s, Locale.Invariant, out result, true) then Convert.RaiseFormatException;
      end;

      class method TryParse(s: String; out Value: Double): Boolean;
      begin
        exit DoTryParse(s, Locale.Invariant, out Value, false);
      end;

      class method TryParse(s: String; aLocale: Locale; out Value: Double): Boolean;
      begin
        exit DoTryParse(s, aLocale, out Value, false);
      end;

      {$Region Aritmethical Operators}
      method &Add(const a: INumber): INumber;
      begin
        exit INumber(self + Double(a));
      end;

      method &Subtract(const a: INumber): INumber;
      begin
        exit INumber(self - Double(a));
      end;

      method &Multiply(const a: INumber): INumber;
      begin
        exit INumber(self * Double(a));
      end;

      method &Divide(const a: INumber): INumber;
      require
        Double(a) <> 0.0;  (*Needs proper floating-point-equal!*)
      begin
        exit INumber(Double(self / Double(a)));
      end;

      class operator Implicit(const a: INumber): Double;
      begin
        exit Double(a);
      end;
    {$ENDREGION}

    {$REGION Logical Operators}
      method &Less(const a: INumber): Boolean;
      begin
        var tmp1 := Double(self);
        var tmp2 := Double(a);
        exit tmp1 < tmp2;
      end;
    {$ENDREGION}
  end;

    FloatToString = private static class
    private
      class const DecimalChar: Char = '.';
      class const maxpos = 1024;

    public
      class method Convert(aValue: Double; aPrecision: Integer): String;
      begin
        exit Convert(aValue, aPrecision, Locale.Current);
      end;

      class method Convert(aValue: Double; aPrecision: Integer; aLocale: Locale): String;
      begin
        const
          digits: not nullable String = '0123456789';

        if aValue = 0 then exit '0';
        if Double.IsNaN(aValue) then exit 'NaN';
        if Double.IsNegativeInfinity(aValue) then exit '-Infinity';
        if Double.IsPositiveInfinity(aValue) then exit 'Infinity';

        if aLocale = nil then aLocale := aLocale.Current;
        var data: array[0..maxpos] of Byte;
        var cur_position := 0;
        var exponent := 0;
        var is_positive_value:=True;
        var lValue := aValue;

        if lValue < 0 then begin
          is_positive_value:=False;
          lValue := Math.Abs(lValue);
        end;

        {$REGION process ####. }
        if lValue >= 1 then begin
          var buf: array[0..maxpos] of Byte;
          var pos1 := 0;

          var t_orig:= Math.Truncate(lValue);
          var t_calc := t_orig;
          t_calc := 0;
          var t_work := t_orig;
          var t_pos1:UInt64 := 1;
          while (t_calc <> t_orig) do begin
            var t1 := Int32(t_work mod 10);
            t_work := Math.Truncate(t_work div 10);
            if pos1 < maxpos then begin
              buf[pos1] := t1;
              inc(pos1);
            end;
            if (t_work = 0) then break;
            t_calc := t_calc + t1*t_pos1;
            t_pos1:= t_pos1*10;
            inc(exponent);
          end;
          for i:Integer := 0 to pos1-1 do
            data[cur_position+i]:= buf[pos1-i-1];
          inc(cur_position, pos1);
        end
        else begin
          dec(exponent);
        end;
        {$ENDREGION}

        {$REGION process .#### }
        var is_fraction_present:=false;
        var t_orig:= lValue mod 1;

        if (t_orig <> 0) and (cur_position < maxpos) then begin
          is_fraction_present:=true;
          var fl:= true;
          while t_orig <> 0 do begin
            t_orig:= t_orig*10;
            if Double.IsInfinity(t_orig) then break;
            var t1 := Int32(t_orig mod 10);
            if (t1 = 0) and fl and (exponent<0) then begin
              dec(exponent);
            end
            else begin
              fl := false;
              data[cur_position]:= t1;
              inc(cur_position);
            end;
            if cur_position >= maxpos then break;
          end;
        end;
        {$ENDREGION}

        var nexp := Math.Abs(exponent);

        var buf: array [0..22] of Char;
        var bufpos:= 0;
        if not is_positive_value then
        begin
          buf[bufpos] := '-';
          inc(bufpos);
        end;

        if (nexp > aPrecision) or (exponent < -4) then begin// => #.#####E+## | #.#####E-##
          buf[bufpos] := digits[data[0]];
          inc(bufpos);
          buf[bufpos] := aLocale.NumberFormat.DecimalSeparator;
          inc(bufpos);
          var st_cnt := aPrecision-1;
          CalcLastDigit(var data, 1, aPrecision-1);

          for i: Integer:= st_cnt-1 downto 2 do
            if data[i] = 0 then dec(st_cnt) else break;
          for i: Integer:=1 to st_cnt-1 do begin
            buf[bufpos] := digits[data[i]];
            inc(bufpos);
          end;
          {$REGION make E+###}
          buf[bufpos] := 'E';
          inc(bufpos);
          buf[bufpos] := iif(exponent>0,'+','-');
          inc(bufpos);
          if nexp > 100 then begin
            var t := Integer(nexp / 100);
            buf[bufpos] := digits[t];
            inc(bufpos);
            dec(nexp, 100*t);
          end;
          var t := Integer(nexp / 10);
          buf[bufpos] := digits[t];
          inc(bufpos);
          dec(nexp, 10*t);
          buf[bufpos] := digits[nexp];
          inc(bufpos);
          {$ENDREGION}
        end
        else if (exponent >= 0) and is_fraction_present then begin// => #####.#####
          var st_cnt := iif(cur_position>aPrecision-1, aPrecision-1, cur_position);
          CalcLastDigit(var data, nexp+1, st_cnt);
          if data[0] = 10 then begin
            var ldata : array[0..maxpos] of Byte;
            ldata[0] := 1;
            ldata[1] := 0;
            memcpy(@ldata[2], @data[1], maxpos-1);
            data := ldata;
            inc(exponent);
            is_fraction_present := False;
          end;
          for i:Integer:=0 to exponent do begin
            buf[bufpos] := digits[data[i]];
            inc(bufpos);
          end;
          if is_fraction_present then begin
            var t_buf := bufpos;
            buf[bufpos] := aLocale.NumberFormat.DecimalSeparator;
            inc(bufpos);
            for i: Integer:= st_cnt-1 downto nexp+2 do
              if data[i] = 0 then dec(st_cnt) else break;
            for i:Integer:=nexp+1 to st_cnt-1 do begin
              buf[bufpos] := digits[data[i]];
              inc(bufpos);
            end;
            if (st_cnt-1 = t_buf) and (data[t_buf] = 0) then bufpos:= t_buf;
          end;
        end
        else if (exponent >= 0) and not is_fraction_present then begin// => #####
          CalcLastDigit(var data, 0, exponent+1);
          for i:Integer:=0 to exponent do begin
            buf[bufpos] := digits[data[i]];
            inc(bufpos);
          end;
        end
        else begin// => 0.##### - 0.000#####
          buf[bufpos] := '0';
          inc(bufpos);
          buf[bufpos] := aLocale.NumberFormat.DecimalSeparator;
          inc(bufpos);
          for i:Integer :=0 to nexp-2 do begin
            buf[bufpos] := '0';
            inc(bufpos);
          end;
          var st_cnt := iif(cur_position>aPrecision-1, aPrecision-1, cur_position);
          CalcLastDigit(var data, 0, st_cnt);
          for i: Integer:= st_cnt-1 downto 1 do
            if data[i] = 0 then dec(st_cnt) else break;
          for i:Integer:=0 to st_cnt-1 do begin
            buf[bufpos] := digits[data[i]];
            inc(bufpos);
          end;
        end;
        exit  String.FromPChar(buf,bufpos);
      end;

      class method CalcLastDigit(var data: array[0..maxpos] of Byte; aStart: Integer; aCount: Integer);
      begin
        if (aCount < length(data)-1) then begin
          if data[aCount] > 5 then begin
            data[aCount-1] := data[aCount-1]+1;
            data[aCount] := 0;
          end
          else if data[aCount] = 5 then begin
            for i:Integer :=aCount to length(data)-1 do begin
              if data[i] = 0 then continue;
              data[aCount-1] := data[aCount-1]+1;
              data[aCount] := 0;
              break;
            end;
          end
          else begin
            // none
          end;
          for i:Integer := aCount-1 downto 1 do begin
            if data[i] = 10 then begin
              data[i] := 0;
              data[i-1] := data[i-1]+1;
            end
            else
              break;
          end;
        end;
      end;

      class method ConvertToDecimal(aValue: Double; aNumberOfDecimalDigits: UInt32): String;
      begin
        exit ConvertToDecimal(aValue, aNumberOfDecimalDigits, Locale.Current);
      end;

      class method ConvertToDecimal(aValue: Double; aNumberOfDecimalDigits: UInt32; aLocale: Locale): String;
      begin
        const
          digits: not nullable String = '0123456789';

        if (aValue = 0) and (aNumberOfDecimalDigits = 0) then exit '0';

        if aLocale = nil then aLocale := Locale.Current;
        var data: array[0..maxpos + 1 {extra digits for rounding}] of Byte;
        var cur_position := 0;
        var exponent := 0;
        var is_positive_value:=True;
        var lValue := aValue;

        if lValue < 0 then begin
          is_positive_value:=False;
          lValue := Math.Abs(lValue);
        end;

        {$REGION process ####. }
        if lValue >= 1 then begin
          var buf: array[0..maxpos] of Byte;
          var pos1 := 0;

          var t_orig:= Math.Truncate(lValue);
          var t_calc := t_orig;
          t_calc := 0;
          var t_work := t_orig;
          var t_pos1:UInt64 := 1;
          while (t_calc <> t_orig) do begin
            var t1 := Int32(t_work mod 10);
            t_work := Math.Truncate(t_work div 10);
            if pos1 < maxpos then begin
              buf[pos1] := t1;
              inc(pos1);
            end;
            if (t_work = 0) then break;
            t_calc := t_calc + t1*t_pos1;
            t_pos1:= t_pos1*10;
            inc(exponent);
          end;
          for i:Integer := 0 to pos1-1 do
            data[cur_position+i]:= buf[pos1-i-1];
          inc(cur_position, pos1);
        end
        else begin
          dec(exponent);
          inc(cur_position);// extra 0 at beginning
        end;
        {$ENDREGION}

        {$REGION process .#### }
        var t_orig:= lValue mod 1;
        if (t_orig <> 0) and (cur_position < maxpos) then begin
          var fl:= true;
          while t_orig <> 0 do begin
            t_orig:= t_orig*10;
            if Double.IsInfinity(t_orig) then break;
            var t1 := Int32(t_orig mod 10);
            if (t1 = 0) and fl and (exponent<0) then begin
              dec(exponent);
            end
            else begin
              fl := false;
              data[cur_position]:= t1;
              inc(cur_position);
            end;
            if cur_position >= maxpos then break;
          end;
        end;
        {$ENDREGION}

        var nexp := Math.Abs(exponent);
        var buf:= new array of Char(nexp + aNumberOfDecimalDigits + 2) ;
        var bufpos:= 0;
        if not is_positive_value then begin
          buf[bufpos] := '-';
          inc(bufpos);
        end;

        if exponent>=0 then begin  //####.#####
          CalcLastDigit(var data, 0, aNumberOfDecimalDigits+nexp+1);
          for i:Integer:=0 to exponent do begin
            buf[bufpos] := digits[data[i]];
            inc(bufpos);
          end;
          if aNumberOfDecimalDigits > 0 then begin
            buf[bufpos] := aLocale.NumberFormat.DecimalSeparator;
            inc(bufpos);
            var st_cnt := aNumberOfDecimalDigits + exponent + 1;
            for i:Integer:=nexp+1 to st_cnt-1 do begin
              buf[bufpos] := digits[data[i]];
              inc(bufpos);
            end;
          end;
        end
        // 0.######
        else if aNumberOfDecimalDigits = 0 then
        begin
          CalcLastDigit(var data, 0, 1);
          buf[bufpos] := digits[data[0]];
          inc(bufpos);
        end
        else
        begin  // 0.######
          CalcLastDigit(var data, 1, aNumberOfDecimalDigits+1);
          buf[bufpos] := '0';
          inc(bufpos);
          buf[bufpos] := aLocale.NumberFormat.DecimalSeparator;
          inc(bufpos);
          for i:Integer :=0 to nexp-2 do begin
            buf[bufpos] := '0';
            inc(bufpos);
          end;
          var st_cnt := aNumberOfDecimalDigits;
          for i:Integer:=0 to st_cnt-1 do begin
            buf[bufpos] := digits[data[i+1]];
            inc(bufpos);
          end;
        end;
        exit  String.FromPChar(@buf[0],bufpos);
        end;
    end;

end.