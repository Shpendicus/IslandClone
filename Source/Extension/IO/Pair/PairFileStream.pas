namespace RemObjects.Elements.System.System.IO.Strategy;

interface

uses 
  System.Runtime.Remoting.Messaging, RemObjects.Elements.System.IO, 
  RemObjects.Elements.System.IO.Factory, RemObjects.Elements.System.IO.Pair;

type
  PairFileStream<TKey, TValue> = public class(BinaryPairStream<TKey, TValue>)
  private
    fBuffer: PairMemoryStream<TKey,TValue>;
    fOutputFile: FileStream; 
    //...
  protected
    //...
  public
    constructor(const aGrowSize: Capacity; const fullName: String; const outputFormat: OutputFormat);
    constructor(const aGrowSize: BitwiseStep; const fullName: String; const outputFormat: OutputFormat);

    {MAIN METHODS}
    method CopyTo(newPairStream: PairStream<TKey,TValue>); override;
    method &Read(const key: TKey): TValue; override;
    method &Write(const pairPtr: KeyValuePair<TKey,TValue>; const howOften: Count := 1); override;   
    {MAIN METHODS}

    {SECONDARY METHODS}
    method Flush; override;
    {SECONDARY METHODS}

    {MAIN PROPERTYS}
    property CanWrite:      Boolean read; override;
    property CanRead:       Boolean read; override;
    property Length:        Count read fBuffer.Length; override;
    property GrowFactor:    Capacity read fBuffer.GrowFactor; override;    
    {MAIN PROPERTYS}
  end;

implementation
constructor PairFileStream<TKey,TValue>(aGrowSize: Capacity; fullName: String; outputFormat: OutputFormat);
begin 
  fBuffer := new PairMemoryStream<TKey,TValue>(aGrowSize); 
  fOutputFile := new FileStream(fullName, FileMode.OpenOrCreate, FileShare.ReadWrite);   
  
  var formatter := FORMATTERFACTORY.CreateFormatter<KeyValuePair<TKey, TValue>>(outputFormat);
  inherited.SwitchOutputFormat(formatter);
end;

constructor PairFileStream<TKey,TValue>(const aGrowSize: ChunkSize; const fullName: String;                                                          const outputFormat: OutputFormat);
begin
  constructor(Int64(aGrowSize), fullName, outputFormat);
end;

{MAIN METHODS}
method PairFileStream<TKey, TValue>.&Write(const pairPtr: KeyValuePair<TKey,TValue>; const howOften: Count := 1);
begin
  fBuffer.Write(pairPtr, howOften);
end;

method PairFileStream<TKey, TValue>.&Read(const key: TKey): TValue;
begin 
  {if the file has some object's in it}
  if fOutputFile.Length >= OutputFormatter.Chunk.Buffer.Length then
  begin
    {dersializes 1 - bytechunk...}    
  end;
end;
{MAIN METHODS}

method PairFileStream<TKey, TValue>.Flush;
begin
  fOutputFile.Position := 0;
  
  for pair in fBuffer.GetAllPairs do
  begin
    //...
  end;
end;

end.
