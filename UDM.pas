unit UDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, Dialogs;

type
  TDM = class(TDataModule)
    Conexao: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    QAux: TFDQuery;
    QCliente: TFDQuery;
    DSCliente: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    function conectar: Boolean;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TDM }

function TDM.conectar: Boolean;
begin
  Result := true;
  try
    DM.Conexao.Params.UserName:= 'root';
    DM.Conexao.Params.Password:= '584584';
    DM.Conexao.Connected := true;
  except
    ShowMessage('N?o foi poss?vel conectar no banco de dados');
    Result := false;
  end;
end;

end.
