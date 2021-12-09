unit Func;

interface
uses System.SysUtils;

type
  TFunc = class
    public
      class function QuotedStr2(s: String): String;
      class function VazioNullString(s :String): String;

  end;

implementation

{ TFunc }

class function TFunc.QuotedStr2(s: String): String;
begin
  if s = '' then
    begin
      Result:= 'null';
    end
  else if s <> 'NULL' then
    begin
      Result:= QuotedStr(s);
    end
  else
    begin
      Result := s;
    end;
end;

class function TFunc.VazioNullString(s: String): String;
begin
  if s = '' then
    Result := 'NULL'
  else
    Result := s;
end;

end.
