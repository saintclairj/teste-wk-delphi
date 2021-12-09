Unit Cliente;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls;

  Type

  TCliente = Class
  Private
    Fid : String;
    Fnome : String;
    Fcidade : String;
    Fuf : String;

  Published
    property id : String read Fid write Fid;
    property nome : String read Fnome write Fnome;
    property cidade : String read Fcidade write Fcidade;
    property uf : String read Fuf write Fuf;

  end;


implementation

end.