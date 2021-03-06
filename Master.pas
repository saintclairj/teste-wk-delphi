unit Master;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient, Vcl.DBCtrls,
  Vcl.StdCtrls, UDM, CTRCliente, Vcl.Grids, Vcl.DBGrids, CTRProduto, Produto, CTRPedido, Pedido, CTRPedidoItem, PedidoItem,
  Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmMaster = class(TForm)
    cds: TClientDataSet;
    GroupBox1: TGroupBox;
    editClienteId: TEdit;
    editCliente: TDBLookupComboBox;
    GBProduto: TGroupBox;
    editProdutoId: TEdit;
    editDescricao: TEdit;
    editQtd: TEdit;
    editValorUnit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    editTotalItem: TEdit;
    cdsid: TIntegerField;
    cdsdescricao: TStringField;
    cdsqtd: TFloatField;
    cdsproduto_id: TIntegerField;
    cdsvalor_unit: TFloatField;
    cdsvalor_total: TFloatField;
    DS: TDataSource;
    Grid: TDBGrid;
    Panel1: TPanel;
    BtNovo: TSpeedButton;
    BtEditar: TSpeedButton;
    btSalvar: TSpeedButton;
    BtCancelar: TSpeedButton;
    BtExcluir: TSpeedButton;
    btGravarPedido: TSpeedButton;
    Label6: TLabel;
    editTotal: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    lblPedido: TLabel;
    editPedidoId: TEdit;
    btCarregarPedido: TSpeedButton;
    SpeedButton1: TSpeedButton;
    btLimparTela: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure editClienteIdExit(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure editClienteClick(Sender: TObject);
    procedure editClienteIdKeyPress(Sender: TObject; var Key: Char);
    procedure editProdutoIdExit(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
    procedure editTotalItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure editQtdChange(Sender: TObject);
    procedure editValorUnitChange(Sender: TObject);
    procedure BtNovoClick(Sender: TObject);
    procedure BtEditarClick(Sender: TObject);
    procedure BtCancelarClick(Sender: TObject);
    procedure BtExcluirClick(Sender: TObject);
    procedure GridKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btGravarPedidoClick(Sender: TObject);
    procedure editClienteIdChange(Sender: TObject);
    procedure btCarregarPedidoClick(Sender: TObject);
    procedure editPedidoIdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btLimparTelaClick(Sender: TObject);
  private
    { Private declarations }
    CTRCliente: TCTRCliente;
    CTRProduto: TCTRProduto;
    Produto: TProduto;
    CTRPedido: TCTRPedido;
    Pedido: TPedido;
    CTRPedidoItem: TCTRPedidoItem;
    PedidoItem: TPedidoItem;
    listaCodExcluidos: TStringList;

    procedure limparCamposProduto;
    function salvarItem: Boolean;
    function excluirItem: Boolean;
    procedure calcularTotal;
    procedure calcularTotalGeral;
    function salvarPedido: Boolean;

  public
    { Public declarations }

  end;

var
  frmMaster: TfrmMaster;

implementation
uses Func;


{$R *.dfm}

procedure TfrmMaster.BtCancelarClick(Sender: TObject);
begin
  BtNovo.Enabled:= true;
  BtEditar.Enabled:= not cds.IsEmpty;
  BtExcluir.Enabled := not cds.IsEmpty;
  btSalvar.Enabled := false;
  BtCancelar.Enabled := false;
  GBProduto.Enabled := false;
  Grid.Enabled:= true;
  limparCamposProduto;
  cds.Cancel;
end;

procedure TfrmMaster.btCarregarPedidoClick(Sender: TObject);
begin
  if editPedidoId.Text <> '' then
    begin
      Pedido.id := editPedidoId.Text;
      if CTRPedido.preencherEntidade(Pedido) then
        begin
          editCliente.KeyValue:= Pedido.cliente_id;
          editTotal.Text:= TFunc.FormatarNumero(Pedido.valor_total);
          CTRPedidoItem.listar(Pedido.id, cds);
        end
      else
        begin
          ShowMessage('Pedido n?o encontrado');
          editPedidoId.Text := '';
        end;


    end;
end;

procedure TfrmMaster.BtEditarClick(Sender: TObject);
begin
  BtNovo.Enabled:= false;
  BtEditar.Enabled:= false;
  BtExcluir.Enabled := false;
  btSalvar.Enabled := true;
  BtCancelar.Enabled := true;
  GBProduto.Enabled := true;
  Grid.Enabled:= false;
  limparCamposProduto;
  editProdutoId.Text := cdsproduto_id.AsString;
  editDescricao.Text := cdsdescricao.AsString;
  editQtd.Text := TFunc.FormatarNumero(cdsqtd.Value);
  editValorUnit.Text := TFunc.FormatarNumero(cdsvalor_unit.Value);
  editTotalItem.Text := TFunc.FormatarNumero(cdsvalor_total.Value);
  cds.Edit;

end;

procedure TfrmMaster.BtExcluirClick(Sender: TObject);
begin
  excluirItem;
end;

procedure TfrmMaster.btGravarPedidoClick(Sender: TObject);
begin
  salvarPedido;
end;

procedure TfrmMaster.BtNovoClick(Sender: TObject);
begin
  BtNovo.Enabled:= false;
  BtEditar.Enabled:= false;
  BtExcluir.Enabled := false;
  btSalvar.Enabled := true;
  BtCancelar.Enabled := true;
  GBProduto.Enabled := true;
  Grid.Enabled:= true;
  limparCamposProduto;
  editProdutoId.SetFocus;
end;

procedure TfrmMaster.btSalvarClick(Sender: TObject);
begin
  salvarItem;

end;

procedure TfrmMaster.calcularTotal;
var
  vrUnit, vrTotal, qtd : Extended;
  ok: Boolean;
begin
  ok:= true;
  editTotalItem.Text := '';
  if not TryStrToFloat(editQtd.Text, qtd) then
    begin
      ok:= false;
    end;
  if not TryStrToFloat(editValorUnit.Text, vrUnit) then
    begin
      ok:= false;
    end;


  if ok then
    begin
      vrTotal := qtd * vrUnit;
      editTotalItem.Text := TFunc.FormatarNumero(vrTotal,2);
    end;

end;

procedure TfrmMaster.calcularTotalGeral;
var
  total: Extended;
  i : integer;
begin
  total:= 0;
  with cds do
    begin
      if not IsEmpty then
        begin
          i:= RecNo;
          DisableControls;
          First;
          while not Eof do
            begin
              total := total + cdsvalor_total.Value;
              Next;
            end;
          RecNo := i;
          EnableControls;
        end;
    end;

  editTotal.Text := TFunc.FormatarNumero(total);


end;

procedure TfrmMaster.editClienteClick(Sender: TObject);
begin
  if editCliente.KeyValue <> null then
    begin
      editClienteId.Text := VarToStr(editCliente.KeyValue);
    end;
  editClienteIdChange(Self);
end;

procedure TfrmMaster.editClienteIdChange(Sender: TObject);
var
  exibir: Boolean;
begin
  exibir := (editClienteId.Text = '');
  lblPedido.Visible:= exibir;
  editPedidoId.Visible := exibir;
  btCarregarPedido.Visible := exibir;
  btLimparTela.Visible := exibir;

  
end;

procedure TfrmMaster.editClienteIdExit(Sender: TObject);
begin
  if editClienteId.Text <> '' then
    begin
      editCliente.KeyValue := editClienteId.Text;
      if editCliente.Text = '' then
        begin
          ShowMessage('Cliente n?o encontrado');
          editClienteId.Text:= '';

        end;

    end
  else
    begin
      editCliente.KeyValue := null;
    end;
  editClienteIdChange(Self);
end;

procedure TfrmMaster.editClienteIdKeyPress(Sender: TObject; var Key: Char);
begin
   if not (Key in ['0'..'9', ',', Chr(8),Chr(VK_RETURN),Chr(VK_DELETE)]) then Key := #0;
end;

procedure TfrmMaster.editPedidoIdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    begin
      btCarregarPedido.Click;
    end;
end;

procedure TfrmMaster.editProdutoIdExit(Sender: TObject);
var
  encontrado: Boolean;
begin
  encontrado:= false;
  if editProdutoId.Text <> '' then
    begin
      produto.id := editProdutoId.Text;

      if CTRProduto.preencherEntidade(Produto) then
        begin
          encontrado:= true;
          editProdutoId.Text := Produto.id;
          editDescricao.Text := Produto.descricao;
          editQtd.Text := '1';
          editValorUnit.Text := TFunc.FormatarNumero(Produto.preco_venda,2);
          editTotalItem.Text := TFunc.FormatarNumero(Produto.preco_venda,2);
        end
      else
        begin
          ShowMessage('Produto n?o encontrado!');
        end;
    end;

  if not encontrado then
    begin

      limparCamposProduto;

    end;

end;

procedure TfrmMaster.editQtdChange(Sender: TObject);
begin
  calcularTotal;
end;

procedure TfrmMaster.editTotalItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_RETURN then
    begin
      if btSalvar.Enabled then btSalvar.Click;
    end;

end;

procedure TfrmMaster.editValorUnitChange(Sender: TObject);
begin
  calcularTotal;
end;

function TfrmMaster.excluirItem: Boolean;
begin
  Result := TFunc.ConfirmarExclusao;

  if Result then
    begin
      if cdsid.Value <> 0 then
        begin
          listaCodExcluidos.Add(cdsid.AsString);
        end;
      cds.Delete;
      BtNovo.Enabled:= true;
      BtEditar.Enabled:= not cds.IsEmpty;
      BtExcluir.Enabled := not cds.IsEmpty;
      btSalvar.Enabled := false;
      BtCancelar.Enabled := false;
      GBProduto.Enabled := false;
      Grid.Enabled:= true;
      limparCamposProduto;
      calcularTotalGeral;
    end;
end;

procedure TfrmMaster.FormCreate(Sender: TObject);
begin
  CTRCliente:= TCTRCliente.Create;
  CTRProduto:= TCTRProduto.Create;
  Produto:= TProduto.Create;
  CTRPedido:= TCTRPedido.Create;
  Pedido:= TPedido.Create;
  CTRPedidoItem:= TCTRPedidoItem.Create;
  PedidoItem:= TPedidoItem.Create;
  listaCodExcluidos:= TStringList.Create;
  cds.CreateDataSet;

  if DM.conectar then
    begin
      CTRCliente.listarClientes(DM.QCliente);
    end;

end;

procedure TfrmMaster.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    begin
      if not ((ActiveControl is TMemo) or (ActiveControl is TDBRichEdit)) then
        begin
          Key := #0;
          Perform(WM_NEXTDLGCTL, 0, 0);
        end;
    end;
end;

procedure TfrmMaster.GridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_DELETE:
      if BtExcluir.Enabled then BtExcluir.Click;
      
    VK_RETURN:
      if BtEditar.Enabled then  BtEditar.Click;
  end;
end;

procedure TfrmMaster.limparCamposProduto;
begin
  editProdutoId.Text := '';
  editDescricao.Text := '';
  editQtd.Text := '';
  editValorUnit.Text := '';
  editTotalItem.Text := '';
end;

function TfrmMaster.salvarItem: Boolean;
var
  msg: String;
  vrUnit, vrTotal, qtd : Extended;
begin
  msg := '';
  if editDescricao.Text = '' then
    begin
      msg := msg + '*Selecione o produto'+#13;
    end;
  if editQtd.Text = '' then
    begin
      msg := msg + '*Digite a quantidade'+#13;
    end;
  if editValorUnit.Text = '' then
    begin
      msg := msg + '*Digite o valor'+#13;
    end;
  if not TryStrToFloat(editQtd.Text, qtd) then
    begin
      msg := msg + '*Quantidade inv?lida'+#13;
    end;
  if not TryStrToFloat(editValorUnit.Text, vrUnit) then
    begin
      msg := msg + '*Valor unit?rio inv?lido'+#13;
    end;
  if not TryStrToFloat(editTotalItem.Text, vrTotal) then
    begin
      msg := msg + '*Valor total inv?lido'+#13;
    end;


  Result := (msg = '');
  if Result then
    begin
      if not (cds.State in[dsInsert,dsEdit]) then
        begin
          cds.Append;
        end;
      cdsdescricao.Value := editDescricao.Text;
      cdsqtd.Value := qtd;
      cdsproduto_id.Value := StrToInt(editProdutoId.Text);
      cdsvalor_unit.Value := vrUnit;
      cdsvalor_total.Value := vrTotal;
      cds.Post;

      BtNovo.Enabled:= true;
      BtEditar.Enabled:= true;
      BtExcluir.Enabled := true;
      btSalvar.Enabled := false;
      BtCancelar.Enabled := false;
      GBProduto.Enabled := false;
      Grid.Enabled:= true;
      limparCamposProduto;

      calcularTotalGeral;

    end
  else
    begin
      ShowMessage(msg);
    end;


end;

function TfrmMaster.salvarPedido: Boolean;
var
  msg, s: String;

begin
  try
    btGravarPedido.Enabled := false;
    msg := '';
    if editClienteId.Text = '' then
      begin
        msg := msg + '*Preencha o cliente'+#13;
      end;
    if cds.IsEmpty then
      begin
        msg := msg + '*N?o h? itens para o pedido'+#13;
      end;

    Result:= (msg.IsEmpty);

    if Result then
      begin
        Pedido.id := editPedidoId.Text;
        Pedido.cliente_id := editClienteId.Text;
        Pedido.data_emissao:= FormatDateTime('dd/mm/yyyy', Now);
        Pedido.valor_total := editTotal.Text;

        CTRPedido.salvar(Pedido);
        with cds do
          begin
            First;
            DisableControls;
            while not Eof do
              begin
                PedidoItem:= TPedidoItem.Create;
                if cdsid.Value <> 0 then
                  begin
                    PedidoItem.id := cdsid.AsString;
                  end;
                PedidoItem.pedido_id := Pedido.id;
                PedidoItem.produto_id := cdsproduto_id.AsString;
                PedidoItem.qtd := TFunc.FormatarNumero(cdsqtd.Value);
                PedidoItem.valor_unit := TFunc.FormatarNumero(cdsvalor_unit.Value);
                PedidoItem.valor_total := TFunc.FormatarNumero(cdsvalor_total.Value);
                CTRPedidoItem.salvar(PedidoItem);
                Next;
              end;
            First;
            EnableControls;
            for s in listaCodExcluidos do
              begin
                PedidoItem.id := s;
                CTRPedidoItem.excluir(PedidoItem);
              end;
            listaCodExcluidos.Clear;

            ShowMessage('Pedido gravado com sucesso: '+ Pedido.id);
            btLimparTela.Click;
          end;
      end
    else
      begin
        ShowMessage(msg);
      end;
  finally
    btGravarPedido.Enabled := true;

  end;


end;

procedure TfrmMaster.SpeedButton1Click(Sender: TObject);
var
  id: String;
  n : integer;
begin
  id := InputBox('Excluir Pedido','Informe o c?digo', '');
  if id <> '' then
    begin
      if TryStrToInt(id, n) then
        begin
          Pedido.id := id;
          if CTRPedido.preencherEntidade(Pedido) then
            begin
              if CTRPedido.excluir(Pedido) then
                begin
                  ShowMessage('Pedido '+id+ ' excluido com sucesso!');
                end;
            end
          else
            begin
              ShowMessage('Pedido n?o encontrado!');
            end;
        end
      else
        begin
          ShowMessage('C?digo inv?lido');
        end;
    end;

end;

procedure TfrmMaster.btLimparTelaClick(Sender: TObject);
begin
  editClienteId.Text := '';
  editCliente.KeyValue := Null;
  editPedidoId.Text := '';
  editTotal.Text := '0';
  cds.EmptyDataSet;
  limparCamposProduto;
  BtCancelar.Click;
end;

end.
