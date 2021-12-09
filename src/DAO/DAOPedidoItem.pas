Unit DAOPedidoItem;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls, UDM, PedidoItem, Func;

  Type

  TDAOPedidoItem = Class
  public
    function inserir(PedidoItem : TPedidoItem) : Boolean;
    function atualizar(PedidoItem : TPedidoItem) : Boolean;
    function excluir(PedidoItem : TPedidoItem) : Boolean;
    function preencherEntidade(PedidoItem : TPedidoItem) : Boolean;
    procedure preencherComDataSet(Query: TDataSet; PedidoItem : TPedidoItem);
  end;


implementation

function TDAOPedidoItem.inserir(PedidoItem : TPedidoItem) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO pedido_item(');
      SQL.Add('pedido_id,produto_id,qtd,valor_unit,valor_total)');

      SQL.Add('VALUES (');
      SQL.Add(TFunc.VazioNullString(PedidoItem.pedido_id)+','+
      TFunc.VazioNullString(PedidoItem.produto_id)+','+
      TFunc.VazioNullString(PedidoItem.qtd)+','+
      TFunc.VazioNullString(PedidoItem.valor_unit)+','+
      TFunc.VazioNullString(PedidoItem.valor_total)+')');
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao inserir pedido_item! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOPedidoItem.atualizar(PedidoItem : TPedidoItem) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE pedido_item SET');
      SQL.Add('id = ' + TFunc.VazioNullString(PedidoItem.id)+',');
      SQL.Add('produto_id = ' + TFunc.VazioNullString(PedidoItem.produto_id)+',');
      SQL.Add('qtd = ' + TFunc.VazioNullString(PedidoItem.qtd)+',');
      SQL.Add('valor_unit = ' + TFunc.VazioNullString(PedidoItem.valor_unit)+',');
      SQL.Add('valor_total = ' + TFunc.VazioNullString(PedidoItem.valor_total));

      SQL.Add('WHERE id = ' + PedidoItem.id);
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao atualizar pedido_item! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOPedidoItem.excluir(PedidoItem : TPedidoItem) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM pedido_item');
      SQL.Add('WHERE id = '+PedidoItem.id);
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao deletar pedido_item! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOPedidoItem.preencherEntidade(PedidoItem : TPedidoItem) : Boolean;
begin
  try
    Result := True;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT id,pedido_id,produto_id,qtd,valor_unit,valor_total');
      SQL.Add('FROM pedido_item'); 
      SQL.Add('WHERE id = '+PedidoItem.id);
      Open;
      preencherComDataSet(DM.QAux,PedidoItem);
      Close;

    end;
  except
    On erro:Exception do 
    begin
      MessageDlg('Ocorreu um erro ao preencher a entidade pedido_item! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
    end;
  end;
end;


procedure TDAOPedidoItem.preencherComDataSet(Query:TDataSet; PedidoItem : TPedidoItem);
begin
  try
    with Query do
    begin
      PedidoItem.id := FieldByName('id').AsString;
      PedidoItem.pedido_id := FieldByName('pedido_id').AsString;
      PedidoItem.produto_id := FieldByName('produto_id').AsString;
      PedidoItem.qtd := FieldByName('qtd').AsString;
      PedidoItem.valor_unit := FieldByName('valor_unit').AsString;
      PedidoItem.valor_total := FieldByName('valor_total').AsString;

    end;
  except
    On erro:Exception do 
    begin
      MessageDlg('Ocorreu um erro ao preencher PedidoItem! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
    end;
  end;
end;
end.