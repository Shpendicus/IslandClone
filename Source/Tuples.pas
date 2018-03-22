namespace RemObjects.Elements.System;

interface

	type
		{$region 1-Tuple}
		Tuple<T1> = public record(IComparable<Tuple<T1>>, IEquatable<Tuple<T1>>)
		public
			constructor(aItem1: T1);

			Item1: T1; readonly;

			method GetHashCode: Integer; override;
			method &Equals(arg1: Object): Boolean; override;
			method &Equals(other: Tuple<T1>): Boolean;
			method CompareTo(a: Tuple<T1>): Integer;
			method ToString: String; override;

			class operator Equal(const arg1, arg2: Tuple<T1>): Boolean;

		end;
		{$ENDREGION}

	  {$region 2-Tuple}
		Tuple<T1, T2> = public record(IComparable<Tuple<T1, T2>>, IEquatable<Tuple<T1, T2>>)
		public
			constructor(aItem1: T1; aItem2: T2);
			Item1: T1; readonly;
			Item2: T2; readonly;
			method GetHashCode: Integer; override;
			method &Equals(arg1: Object): Boolean; override;
			method &Equals(other: Tuple<T1, T2>): Boolean;
			method CompareTo(a: Tuple<T1, T2>): Integer;
			method ToString: String; override;
			class operator Equal(const arg1, arg2: Tuple<T1, T2>): Boolean;
		end;
		{$ENDREGION}

		{$region 3-Tuple}
		Tuple<T1, T2, T3> = public record(IComparable<Tuple<T1, T2, T3>>, IEquatable<Tuple<T1, T2, T3>>)
		public
			constructor(aItem1: T1; aItem2: T2; aItem3: T3);
			Item1: T1; readonly;
			Item2: T2; readonly;
			Item3: T3; readonly;
			method GetHashCode: Integer; override;
			method &Equals(arg1: Object): Boolean; override;
			method &Equals(other: Tuple<T1, T2, T3>): Boolean;
			method CompareTo(a: Tuple<T1, T2, T3>): Integer;
			method ToString: String; override;
			class operator Equal(const arg1, arg2: Tuple<T1, T2, T3>): Boolean;
		end;
		{$ENDREGION}

		{$region 4-Tuple}
		Tuple<T1, T2, T3, T4> = public record(IComparable<Tuple<T1, T2, T3, T4>>, IEquatable<Tuple<T1, T2, T3, T4>>)
		public
			constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4);
			 Item1: T1; readonly;
			 Item2: T2; readonly;
			 Item3: T3; readonly;
			 Item4: T4; readonly;
			method GetHashCode: Integer; override;
			method &Equals(arg1: Object): Boolean; override;
			method &Equals(other: Tuple<T1, T2, T3, T4>): Boolean;
			method CompareTo(a: Tuple<T1, T2, T3, T4>): Integer;
			method ToString: String; override;
			class operator Equal(const arg1, arg2: Tuple<T1, T2, T3, T4>): Boolean;
		end;
		{$ENDREGION}

		{$region 5-Tuple}
		Tuple<T1, T2, T3, T4, T5> = public record(IComparable<Tuple<T1, T2, T3, T4, T5>>, IEquatable<Tuple<T1, T2, T3, T4, T5>>)
		public
			constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5);

			Item1: T1; readonly;
			Item2: T2; readonly;
			Item3: T3; readonly;
			Item4: T4; readonly;
			Item5: T5; readonly;

			method GetHashCode: Integer; override;
			method &Equals(arg1: Object): Boolean; override;
			method &Equals(other: Tuple<T1, T2, T3, T4, T5>): Boolean;
			method CompareTo(a: Tuple<T1, T2, T3, T4, T5>): Integer;
			method ToString: String; override;
			class operator Equal(const arg1, arg2: Tuple<T1, T2, T3, T4, T5>): boolean;
		end;
		{$ENDREGION}

		{$region 6-Tuple}
		Tuple<T1, T2, T3, T4, T5, T6> = public record(IComparable<Tuple<T1, T2, T3, T4, T5, T6>>, IEquatable<Tuple<T1, T2, T3, T4, T5, T6>>)
		public
			constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6);
			 Item1: T1; readonly;
			 Item2: T2; readonly;
			 Item3: T3; readonly;
			 Item4: T4; readonly;
			 Item5: T5; readonly;
			 Item6: T6; readonly;
			method GetHashCode: Integer; override;
			method &Equals(arg1: Object): Boolean; override;
			method &Equals(other: Tuple<T1, T2, T3, T4, T5, T6>): Boolean;
			method CompareTo(a: Tuple<T1, T2, T3, T4, T5, T6>): Integer;
			method ToString: String; override;
			class operator Equal(const arg1, arg2: Tuple<T1, T2, T3, T4, T5, T6>): boolean;
		end;
		{$ENDREGION}

		{$region 7-Tuple}
		Tuple<T1, T2, T3, T4, T5, T6, T7> = public record(IComparable<Tuple<T1, T2, T3, T4, T5, T6, T7>>, IEquatable<Tuple<T1, T2, T3, T4, T5, T6, T7>>)
		public
			constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7);
			 Item1: T1; readonly;
			 Item2: T2; readonly;
			 Item3: T3; readonly;
			 Item4: T4; readonly;
			 Item5: T5; readonly;
			 Item6: T6; readonly;
			 Item7: T7; readonly;
			method GetHashCode: Integer; override;
			method &Equals(arg1: Object): Boolean; override;
			method &Equals(other: Tuple<T1, T2, T3, T4, T5, T6, T7>): Boolean;
			method CompareTo(a: Tuple<T1, T2, T3, T4, T5, T6, T7>): Integer;
			method ToString: String; override;
			class operator Equal(const arg1, arg2: Tuple<T1, T2, T3, T4, T5, T6, T7>): boolean;
		end;
		{$ENDREGION}

		{$region 8-Tuple}
		Tuple<T1, T2, T3, T4, T5, T6, T7, T8> = public record(IComparable<Tuple<T1, T2, T3, T4, T5, T6, T7, T8>>, IEquatable<Tuple<T1, T2, T3, T4, T5, T6, T7, T8>>)
		public
			constructor(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7; aItem8: T8);
			 Item1: T1; readonly;
			 Item2: T2; readonly;
			 Item3: T3; readonly;
			 Item4: T4; readonly;
			 Item5: T5; readonly;
			 Item6: T6; readonly;
			 Item7: T7; readonly;
			 Item8: T8; readonly;
			method GetHashCode: Integer; override;
			method &Equals(arg1: Object): Boolean; override;
			method &Equals(other: Tuple<T1, T2, T3, T4, T5, T6, T7, T8>): Boolean;
			method CompareTo(a: Tuple<T1, T2, T3, T4, T5, T6, T7, T8>): Integer;
			method ToString: String; override;
			class operator Equal(const arg1, arg2: Tuple<T1, T2, T3, T4, T5, T6, T7, T8>): boolean;
		end;
		{$ENDREGION}

		{$region STATIC TUPLE}
		Tuple = public static class
		assembly
			class method R3(i: Integer): Integer;
		public
			 class method &New<T1>(aItem1: T1): Tuple<T1>;
			 class method &New<T1, T2>(aItem1: T1; aItem2: T2): Tuple<T1, T2>;
			 class method &New<T1, T2, T3>(aItem1: T1; aItem2: T2; aItem3: T3): Tuple<T1, T2, T3>;
			 class method &New<T1, T2, T3, T4>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4): Tuple<T1, T2, T3, T4>;
			 class method &New<T1, T2, T3, T4, T5>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4; aItem5: T5): Tuple<T1, T2, T3, T4, T5>;
			 class method &New<T1, T2, T3, T4, T5, T6>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4; aItem5: T5; aItem6: T6): Tuple<T1, T2, T3, T4, T5, T6>;
			 class method &New<T1, T2, T3, T4, T5, T6, T7>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7): Tuple<T1, T2, T3, T4, T5, T6, T7>;
			 class method &New<T1, T2, T3, T4, T5, T6, T7, T8>(aItem1: T1; aItem2: T2; aItem3: T3;  aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7; aItem8: T8): Tuple<T1, T2, T3, T4, T5, T6, T7, T8>;
		end;
		{$ENDREGION}

implementation

  {$region 1-Tuple}
  constructor Tuple<T1>(aItem1: T1);
  begin
    Item1 := aItem1;
  end;

  method Tuple<T1>.GetHashCode: Integer;
  begin
    if Item1 = nil then exit 0;
    exit Item1.GetHashCode;
  end;

  method Tuple<T1>.&Equals(arg1: Object): Boolean;
  begin
    var lTuple := arg1 as IEquatable<Tuple<T1>>;
    lTuple.Equals(self);
  end;

  method Tuple<T1>.&Equals(other: Tuple<T1>): Boolean;
  begin
    result := other.Item1.Equals(Item1);
  end;

  class operator Tuple<T1>.Equal(const arg1, arg2: Tuple<T1>): Boolean;
  begin
    result := arg1.Equals(arg2);
  end;

	method Tuple<T1>.CompareTo(a: &Tuple<T1>): Integer;
	begin
		result := Item1.CompareTo(a.Item1);
	end;

	method Tuple<T1>.ToString: String;
  begin
    //(item1) => not optimization needed
    result := '(' + Item1.ToString + ')';
  end;
  {$ENDREGION}


  {$region 2-Tuple}
  constructor Tuple<T1, T2>(aItem1: T1; aItem2: T2);
  begin
    Item1 := aItem1;
    Item2 := aItem2;
  end;

  method Tuple<T1, T2>.GetHashCode: Integer;
  begin
    result := 0;
    if Item1 <> nil then result := Tuple.R3(result) xor Item1.GetHashCode;
    if Item2 <> nil then result := Tuple.R3(result) xor Item2.GetHashCode;
  end;

  method Tuple<T1, T2>.&Equals(arg1: Object): Boolean;
  begin
    var lTuple := arg1 as IEquatable<Tuple<T1,T2>>;
    result := lTuple.Equals(self);
  end;

  method Tuple<T1, T2>.&Equals(other: Tuple<T1, T2>): Boolean;
  begin
    result := (other.Item1.Equals(Item1)) and
              (other.Item2.Equals(Item2));
  end;

	class operator Tuple<T1, T2>.Equal(const arg1, arg2: Tuple<T1, T2>): Boolean;
  begin
    result := arg1.Equals(arg2);
  end;

	method Tuple<T1, T2>.CompareTo(a: Tuple<T1, T2>): Integer;
	begin	  
		var tmp := Item1.CompareTo(a.Item1);

		if tmp <> 0 then
		  result := tmp
		else 
		begin
		  tmp := Item2.CompareTo(a.Item2);
			if tmp <> 0 then 
				result := tmp;
		end;
	end;

	method Tuple<T1, T2>.ToString: String;
  begin
    //(item1, item2) => no optimization needed
    result := '(' + Item1.ToString + ', ' + Item2.ToString + ')';
  end;
  {$ENDREGION}


  {$REGION 3-Tuple}
  constructor Tuple<T1, T2, T3>(aItem1: T1; aItem2: T2; aItem3: T3);
  begin
    Item1 := aItem1;
    Item2 := aItem2;
    Item3 := aItem3;
  end;

  method Tuple<T1, T2, T3>.GetHashCode: Integer;
  begin
    result := 0;
    if Item1 <> nil then result := Tuple.R3(result) xor Item1.GetHashCode;
    if Item2 <> nil then result := Tuple.R3(result) xor Item2.GetHashCode;
    if Item3 <> nil then result := Tuple.R3(result) xor Item3.GetHashCode;
  end;

  method Tuple<T1, T2, T3>.&Equals(arg1: Object): Boolean;
  begin
    var lTuple := arg1 as IEquatable<Tuple<T1,T2, T3>>;
    result := lTuple.Equals(self);
  end;

  method Tuple<T1, T2, T3>.&Equals(other: Tuple<T1, T2, T3>): Boolean;
  begin
    result := (other.Item1.Equals(Item1)) and
              (other.Item2.Equals(Item2)) and
              (other.Item3.Equals(Item3));
  end;

	class operator Tuple<T1, T2, T3>.Equal(const arg1, arg2: Tuple<T1, T2, T3>): Boolean;
  begin
    result := arg1.Equals(arg2);
  end;

	method Tuple<T1, T2, T3>.CompareTo(a: Tuple<T1, T2, T3>): Integer;
	begin
		var tmp := Item1.CompareTo(a.Item1);

		if tmp <> 0 then
		  result := tmp
		else 
		begin
		  tmp := Item2.CompareTo(a.Item2);
			if tmp <> 0 then 
				result := tmp

			else
			begin
				tmp := Item3.CompareTo(a.Item3);

				if tmp <> 0 then 
					result := tmp
			end;
		end;
	end;

	method Tuple<T1, T2, T3>.ToString: String;
  begin
    //(item1, item2, item3) => no optimazation needed
    result := '(' + Item1.ToString + ', ' +
                    Item2.ToString + ', ' +
                    Item3.ToString;
  end;

  {$ENDREGION}


  {$REGION 4-Tuple}
  constructor Tuple<T1, T2, T3, T4>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4);
  begin
    Item1 := aItem1;
    Item2 := aItem2;
    Item3 := aItem3;
    Item4 := aItem4;
  end;

  method Tuple<T1, T2, T3, T4>.GetHashCode: Integer;
  begin
    result := 0;
    if Item1 <> nil then result := Tuple.R3(result) xor Item1.GetHashCode;
    if Item2 <> nil then result := Tuple.R3(result) xor Item2.GetHashCode;
    if Item3 <> nil then result := Tuple.R3(result) xor Item3.GetHashCode;
    if Item4 <> nil then result := Tuple.R3(result) xor Item4.GetHashCode;
  end;

  method Tuple<T1, T2, T3, T4>.&Equals(arg1: Object): Boolean;
  begin
    var lTuple := arg1 as IEquatable<Tuple<T1,T2,T3,T4>>;
    result := lTuple.Equals(self);
  end;

  method Tuple<T1, T2, T3, T4>.&Equals(other: Tuple<T1, T2, T3, T4>): Boolean;
  begin
    result := (other.Item1.Equals(Item1)) and
              (other.Item2.Equals(Item2)) and
              (other.Item3.Equals(Item3)) and
              (other.Item4.Equals(Item4));
  end;

	method Tuple<T1, T2, T3, T4>.CompareTo(a: Tuple<T1, T2, T3, T4>): Integer;
	begin
		result := 0;

		var tmp := Item1.CompareTo(a.Item1);

		if tmp <> 0 then
		  result := tmp
		else 
		begin
		  tmp := Item2.CompareTo(a.Item2);
			if tmp <> 0 then 
				result := tmp

			else
			begin
				tmp := Item3.CompareTo(a.Item3);

				if tmp <> 0 then 
					result := tmp
				else
				begin
				  tmp := Item4.CompareTo(a.Item4);

				if tmp <> 0 then 
					result := tmp
				end;
			end;
		end;
	end;

	class operator Tuple<T1, T2, T3, T4>.Equal(const arg1, arg2: Tuple<T1, T2, T3, T4>): Boolean;
	begin
		result := arg1.Equals(arg2);
	end;

	method Tuple<T1, T2, T3, T4>.ToString: String;
  begin
    //(item1, item2, item3, item4) => no optimization needed
    result := '(' + Item1.ToString + ', ' +
                    Item2.ToString + ', ' +
                    Item3.ToString + ', ' +
                    Item4.ToString;
  end;

  {$ENDREGION}


  {$REGION 5-Tuple}
  constructor Tuple<T1, T2, T3, T4, T5>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5);
  begin
    Item1 := aItem1;
    Item2 := aItem2;
    Item3 := aItem3;
    Item4 := aItem4;
    Item5 := aItem5;
  end;

  method Tuple<T1, T2, T3, T4, T5>.GetHashCode: Integer;
  begin
    result := 0;
    if Item1 <> nil then result := Tuple.R3(result) xor Item1.GetHashCode;
    if Item2 <> nil then result := Tuple.R3(result) xor Item2.GetHashCode;
    if Item3 <> nil then result := Tuple.R3(result) xor Item3.GetHashCode;
    if Item4 <> nil then result := Tuple.R3(result) xor Item4.GetHashCode;
    if Item5 <> nil then result := Tuple.R3(result) xor Item5.GetHashCode;
  end;

  method Tuple<T1, T2, T3, T4, T5>.&Equals(arg1: Object): Boolean;
  begin
    var lTuple := Tuple<T1, T2, T3, T4, T5>(arg1);
    result := lTuple.Equals(self);
  end;

  method Tuple<T1, T2, T3, T4, T5>.&Equals(other: Tuple<T1, T2, T3, T4, T5>): Boolean;
  begin
    result := (other.Item1.Equals(Item1)) and
              (other.Item2.Equals(Item2)) and
              (other.Item3.Equals(Item3)) and
              (other.Item4.Equals(Item4)) and
              (other.Item5.Equals(Item5));
  end;

	class operator Tuple<T1, T2, T3, T4, T5>.Equal(const arg1, arg2: Tuple<T1, T2, T3, T4, T5>): Boolean;
	begin
		result := arg1.Equals(arg2);
	end;

	method Tuple<T1, T2, T3, T4, T5>.CompareTo(a: Tuple<T1, T2, T3, T4, T5>): Integer;
	begin
	  result := 0;

		var tmp := Item1.CompareTo(a.Item1);

		if tmp <> 0 then
		  result := tmp
		else 
		begin
		  tmp := Item2.CompareTo(a.Item2);
			if tmp <> 0 then 
				result := tmp

			else
			begin
				tmp := Item3.CompareTo(a.Item3);

				if tmp <> 0 then 
					result := tmp
				else
				begin
				  tmp := Item4.CompareTo(a.Item4);

					if tmp <> 0 then 
						result := tmp
					else
					begin
						tmp := Item5.CompareTo(a.Item5);

						if tmp <> 0 then 
							result := tmp
					end;
				end;
			end;
		end;
	end;

	method Tuple<T1, T2, T3, T4, T5>.ToString: String;
  begin
    //(item1, item2, item3, item4, item5)
    result := '(' + Item1.ToString + ', ' +
                    Item2.ToString + ', ' +
                    Item3.ToString + ', ' +
                    Item4.ToString + ', ' +
                    Item4.ToString;
  end;
  {$ENDREGION}


  {$REGION 6-Tuple}
  constructor Tuple<T1, T2, T3, T4, T5, T6>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6);
  begin
    Item1 := aItem1;
    Item2 := aItem2;
    Item3 := aItem3;
    Item4 := aItem4;
    Item5 := aItem5;
    Item6 := aItem6;
  end;

  method Tuple<T1, T2, T3, T4, T5, T6>.GetHashCode: Integer;
  begin
    result := 0;
    if Item1 <> nil then result := Tuple.R3(result) xor Item1.GetHashCode;
    if Item2 <> nil then result := Tuple.R3(result) xor Item2.GetHashCode;
    if Item3 <> nil then result := Tuple.R3(result) xor Item3.GetHashCode;
    if Item4 <> nil then result := Tuple.R3(result) xor Item4.GetHashCode;
    if Item5 <> nil then result := Tuple.R3(result) xor Item5.GetHashCode;
    if Item6 <> nil then result := Tuple.R3(result) xor Item6.GetHashCode;
  end;

  method Tuple<T1, T2, T3, T4, T5, T6>.&Equals(arg1: Object): Boolean;
  begin
    var lTuple := Tuple<T1, T2, T3, T4, T5, T6>(arg1);
    result := lTuple.Equals(self);
  end;

  method Tuple<T1, T2, T3, T4, T5, T6>.&Equals(other: Tuple<T1, T2, T3, T4, T5, T6>): Boolean;
  begin
    result := (other.Item1.Equals(Item1))  and
              (other.Item2.Equals(Item2)) and
              (other.Item3.Equals(Item3)) and
              (other.Item4.Equals(Item4)) and
              (other.Item5.Equals(Item5)) and
              (other.Item6.Equals(Item6));
  end;

	class operator Tuple<T1, T2, T3, T4, T5, T6>.Equal(const arg1, arg2: Tuple<T1, T2, T3, T4, T5, T6>): Boolean;
	begin
		result := arg1.Equals(arg2);
	end;

	method Tuple<T1, T2, T3, T4, T5, T6>.CompareTo(a: Tuple<T1, T2, T3, T4, T5, T6>): Integer;
	begin
		result := 0;

		var tmp := Item1.CompareTo(a.Item1);

		if tmp <> 0 then
		  result := tmp
		else 
		begin
		  tmp := Item2.CompareTo(a.Item2);
			if tmp <> 0 then 
				result := tmp

			else
			begin
				tmp := Item3.CompareTo(a.Item3);

				if tmp <> 0 then 
					result := tmp
				else
				begin
				  tmp := Item4.CompareTo(a.Item4);

					if tmp <> 0 then 
						result := tmp
					else
					begin
						tmp := Item5.CompareTo(a.Item5);

						if tmp <> 0 then 
							result := tmp
						else
						begin
							tmp := Item6.CompareTo(a.Item6);

							if tmp <> 0 then 
								result := tmp
						end;
					end;
				end;
			end;
		end;
	end;

	
  method Tuple<T1, T2, T3, T4, T5, T6>.ToString: String;
  begin
    //(item1, item2, item3, item4, item5, item6)		
    result := '(' + Item1.ToString + ', ' +
                    Item2.ToString + ', ' +
                    Item3.ToString + ', ' +
                    Item4.ToString + ', ' +
                    Item5.ToString + ', ' +
                    Item6.ToString + ')';
  end;
  {$ENDREGION}


  {$REGION 7-Tuple}
  constructor Tuple<T1, T2, T3, T4, T5, T6, T7>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7);
  begin
    Item1 := aItem1;
    Item2 := aItem2;
    Item3 := aItem3;
    Item4 := aItem4;
    Item5 := aItem5;
    Item6 := aItem6;
    Item7 := aItem7;
  end;

  method Tuple<T1, T2, T3, T4, T5, T6, T7>.GetHashCode: Integer;
  begin
    result := 0;
    if Item1 <> nil then result := Tuple.R3(result) xor Item1.GetHashCode;
    if Item2 <> nil then result := Tuple.R3(result) xor Item2.GetHashCode;
    if Item3 <> nil then result := Tuple.R3(result) xor Item3.GetHashCode;
    if Item4 <> nil then result := Tuple.R3(result) xor Item4.GetHashCode;
    if Item5 <> nil then result := Tuple.R3(result) xor Item5.GetHashCode;
    if Item6 <> nil then result := Tuple.R3(result) xor Item6.GetHashCode;
    if Item7 <> nil then result := Tuple.R3(result) xor Item7.GetHashCode;
  end;

  method Tuple<T1, T2, T3, T4, T5, T6, T7>.&Equals(arg1: Object): Boolean;
  begin
    var lTuple := Tuple<T1, T2, T3, T4, T5, T6, T7>(arg1);
    result := lTuple.Equals(self);
  end;

  method Tuple<T1, T2, T3, T4, T5, T6, T7>.&Equals(other: Tuple<T1, T2, T3, T4, T5, T6, T7>): Boolean;
  begin
    result := (other.Item1.Equals(Item1))  and
              (other.Item2.Equals(Item2)) and
              (other.Item3.Equals(Item3)) and
              (other.Item4.Equals(Item4)) and
              (other.Item5.Equals(Item5)) and
              (other.Item6.Equals(Item6)) and
              (other.Item7.Equals(Item7));
  end;

	class operator Tuple<T1, T2, T3, T4, T5, T6, T7>.Equal(const arg1, arg2: Tuple<T1, T2, T3, T4, T5, T6, T7>): Boolean;
	begin
		result := arg1.Equals(arg2);
	end;

	method Tuple<T1, T2, T3, T4, T5, T6, T7>.CompareTo(a: Tuple<T1, T2, T3, T4, T5, T6, T7>): Integer;
	begin
		result := 0;

		var tmp := Item1.CompareTo(a.Item1);

		if tmp <> 0 then
		  result := tmp
		else 
		begin
		  tmp := Item2.CompareTo(a.Item2);

			if tmp <> 0 then 
				result := tmp

			else
			begin
				tmp := Item3.CompareTo(a.Item3);

				if tmp <> 0 then 
					result := tmp
				else
				begin
				  tmp := Item4.CompareTo(a.Item4);

					if tmp <> 0 then 
						result := tmp
					else
					begin
						tmp := Item5.CompareTo(a.Item5);

						if tmp <> 0 then 
							result := tmp
						else
						begin
							tmp := Item6.CompareTo(a.Item6);

							if tmp <> 0 then 
								result := tmp
							else
							begin
								tmp := Item7.CompareTo(a.Item7);

								if tmp <> 0 then 
									result := tmp
							end;
						end;
					end;
				end;
			end;
		end;
	end;

	method Tuple<T1, T2, T3, T4, T5, T6, T7>.ToString: String;
  begin
    //(item1, item2, item3, item4, item5, item6)
    result := '(' + Item1.ToString + ', ' +
                    Item2.ToString + ', ' +
                    Item3.ToString + ', ' +
                    Item4.ToString + ', ' +
                    Item5.ToString + ', ' +
                    Item6.ToString + ', ' +
                    Item7.ToString;
  end;
  {$ENDREGION}


  {$REGION 8-Tuple}
  constructor Tuple<T1, T2, T3, T4, T5, T6, T7, T8>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7; aItem8: T8);
  begin
    Item1 := aItem1;
    Item2 := aItem2;
    Item3 := aItem3;
    Item4 := aItem4;
    Item5 := aItem5;
    Item6 := aItem6;
    Item7 := aItem7;
    Item8 := aItem8;
  end;

  method Tuple<T1, T2, T3, T4, T5, T6, T7, T8>.GetHashCode: Integer;
  begin
    result := 0;
    if Item1 <> nil then result := Tuple.R3(result) xor Item1.GetHashCode;
    if Item2 <> nil then result := Tuple.R3(result) xor Item2.GetHashCode;
    if Item3 <> nil then result := Tuple.R3(result) xor Item3.GetHashCode;
    if Item4 <> nil then result := Tuple.R3(result) xor Item4.GetHashCode;
    if Item5 <> nil then result := Tuple.R3(result) xor Item5.GetHashCode;
    if Item6 <> nil then result := Tuple.R3(result) xor Item6.GetHashCode;
    if Item7 <> nil then result := Tuple.R3(result) xor Item7.GetHashCode;
    if Item8 <> nil then result := Tuple.R3(result) xor Item8.GetHashCode;
  end;

  method Tuple<T1, T2, T3, T4, T5, T6, T7, T8>.&Equals(arg1: Object): Boolean;
  begin
    var lTuple := Tuple<T1, T2, T3, T4, T5, T6, T7, T8>(arg1);
    result := lTuple.Equals(self);
  end;

  method Tuple<T1, T2, T3, T4, T5, T6, T7, T8>.&Equals(other: Tuple<T1, T2, T3, T4, T5, T6, T7, T8>): Boolean;
  begin
    result := (other.Item1.Equals(Item1)) and
              (other.Item2.Equals(Item2)) and
              (other.Item3.Equals(Item3)) and
              (other.Item4.Equals(Item4)) and
              (other.Item5.Equals(Item5)) and
              (other.Item6.Equals(Item6)) and
              (other.Item7.Equals(Item7)) and
              (other.Item8.Equals(Item8));
  end;

	class operator Tuple<T1, T2, T3, T4, T5, T6, T7, T8>.Equal(const arg1, arg2: Tuple<T1, T2, T3, T4, T5, T6, T7, T8>): Boolean;
	begin
		result := arg1.Equals(arg2);
	end;

	method Tuple<T1, T2, T3, T4, T5, T6, T7, T8>.CompareTo(a: Tuple<T1, T2, T3, T4, T5, T6, T7, T8>): Integer;
	begin
	result := 0;

		var tmp := Item1.CompareTo(a.Item1);

		if tmp <> 0 then
		  result := tmp
		else 
		begin
		  tmp := Item2.CompareTo(a.Item2);

			if tmp <> 0 then 
				result := tmp

			else
			begin
				tmp := Item3.CompareTo(a.Item3);

				if tmp <> 0 then 
					result := tmp
				else
				begin
				  tmp := Item4.CompareTo(a.Item4);

					if tmp <> 0 then 
						result := tmp
					else
					begin
						tmp := Item5.CompareTo(a.Item5);

						if tmp <> 0 then 
							result := tmp
						else
						begin
							tmp := Item6.CompareTo(a.Item6);

							if tmp <> 0 then 
								result := tmp
							else
							begin
								tmp := Item7.CompareTo(a.Item7);

								if tmp <> 0 then 
									result := tmp
								else
								begin
									tmp := Item8.CompareTo(a.Item8);

									if tmp <> 0 then 
										result := tmp
								end;
							end;
						end;
					end;
				end;
			end;
		end;
	end;

	method Tuple<T1, T2, T3, T4, T5, T6, T7, T8>.ToString: String;
  begin
    //(item1, item2, item3, item4, item5, item6)
    result := '(' + Item1.ToString + ', ' +
                    Item2.ToString + ', ' +
                    Item3.ToString + ', ' +
                    Item4.ToString + ', ' +
                    Item5.ToString + ', ' +
                    Item6.ToString + ', ' +
                    Item7.ToString + ', ' +
                    Item8.ToString;
  end;
  {$ENDREGION}


  {$REGION STATIC - TUPLEMETHODS}
  class method Tuple.&New<T1>(aItem1: T1): Tuple<T1>;
  begin
    exit new Tuple<T1>(aItem1);
  end;

  class method Tuple.&New<T1,T2>(aItem1: T1; aItem2: T2): Tuple<T1, T2>;
  begin
    exit new Tuple<T1, T2>(aItem1, aItem2);
  end;

  class method Tuple.&New<T1,T2,T3>(aItem1: T1; aItem2: T2; aItem3: T3): Tuple<T1, T2, T3>;
  begin
    exit new Tuple<T1, T2, T3>(aItem1, aItem2, aItem3);
  end;

  class method Tuple.&New<T1,T2,T3,T4>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4): Tuple<T1, T2, T3, T4>;
  begin
    exit new Tuple<T1, T2, T3, T4>(aItem1, aItem2, aItem3, aItem4);
  end;

  class method Tuple.&New<T1,T2,T3,T4,T5>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5): Tuple<T1, T2, T3, T4, T5>;
  begin
    exit new Tuple<T1, T2, T3, T4, T5>(aItem1, aItem2, aItem3, aItem4, aItem5);
  end;

  class method Tuple.&New<T1,T2,T3,T4,T5,T6>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6): Tuple<T1, T2, T3, T4, T5, T6>;
  begin
    exit new Tuple<T1, T2, T3, T4, T5,T6>(aItem1, aItem2, aItem3, aItem4, aItem5, aItem6);
  end;

  class method Tuple.&New<T1,T2,T3,T4,T5,T6,T7>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7): Tuple<T1, T2, T3, T4, T5, T6, T7>;
  begin
    exit new Tuple<T1, T2, T3, T4, T5,T6, T7>(aItem1, aItem2, aItem3, aItem4, aItem5, aItem6, aItem7);
  end;

  class method Tuple.&New<T1,T2,T3,T4,T5,T6,T7,T8>(aItem1: T1; aItem2: T2; aItem3: T3; aItem4: T4; aItem5: T5; aItem6: T6; aItem7: T7; aItem8: T8): Tuple<T1, T2, T3, T4, T5, T6, T7, T8>;
  begin
    exit new Tuple<T1, T2, T3, T4, T5,T6, T7, T8>(aItem1, aItem2, aItem3, aItem4, aItem5, aItem6, aItem7, aItem8);
  end;

  class method Tuple.R3(i: Integer): Integer;
  begin
    exit (i shl 29) or (i shr 3);
  end;

  {$ENDREGION}

end.
