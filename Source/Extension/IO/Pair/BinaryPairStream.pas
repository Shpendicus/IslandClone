namespace RemObjects.Elements.System.IO.Pair;

uses 
  RemObjects.Elements.System.IO.Strategy;

type
  BinaryPairStream<TKey, TValue> = public abstract class(PairStream<TKey, TValue>)    
  protected
    property OutputFormatter: ISerializer<KeyValuePair<TKey, TValue>> read private write; 

  public
    //Strategy
    method SwitchOutputFormat(const formatter: ISerializer<KeyValuePair<TKey, TValue>>);
    begin
      OutputFormatter := formatter;
    end;
  end;

end.
