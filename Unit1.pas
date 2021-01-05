unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  IdBaseComponent, IdComponent, IdUDPBase, IdUDPClient, IdSNTP;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Image1: TImage;
    lblIp: TLabel;
    IdSNTP1: TIdSNTP;
    lblHorario: TLabel;
    Timer1: TTimer;
    lblInfo: TLabel;
    Timer2: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    Lista:TStringList;
    procedure ShowImageFromStream(AImage: TImage; AData: TStream);
    function retornaImagem:TBytes; overload;
    function retornaImagem(vsId:String):TBytes; overload;
    function retornaInfoImagem(vsId:String):string;
    function retornaListaImagem:TStringList;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  Response, Request, JPEG, System.NetEncoding, Jsons;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Resposta: IResponse;
begin
  Timer2.Enabled := False;

  Resposta := TRequest.New
                      .BaseURL('https://ident.me/')
                      .Get;

  Memo1.Lines.Clear;
  Memo1.Lines.Add(Resposta.Content);

  lblIp.Visible := True;
  lblIp.Caption := Resposta.Content;

  retornaImagem;

  if not Timer1.Enabled then
    Timer1.Enabled := True;

  Timer2.Enabled := True;
end;

function TForm1.retornaImagem: TBytes;
var
  Resposta : IResponse;
  Recebido : TStringStream;
  Foto     : TMemoryStream;
begin
  try
    Recebido := TStringStream.Create;
    Foto     := TMemoryStream.Create;
    try
      Resposta := TRequest.New
                          .BaseURL('https://picsum.photos/548/217.jpg')
                          .Get;

      Recebido.WriteData(Resposta.RawBytes, Length(Resposta.RawBytes));
      Recebido.Position := 0;

      Foto := TMemoryStream.Create;
      Foto.LoadFromStream(Recebido);

      Image1.Picture.Assign(nil);

      ShowImageFromStream(Image1, Foto);

      lblInfo.Visible := True;
      lblInfo.Caption := retornaInfoImagem(Resposta.Headers.Values['Picsum-Id']);
      retornaListaImagem;
    except
      on E: Exception do
        ShowMessage('Erro: ' + e.Message)
    end;
  finally
    FreeAndNil(Recebido);
    FreeAndNil(Foto);
  end;
end;

function TForm1.retornaImagem(vsId: String): TBytes;
var
  Resposta   : IResponse;
  Recebido   : TStringStream;
  Foto       : TMemoryStream;
begin
  try
    Recebido := TStringStream.Create;
    Foto     := TMemoryStream.Create;
    try
      Resposta := TRequest.New
                          .BaseURL(Format('https://picsum.photos/id/%s/548/217', [vsId]))
                          .Get;

      Recebido.WriteData(Resposta.RawBytes, Length(Resposta.RawBytes));
      Recebido.Position := 0;

      Foto := TMemoryStream.Create;
      Foto.LoadFromStream(Recebido);

      Image1.Picture.Assign(nil);

      ShowImageFromStream(Image1, Foto);

      lblInfo.Visible := True;
      lblInfo.Caption := retornaInfoImagem(Resposta.Headers.Values['Picsum-Id']);

    except
      on E: Exception do
        ShowMessage('Erro: ' + e.Message)
    end;
  finally
    FreeAndNil(Recebido);
    FreeAndNil(Foto);
  end;
end;

function TForm1.retornaInfoImagem(vsId: String): string;
var
  JsonResposta:TJson;
  Resposta:IResponse;
begin
  try
    JsonResposta := TJson.Create;
    Resposta := TRequest.New
                        .BaseURL(Format('https://picsum.photos/id/%s/info', [vsId]))
                        .Get;


    JsonResposta.Parse(Resposta.JSONText);

    Result := 'Autor: ' + JsonResposta.Values['author'].AsString;
  finally
    FreeAndNil(JsonResposta);
  end;
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

function TForm1.retornaListaImagem: TStringList;
var
  vnIdx, vnIdxJson: Integer;
  Resposta: IResponse;
  JsonResposta: TJsonArray;
begin
  try
    JsonResposta := TJsonArray.Create;
    Result := TStringList.Create;
    try

      for vnIdx := 1 to 10 do
      begin
        Resposta := TRequest.New
                            .BaseURL(Format('https://picsum.photos/v2/list?page=%d&limit=100', [vnidx]))
                            .Get;

        JsonResposta.Clear;

        JsonResposta.Parse(Resposta.JSONValue.ToJSON);

        for vnIdxJson := 0 to JsonResposta.Count - 1 do
          Result.Add(JsonResposta.Items[vnIdxJson].AsObject.Values['id'].AsString)

      end;

    except
      on E: Exception do
        ShowMessage('Erro: ' + e.Message)
    end;
  finally
    FreeAndNil(JsonResposta);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  IdSNTP1.Connect;

  lblHorario.Visible := True;
  lblHorario.Caption := DateTimeToStr(IdSNTP1.DateTime);
  Application.ProcessMessages;
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var
  vnId:Integer;
begin

  if not Assigned(Lista) then
  begin
    Lista := TStringList.Create;
    Lista := retornaListaImagem;
  end;

  Randomize;
  vnId := Random(Lista.Count);

  retornaImagem(Lista.Strings[vnId]);

  Memo1.Lines.Add('Buscando uma imagem Random ID: ' + IntToStr(vnId));
end;

end.
