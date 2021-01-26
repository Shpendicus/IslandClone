namespace ConsoleApplication;

type
  Program = class
  public
    class method Main(args: array of String): Int32;
    begin
      //var pair : tuple of (String, Integer) := ("memberName", 1000);
      //writeLn(pair.ToString);
      var a := 100;
      var b : TNumeric := 100;

    //Test_Softinterfaces<TNumeric>(a, b); //actually this should not compile,
                                           //because TNumeric and Boolean, except implicit operator, dont know eachother a bit
                                           //so since I wanna allow only variables of type IEquatable<TNumeric> and not IEquatable<Boolean>
                                           //im wondering why the compiler allows this, im kind of happy
                                           //can it be, that he just sees that TNumeric has an implicit operator to Boolean
                                           //and so he understands IEquatable<TNumeric> as IEquatable<Boolean>?
                                           //If this is the case, very good, but sadly, same issue here as for boolean,
                                           //the result is ALWYS false, like false=false, true=true, should give True, but gives false.
                                           //Antoher thing is, the vice-versa case: IEqutable<Boolean> only allows for real boolean types to be passed in now,
                                           //but not for TNumeric values, as above: IEquatable<TNumeric> allows for both, boolean AND TNumeric values
                                           //which confuses me abit, tbh.

                                            //OK: here is the thing: I get an internal Error when using the TNumeric from custom Island.Shared
                                            //BUT: When I copy the EXACT same file in the isolated ConsoleApp and use it in EXACT SAME WAY i get only:
                                            //Method "method Equals(other: Boolean): Boolean" not implemented as required for interface "IEquatable<Boolean>" [C:\Users\shho3\Desktop\Numeric.pas (28)]
                                            //which is correct ofc, since IEquatable<TNumeric> is smth completly different than IEquatable<Boolean>
                                            //Idk now, strange that happens..

      var s: TNumeric := 100;
      var c: Currency := 1.23;
      writeLn(TNumeric(c).AsString);
      Test_DucktypingFromClasses_1(s);
      writeLn(DWord.MaxValue);
      writeLn(Currency(100.000));
      var res := Cast<Currency>(s) &To(TNumericType.Currency);
      writeLn(res);
    end;

    method Cast<T>(const operand: TNumeric) &To(const toCastTo: TNumericType) : T; where T is record; static;
    begin
      for i: TNumericType := low(TNumericType) to high(TNumericType) do
        begin
          if i = operand.fType then
          begin
            case i of
              TNumericType.Boolean: exit T(UInt8(operand.fValue.a0));
              TNumericType.Int8:
              begin
                case toCastTo of
                  TNumericType.Boolean: exit T(Boolean(operand.fValue.a1));
                  TNumericType.Int16:   exit T(Int16(operand.fValue.a1));
                  TNumericType.Int32:   exit T(Int32(operand.fValue.a1));
                  TNumericType.Int64:   exit T(Int64(operand.fValue.a1));
                  TNumericType.UInt8:   exit T(UInt8(operand.fValue.a1));
                  TNumericType.UInt16:  exit T(UInt16(operand.fValue.a1));
                  TNumericType.UInt32:  exit T(UInt32(operand.fValue.a1));
                  TNumericType.UInt64:  exit T(UInt8(operand.fValue.a1));
                  TNumericType.Single:  exit T(Single(operand.fValue.a1));
                  TNumericType.Double:  exit T(Double(operand.fValue.a1));
                  TNumericType.AnsiChar:exit T(AnsiChar(operand.fValue.a1));
                  //TNumericType.Currency: exit T(Currency(operand.fValue.a1));
                end;
              end;
              TNumericType.Int16:
              begin
                case toCastTo of
                  TNumericType.Boolean: exit T(Boolean(operand.fValue.a2));
                  TNumericType.Int8:    exit T(Int8(operand.fValue.a2));
                  TNumericType.Int32:   exit T(Int16(operand.fValue.a2));
                  TNumericType.Int64:   exit T(Int64(operand.fValue.a2));
                  TNumericType.UInt8:   exit T(UInt8(operand.fValue.a2));
                  TNumericType.UInt16:  exit T(UInt16(operand.fValue.a2));
                  TNumericType.UInt32:  exit T(UInt32(operand.fValue.a2));
                  TNumericType.UInt64:  exit T(UInt8(operand.fValue.a2));
                  TNumericType.Single:  exit T(Single(operand.fValue.a2));
                  TNumericType.Double:  exit T(Double(operand.fValue.a2));
                  //TNumericType.Currency: exit T(Currency(operand.fValue.a2));
                end;
              end;
              TNumericType.Int32:
              begin
                case toCastTo of
                  //a3 will be understood implicitly as TNumeric, which causes StackOverflow
                  TNumericType.Boolean: exit T(Boolean(operand.fValue.a3));
                  TNumericType.Int8:   exit T(Int8(operand.fValue.a3));
                  TNumericType.Int16:  exit T(Int16(operand.fValue.a3));
                  TNumericType.Int64:  exit T(Int32(operand.fValue.a3));
                  TNumericType.UInt8:  exit T(UInt8(operand.fValue.a3));
                  TNumericType.UInt16: exit T(UInt16(operand.fValue.a3));
                  TNumericType.UInt32: exit T(UInt32(operand.fValue.a3));
                  TNumericType.UInt64: exit T(UInt8(operand.fValue.a3));
                  TNumericType.Single: exit T(Single(operand.fValue.a3));
                  TNumericType.Double: exit T(Double(operand.fValue.a3));
                   //TNumericType.Currency: exit T(Currency(operand.fValue.a1));
                end;
              end;
              TNumericType.Int64:
              begin
                case toCastTo of
                  TNumericType.Boolean: exit T(Boolean(operand.fValue.a4));  //will be converted IMPLICITLY to TNumeric
                  TNumericType.Int8:    exit T(Int8(operand.fValue.a4));
                  TNumericType.Int16:   exit T(Int16(operand.fValue.a4));
                  TNumericType.Int32:   exit T(Int32(operand.fValue.a4));
                  TNumericType.UInt8:   exit T(UInt8(operand.fValue.a4));
                  TNumericType.UInt16:  exit T(UInt16(operand.fValue.a4));
                  TNumericType.UInt32:  exit T(UInt32(operand.fValue.a4));
                  TNumericType.UInt64:  exit T(UInt8(operand.fValue.a4));
                  TNumericType.Single:  exit T(Single(operand.fValue.a4));
                  TNumericType.Double:  exit T(Double(operand.fValue.a4));
                end;
              end;
              TNumericType.UInt8:
              begin
                case toCastTo of
                  TNumericType.Boolean: exit T(Boolean(operand.fValue.a5));
                  TNumericType.Int8:    exit T(Int8(operand.fValue.a5));
                  TNumericType.Int16:   exit T(Int16(operand.fValue.a5));
                  TNumericType.Int32:   exit T(Int32(operand.fValue.a5));
                  TNumericType.Int64:   exit T(Int64(operand.fValue.a5));
                  TNumericType.UInt16:  exit T(UInt16(operand.fValue.a5));
                  TNumericType.UInt32:  exit T(UInt32(operand.fValue.a5));
                  TNumericType.UInt64:  exit T(UInt8(operand.fValue.a5));
                  TNumericType.Single:  exit T(Single(operand.fValue.a5));
                  TNumericType.Double:  exit T(Double(operand.fValue.a5));
                end;
              end;
              TNumericType.UInt16:
              begin
                case toCastTo of
                  TNumericType.Boolean: exit T(Boolean(operand.fValue.a6));
                  TNumericType.Int8:    exit T(Int8(operand.fValue.a6));
                  TNumericType.Int16:   exit T(Int16(operand.fValue.a6));
                  TNumericType.Int32:   exit T(Int32(operand.fValue.a6));
                  TNumericType.Int64:   exit T(Int64(operand.fValue.a6));
                  TNumericType.UInt8:   exit T(UInt8(operand.fValue.a6));
                  TNumericType.UInt32:  exit T(UInt32(operand.fValue.a6));
                  TNumericType.UInt64:  exit T(UInt64(operand.fValue.a6));
                  TNumericType.Single:  exit T(Single(operand.fValue.a6));
                  TNumericType.Double:  exit T(Double(operand.fValue.a6));
                end;
              end;
              TNumericType.UInt32:
              begin
                case toCastTo of
                  TNumericType.Boolean: exit T(Boolean(operand.fValue.a7));
                  TNumericType.Int8:    exit T(Int8(operand.fValue.a7));
                  TNumericType.Int16:   exit T(Int16(operand.fValue.a7));
                  TNumericType.Int32:   exit T(Int32(operand.fValue.a7));
                  TNumericType.Int64:   exit T(Int64(operand.fValue.a7));
                  TNumericType.UInt8:   exit T(UInt8(operand.fValue.a7));
                  TNumericType.UInt64:  exit T(UInt64(operand.fValue.a7));
                  TNumericType.UInt16:  exit T(UInt16(operand.fValue.a7));
                  TNumericType.Single:  exit T(Single(operand.fValue.a7));
                  TNumericType.Double:  exit T(Double(operand.fValue.a7));
                end;
              end;
              TNumericType.UInt64:
              begin
                case toCastTo of
                  TNumericType.Boolean: exit T(Boolean(operand.fValue.a8));
                  TNumericType.Int8:    exit T(Int8(operand.fValue.a8));
                  TNumericType.Int16:   exit T(Int16(operand.fValue.a8));
                  TNumericType.Int32:   exit T(Int32(operand.fValue.a8));
                  TNumericType.Int64:   exit T(Int64(operand.fValue.a8));
                  TNumericType.UInt8:   exit T(UInt8(operand.fValue.a8));
                  TNumericType.UInt32:  exit T(UInt32(operand.fValue.a8));
                  TNumericType.UInt16:  exit T(UInt16(operand.fValue.a8));
                  TNumericType.Single:  exit T(Single(operand.fValue.a8));
                  TNumericType.Double:  exit T(Double(operand.fValue.a8));
                end;
              end;
              TNumericType.Single:
              begin
                case toCastTo of
                  TNumericType.Int8:    exit T(Int8(operand.fValue.a9));
                  TNumericType.Int16:   exit T(Int16(operand.fValue.a9));
                  TNumericType.Int32:   exit T(Int32(operand.fValue.a9));
                  TNumericType.Int64:   exit T(Int64(operand.fValue.a9));
                  TNumericType.UInt8:   exit T(UInt8(operand.fValue.a9));
                  TNumericType.UInt32:  exit T(UInt32(operand.fValue.a9));
                  TNumericType.UInt16:  exit T(UInt16(operand.fValue.a9));
                  TNumericType.UInt64:  exit T(UInt64(operand.fValue.a9));
                  TNumericType.Double:  exit T(Double(operand.fValue.a9));
                end;
              end;
              TNumericType.Double:
              begin
                case toCastTo of
                  TNumericType.Int8:    exit T(Int8(operand.fValue.a10));
                  TNumericType.Int16:  exit T(Int16(operand.fValue.a10));
                  TNumericType.Int32:  exit T(Int32(operand.fValue.a10));
                  TNumericType.Int64:  exit T(Int64(operand.fValue.a10));
                  TNumericType.UInt8:  exit T(UInt8(operand.fValue.a10));
                  TNumericType.UInt32: exit T(UInt32(operand.fValue.a10));
                  TNumericType.UInt16: exit T(UInt16(operand.fValue.a10));
                  TNumericType.UInt64: exit T(UInt64(operand.fValue.a10));
                  TNumericType.Single: exit  T(Single(operand.fValue.a10));
                end;
              end;
              TNumericType.AnsiChar:
              begin
                //operand.fActiveType := [low(TNumericType)..high(TNumericType)]

                case toCastTo of
                  TNumericType.Int8, TNumericType.Int16,
                  TNumericType.Int32, TNumericType.Int64,
                  TNumericType.UInt8, TNumericType.UInt16,
                  TNumericType.UInt32, TNumericType.UInt64 :   exit T(Int8(operand.fValue.a11));
                end;
              end;
            end;
          end;
        end;
      end;

    class method Test_DucktypingFromClasses_1(const a: TNumeric);
    begin
      var d := (a.AsString);
      writeLn(d);
      //writeLn(a.HashCode);
    end;
  end;

  //TEnum = enum (a=1, b=234, c=34, d=89) of Byte;
  TEnum = enum(a=2, b=23, c=34, d=107) of Byte;
end.