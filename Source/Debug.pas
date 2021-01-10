namespace RemObjects.Elements.System;

type
  Debug = public static class
  public
    [Conditional('DEBUG')]
    class method Assert(aCheck: Boolean; aMessage: String; aFile: String := currentFileName(); aLine: Integer := currentLineNumber());
    begin
      if not aCheck then
        raise new AssertionException('Assertion failed: '+aMessage+' at '+aFile+'('+aLine.ToString+')');
    end;
    class method Throw(s: String);
    begin
      raise new Exception(s);
    end;
  end;

end.