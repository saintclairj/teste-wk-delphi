Unit Produto;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls;

  Type

  TProduto = Class
  Private
    Fid : String;
    Fdescricao : String;
    Fpreco_venda : String;

  Published
    property id : String read Fid write Fid;
    property descricao : String read Fdescricao write Fdescricao;
    property preco_venda : String read Fpreco_venda write Fpreco_venda;

  end;


implementation

end.