Unit CTRProduto;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls, Produto, DAOproduto;

  Type

  TCTRProduto = Class
  private
    constructor Create; overload;
  public
    objDAOProduto : TDAOProduto;
    destructor Destroy; override;

    function inserir(produto : TProduto) : Boolean;
    function atualizar(produto : TProduto) : Boolean;
    function salvar(produto : TProduto) : Boolean;
    function excluir(produto : TProduto) : Boolean;
    function preencherEntidade(produto : TProduto) : Boolean;
    procedure preencherComDataset(Query: TDataSet; produto : TProduto);
  end;


implementation

constructor TCTRProduto.Create;
begin
  objDAOproduto := TDAOProduto.Create;
end;

destructor TCTRProduto.Destroy;
begin
  FreeAndNil(objDAOProduto);
  inherited;
end;

function TCTRProduto.inserir(produto : TProduto) : Boolean;
begin
  Result := objDAOProduto.inserir(produto);
end;

function TCTRProduto.atualizar(produto : TProduto) : Boolean;
begin
  Result := objDAOProduto.atualizar(produto);
end;

function TCTRProduto.salvar(produto : TProduto) : Boolean;
begin
  if produto.id = '' then
    begin
      Result := objDAOProduto.inserir(produto);
    end
  else
    begin
      Result := objDAOProduto.atualizar(produto);
    end;
end;

function TCTRProduto.excluir(produto : TProduto) : Boolean;
begin
  Result := objDAOProduto.excluir(produto);
end;

function TCTRProduto.preencherEntidade(produto : TProduto) : Boolean;
begin
  Result := objDAOProduto.preencherEntidade(produto);
end;

procedure TCTRProduto.preencherComDataset(Query:TDataSet; produto : Tproduto);
begin
  objDAOProduto.preencherComDataset(Query, produto);
end;
end.