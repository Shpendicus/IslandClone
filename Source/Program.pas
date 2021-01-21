namespace ConsoleApplication;

type
  Program = class
  public
    class method Main(args: array of String): Int32;
    begin
      var a := 100;
      var b : TNumeric := 100;
      writeLn(a is IEquatable<TNumeric>); //correct output: FALSE
      writeLn(b is IEquatable<TNumeric>); //correct output: TRUE

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
      Test_DucktypingFromClasses(SByte(100));
    end;

    class method Test_Softinterfaces<T>(const a, b: IEquatable<T>);
    begin
      writeLn(a.Equals(b));
      //writeLn(a.GetHashCode);
      //writeLn(b.GetHashCode);
    end;

    class method Test_DucktypingFromClasses(const a: ISoftObject<Byte>);
    begin
      writeLn(a.AsString);
    end;

  end;

  IEquatable<T> = public soft interface   //make them "soft" so no boxing is needed when the compiler detects an Equals(a) or GetHashCode function
    method &Equals(other: T): Boolean;
    method GetHashCode: Integer;
  end;
end.