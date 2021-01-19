unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation


Uses
 System.JSON, Request, REST.Types;

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  JsonPedido:TJSONObject;
  Paging:TJSONObject;
  JsonOrders:TJSONArray;
  JsonOrder:TJSONObject;
  Resposta: IResponse;
  I: Integer;
begin
  Resposta := TRequest.New
                      .BaseURL('https://api.jsonbin.io/b/6001fa4a4f42973a289d682c')
                      .AddHeader('secret-key', '$2b$10$W1HJIZPyGuvMH26c8DmrSedhgbGtlrAPio4l8.tiCuAUeWchLyKcq', [poDoNotEncode])
                      .Get;

  {Formas de receber e ler o JSON}
//    JsonCompleto := Resposta.JSONValue as TJSONObject;

  JsonPedido := TJSONObject.ParseJSONValue(TEncoding.UTF8.GetBytes(Resposta.JSONValue.ToJSON), 0) as TJSONObject;

  {Lendo o objeto Paging do JSON}
  Paging := JsonPedido.GetValue<TJSONObject>('paging');

  Memo1.Lines.Clear;
  Memo1.Lines.Add(Paging.Values['total'].ToString);
  Memo1.Lines.Add(Paging.Values['page'].ToString);
  Memo1.Lines.Add(Paging.Values['offset'].ToString);
  Memo1.Lines.Add(Paging.Values['limit'].ToString);
  Memo1.Lines.Add(Paging.Values['maxLimit'].ToString);

  {Lendo o objeto Orders - Order}
  JsonOrders := JsonPedido.GetValue<TJSONArray>('Orders');

  for i := 0 to Pred(JsonOrders.Count) do
  begin
    JsonOrder := JsonOrders.Items[i].GetValue<TJSONObject>('Order');

    Memo1.Lines.Add(JsonOrder.Values['store_note'].ToString);
  end;

  FreeAndNil(JsonPedido);
end;

procedure TForm2.Button2Click(Sender: TObject);
var
  resposta: IResponse;
  JSONPedido, JSONItem: TJSONObject;
  JsonArraItem:TJSONArray;
  i:Integer;
begin
  JSONPedido   := TJSONObject.Create;
  JSONItem     := TJSONObject.Create;
  JsonArraItem := TJSONArray.Create;

  Memo2.Lines.Clear;

  JSONPedido := TJSONObject.Create;
  JSONPedido.AddPair('pedido', '100');
  JSONPedido.AddPair('cliente', 'Murilo Beluco');
  JSONPedido.AddPair('total', TJSONNumber.Create(402.6));
  JSONPedido.AddPair('status', TJSONTrue.Create);

  for i := 0 to 300 do
  begin
    JSONItem := TJSONObject.Create;
    JSONItem.AddPair('descricao', 'radio: ' + IntToStr(i));
    JSONItem.AddPair('total', TJSONNumber.Create(100.65));
    JsonArraItem.AddElement(JSONItem);
  end;

  JSONPedido.AddPair('itens', JsonArraItem);

  Memo2.Lines.Add(JSONPedido.ToJSON);

  resposta := TRequest.New
                      .BaseURL('https://webhook.site/5a823b92-9a5f-4004-9c2a-75cd8db3a2fe')
                      .AddBody(JSONPedido, False)
                      .Post;

    {lista todo o header}
//  for i := 0 to Pred(resposta.Headers.Count) do
//    Memo2.Lines.Add(resposta.Headers[i]);

  {acessar informações do Header}
  Memo2.Lines.Add(resposta.Headers.Values['Server']);

  FreeAndNil(JSONPedido);
end;

end.
