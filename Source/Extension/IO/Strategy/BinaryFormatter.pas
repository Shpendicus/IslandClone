namespace RemObjects.Elements.System.IO.Strategy;

uses 
  System.Globalization, System.IO, RemObjects.Elements.System.System.IO.Strategy_Pattern.Strategy;

type
  BinaryFormatter<TInput> = public class(ISerializer<TInput>)  
  public
    method Serialize(const input: TInput): sequence of Byte;
    begin
      //...
    end;
    method Deserialize(const input: sequence of Byte): TInput; 
    begin
      //...
    end;     
  end;

end.
