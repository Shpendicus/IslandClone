namespace RemObjects.Elements.System.IO.Pair;

type
  [Packed]
  PairInfo<TKey, TValue> = public record
    property Pair: KeyValuePair<TKey, TValue>; readonly;
    property PairCount: Count; readonly;

    constructor(const p: KeyValuePair<TKey,TValue>; const pCount: Count);
    begin
      Pair := p;
      PairCount := pCount;
    end;
  end;

  PairStream<TKey, TValue> = public abstract class    
  public 
    {MAIN METHODS}
    method &Write(const pairPtr: KeyValuePair<TKey, TValue>; const howOften: Count := 1); abstract;
    method &Read(const key: TKey): TValue; abstract;

    {EXTRA METHODS}
    method Close; virtual; empty;
    method Flush; virtual; empty;
    method CopyTo(newPairStream: PairStream<TKey, TValue>); abstract;
    {EXTRA METHODS}

    property GrowFactor: Capacity read; abstract;
    property Length: Count read; abstract;
    property CanRead: Boolean read; abstract;    
    property CanWrite: Boolean read; abstract;
  end;

end.
