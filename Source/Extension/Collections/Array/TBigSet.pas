namespace BigSet;

	uses 
		rtl, RemObjects.Elements, OwnDynamicArrayImplementation;

	type
		TMAXSETRANGE = 0..63;

		TANYNUMERICVALUE = ValueType;

		TMAX_SET = set of TMAXSETRANGE;

		TSetInfo = private record
			Data: TMAX_SET;
			Count: TMAXSETRANGE; //..Count is needed, to avoid set-iteration
		end;

		{can't represent floating point numbers...}
		TBigSet = public record 
		private
			fMax, fCurrSlot: LongInt;
			fSetSlots: TDoublyLinkedArray<TSetInfo>;
						
			method ValueToBin(const value: TANYNUMERICVALUE): String; 
			begin		
				//TODO: proper handling for CHAR needs to be done...
				var numeric := Int64(if ( (value is Int64) or (value is UInt64) or (value is Char) ) then value	
														 else raise new ArgumentException(nameOf(value) + ' is not a numerical value and so it cannot be converted to binary format'));
				
				const ORDINAL_ZERO = 48;
				result := '       ';  	
				var ptr := result.FirstChar; 								

				for i: int32 := 7 downto 0 do 
					ptr[i] := Char(ORDINAL_ZERO + ((numeric shr (7 - i)) and 1)); 
			end;

			method CreateBitSet(const value: TANYNUMERICVALUE): TSetInfo; 
			begin				
				result.Data := [];
				var currBit := 0;
				var binStr := ValueToBin(value);

				for bit in binStr do //i.e 10011110
				begin
					case bit of
					'0': begin //just get to the next bit
								 currBit := succ(currBit);	
								 inc(result.Count);							 
								 continue;
							 end;
					//-----------------------//
					'1': begin 
								result.Data := result.Data + [currBit];
								inc(result.Count);
							 end;
					end;					
				end;
			end;
			
		public
			constructor;
			begin
				fCurrSlot := 0;
				fSetSlots := new TDoublyLinkedArray<TSetInfo>(1, true);
			end;		

			constructor(const max: Int64); 			
			begin
				fCurrSlot := 0;
				fMax := max;
			  fSetSlots := new TDoublyLinkedArray<TSetInfo>(fMax, false);
			end;

			/// <summary>
		 /// INCOMPLETE!!
		 /// </summary>
		 /// <param name="input"></param>
		 /// <returns></returns>
			method &Union(const input: TBigSet): TBigSet;
			begin				
				var value := 1000; //dummy value
				var tmpSetValue := CreateBitSet(value);

				//if tmpSetValue.Data <= fSetSlots[fCurrSlot].Data then
				  
			end;
		end;	
end.
