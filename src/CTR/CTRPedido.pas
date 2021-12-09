Unit CTRPedido;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls, Pedido, DAOPedido;

  Type

  TCTRPedido = Class
  private
    constructor Create; overload;
  public
    objDAOPedido : TDAOPedido;
    destructor Destroy; override;

    function inserir(pedido : TPedido) : Boolean;
    function atualizar(pedido : TPedido) : Boolean;
    function salvar(pedido : TPedido) : Boolean;
    function excluir(pedido : TPedido) : Boolean;
    function preencherEntidade(pedido : TPedido) : Boolean;
    procedure preencherComDataset(Query: TDataSet; pedido : TPedido);
  end;


implementation

constructor TCTRPedido.Create;
begin
  objDAOPedido := TDAOPedido.Create;
end;

destructor TCTRPedido.Destroy;
begin
  FreeAndNil(objDAOPedido);
  inherited;
end;

function TCTRPedido.inserir(pedido : TPedido) : Boolean;
begin
  Result := objDAOPedido.inserir(pedido);
end;

function TCTRPedido.atualizar(pedido : TPedido) : Boolean;
begin
  Result := objDAOPedido.atualizar(pedido);
end;

function TCTRPedido.salvar(pedido : TPedido) : Boolean;
begin
  if pedido.id = '' then
    begin
      Result := objDAOPedido.inserir(pedido);
    end
  else
    begin
      Result := objDAOPedido.atualizar(pedido);
    end;
end;

function TCTRPedido.excluir(pedido : TPedido) : Boolean;
begin
  Result := objDAOPedido.excluir(pedido);
end;

function TCTRPedido.preencherEntidade(pedido : TPedido) : Boolean;
begin
  Result := objDAOPedido.preencherEntidade(pedido);
end;

procedure TCTRPedido.preencherComDataset(Query:TDataSet; pedido : TPedido);
begin
  objDAOPedido.preencherComDataset(Query, pedido);
end;
end.