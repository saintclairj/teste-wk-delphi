Unit DAOPedido;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls, UDM, Pedido, Func;

  Type

  TDAOPedido = Class
  public
    function inserir(Pedido : TPedido) : Boolean;
    function atualizar(Pedido : TPedido) : Boolean;
    function excluir(Pedido : TPedido) : Boolean;
    function preencherEntidade(Pedido : TPedido) : Boolean;
    procedure preencherComDataSet(Query: TDataSet; Pedido : TPedido);
  end;


implementation

function TDAOPedido.inserir(Pedido : TPedido) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
      begin
        Close;
        SQL.Clear;
        SQL.Add('INSERT INTO pedido(');
        SQL.Add('cliente_id,data_emissao,valor_total)');
        SQL.Add('VALUES (');
        SQL.Add(TFunc.VazioNullString(Pedido.cliente_id)+','+TFunc.DataParaBD(Pedido.data_emissao)+','+TFunc.DoubleParaBD(Pedido.valor_total)+')');
        ExecSQL;
        Close;
        SQL.Clear;
        SQL.Add('SELECT LAST_INSERT_ID() cod;');
        Open;
        Pedido.id := FieldByName('cod').AsString;
        DM.Conexao.Commit;
      end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao inserir pedido! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOPedido.atualizar(Pedido : TPedido) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE pedido SET');
      SQL.Add('id = ' + TFunc.VazioNullString(Pedido.id)+',');
      SQL.Add('data_emissao = ' +TFunc.DataParaBD(Pedido.data_emissao)+',');
      SQL.Add('valor_total = ' + TFunc.DoubleParaBD(Pedido.valor_total));

      SQL.Add('WHERE id = ' + Pedido.id);
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao atualizar pedido! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOPedido.excluir(Pedido : TPedido) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
      begin
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM pedido_item WHERE pedido_id = '+Pedido.id+';');
        ExecSQL;
        Close;
        SQL.Clear;
        SQL.Add('DELETE FROM pedido WHERE id = '+Pedido.id+';');
        ExecSQL;


        DM.Conexao.Commit;
      end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao deletar pedido! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOPedido.preencherEntidade(Pedido : TPedido) : Boolean;
begin
  try

    Result := True;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('id,cliente_id,data_emissao,valor_total');
      SQL.Add('FROM pedido');
      SQL.Add('WHERE id = '+Pedido.id);
      Open;
      if not IsEmpty then
        begin
          preencherComDataSet(DM.QAux,Pedido);
        end
      else
        begin
          Pedido.id := '';
          Result := false;
        end;

      Close;

    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao preencher a entidade pedido! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
    end;
  end;
end;


procedure TDAOPedido.preencherComDataSet(Query:TDataSet; Pedido : TPedido);
begin
  try
    with Query do
    begin
      Pedido.id := FieldByName('id').AsString;
      Pedido.cliente_id := FieldByName('cliente_id').AsString;
      Pedido.data_emissao := FieldByName('data_emissao').AsString;
      Pedido.valor_total := FieldByName('valor_total').AsString;

    end;
  except
    On erro:Exception do 
    begin
      MessageDlg('Ocorreu um erro ao preencher Pedido! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
    end;
  end;
end;
end.