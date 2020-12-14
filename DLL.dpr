library DLL;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  System.SysUtils,
  System.Classes,
  System.UITypes,
  Vcl.Dialogs,
  Unit1 in 'Unit1.pas' {Form1},
  Request in 'Acesso_Rest\Request.pas',
  Response in 'Acesso_Rest\Response.pas',
  Request.Intf in 'Acesso_Rest\interfaces\Request.Intf.pas',
  Response.Intf in 'Acesso_Rest\interfaces\Response.Intf.pas';

{$R *.res}

function Somar(Valor1, valor2: integer): integer; stdcall;
begin
  Result := Valor1 + valor2;
end;

function Subtrair(Valor1, valor2: integer): integer; stdcall;
begin
  Result := Valor1 - valor2;
end;

function Dividir(Valor1, valor2: double): double; stdcall;
begin
  Result := Valor1 / valor2;
end;

function Mutiplicar(valor1, valor2: Integer): Integer; stdcall;
begin
  result := valor1 * valor2;
end;

procedure abrir; stdcall;
begin
  MessageDlg('entrou', mtInformation, [mbOk], 0);
  Form1 := TForm1.Create(nil);
  form1.ShowModal;
  FreeAndNil(Form1);
end;

function testeString(valor1, valor2: PAnsiString): PWideChar; stdcall;
var
  Arq: TStringList;
begin

  MessageDlg('O Arquivo HAHAHAHA.txt sera criado!', mtInformation, [mbOk], 0);

  try
    Arq := TStringList.Create;
    Arq.Add('HDSUADHSUADHAs');
    Arq.Add('HDSUADHSUADHAs');
    Arq.Add('HDSUADHSUADHAs');
    Arq.Add('HDSUADHSUADHAs');
    Arq.Add('APÚFHR');
    Arq.Add('APÚFHR');
    Arq.Add('APÚFHR');
    Arq.Add('APÚFHR');
    Arq.Add('APÚFHR');
    Arq.Add(PWideChar(valor1));
    Arq.Add(PWideChar(valor2));
    Arq.Sort;
    Arq.SaveToFile('HAHAHAHA.txt', TEncoding.UTF8);
    FreeAndNil(Arq);
  except
    on E: Exception do
      ShowMessage('ERRO: ' + e.Message);
  end;

  Result := PWideChar('Resultado: ' + PWideChar(valor1) + ' ' + PWideChar(valor2));
end;

exports
  Somar,
  Subtrair,
  Dividir,
  Mutiplicar,
  testeString,
  abrir;

begin
end.

