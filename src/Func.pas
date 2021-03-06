unit Func;

interface
uses System.SysUtils, System.UITypes, Dialogs, Forms, StdCtrls;

type
  TFunc = class
    public
      class function QuotedStr2(s: String): String;
      class function VazioNullString(s :String): String;
      class function FormatarNumero(numero : Real; Decimais : Integer = 2; UsaMilhar : Boolean = False) : String; overload;
      class function FormatarNumero(numero : String; Decimais : Integer = 2; UsaMilhar : Boolean = False) : String; overload;
      class function MostrarMensagem(Caption, Texto: String; Tipo: Integer): TModalResult;
      class function MostrarMensagemConfirmacao(Caption, Texto: String): TModalResult;
      class function ConfirmarExclusao: Boolean;
      class function DataParaBD(data : String) : String;
      class function DoubleParaBD(dbl : String) : String;


  end;

implementation

{ TFunc }

class function TFunc.ConfirmarExclusao: Boolean;
begin
  Result:= TFunc.MostrarMensagemConfirmacao('Confirmar Exclus?o','Deseja excluir?') = mrYes;
end;

class function TFunc.DataParaBD(data: String): String;
var
  d: TDateTime;
begin
  if TryStrToDate(data, d) then
    begin
      Result := QuotedStr(FormatDateTime('yyyy-mm-dd',d));
    end
  else
    begin
      Result := 'NULL';
    end;

end;

class function TFunc.DoubleParaBD(dbl: String): String;
var
  i : Integer;
  sout : String;
begin
  sout := '';
  for i := 1 to Length(dbl) do
    begin
      //if (dbl[i] in ['0'..'9',',','.']) then
      if CharInSet(dbl[i],['0'..'9',',','.']) then
        sout := sout + dbl[i];
    end;

  sout := StringReplace(sout,'.','',[rfReplaceAll]);
  sout := StringReplace(sout,',','.', [rfReplaceAll]);


  if sout = '' then
    Result := 'NULL'
  else
    Result := sout;

end;

class function TFunc.FormatarNumero(numero: String; Decimais: Integer;
  UsaMilhar: Boolean): String;
var
  i : Integer;
  fmt, dec : String;
  num : Extended;
begin
  Result := '';
  dec := '';

  numero := StringReplace(numero, '.', '',[rfReplaceAll]);

  if Decimais > 0 then dec := '.';
  if numero = '' then numero := '0';

  for i := 1 to Decimais do
    begin
      dec := dec + '0';
    end;

  if UsaMilhar then
    fmt := '#,##0'+dec
  else
    fmt := '#0'+dec;

  if TryStrToFloat(numero,num) then
    begin
      Result := FormatFloat(fmt,num);
    end;
end;

class function TFunc.MostrarMensagem(Caption, Texto: String; Tipo: Integer): TModalResult;
var
  Msg: TForm;
  MsgType: TMsgDlgType;
  MsgBtns: TMsgDlgButtons;
begin
  try
    case Tipo of
      // Informa??o
      0:
        begin
          MsgType := mtInformation;
          MsgBtns := [TMsgDlgBtn.mbOK];
        end;
      // Aten??o
      1:
        begin
          MsgType := mtWarning;
          MsgBtns := [TMsgDlgBtn.mbOK];
        end;
      // Confirma??o Sim/N?o
      2:
        begin
          MsgType := mtConfirmation;
          MsgBtns := [TMsgDlgBtn.mbYes,TMsgDlgBtn.mbNo];
        end;
      // Erro
      3:
        begin
          MsgType := mtError;
          MsgBtns := [TMsgDlgBtn.mbOK];
        end;
    end;

    Msg := CreateMessageDialog(Texto, MsgType, MsgBtns);
    Msg.Caption := Caption;

    // Traduzindo Bot?es
    (Msg.FindComponent('Yes') As TButton).Caption := 'Sim';
    (Msg.FindComponent('No') As TButton).Caption := 'N?o';



    Msg.ShowModal;
    Result := Msg.ModalResult;
  finally
    FreeAndNil(Msg);
  end;
end;

class function TFunc.MostrarMensagemConfirmacao(Caption, Texto: String): TModalResult;
begin
  Result:= TFunc.MostrarMensagem(Caption, Texto,2);
end;

class function TFunc.FormatarNumero(numero: Real; Decimais: Integer;
  UsaMilhar: Boolean): String;
var
  i : Integer;
  fmt, dec : String;
begin
  Result := '';
  dec := '';
  if Decimais > 0 then dec := '.';
  for i := 1 to Decimais do
    begin
      dec := dec + '0';
    end;

  if UsaMilhar then
    fmt := '#,##0'+dec
  else
    fmt := '#0'+dec;

  Result := FormatFloat(fmt,numero);
end;

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
