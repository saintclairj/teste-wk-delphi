program Teste;

uses
  Vcl.Forms,
  Master in 'Master.pas' {frmMaster},
  UDM in 'UDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMaster, frmMaster);
  Application.Run;
end.