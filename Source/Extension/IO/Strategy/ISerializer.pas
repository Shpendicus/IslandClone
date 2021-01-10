namespace RemObjects.Elements.System.IO.Strategy;

type
  ISerializer<TInput> = public interface   
    property Chunk: ObjectChunk<TInput> read;
    method Serialize(const input: TInput);
    method Deserialize(): TInput;
  end;
end.
