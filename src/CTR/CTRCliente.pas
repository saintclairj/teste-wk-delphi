Unit CTRCliente;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls, cliente, DAOCliente,
  Firedac.Comp.Client;

  Type

  TCTRCliente = Class
  private
    constructor Create; overload;
  public
    objDAOCliente : TDAOCliente;
    destructor Destroy; override;

    function inserir(cliente : TCliente) : Boolean;
    function atualizar(cliente : TCliente) : Boolean;
    function salvar(cliente : TCliente) : Boolean;
    function excluir(cliente : TCliente) : Boolean;
    function preencherEntidade(cliente : TCliente) : Boolean;
    procedure preencherComDataset(Query: TDataSet; cliente : TCliente);
    procedure listarClientes(Query: TFDQuery);
  end;


implementation

constructor TCTRCliente.Create;
begin
  objDAOCliente := TDAOCliente.Create;
end;

destructor TCTRCliente.Destroy;
begin
  FreeAndNil(objDAOCliente);
  inherited;
end;

function TCTRCliente.inserir(cliente : TCliente) : Boolean;
begin
  Result := objDAOCliente.inserir(cliente);
end;

procedure TCTRCliente.listarClientes(Query: TFDQuery);
begin
  objDAOCliente.listarClientes(Query);
end;

function TCTRCliente.atualizar(cliente : TCliente) : Boolean;
begin
  Result := objDAOCliente.atualizar(cliente);
end;

function TCTRCliente.salvar(cliente : TCliente) : Boolean;
begin
  if cliente.id = '' then
    begin
      Result := objDAOCliente.inserir(cliente);
    end
  else
    begin
      Result := objDAOCliente.atualizar(cliente);
    end;
end;

function TCTRCliente.excluir(cliente : TCliente) : Boolean;
begin
  Result := objDAOCliente.excluir(cliente);
end;

function TCTRCliente.preencherEntidade(cliente : TCliente) : Boolean;
begin
  Result := objDAOCliente.preencherEntidade(cliente);
end;

procedure TCTRCliente.preencherComDataset(Query:TDataSet; cliente : TCliente);
begin
  objDAOCliente.preencherComDataset(Query, cliente);
end;
end.