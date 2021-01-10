namespace RemObjects.Elements.System.IO.Pair;

interface

type
  PairMemoryStream<TKey, TValue> = public class(PairStream<TKey, TValue>)
  private
    fBuffer: Dictionary<TKey, TValue>;
    fPairInfoList: TArray<PairInfo<TKey, TValue>>;
    fGrow: Capacity := 20;   
    fLen: Count := 1;
    method GetProperCountPerPair(const pairPtr: KeyValuePair<TKey, TValue>) : Count;

  public
    constructor(const aCapacity: Capacity);
    constructor(const aCapacityLvl: CapacityLvl);

    method &Write(const pairPtr: KeyValuePair<TKey,TValue>; const howOften: Count := 1); override;
    method &Read(const key: TKey): TValue; override;
    method CopyTo(newPairStream: PairStream<TKey,TValue>); override;
    method GetAllPairs: sequence of KeyValuePair<TKey, TValue>;

    property CanWrite: Boolean read true; override;
    property CanRead: Boolean read true; override;
    property GrowFactor: Capacity read fGrow; override;
    property Length: Count read fLen; override;
    
  end;

implementation
method PairMemoryStream<TKey, TValue>.GetProperCountPerPair(const pairPtr: KeyValuePair<TKey, TValue>): Count; 
begin
  for start: Count := 0 to fPairInfoList.Count do
  begin
    var tmp : PairInfo<TKey, TValue> := fPairInfoList.Read(start);

    exit if tmp.Pair = pairPtr then tmp.PairCount else 0;    
  end;
end;

constructor PairMemoryStream<TKey,TValue>(aCapacity: Capacity);
begin
  fGrow := aCapacity;
  fBuffer := new Dictionary<TKey,TValue>(aCapacity);  
  fPairInfoList := new TArray<PairInfo<TKey,TValue>>(aCapacity);
end;

constructor PairMemoryStream<TKey,TValue>(aCapacityLvl: CapacityLevel);
begin
  fCapacity := Int64(aCapacityLvl); //Change, when it works to: "Capacity(aCapacityLvl);"
  fBuffer := new Dictionary<TKey,TValue>(fCapacity);
end;

method PairMemoryStream<TKey, TValue>.&Write(const pairPtr: KeyValuePair<TKey, TValue>; const howOften: Count := 1);
begin
  for i: Count := 0 to howOften do
  begin
    var pInfo := new PairInfo<TKey, TValue>(pairPtr, howOften);
    fPairInfoList.Write(fLen, pInfo);
    fBuffer.Add(pairPtr.Key, pairPtr.Value);
    fLen := fLen + 1;
  end;
end;

method PairMemoryStream<TKey, TValue>.&Read(const key: TKey): TValue;
begin
  var tmp: TValue;
  result := if fBuffer.TryGetValue(key, out tmp) then tmp else &default(TValue);
end;

method PairMemoryStream<TKey, TValue>.CopyTo(newPairStream: PairStream<TKey,TValue>);
begin
  if newPairStream.CanWrite then
    for each kvp in fBuffer do
      newPairStream.Write(kvp, GetProperCountPerPair(kvp));
end;

method PairMemoryStream<TKey, TValue>.GetAllPairs: sequence of KeyValuePair<TKey, TValue>;
begin
  for pair in fBuffer do
    yield pair;
end;
end.
 