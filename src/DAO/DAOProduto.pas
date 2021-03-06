Unit DAOProduto;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls, UDM, Produto, Func;

  Type

  TDAOProduto = Class
  public
    function inserir(produto : TProduto) : Boolean;
    function atualizar(produto : TProduto) : Boolean;
    function excluir(produto : TProduto) : Boolean;
    function preencherEntidade(produto : TProduto) : Boolean;
    procedure preencherComDataSet(Query: TDataset; produto : TProduto);
  end;


implementation

function TDAOproduto.inserir(produto : TProduto) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO produto(');
      SQL.Add('descricao,preco_venda)');
      SQL.Add('VALUES ('); 
      SQL.Add(TFunc.QuotedStr2(produto.descricao)+','+TFunc.VazioNullString(produto.preco_venda)+')');
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao inserir produto! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOproduto.atualizar(produto : TProduto) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE produto SET');
      SQL.Add('id = ' + TFunc.QuotedStr2(produto.id)+',');
      SQL.Add('preco_venda = ' + TFunc.VazioNullString(produto.preco_venda));

      SQL.Add('WHERE id = ' + produto.id); 
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao atualizar produto! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOproduto.excluir(produto : TProduto) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM produto');
      SQL.Add('WHERE id = '+produto.id);
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao deletar produto! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOproduto.preencherEntidade(produto : TProduto) : Boolean;
begin
  try
    Result := True;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('id,descricao,preco_venda');
      SQL.Add('FROM produto'); 
      SQL.Add('WHERE id = '+produto.id);
      Open;
      if not IsEmpty then
        begin
          preencherComDataSet(DM.QAux, produto);
        end
      else
        begin
          produto.id := '';
          Result := false;
        end;
      Close;

    end;
  except
    On erro:Exception do 
    begin
      MessageDlg('Ocorreu um erro ao preencher a entidade produto! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
    end;
  end;
end;


procedure TDAOproduto.preencherComDataSet(Query:TDataSet; produto : TProduto);
begin
  try
    with Query do
    begin
      produto.id := FieldByName('id').AsString;
      produto.descricao := FieldByName('descricao').AsString;
      produto.preco_venda := FieldByName('preco_venda').AsString;

    end;
  except
    On erro:Exception do 
    begin
      MessageDlg('Ocorreu um erro ao preencher Produto! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
    end;
  end;
end;
end.