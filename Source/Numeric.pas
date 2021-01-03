namespace RemObjects.Elements.System;

	type
		TNumericType = public enum (Boolean, Int8, Int16, Int32, Int64,
															 UInt8, UInt32, UInt64, Single, Double) of byte;

		TOperationToken = public enum (&Add, Subtract, Multiply, Divide,
									    GreaterOrEqual, Greater, Equal, NotEqual, LessOrEqual, Less); //can be expanded ofc with logical operators

		[Union]
		TNumeric = public record
		private
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
			fType: TNumericType;

			method ArithmeticOperation(const operand1, operand2: TNumeric; token: TOperationToken): TNumeric; static;
			begin
				if operand1.fType = TNumericType.Int8 then
				begin
					case operand2.fType of
						TNumericType.Int8:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + Single(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - Single(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * Single(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := Int8(operand1) + Double(operand2);
								TOperationToken.Subtract: result := Int8(operand1) - Double(operand2);
								TOperationToken.Multiply: result := Int8(operand1) * Double(operand2);
								TOperationToken.Divide:   result := Int8(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := Int16(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + Single(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - Single(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * Single(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := Int16(operand1) + Double(operand2);
								TOperationToken.Subtract: result := Int16(operand1) - Double(operand2);
								TOperationToken.Multiply: result := Int16(operand1) * Double(operand2);
								TOperationToken.Divide:   result := Int16(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := Int32(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + Single(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - Single(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * Single(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := Int32(operand1) + Double(operand2);
								TOperationToken.Subtract: result := Int32(operand1) - Double(operand2);
								TOperationToken.Multiply: result := Int32(operand1) * Double(operand2);
								TOperationToken.Divide:   result := Int32(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := Int64(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + Single(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - Single(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * Single(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := Int64(operand1) + Double(operand2);
								TOperationToken.Subtract: result := Int64(operand1) - Double(operand2);
								TOperationToken.Multiply: result := Int64(operand1) * Double(operand2);
								TOperationToken.Divide:   result := Int64(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := UInt8(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + Single(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - Single(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * Single(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := UInt8(operand1) + Double(operand2);
								TOperationToken.Subtract: result := UInt8(operand1) - Double(operand2);
								TOperationToken.Multiply: result := UInt8(operand1) * Double(operand2);
								TOperationToken.Divide:   result := UInt8(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := UInt16(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + Single(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - Single(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * Single(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := UInt16(operand1) + Double(operand2);
								TOperationToken.Subtract: result := UInt16(operand1) - Double(operand2);
								TOperationToken.Multiply: result := UInt16(operand1) * Double(operand2);
								TOperationToken.Divide:   result := UInt16(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := UInt32(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + Single(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - Single(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * Single(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := UInt32(operand1) + Double(operand2);
								TOperationToken.Subtract: result := UInt32(operand1) - Double(operand2);
								TOperationToken.Multiply: result := UInt32(operand1) * Double(operand2);
								TOperationToken.Divide:   result := UInt32(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := UInt64(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + Single(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - Single(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * Single(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := UInt64(operand1) + Double(operand2);
								TOperationToken.Subtract: result := UInt64(operand1) - Double(operand2);
								TOperationToken.Multiply: result := UInt64(operand1) * Double(operand2);
								TOperationToken.Divide:   result := UInt64(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := Single(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := Single(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := Single(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := Single(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := Single(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := Single(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := Single(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := Single(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := Single(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := Single(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := Single(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := Single(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := Single(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := Single(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := Single(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := Single(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := Single(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := Single(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := Single(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := Single(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := Single(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := Single(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := Single(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := Single(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := Single(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + Single(operand2);
								TOperationToken.Subtract: result := Single(operand1) - Single(operand2);
								TOperationToken.Multiply: result := Single(operand1) * Single(operand2);
								TOperationToken.Divide:   result := Single(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := Single(operand1) + Double(operand2);
								TOperationToken.Subtract: result := Single(operand1) - Double(operand2);
								TOperationToken.Multiply: result := Single(operand1) * Double(operand2);
								TOperationToken.Divide:   result := Single(operand1) / Double(operand2);
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
								TOperationToken.Add:      result := Double(operand1) + Int8(operand2);
								TOperationToken.Subtract: result := Double(operand1) - Int8(operand2);
								TOperationToken.Multiply: result := Double(operand1) * Int8(operand2);
								TOperationToken.Divide:   result := Double(operand1) / Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + Int16(operand2);
								TOperationToken.Subtract: result := Double(operand1) - Int16(operand2);
								TOperationToken.Multiply: result := Double(operand1) * Int16(operand2);
								TOperationToken.Divide:   result := Double(operand1) / Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + Int32(operand2);
								TOperationToken.Subtract: result := Double(operand1) - Int32(operand2);
								TOperationToken.Multiply: result := Double(operand1) * Int32(operand2);
								TOperationToken.Divide:   result := Double(operand1) / Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + Int64(operand2);
								TOperationToken.Subtract: result := Double(operand1) - Int64(operand2);
								TOperationToken.Multiply: result := Double(operand1) * Int64(operand2);
								TOperationToken.Divide:   result := Double(operand1) / Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + UInt8(operand2);
								TOperationToken.Subtract: result := Double(operand1) - UInt8(operand2);
								TOperationToken.Multiply: result := Double(operand1) * UInt8(operand2);
								TOperationToken.Divide:   result := Double(operand1) / UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + UInt16(operand2);
								TOperationToken.Subtract: result := Double(operand1) - UInt16(operand2);
								TOperationToken.Multiply: result := Double(operand1) * UInt16(operand2);
								TOperationToken.Divide:   result := Double(operand1) / UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + UInt32(operand2);
								TOperationToken.Subtract: result := Double(operand1) - UInt32(operand2);
								TOperationToken.Multiply: result := Double(operand1) * UInt32(operand2);
								TOperationToken.Divide:   result := Double(operand1) / UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + UInt64(operand2);
								TOperationToken.Subtract: result := Double(operand1) - UInt64(operand2);
								TOperationToken.Multiply: result := Double(operand1) * UInt64(operand2);
								TOperationToken.Divide:   result := Double(operand1) / UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + Single(operand2);
								TOperationToken.Subtract: result := Double(operand1) - Single(operand2);
								TOperationToken.Multiply: result := Double(operand1) * Single(operand2);
								TOperationToken.Divide:   result := Double(operand1) / Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Add:      result := Double(operand1) + Double(operand2);
								TOperationToken.Subtract: result := Double(operand1) - Double(operand2);
								TOperationToken.Multiply: result := Double(operand1) * Double(operand2);
								TOperationToken.Divide:   result := Double(operand1) / Double(operand2);
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
								TOperationToken.Greater:          result := Int8(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ Int8(operand2);
								TOperationToken.Less:             result := Int8(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:      result := Int8(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := Int8(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := Int8(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := Int8(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := Int8(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := Int8(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> UIn16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := Int8(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := Int8(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ Single(operand2);
								TOperationToken.Less:        result := Int8(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := Int8(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := Int8(operand1) ≥ Double(operand2);
								TOperationToken.Less:        result := Int8(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := Int8(operand1) ≤ Double(operand2);
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
								TOperationToken.Greater:        result := Int16(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := Int16(operand1) ≤ Int8(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) < Int8(operand2);
								TOperationToken.Equal:            result := Int16(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := Int16(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) > Int16(operand2);
								TOperationToken.Less:        result := Int16(operand1) ≤ Int16(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) < Int16(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := Int16(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := Int16(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := Int16(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := Int16(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := Int16(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := Int16(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := Int16(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := Int16(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := Int16(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := Int16(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := Int16(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := Int16(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := Int16(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := Int16(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := Int16(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := Int16(operand1) <> UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ Single(operand2);
								TOperationToken.Less:        result := Int16(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := Int16(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := Int16(operand1) ≥ Double(operand2);
								TOperationToken.Less:        result := Int16(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := Int16(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := Int16(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := Int16(operand1) <> Double(operand2);
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
								TOperationToken.Greater:        result := Int32(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := Int32(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := Int32(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := Int8(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := Int8(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := Int32(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := Int32(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := Int32(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := Int32(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := Int32(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := Int32(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ Single(operand2);
								TOperationToken.Less:        result := Int32(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := Int32(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := Int32(operand1) ≥ Double(operand2);
								TOperationToken.Less:        result := Int32(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := Int32(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := Int32(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := Int32(operand1) <> Double(operand2);
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
								TOperationToken.Greater:        result := Int64(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := Int64(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := Int64(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := Int64(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := Int64(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := Int64(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := Int64(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> Uint16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := Int64(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := Int64(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ Single(operand2);
								TOperationToken.Less:        result := Int64(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := Int64(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := Int64(operand1) ≥ Double(operand2);
								TOperationToken.Less:        result := Int64(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := Int64(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := Int64(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := Int64(operand1) <> Double(operand2);
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
								TOperationToken.Greater:        result := UInt8(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> UInt8(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ Single(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := UInt8(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt8(operand1) ≥ Double(operand2);
								TOperationToken.Less:        result := UInt8(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := UInt8(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := UInt8(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := UInt8(operand1) <> Double(operand2);
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
								TOperationToken.Greater:        result := UInt16(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ Single(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := UInt16(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt16(operand1) ≥ Double(operand2);
								TOperationToken.Less:        result := UInt16(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := UInt16(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := UInt16(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := UInt16(operand1) <> Double(operand2);
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
								TOperationToken.Greater:        result := UInt32(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := UInt32(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := UInt32(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := UInt32(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := UInt32(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := UInt32(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := UInt32(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> UInt16(operand2)
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := UInt32(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> UInt32(operand2)
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := UInt32(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> UInt64(operand2)
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ Single(operand2);
								TOperationToken.Less: result := UInt32(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> Single(operand2)
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := UInt32(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt32(operand1) ≥ Double(operand2);
								TOperationToken.Less: result := UInt32(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := UInt32(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := UInt32(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := UInt32(operand1) <> Double(operand2)
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
								TOperationToken.Greater:        result := UInt64(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> Int16(operand2);

							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ Single(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := UInt64(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := UInt64(operand1) ≥ Double(operand2);
								TOperationToken.Less:        result := UInt64(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := UInt64(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := UInt64(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := UInt64(operand1) <> Double(operand2);
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
								TOperationToken.Greater:        result := Single(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := Single(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := Single(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := Single(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := Single(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := Single(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := Single(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := Single(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := Single(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := Single(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := Single(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := Single(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := Single(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := Single(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := Single(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := Single(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ UInt64(operand2);
								TOperationToken.Equal:            result := Single(operand1) = UInt64(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) ≥ Single(operand2);
								TOperationToken.Less:        result := Single(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := Single(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := Single(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := Single(operand1) > Double(operand2);
								TOperationToken.Less:        result := Single(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := Single(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := Single(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := Single(operand1) <> Double(operand2);
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
								TOperationToken.Greater:        result := Double(operand1) > Int8(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ Int8(operand2);
								TOperationToken.Less:        result := Double(operand1) < Int8(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ Int8(operand2);
								TOperationToken.Equal:            result := Double(operand1) = Int8(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> Int8(operand2);
							end;
						end;
						TNumericType.Int16:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > Int16(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ Int16(operand2);
								TOperationToken.Less:        result := Double(operand1) < Int16(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ Int16(operand2);
								TOperationToken.Equal:            result := Double(operand1) = Int16(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> Int16(operand2);
							end;
						end;
						TNumericType.Int32:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > Int32(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ Int32(operand2);
								TOperationToken.Less:        result := Double(operand1) < Int32(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ Int32(operand2);
								TOperationToken.Equal:            result := Double(operand1) = Int32(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> Int32(operand2);
							end;
						end;
						TNumericType.Int64:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > Int64(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ Int64(operand2);
								TOperationToken.Less:        result := Double(operand1) < Int64(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ Int64(operand2);
								TOperationToken.Equal:            result := Double(operand1) = Int64(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> Int64(operand2);
							end;
						end;
						TNumericType.UInt8:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > UInt8(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ UInt8(operand2);
								TOperationToken.Less:        result := Double(operand1) < UInt8(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ UInt8(operand2);
								TOperationToken.Equal:            result := Double(operand1) = UInt8(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> UInt8(operand2);
							end;
						end;
						TNumericType.UInt16:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > UInt16(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ UInt16(operand2);
								TOperationToken.Less:        result := Double(operand1) < UInt16(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ UInt16(operand2);
								TOperationToken.Equal:            result := Double(operand1) = UInt16(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> UInt16(operand2);
							end;
						end;
						TNumericType.UInt32:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > UInt32(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ UInt32(operand2);
								TOperationToken.Less:        result := Double(operand1) < UInt32(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ UInt32(operand2);
								TOperationToken.Equal:            result := Double(operand1) = UInt32(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> UInt32(operand2);
							end;
						end;
						TNumericType.UInt64:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > UInt64(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ UInt64(operand2);
								TOperationToken.Less:        result := Double(operand1) < UInt64(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ UInt64(operand2);
							end;
						end;
						TNumericType.Single:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > Single(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≤ Single(operand2);
								TOperationToken.Less:        result := Double(operand1) < Single(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ Single(operand2);
								TOperationToken.Equal:            result := Double(operand1) = Single(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> Single(operand2);
							end;
						end;
						TNumericType.Double:
						begin
							case token of
								TOperationToken.Greater:        result := Double(operand1) > Double(operand2);
								TOperationToken.GreaterOrEqual:   result := Double(operand1) ≥ Double(operand2);
								TOperationToken.Less:        result := Double(operand1) < Double(operand2);
								TOperationToken.LessOrEqual:   result := Double(operand1) ≤ Double(operand2);
								TOperationToken.Equal:            result := Double(operand1) = Double(operand2);
								TOperationToken.NotEqual:         result := Double(operand1) <> Int8(operand2);
							end;
						end;
					end;
				end;
			end;

		public
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
				exit operand.a0;
			end;

			operator Implicit(const operand: TNumeric): Int8;
			begin
				exit operand.a1;
			end;

			operator Implicit(const operand: TNumeric): Int16;
			begin
				exit operand.a2;
			end;

			operator Implicit(const operand: TNumeric): Int32;
			begin
				exit operand.a3;
			end;

			operator Implicit(const operand: TNumeric): Int64;
			begin
				exit operand.a4;
			end;

			operator Implicit(const operand: TNumeric): UInt8;
			begin
				exit operand.a5;
			end;

			operator Implicit(const operand: TNumeric): UInt16;
			begin
				exit operand.a6;
			end;

			operator Implicit(const operand: TNumeric): UInt32;
			begin
				exit operand.a7;
			end;

			operator Implicit(const operand: TNumeric): UInt64;
			begin
				exit operand.a8;
			end;

			operator Implicit(const operand: TNumeric): Single;
			begin
				exit operand.a9;
			end;

			operator Implicit(const operand: TNumeric): Double;
			begin
				exit operand.a10;
			end;

			operator Implicit(const operand: Boolean): TNumeric;
			begin
				var nr : TNumeric;
				nr.a0 := operand;
				nr.fType := TNumericType.Boolean;
				exit nr;
			end;

			{IMPLICIT CONVERSION FROM:  BaseType to TNumeric}
			 //var myNumber : TNumber := 100;
			operator Implicit(const operand: Int8): TNumeric;
			begin
				var nr : TNumeric;
				nr.a1 := operand;
				nr.fType := TNumericType.Int8;
				exit nr;
			end;

			operator Implicit(const operand: Int16): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a2 := operand;
				nr.fType := TNumericType.Int16;
				exit nr;
			end;

			operator Implicit(const operand: Int32): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a3 := operand;
				nr.fType := TNumericType.Int32;
				exit nr;
			end;

			operator Implicit(const operand: Int64): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a4 := operand;
				nr.fType := TNumericType.Int64;
				exit nr;
			end;

			operator Implicit(const operand: UInt8): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a5 := operand;
				nr.fType := TNumericType.UInt8;
				exit nr;
			end;

			operator Implicit(const operand: UInt16): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a6 := operand;
				nr.fType := TNumericType.UInt16;
				exit nr;
			end;

			operator Implicit(const operand: UInt32): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a7 := operand;
				nr.fType := TNumericType.UInt32;
				exit nr;
			end;

			operator Implicit(const operand: UInt64): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a8 := operand;
				nr.fType := TNumericType.UInt64;
				exit nr;
			end;

			operator Implicit(const operand: Single): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a9 := operand;
				nr.fType := TNumericType.Single;
				exit nr;
			end;

			operator Implicit(const operand: Double): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a10 := operand;
				nr.fType := TNumericType.Double;
				exit nr;
			end;


			{2. EXPLICIT CONVERSION FROM:  BaseType to TNumeric  --> "var b: TNumeric := BaseType(operand)"}
			operator Explicit(const operand: Int8): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a1 := operand;
				nr.fType := TNumericType.Int8;
				exit nr;
			end;

			operator Explicit(const operand: Int16): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a2 := operand;
				nr.fType := TNumericType.Int16;
				exit nr;
			end;

			operator Explicit(const operand: Int32): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a3 := operand;
				nr.fType := TNumericType.Int32;
				exit nr;
			end;

			operator Explicit(const operand: Int64): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a4 := operand;
				nr.fType := TNumericType.Int64;
				exit nr;
			end;

			operator Explicit(const operand: UInt8): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a5 := operand;
				nr.fType := TNumericType.UInt8;
				exit nr;
			end;

			operator Explicit(const operand: UInt16): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a6 := operand;
				nr.fType := TNumericType.UInt16;
				exit nr;
			end;

			operator Explicit(const operand: UInt32): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a7 := operand;
				nr.fType := TNumericType.UInt32;
				exit nr;
			end;

			operator Explicit(const operand: UInt64): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a8 := operand;
				nr.fType := TNumericType.UInt64;
				exit nr;
			end;

			operator Explicit(const operand: Single): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a9 := operand;
				nr.fType := TNumericType.Single;
				exit nr;
			end;

			operator Explicit(const operand: Double): TNumeric;
			begin
				 //var myNumber : Number := 100;
				var nr : TNumeric;
				nr.a10 := operand;
				nr.fType := TNumericType.Double;
				exit nr;
			end;


			{1. EXPLICIT CONVERSION FROM:  TNumeric to BaseType => var bt: BaseType := BaseType(myNumeric)}
			operator Explicit(const operand: TNumeric): Boolean;
			begin
				exit operand.a0;
			end;

			operator Explicit(const operand: TNumeric): Int8;
			begin
				exit operand.a1;
			end;

			operator Explicit(const operand: TNumeric): Int16;
			begin
				exit operand.a2;
			end;

			operator Explicit(const operand: TNumeric): Int32;
			begin
				exit operand.a3;
			end;

			operator Explicit(const operand: TNumeric): Int64;
			begin
				exit operand.a4;
			end;

			operator Explicit(const operand: TNumeric): UInt8;
			begin
				exit operand.a5;
			end;

			operator Explicit(const operand: TNumeric): UInt16;
			begin
				exit operand.a6;
			end;

			operator Explicit(const operand: TNumeric): UInt32;
			begin
				exit operand.a7;
			end;

			operator Explicit(const operand: TNumeric): UInt64;
			begin
				exit operand.a8;
			end;

			operator Explicit(const operand: TNumeric): Single;
			begin
				exit operand.a9;
			end;

			operator Explicit(const operand: TNumeric): Double;
			begin
				exit operand.a10;
			end;
		end;
