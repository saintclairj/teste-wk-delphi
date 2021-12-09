Unit PedidoItem;

interface

  uses db, Dialogs, SysUtils, StdCtrls, Contnrs, Controls;

  Type

  TPedidoItem = Class
  Private
    Fid : String;
    Fpedido_id : String;
    Fproduto_id : String;
    Fqtd : String;
    Fvalor_unit : String;
    Fvalor_total : String;

  Published
    property id : String read Fid write Fid;
    property pedido_id : String read Fpedido_id write Fpedido_id;
    property produto_id : String read Fproduto_id write Fproduto_id;
    property qtd : String read Fqtd write Fqtd;
    property valor_unit : String read Fvalor_unit write Fvalor_unit;
    property valor_total : String read Fvalor_total write Fvalor_total;

  end;


implementation

end.