namespace RemObjects.Elements.System;

  type
    TNumericType    = public enum (Boolean, Int8, Int16, Int32, Int64, AnsiChar,
                                   UInt8, UInt16, UInt32, UInt64, Single, Double, Digital) of Byte;

    TOperationToken = public enum (&Add, Subtract, Multiply, Divide, Modulus, BitwiseAnd,
                                   GreaterOrEqual, Greater, Equal, NotEqual, LessOrEqual, Less) of Byte; //can be expanded ofc with logical operators

    //TCharSet = set of ['a'..'z', 'A.'..'Z', '0'..'9'];

    [Union]
    TValue = record
      a0: Boolean;
      a1: Int8;
      a2: Int16;
      a3: Int32;
      a4: Int64;
      a5: UInt8;
      a6: UInt16;
      a7: UInt32;
      a8: UInt64;
      a9: Single;
      a10:Double;
      a11: AnsiChar;
    end;

    TNumeric = public record(IComparable<TNumeric>)
    unit
      fValue: TValue;
      fType: TNumericType;

    private
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

      method ArithmeticOperation(const operand1, operand2: TNumeric; token: TOperationToken): TNumeric; static;
      begin
        if (operand1.fType = TNumericType.AnsiChar) then
        begin
          const chrOp1 = Byte(operand1);
          const chrOp2 = Byte(operand2);

          case operand2.fType of
            TNumericType.AnsiChar:
            begin
              case token of
                TOperationToken.Add:
                begin
                  result := (chrOp1 + chrOp2);

                  if Byte(result.fValue.a11) > high(Byte) then
                     raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

                  exit AnsiChar(result);
                end;
                TOperationToken.Subtract:
                begin
                  result := (chrOp1 - chrOp2);
                  if Byte(result.fValue.a11) < low(Byte) then
                    raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

                  exit AnsiChar(result);
                end;
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:
                begin
                  result := (chrOp1 + chrOp2);

                  if UInt8(result.fValue.a5) > high(Byte) then
                    raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

                  exit AnsiChar(result);
                end;
                TOperationToken.Subtract:
                begin
                  result := (chrOp1 - chrOp2);

                  if UInt8(result.fValue.a5) < low(Byte) then
                    raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

                  exit AnsiChar(result);
                end;
              end;
            end;
          end;
        end;

        if (operand1.fType = TNumericType.Int8) then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / Int8(operand2);
                TOperationToken.Modulus:  exit Int8(operand1) mod Int8(operand2);
                TOperationToken.BitwiseAnd: exit Int8(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod Int16(operand2);
                TOperationToken.BitwiseAnd: exit Int8(operand1) and Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod Int32(operand2);
                TOperationToken.BitwiseAnd: exit Int8(operand1) and Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod UInt8(operand2);
                TOperationToken.BitwiseAnd: exit Int8(operand1) and UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod UInt16(operand2);
                TOperationToken.BitwiseAnd: exit Int8(operand1) and UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod UInt32(operand2);
                TOperationToken.BitwiseAnd: exit Int8(operand1) and UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + Single(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - Single(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * Single(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit Int8(operand1) + Double(operand2);
                TOperationToken.Subtract: exit Int8(operand1) - Double(operand2);
                TOperationToken.Multiply: exit Int8(operand1) * Double(operand2);
                TOperationToken.Divide:   exit Int8(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit Int8(operand1) mod Double(operand2);
              end;
            end;
          end;
        end;
        //---------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Int16 then
        begin
          case operand2.fType of
            TNumericType.Int8, TNumericType.AnsiChar:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod Int8(operand2);
                TOperationToken.BitwiseAnd: exit Int16(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod Int16(operand2);
                TOperationToken.BitwiseAnd: exit Int16(operand1) and Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod Int32(operand2);
                TOperationToken.BitwiseAnd: exit Int16(operand1) and Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod Int64(operand2);
                TOperationToken.BitwiseAnd: exit Int16(operand1) and Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod UInt8(operand2);
                TOperationToken.BitwiseAnd: exit Int16(operand1) and UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod UInt16(operand2);
                TOperationToken.BitwiseAnd: exit Int16(operand1) and UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod UInt32(operand2);
                TOperationToken.BitwiseAnd: exit Int16(operand1) and UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod UInt64(operand2);
                TOperationToken.BitwiseAnd: exit Int16(operand1) and UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + Single(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - Single(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * Single(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit Int16(operand1) + Double(operand2);
                TOperationToken.Subtract: exit Int16(operand1) - Double(operand2);
                TOperationToken.Multiply: exit Int16(operand1) * Double(operand2);
                TOperationToken.Divide:   exit Int16(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit Int16(operand1) mod Double(operand2);
              end;
            end;
          end;
        end;

      //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Int32 then
        begin
          case operand2.fType of
            TNumericType.Int8, TNumericType.AnsiChar:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod Int8(operand2);
                TOperationToken.BitwiseAnd: exit Int32(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod Int16(operand2);
                TOperationToken.BitwiseAnd: exit Int32(operand1) and Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod Int32(operand2);
                TOperationToken.BitwiseAnd: exit Int32(operand1) and Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod Int64(operand2);
                TOperationToken.BitwiseAnd: exit Int32(operand1) and Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod UInt8(operand2);
                TOperationToken.BitwiseAnd: exit Int32(operand1) and UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod UInt16(operand2);
                TOperationToken.BitwiseAnd: exit Int32(operand1) and UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod UInt32(operand2);
                TOperationToken.BitwiseAnd: exit Int32(operand1) and UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod UInt64(operand2);
                TOperationToken.BitwiseAnd: exit Int32(operand1) and UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + Single(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - Single(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * Single(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit Int32(operand1) + Double(operand2);
                TOperationToken.Subtract: exit Int32(operand1) - Double(operand2);
                TOperationToken.Multiply: exit Int32(operand1) * Double(operand2);
                TOperationToken.Divide:   exit Int32(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit Int32(operand1) mod Double(operand2);
              end;
            end;
          end;
        end;

       //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Int64 then
        begin
          case operand2.fType of
            TNumericType.Int8, TNumericType.AnsiChar:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod Int8(operand2);
                TOperationToken.BitwiseAnd: exit Int64(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod Int16(operand2);
                TOperationToken.BitwiseAnd: exit Int64(operand1) and Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod Int32(operand2);
                TOperationToken.BitwiseAnd: exit Int64(operand1) and Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod Int64(operand2);
                TOperationToken.BitwiseAnd: exit Int64(operand1) and Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod UInt8(operand2);
                TOperationToken.BitwiseAnd: exit Int64(operand1) and UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod UInt16(operand2);
                TOperationToken.BitwiseAnd: exit Int64(operand1) and UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod UInt32(operand2);
                TOperationToken.BitwiseAnd: exit Int64(operand1) and UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod UInt64(operand2);
                TOperationToken.BitwiseAnd: exit Int64(operand1) and UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + Single(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - Single(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * Single(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit Int64(operand1) + Double(operand2);
                TOperationToken.Subtract: exit Int64(operand1) - Double(operand2);
                TOperationToken.Multiply: exit Int64(operand1) * Double(operand2);
                TOperationToken.Divide:   exit Int64(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit Int64(operand1) mod Double(operand2);
              end;
            end;
          end;
        end;

       //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.UInt8 then
        begin
          const chrOp1 = UInt8(operand1);
          const chrOp2 = UInt8(operand2);

          case operand2.fType of
            TNumericType.AnsiChar:
            begin
              case token of
                TOperationToken.Add:
                begin
                  result := (chrOp1 + chrOp2);

                  if Byte(result.fValue.a11) > high(Byte) then
                    raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

                  exit AnsiChar(result);
                end;
                TOperationToken.Subtract:
                begin
                  result := (chrOp1 - chrOp2);
                  if Byte(result.fValue.a11) < low(Byte) then
                    raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

                  exit AnsiChar(result);
                end;
              end;
            end;

            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod Int8(operand2);
                TOperationToken.BitwiseAnd: exit UInt8(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod Int16(operand2);
                TOperationToken.BitwiseAnd: exit UInt8(operand1) and Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod Int32(operand2);
                TOperationToken.BitwiseAnd: exit UInt8(operand1) and Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod Int64(operand2);
                TOperationToken.BitwiseAnd: exit UInt8(operand1) and Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod UInt8(operand2);
                TOperationToken.BitwiseAnd: exit UInt8(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod UInt16(operand2);
                TOperationToken.BitwiseAnd: exit UInt8(operand1) and UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod UInt32(operand2);
                TOperationToken.BitwiseAnd: exit UInt8(operand1) and UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod UInt64(operand2);
                TOperationToken.BitwiseAnd: exit UInt8(operand1) and UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + Single(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - Single(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * Single(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit UInt8(operand1) + Double(operand2);
                TOperationToken.Subtract: exit UInt8(operand1) - Double(operand2);
                TOperationToken.Multiply: exit UInt8(operand1) * Double(operand2);
                TOperationToken.Divide:   exit UInt8(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit UInt8(operand1) mod Double(operand2);
              end;
            end;
          end;
        end;


       //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.UInt16 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod Int8(operand2);
                TOperationToken.BitwiseAnd: exit UInt16(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod Int16(operand2);
                TOperationToken.BitwiseAnd: exit UInt16(operand1) and Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod Int32(operand2);
                TOperationToken.BitwiseAnd: exit UInt16(operand1) and Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod Int64(operand2);
                TOperationToken.BitwiseAnd: exit UInt16(operand1) and Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod UInt8(operand2);
                TOperationToken.BitwiseAnd: exit UInt16(operand1) and UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) and UInt8(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod UInt32(operand2);
                TOperationToken.BitwiseAnd:   exit UInt16(operand1) and UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod UInt64(operand2);
                TOperationToken.BitwiseAnd:   exit UInt16(operand1) and UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + Single(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - Single(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * Single(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit UInt16(operand1) + Double(operand2);
                TOperationToken.Subtract: exit UInt16(operand1) - Double(operand2);
                TOperationToken.Multiply: exit UInt16(operand1) * Double(operand2);
                TOperationToken.Divide:   exit UInt16(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit UInt16(operand1) mod Double(operand2);
              end;
            end;
          end;
        end;

        //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.UInt32 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod Int8(operand2);
                TOperationToken.BitwiseAnd:   exit UInt32(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod Int16(operand2);
                TOperationToken.BitwiseAnd:   exit UInt32(operand1) and Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod Int32(operand2);
                TOperationToken.BitwiseAnd:   exit UInt32(operand1) and Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod Int64(operand2);
                TOperationToken.BitwiseAnd:   exit UInt32(operand1) and Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod UInt8(operand2);
                TOperationToken.BitwiseAnd:   exit UInt32(operand1) and UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod UInt16(operand2);
                TOperationToken.BitwiseAnd:   exit UInt32(operand1) and UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod UInt32(operand2);
                TOperationToken.BitwiseAnd:   exit UInt32(operand1) and UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod UInt64(operand2);
                TOperationToken.BitwiseAnd:   exit UInt32(operand1) and UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + Single(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - Single(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * Single(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit UInt32(operand1) + Double(operand2);
                TOperationToken.Subtract: exit UInt32(operand1) - Double(operand2);
                TOperationToken.Multiply: exit UInt32(operand1) * Double(operand2);
                TOperationToken.Divide:   exit UInt32(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit UInt32(operand1) mod Double(operand2);
              end;
            end;
          end;
        end;

       //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.UInt64 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod Int8(operand2);
                TOperationToken.BitwiseAnd:   exit UInt64(operand1) and Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod Int16(operand2);
                TOperationToken.BitwiseAnd:   exit UInt64(operand1) and Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod Int32(operand2);
                TOperationToken.BitwiseAnd:   exit UInt64(operand1) and Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod Int64(operand2);
                TOperationToken.BitwiseAnd:   exit UInt64(operand1) and Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod UInt8(operand2);
                TOperationToken.BitwiseAnd:   exit UInt64(operand1) and UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod UInt16(operand2);
                TOperationToken.BitwiseAnd:   exit UInt64(operand1) and UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod UInt32(operand2);
                TOperationToken.BitwiseAnd:   exit UInt64(operand1) and UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod UInt64(operand2);
                TOperationToken.BitwiseAnd:   exit UInt64(operand1) and UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + Single(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - Single(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * Single(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit UInt64(operand1) + Double(operand2);
                TOperationToken.Subtract: exit UInt64(operand1) - Double(operand2);
                TOperationToken.Multiply: exit UInt64(operand1) * Double(operand2);
                TOperationToken.Divide:   exit UInt64(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit UInt64(operand1) mod Double(operand2);

              end;
            end;
          end;
        end;


        //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Single then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit Single(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit Single(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit Single(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod Int8(operand2);

              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit Single(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit Single(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit Single(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod Int16(operand2);

              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit Single(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit Single(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit Single(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod Int32(operand2);

              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit Single(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit Single(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit Single(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit Single(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit Single(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit Single(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit Single(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit Single(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit Single(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit Single(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit Single(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit Single(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit Single(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit Single(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit Single(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + Single(operand2);
                TOperationToken.Subtract: exit Single(operand1) - Single(operand2);
                TOperationToken.Multiply: exit Single(operand1) * Single(operand2);
                TOperationToken.Divide:   exit Single(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit Single(operand1) + Double(operand2);
                TOperationToken.Subtract: exit Single(operand1) - Double(operand2);
                TOperationToken.Multiply: exit Single(operand1) * Double(operand2);
                TOperationToken.Divide:   exit Single(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit Single(operand1) mod Double(operand2);
              end;
            end;
          end;
        end;

        //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Double then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + Int8(operand2);
                TOperationToken.Subtract: exit Double(operand1) - Int8(operand2);
                TOperationToken.Multiply: exit Double(operand1) * Int8(operand2);
                TOperationToken.Divide:   exit Double(operand1) / Int8(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + Int16(operand2);
                TOperationToken.Subtract: exit Double(operand1) - Int16(operand2);
                TOperationToken.Multiply: exit Double(operand1) * Int16(operand2);
                TOperationToken.Divide:   exit Double(operand1) / Int16(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + Int32(operand2);
                TOperationToken.Subtract: exit Double(operand1) - Int32(operand2);
                TOperationToken.Multiply: exit Double(operand1) * Int32(operand2);
                TOperationToken.Divide:   exit Double(operand1) / Int32(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + Int64(operand2);
                TOperationToken.Subtract: exit Double(operand1) - Int64(operand2);
                TOperationToken.Multiply: exit Double(operand1) * Int64(operand2);
                TOperationToken.Divide:   exit Double(operand1) / Int64(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + UInt8(operand2);
                TOperationToken.Subtract: exit Double(operand1) - UInt8(operand2);
                TOperationToken.Multiply: exit Double(operand1) * UInt8(operand2);
                TOperationToken.Divide:   exit Double(operand1) / UInt8(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + UInt16(operand2);
                TOperationToken.Subtract: exit Double(operand1) - UInt16(operand2);
                TOperationToken.Multiply: exit Double(operand1) * UInt16(operand2);
                TOperationToken.Divide:   exit Double(operand1) / UInt16(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + UInt32(operand2);
                TOperationToken.Subtract: exit Double(operand1) - UInt32(operand2);
                TOperationToken.Multiply: exit Double(operand1) * UInt32(operand2);
                TOperationToken.Divide:   exit Double(operand1) / UInt32(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + UInt64(operand2);
                TOperationToken.Subtract: exit Double(operand1) - UInt64(operand2);
                TOperationToken.Multiply: exit Double(operand1) * UInt64(operand2);
                TOperationToken.Divide:   exit Double(operand1) / UInt64(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + Single(operand2);
                TOperationToken.Subtract: exit Double(operand1) - Single(operand2);
                TOperationToken.Multiply: exit Double(operand1) * Single(operand2);
                TOperationToken.Divide:   exit Double(operand1) / Single(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Add:      exit Double(operand1) + Double(operand2);
                TOperationToken.Subtract: exit Double(operand1) - Double(operand2);
                TOperationToken.Multiply: exit Double(operand1) * Double(operand2);
                TOperationToken.Divide:   exit Double(operand1) / Double(operand2);
                TOperationToken.Modulus:   exit Double(operand1) mod Double(operand2);
              end;
            end;
          end;
        end
        else
          raise new ArgumentException("You cannot use arithemtical operations on this type!");
      end;


      //LOGICAL OPERATION------------------------------------------------------------------------------------------
      method LogicalOperation(const operand1, operand2: TNumeric; token: TOperationToken): TNumeric; static;
      begin
        if operand1.fType = TNumericType.Int8 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:          exit Int8(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ Int8(operand2);
                TOperationToken.Less:             exit Int8(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:      exit Int8(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit Int8(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit Int8(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit Int8(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit Int8(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit Int8(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = UInt16(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit Int8(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit Int8(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ Single(operand2);
                TOperationToken.Less:        exit Int8(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit Int8(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit Int8(operand1) ≥ Double(operand2);
                TOperationToken.Less:        exit Int8(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit Int8(operand1) ≤ Double(operand2);
              end;
            end;
          end;
        end;
   //---------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Int16 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit Int16(operand1) ≤ Int8(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) < Int8(operand2);
                TOperationToken.Equal:            exit Int16(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit Int16(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) > Int16(operand2);
                TOperationToken.Less:        exit Int16(operand1) ≤ Int16(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) < Int16(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit Int16(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit Int16(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit Int16(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit Int16(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit Int16(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit Int16(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit Int16(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit Int16(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit Int16(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit Int16(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = UInt16(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit Int16(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit Int16(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit Int16(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit Int16(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit Int16(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit Int16(operand1) <> UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ Single(operand2);
                TOperationToken.Less:        exit Int16(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit Int16(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit Int16(operand1) ≥ Double(operand2);
                TOperationToken.Less:        exit Int16(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit Int16(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit Int16(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit Int16(operand1) <> Double(operand2);
              end;
            end;
          end;
        end;

      //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Int32 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit Int32(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit Int32(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit Int8(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit Int8(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit Int32(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit Int32(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit Int32(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit Int32(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = UInt16(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit Int32(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit Int32(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ Single(operand2);
                TOperationToken.Less:        exit Int32(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit Int32(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit Int32(operand1) ≥ Double(operand2);
                TOperationToken.Less:        exit Int32(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit Int32(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit Int32(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit Int32(operand1) <> Double(operand2);
              end;
            end;
          end;
        end;

       //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Int64 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit Int64(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit Int64(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit Int64(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit Int64(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit Int64(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit Int64(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = UInt16(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit Int64(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit Int64(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ Single(operand2);
                TOperationToken.Less:        exit Int64(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit Int64(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit Int64(operand1) ≥ Double(operand2);
                TOperationToken.Less:        exit Int64(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit Int64(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit Int64(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit Int64(operand1) <> Double(operand2);
              end;
            end;
          end;
        end;

       //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.UInt8 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ Single(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit UInt8(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt8(operand1) ≥ Double(operand2);
                TOperationToken.Less:        exit UInt8(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit UInt8(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit UInt8(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit UInt8(operand1) <> Double(operand2);
              end;
            end;
          end;
        end;


       //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.UInt16 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = UInt16(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ Single(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit UInt16(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt16(operand1) ≥ Double(operand2);
                TOperationToken.Less:        exit UInt16(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit UInt16(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit UInt16(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit UInt16(operand1) <> Double(operand2);
              end;
            end;
          end;
        end;

        //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.UInt32 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit UInt32(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit UInt32(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit UInt32(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit UInt32(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit UInt32(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit UInt32(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = UInt16(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> UInt16(operand2)
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit UInt32(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> UInt32(operand2)
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit UInt32(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> UInt64(operand2)
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ Single(operand2);
                TOperationToken.Less: exit UInt32(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> Single(operand2)
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit UInt32(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt32(operand1) ≥ Double(operand2);
                TOperationToken.Less: exit UInt32(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit UInt32(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit UInt32(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit UInt32(operand1) <> Double(operand2)
              end;
            end;
          end;
        end;

       //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.UInt64 then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> Int16(operand2);

              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ Single(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit UInt64(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit UInt64(operand1) ≥ Double(operand2);
                TOperationToken.Less:        exit UInt64(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit UInt64(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit UInt64(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit UInt64(operand1) <> Double(operand2);
              end;
            end;
          end;
        end;


        //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Single then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit Single(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit Single(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit Single(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit Single(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit Single(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit Single(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit Single(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit Single(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit Single(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit Single(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit Single(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit Single(operand1) = UInt16(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit Single(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit Single(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit Single(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ UInt64(operand2);
                TOperationToken.Equal:            exit Single(operand1) = UInt64(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) ≥ Single(operand2);
                TOperationToken.Less:        exit Single(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit Single(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit Single(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit Single(operand1) > Double(operand2);
                TOperationToken.Less:        exit Single(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit Single(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit Single(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit Single(operand1) <> Double(operand2);
              end;
            end;
          end;
        end;

        //------------------------------------------------------------------------------------------//
        if operand1.fType = TNumericType.Double then
        begin
          case operand2.fType of
            TNumericType.Int8:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > Int8(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ Int8(operand2);
                TOperationToken.Less:        exit Double(operand1) < Int8(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ Int8(operand2);
                TOperationToken.Equal:            exit Double(operand1) = Int8(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> Int8(operand2);
              end;
            end;
            TNumericType.Int16:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > Int16(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ Int16(operand2);
                TOperationToken.Less:        exit Double(operand1) < Int16(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ Int16(operand2);
                TOperationToken.Equal:            exit Double(operand1) = Int16(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> Int16(operand2);
              end;
            end;
            TNumericType.Int32:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > Int32(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ Int32(operand2);
                TOperationToken.Less:        exit Double(operand1) < Int32(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ Int32(operand2);
                TOperationToken.Equal:            exit Double(operand1) = Int32(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> Int32(operand2);
              end;
            end;
            TNumericType.Int64:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > Int64(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ Int64(operand2);
                TOperationToken.Less:        exit Double(operand1) < Int64(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ Int64(operand2);
                TOperationToken.Equal:            exit Double(operand1) = Int64(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> Int64(operand2);
              end;
            end;
            TNumericType.UInt8:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > UInt8(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ UInt8(operand2);
                TOperationToken.Less:        exit Double(operand1) < UInt8(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ UInt8(operand2);
                TOperationToken.Equal:            exit Double(operand1) = UInt8(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> UInt8(operand2);
              end;
            end;
            TNumericType.UInt16:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > UInt16(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ UInt16(operand2);
                TOperationToken.Less:        exit Double(operand1) < UInt16(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ UInt16(operand2);
                TOperationToken.Equal:            exit Double(operand1) = UInt16(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> UInt16(operand2);
              end;
            end;
            TNumericType.UInt32:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > UInt32(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ UInt32(operand2);
                TOperationToken.Less:        exit Double(operand1) < UInt32(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ UInt32(operand2);
                TOperationToken.Equal:            exit Double(operand1) = UInt32(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> UInt32(operand2);
              end;
            end;
            TNumericType.UInt64:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > UInt64(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ UInt64(operand2);
                TOperationToken.Less:        exit Double(operand1) < UInt64(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ UInt64(operand2);
              end;
            end;
            TNumericType.Single:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > Single(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≤ Single(operand2);
                TOperationToken.Less:        exit Double(operand1) < Single(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ Single(operand2);
                TOperationToken.Equal:            exit Double(operand1) = Single(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> Single(operand2);
              end;
            end;
            TNumericType.Double:
            begin
              case token of
                TOperationToken.Greater:        exit Double(operand1) > Double(operand2);
                TOperationToken.GreaterOrEqual:   exit Double(operand1) ≥ Double(operand2);
                TOperationToken.Less:        exit Double(operand1) < Double(operand2);
                TOperationToken.LessOrEqual:   exit Double(operand1) ≤ Double(operand2);
                TOperationToken.Equal:            exit Double(operand1) = Double(operand2);
                TOperationToken.NotEqual:         exit Double(operand1) <> Int8(operand2);
              end;
            end;
          end;
        end;
      end;

    public
      method ToString: String; override;
      begin
        exit AsString;
      end;

      method AsString: String;
      begin
        case fType of
          TNumericType.Boolean:   exit fValue.a0.AsString;
          TNumericType.Int8:      exit fValue.a1.AsString;
          TNumericType.Int16:     exit fValue.a2.AsString;
          TNumericType.Int32:     exit fValue.a3.AsString;
          TNumericType.Int64:     exit fValue.a4.AsString;
          TNumericType.UInt8:     exit fValue.a5.AsString;
          TNumericType.UInt16:    exit fValue.a6.AsString;
          TNumericType.UInt32:    exit fValue.a7.AsString;
          TNumericType.UInt64:    exit fValue.a8.AsString;
          TNumericType.Single:    exit fValue.a9.AsString;
          TNumericType.Double:    exit fValue.a10.AsString;
          TNumericType.AnsiChar:  exit fValue.a11.AsString;
        end;
      end;

      method HashCode: Integer;
      begin
        exit 3847348; //just some rndVal;
      end;

      method &Equals(other: TNumeric): Boolean;
      begin
        exit false;//self.fValue = other.fValue; --> look at this line here later
      end;

      method CompareTo(a: TNumeric): Integer;
      begin
        exit 0;
        {
        if self = a then exit 0
        else if self < a then exit -1
        else exit 1;
        }
      end;

      //ARITHEMETIC OPERATOR
      operator &Add(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit ArithmeticOperation(operand1, operand2, TOperationToken.Add);
      end;

      operator Subtract(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit ArithmeticOperation(operand1, operand2, TOperationToken.Subtract);
      end;

      operator Multiply(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit ArithmeticOperation(operand1, operand2, TOperationToken.Multiply);
      end;

      operator Divide(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit ArithmeticOperation(operand1, operand2, TOperationToken.Divide);
      end;

      operator Modulus(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit ArithmeticOperation(operand1, operand2, TOperationToken.Modulus);
      end;

      operator BitwiseAnd(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit ArithmeticOperation(operand1, operand2, TOperationToken.BitwiseAnd);
      end;

      //Logical OPERATOR
      operator Greater(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit LogicalOperation(operand1, operand2, TOperationToken.Greater);
      end;

      operator GreaterOrEqual(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit LogicalOperation(operand1, operand2, TOperationToken.GreaterOrEqual);
      end;

      operator Less(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit LogicalOperation(operand1, operand2, TOperationToken.Less);
      end;

      operator LessOrEqual(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit LogicalOperation(operand1, operand2, TOperationToken.LessOrEqual);
      end;

      operator Equal(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit LogicalOperation(operand1, operand2, TOperationToken.Equal);
      end;

      operator NotEqual(const operand1, operand2: TNumeric): TNumeric;
      begin
        exit LogicalOperation(operand1, operand2, TOperationToken.NotEqual);
      end;

      {IMPLICIT CONVERSION FROM:  BaseType to TNumeric}
       //var myNumber : TNumber := 100;
      operator Implicit(const operand: Boolean): TNumeric;
      begin
        var nr : TNumeric;
        nr.fValue.a0 := operand;
        nr.fType := TNumericType.Boolean;
        exit nr;
      end;

      operator Implicit(const operand: Int8): TNumeric;
      begin
        var nr : TNumeric;
        nr.fValue.a1 := operand;
        nr.fType := TNumericType.Int8;
        exit nr;
      end;

      operator Implicit(const operand: Int16): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a2 := operand;
        nr.fType := TNumericType.Int16;
        exit nr;
      end;

      operator Implicit(const operand: Int32): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a3 := operand;
        nr.fType := TNumericType.Int32;
        exit nr;
      end;

      operator Implicit(const operand: Int64): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a4 := operand;
        nr.fType := TNumericType.Int64;
        exit nr;
      end;

      operator Implicit(const operand: UInt8): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a5 := operand;
        nr.fType := TNumericType.UInt8;
        exit nr;
      end;

      operator Implicit(const operand: UInt16): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a6 := operand;
        nr.fType := TNumericType.UInt16;
        exit nr;
      end;

      operator Implicit(const operand: UInt32): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a7 := operand;
        nr.fType := TNumericType.UInt32;
        exit nr;
      end;

      operator Implicit(const operand: UInt64): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a8 := operand;
        nr.fType := TNumericType.UInt64;
        exit nr;
      end;

      operator Implicit(const operand: Single): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a9 := operand;
        nr.fType := TNumericType.Single;
        exit nr;
      end;

      operator Implicit(const operand: Double): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a10 := operand;
        nr.fType := TNumericType.Double;
        exit nr;
      end;

      operator Implicit(const operand: AnsiChar): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a11 := operand;
        nr.fType := TNumericType.AnsiChar;
        exit nr;
      end;



      {2. EXPLICIT CONVERSION FROM:  BaseType to TNumeric  --> "var b: TNumeric := BaseType(operand.fValue)"}
      operator Explicit(const operand: Int8): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a1 := operand;
        nr.fType := TNumericType.Int8;
        exit nr;
      end;

      operator Explicit(const operand: Int16): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a2 := operand;
        nr.fType := TNumericType.Int16;
        exit nr;
      end;

      operator Explicit(const operand: Int32): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a3 := operand;
        nr.fType := TNumericType.Int32;
        exit nr;
      end;

      operator Explicit(const operand: Int64): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a4 := operand;
        nr.fType := TNumericType.Int64;
        exit nr;
      end;

      operator Explicit(const operand: UInt8): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a5 := operand;
        nr.fType := TNumericType.UInt8;
        exit nr;
      end;

      operator Explicit(const operand: UInt16): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a6 := operand;
        nr.fType := TNumericType.UInt16;
        exit nr;
      end;

      operator Explicit(const operand: UInt32): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a7 := operand;
        nr.fType := TNumericType.UInt32;
        exit nr;
      end;

      operator Explicit(const operand: UInt64): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a8 := operand;
        nr.fType := TNumericType.UInt64;
        exit nr;
      end;

      operator Explicit(const operand: Single): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a9 := operand;
        nr.fType := TNumericType.Single;
        exit nr;
      end;

      operator Explicit(const operand: Double): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a10 := operand;
        nr.fType := TNumericType.Double;
        exit nr;
      end;

      operator Explicit(const operand: AnsiChar): TNumeric;
      begin
         //var myNumber : Number := 100;
        var nr : TNumeric;
        nr.fValue.a11 := operand;
        nr.fType := TNumericType.AnsiChar;
        exit nr;
      end;

      {1. EXPLICIT CONVERSION FROM:  TNumeric to BaseType => var bt: BaseType := BaseType(myNumeric)}
      operator Explicit(const operand: TNumeric): Boolean;
      begin
        exit Cast<Boolean>(operand) &To(TNumericType.Boolean);
      end;

      operator Explicit(const operand: TNumeric): Int8;
      begin
        exit Cast<Int8>(operand) &To(TNumericType.Int8);
      end;

      operator Explicit(const operand: TNumeric): Int16;
      begin
        exit Cast<Int16>(operand) &To(TNumericType.Int16);
      end;

      operator Explicit(const operand: TNumeric): Int32;
      begin
        exit Cast<Int32>(operand) &To(TNumericType.Int32);
      end;

      operator Explicit(const operand: TNumeric): Int64;
      begin
        exit Cast<Int64>(operand) &To(TNumericType.Int64);
      end;

      operator Explicit(const operand: TNumeric): UInt8;
      begin
        exit Cast<UInt8>(operand) &To(TNumericType.UInt8);
      end;

      operator Explicit(const operand: TNumeric): UInt16;
      begin
        exit Cast<UInt16>(operand) &To(TNumericType.UInt16);
      end;

      operator Explicit(const operand: TNumeric): UInt32;
      begin
        exit Cast<UInt32>(operand) &To(TNumericType.UInt32);
      end;

      operator Explicit(const operand: TNumeric): UInt64;
      begin
        exit Cast<UInt64>(operand) &To(TNumericType.UInt64);
      end;

      operator Explicit(const operand: TNumeric): Single;
      begin
        exit Cast<Single>(operand) &To(TNumericType.Single);
      end;

      operator Explicit(const operand: TNumeric): Double;
      begin
        exit Cast<Double>(operand) &To(TNumericType.Double);
      end;

      operator Explicit(const operand: TNumeric): AnsiChar;
      begin
        exit Cast<AnsiChar>(operand) &To(TNumericType.AnsiChar);
      end;
    end;
end.