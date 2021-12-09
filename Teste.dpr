program Teste;

uses
  Vcl.Forms,
  Master in 'Master.pas' {frmMaster},
  UDM in 'UDM.pas' {DM: TDataModule},
  Cliente in 'src\Entidades\Cliente.pas',
  Pedido in 'src\Entidades\Pedido.pas',
  PedidoItem in 'src\Entidades\PedidoItem.pas',
  Produto in 'src\Entidades\Produto.pas',
  DAOCliente in 'src\DAO\DAOCliente.pas',
  DAOPedido in 'src\DAO\DAOPedido.pas',
  DAOPedidoItem in 'src\DAO\DAOPedidoItem.pas',
  DAOProduto in 'src\DAO\DAOProduto.pas',
  CTRCliente in 'src\CTR\CTRCliente.pas',
  CTRPedido in 'src\CTR\CTRPedido.pas',
  CTRPedidoItem in 'src\CTR\CTRPedidoItem.pas',
  CTRProduto in 'src\CTR\CTRProduto.pas',
  Func in 'src\Func.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMaster, frmMaster);
  Application.Run;
end.
