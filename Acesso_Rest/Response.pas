unit Response;

interface

uses Response.Intf, REST.Client, System.SysUtils, System.JSON, System.Classes, Character;

type
  TResponse = class(TInterfacedObject, IResponse)
  private
    FRESTResponse: TRESTResponse;
    function Content: string;
    function ContentLength: Cardinal;
    function ContentType: string;
    function ContentEncoding: string;
    function StatusCode: Integer;
    function ErrorMessage: string;
    function RawBytes: TBytes;
    function JSONValue: TJSONValue;
    function Headers: TStrings;
    function JSONText:string;
    procedure RootElement(const PRootElement:String);
    function StripNonJson(s: string): string;
  public
    constructor Create(const ARESTResponse: TRESTResponse);
  end;

implementation

constructor TResponse.Create(const ARESTResponse: TRESTResponse);
begin
  FRESTResponse := ARESTResponse;
end;

function TResponse.ErrorMessage: string;
begin
  Result := '';
  if (FRESTResponse.Status.ClientErrorBadRequest_400) or
     (FRESTResponse.Status.ClientErrorUnauthorized_401) or
     (FRESTResponse.Status.ClientErrorForbidden_403) or
     (FRESTResponse.Status.ClientErrorNotFound_404) or
     (FRESTResponse.Status.ClientErrorNotAcceptable_406) or
     (FRESTResponse.Status.ClientErrorDuplicate_409)  then
  begin
    Result := FRESTResponse.StatusText;
  end;
end;

function TResponse.Content: string;
begin
  Result := FRESTResponse.Content;
end;

function TResponse.Headers: TStrings;
begin
  Result := FRESTResponse.Headers;
end;

function TResponse.ContentEncoding: string;
begin
  Result := FRESTResponse.ContentEncoding;
end;

function TResponse.ContentLength: Cardinal;
begin
  Result := FRESTResponse.ContentLength;
end;

function TResponse.ContentType: string;
begin
  Result := FRESTResponse.ContentType;
end;

function TResponse.JSONText: string;
begin
  Result := StripNonJson(FRESTResponse.JSONText);
end;

function TResponse.JSONValue: TJSONValue;
begin
  Result := FRESTResponse.JSONValue;
end;

function TResponse.RawBytes: TBytes;
begin
  Result := FRESTResponse.RawBytes;
end;

procedure TResponse.RootElement(const PRootElement:String);
begin
  FRESTResponse.RootElement := PRootElement;
end;

function TResponse.StatusCode: Integer;
begin
  Result := FRESTResponse.StatusCode;
end;

function TResponse.StripNonJson(s: string): string;
var
  ch: char;
  inString: boolean;
begin
  Result := '';
  inString := false;
  for ch in s do
  begin
    if ch = '"' then
      inString := not inString;

    if ch.IsWhiteSpace and not inString then
      continue;
    Result := Result + ch;
  end;
end;

end.

