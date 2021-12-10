Unit CTRPedidoItem;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls, PedidoItem, DAOPedidoItem;

  Type

  TCTRPedidoItem = Class
  private
    constructor Create; overload;
  public
    objDAOPedidoItem : TDAOPedidoItem;
    destructor Destroy; override;

    function inserir(pedidoItem: TPedidoItem) : Boolean;
    function atualizar(pedidoItem: TPedidoItem) : Boolean;
    function salvar(pedidoItem: TPedidoItem) : Boolean;
    function excluir(pedidoItem: TPedidoItem) : Boolean;
    function preencherEntidade(pedidoItem: TPedidoItem) : Boolean;
    procedure preencherComDataset(Query: TDataSet; pedidoItem: TPedidoItem);
  end;


implementation

constructor TCTRPedidoItem.Create;
begin
  objDAOPedidoItem := TDAOPedidoItem.Create;
end;

destructor TCTRPedidoItem.Destroy;
begin
  FreeAndNil(objDAOPedidoItem);
  inherited;
end;

function TCTRPedidoItem.inserir(pedidoItem: TPedidoItem) : Boolean;
begin
  Result := objDAOPedidoItem.inserir(pedidoItem);
end;

function TCTRPedidoItem.atualizar(pedidoItem: TPedidoItem) : Boolean;
begin
  Result := objDAOPedidoItem.atualizar(pedidoItem);
end;

function TCTRPedidoItem.salvar(pedidoItem: TPedidoItem) : Boolean;
begin
  if pedidoItem.id = '' then
    begin
      Result := objDAOPedidoItem.inserir(pedidoItem);
    end
  else
    begin
      Result := objDAOPedidoItem.atualizar(pedidoItem);
    end;
end;

function TCTRPedidoItem.excluir(pedidoItem: TPedidoItem) : Boolean;
begin
  Result := objDAOPedidoItem.excluir(pedidoItem);
end;

function TCTRPedidoItem.preencherEntidade(pedidoItem: TPedidoItem) : Boolean;
begin
  Result := objDAOPedidoItem.preencherEntidade(pedidoItem);
end;

procedure TCTRPedidoItem.preencherComDataset(Query:TDataSet; pedidoItem: TPedidoItem);
begin
  objDAOPedidoItem.preencherComDataset(Query, pedidoItem);
end;
end.