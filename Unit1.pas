unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Image1: TImage;
    procedure Button1Click(Sender: TObject);
  private
    procedure ShowImageFromStream(AImage: TImage; AData: TStream);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Response, Request, JPEG, System.NetEncoding;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Resposta: IResponse;
  resposta1: IResponse;
  Recebido : TStringStream;
  Foto : TMemoryStream;
begin
  Resposta := TRequest.New
                         .BaseURL('https://httpbin.org/get')
                         .Get;

  Memo1.Lines.Clear;
  Memo1.Lines.Add(Resposta.JSONValue.ToJSON);


  resposta1 := TRequest.New.BaseURL('https://httpbin.org/image/jpeg').Get;

  Memo1.Lines.Add(resposta1.ContentType);

  Recebido := TStringStream.Create(resposta1.RawBytes);
  Recebido.Position := 0;
  Foto := TMemoryStream.Create;
  foto.LoadFromStream(Recebido);
  Foto.Position := 0;

  ShowImageFromStream(Image1, Foto);

  FreeAndNil(Recebido);
  FreeAndNil(foto);
end;

procedure TForm1.ShowImageFromStream(AImage: TImage; AData: TStream);
var
  JPEGImage: TJPEGImage;
begin
  AData.Position := 0;
  JPEGImage := TJPEGImage.Create;
  try
    JPEGImage.LoadFromStream(AData);
    AImage.Picture.Assign(JPEGImage);
  finally
    JPEGImage.Free;
  end;
end;

end.
