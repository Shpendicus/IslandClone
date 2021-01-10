namespace RemObjects.Elements.System.IO.Factory;

uses
  RemObjects.Elements.System.IO,
  RemObjects.Elements.System.IO.Strategy;

type
  FORMATTERFACTORY = public static class
  public
    class method CreateFormatter<TInput>(const output: OutputFormat): ISerializer<TInput>;
    begin
      var instance: ISerializer<TInput>;
 
      case output of
        OutputFormat.JSON:     instance := nil;
        OutputFormat.XML:      instance := nil;
        OutputFormat.Binary:   instance := nil;
        OutputFormat.ProtoBuf: instance := nil;
      end;
      exit instance;
    end;
  end;
end.
