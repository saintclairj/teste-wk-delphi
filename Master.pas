unit Master;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Datasnap.DBClient;

type
  TfrmMaster = class(TForm)
    cds: TClientDataSet;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMaster: TfrmMaster;

implementation
uses UDM;

{$R *.dfm}

procedure TfrmMaster.FormCreate(Sender: TObject);
begin
  try
    DM.Conexao.Connected := true;
  except
    ShowMessage('Não foi possível conectar no banco de dados');
  end;

end;

end.
