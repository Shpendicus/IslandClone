namespace RemObjects.Elements.System;

	type
		TNumericType    = public enum (Boolean, Int8, Int16, Int32, Int64, AnsiChar,
																	 UInt8, UInt16, UInt32, UInt64, Single, Double, Digital) of Byte;

		TOperationToken = public enum (&Add, Subtract, Multiply, Divide, Modulus, BitwiseAnd,
																		GreaterOrEqual, Greater, Equal, NotEqual, LessOrEqual, Less); //can be expanded ofc with logical operators

		//TCharSet = set of ['a'..'z', 'A.'..'Z', '0'..'9'];

		[Union]
		TValue nested in TNumeric = unit record
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

		TNumeric = public record(IComparable<TNumeric>, IEquatable<TNumeric>)
		unit
			fValue: TValue;
			fType: TNumericType;
			fUseCharCodesForOperation: Boolean;
			//This allows to have a UnicodeChar to be used for arithmeticalOps,
			//Like saying: '~' + '_' translates to: ---> Int8('~') + Int8('_');
			//and so on...

		private
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

									if result > high(Byte) then
										raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

									exit AnsiChar(result);
								end;
								TOperationToken.Subtract:
								begin
									result := (chrOp1 - chrOp2);

									if result < low(Byte) then
										raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

									exit AnsiChar(result);
								end;
							end;
						end;
					end;
				end;

				if (operand1.fType = TNumericType.Int8) then
				begin
					const chrOp1 = Byte(AnsiChar(operand1));
					case operand2.fType of

						TNumericType.AnsiChar:
						begin
							const chrOp2 = Byte(AnsiChar(operand2));

							case token of
								TOperationToken.Add:
								begin
									if (chrOp1 + chrOp2) > high(Byte) then
										raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

									exit AnsiChar(chrOp1 + chrOp2);
								end;
								TOperationToken.Subtract:
								begin
									if (chrOp1 - chrOp2) > high(Byte) < 0 then
										raise new ArgumentOutOfRangeException('the result of the + operation extends the valid boundaries of AnsiChar');

									exit AnsiChar(chrOp1 - chrOp2);
								end;
							 end;
						end;
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
					case operand2.fType of
						TNumericType.Int8, TNumericType.AnsiChar:
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
				end;
			end;

			//-----------------------------------------------------------------------------------------------------//
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
			constructor(useCharCodesForOperation: Boolean);
			begin
				if useCharCodesForOperation then

			end;

			method ToString: String; override;
			begin
				case fType of
					TNumericType.Boolean: exit fValue.a0.ToString();
					TNumericType.Int8:    exit fValue.a1.ToString();
					TNumericType.Int16:   exit fValue.a2.ToString();
					TNumericType.Int32:   exit fValue.a3.ToString();
					TNumericType.Int64:   exit fValue.a4.ToString();
					TNumericType.UInt8:   exit fValue.a5.ToString();
					TNumericType.UInt16:  exit fValue.a6.ToString();
					TNumericType.UInt32:  exit fValue.a7.ToString();
					TNumericType.UInt64:  exit fValue.a8.ToString();
					TNumericType.Single:  exit fValue.a9.ToString();
					TNumericType.Double:  exit fValue.a10.ToString();
					TNumericType.AnsiChar:  exit fValue.a11.ToString;
				end;
			end;

			method &Equals(other: TNumeric): Boolean;
			begin
				exit self = other;
			end;

			method CompareTo(a: TNumeric): Integer;
			begin
				if self = a then exit 0
				else if self < a then exit -1
				else exit 1;
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


			//-----------------CONVERSION-------------------------------------------------------------------//
			{1.IMPLICIT CONVERSION FROM:  TNumeric to BaseType => var bt: BaseType := myNumeric}
			operator Implicit(const operand: TNumeric): Boolean;
			begin
				exit operand.fValue.a0;
			end;

			operator Implicit(const operand: TNumeric): Int8;
			begin
				exit operand.fValue.a1;
			end;

			operator Implicit(const operand:TNumeric): Int16;
			begin
				exit operand.fValue.a2;
			end;

			operator Implicit(const operand: TNumeric): Int32;
			begin
				exit operand.fValue.a3;
			end;

			operator Implicit(const operand: TNumeric): Int64;
			begin
				exit operand.fValue.a4;
			end;

			operator Implicit(const operand: TNumeric): UInt8;
			begin
				exit operand.fValue.a5;
			end;

			operator Implicit(const operand: TNumeric): UInt16;
			begin
				exit operand.fValue.a6;
			end;

			operator Implicit(const operand: TNumeric): UInt32;
			begin
				exit operand.fValue.a7;
			end;

			operator Implicit(const operand: TNumeric): UInt64;
			begin
				exit operand.fValue.a8;
			end;

			operator Implicit(const operand: TNumeric): Single;
			begin
				exit operand.fValue.a9;
			end;

			operator Implicit(const operand: TNumeric): Double;
			begin
				exit operand.fValue.a10;
			end;

			operator Implicit(const operand: TNumeric): AnsiChar;
			begin
				exit operand.fValue.a11;
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
				exit operand.fValue.a0;
			end;

			operator Explicit(const operand: TNumeric): Int8;
			begin
				exit operand.fValue.a1;
			end;

			operator Explicit(const operand: TNumeric): Int16;
			begin
				exit operand.fValue.a2;
			end;

			operator Explicit(const operand: TNumeric): Int32;
			begin
				exit operand.fValue.a3;
			end;

			operator Explicit(const operand: TNumeric): Int64;
			begin
				exit operand.fValue.a4;
			end;

			operator Explicit(const operand: TNumeric): UInt8;
			begin
				exit operand.fValue.a5;
			end;

			operator Explicit(const operand: TNumeric): UInt16;
			begin
				exit operand.fValue.a6;
			end;

			operator Explicit(const operand: TNumeric): UInt32;
			begin
				exit operand.fValue.a7;
			end;

			operator Explicit(const operand: TNumeric): UInt64;
			begin
				exit operand.fValue.a8;
			end;

			operator Explicit(const operand: TNumeric): Single;
			begin
				exit operand.fValue.a9;
			end;

			operator Explicit(const operand: TNumeric): Double;
			begin
				exit operand.fValue.a10;
			end;

			operator Explicit(const operand: TNumeric): AnsiChar;
			begin
				exit operand.fValue.a11;
			end;
		end;
end.