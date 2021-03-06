Unit DAOCliente;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls, UDM, Cliente, Func, Firedac.Comp.Client;

  Type

  TDAOCliente = Class
  public
    function inserir(cliente: TCliente) : Boolean;
    function atualizar(cliente: TCliente) : Boolean;
    function excluir(cliente: TCliente) : Boolean;
    function preencherEntidade(cliente: TCliente) : Boolean;
    procedure preencherComDataSet(Query: TDataSet; cliente: TCliente);
    procedure listarClientes(Query: TFDQuery);
  end;


implementation

function TDAOCliente.inserir(cliente: TCliente) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO cliente(');
      SQL.Add('nome,cidade,uf)');
      SQL.Add('VALUES (');
      SQL.Add(TFunc.QuotedStr2(cliente.nome)+','+TFunc.QuotedStr2(cliente.cidade)+','+TFunc.QuotedStr2(cliente.uf)+')');
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao inserir cliente! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


procedure TDAOCliente.listarClientes(Query: TFDQuery);
begin
  with Query do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT * FROM cliente ORDER BY nome');
      Open;
    end;
end;

function TDAOCliente.atualizar(cliente: TCliente) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE cliente SET');
      SQL.Add('id = ' + TFunc.QuotedStr2(cliente.id)+',');
      SQL.Add('cidade = ' + TFunc.QuotedStr2(cliente.cidade)+',');
      SQL.Add('uf = ' + TFunc.QuotedStr2(cliente.uf));

      SQL.Add('WHERE id = ' + cliente.id);
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao atualizar cliente! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOCliente.excluir(cliente: TCliente) : Boolean;
begin
  try
    Result := True;
    DM.Conexao.StartTransaction;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('DELETE FROM cliente');
      SQL.Add('WHERE id = '+cliente.id);
      ExecSQL;
      DM.Conexao.Commit;
    end;
  except
    On erro:Exception do
    begin
      MessageDlg('Ocorreu um erro ao deletar cliente! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
      DM.Conexao.Rollback;
    end;
  end;
end;


function TDAOCliente.preencherEntidade(cliente: TCliente) : Boolean;
begin
  try
    Result := True;
    with DM.QAux do
    begin
      Close;
      SQL.Clear;
      SQL.Add('SELECT ');
      SQL.Add('id,nome,cidade,uf');
      SQL.Add('FROM cliente'); 
      SQL.Add('WHERE id = '+cliente.id);
      Open;
      preencherComDataSet(DM.QAux,cliente);
      Close;

    end;
  except
    On erro:Exception do 
    begin
      MessageDlg('Ocorreu um erro ao preencher a entidade cliente! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
      Result := false;
    end;
  end;
end;


procedure TDAOCliente.preencherComDataset(Query:TDataSet; cliente: TCliente);
begin
  try
    with Query do
    begin
      cliente.id := FieldByName('id').AsString;
      cliente.nome := FieldByName('nome').AsString;
      cliente.cidade := FieldByName('cidade').AsString;
      cliente.uf := FieldByName('uf').AsString;

    end;
  except
    On erro:Exception do 
    begin
      MessageDlg('Ocorreu um erro ao preencher cliente! '
      + 'Mensagem de erro : ' + #13 + erro.message, mtInformation, [MbOk], 0);
    end;
  end;
end;
end.