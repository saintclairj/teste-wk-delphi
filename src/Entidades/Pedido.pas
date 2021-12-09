Unit Pedido;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls;

  Type

  TPedido = Class
  Private
    Fid : String;
    Fcliente_id : String;
    Fdata_emissao : String;
    Fvalor_total : String;

  Published
    property id : String read Fid write Fid;
    property cliente_id : String read Fcliente_id write Fcliente_id;
    property data_emissao : String read Fdata_emissao write Fdata_emissao;
    property valor_total : String read Fvalor_total write Fvalor_total;

  end;


implementation

end.