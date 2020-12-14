unit Request.Intf;

interface

uses Data.DB, REST.Types, System.JSON, Response.Intf;


type
  IRequest = interface
    ['{002607F0-A4BC-453B-B961-E2714C92EDAB}']
    function AcceptEncoding: string; overload;
    function AcceptEncoding(const AAcceptEncoding: string): IRequest; overload;
    function AcceptCharset: string; overload;
    function AcceptCharset(const AAcceptCharset: string): IRequest; overload;
    function Accept: string; overload;
    function Accept(const AAccept: string): IRequest; overload;
    function Timeout: Integer; overload;
    function Timeout(const ATimeout: Integer): IRequest; overload;
    function DataSetAdapter(const ADataSet: TDataSet): IRequest; overload;
    function DataSetAdapter: TDataSet; overload;
    function BaseURL(const ABaseURL: string): IRequest; overload;
    function BaseURL: string; overload;
    function Resource(const AResource: string): IRequest; overload;
    function RaiseExceptionOn500: Boolean; overload;
    function RaiseExceptionOn500(const ARaiseException: Boolean): IRequest; overload;
    function Resource: string; overload;
    function ResourceSuffix(const AResourceSuffix: string): IRequest; overload;
    function ResourceSuffix: string; overload;
    function Token(const AToken: string): IRequest;
    function BasicAuthentication(const AUsername, APassword: string): IRequest;
    function Get: IResponse;
    function Post: IResponse;
    function Put: IResponse;
    function Delete: IResponse;
    function Patch: IResponse;
    function FullRequestURL(const AIncludeParams: Boolean = True): string;
    function ClearBody: IRequest;
    function AddBody(const AContent: string; const AContentType: TRESTContentType = ctAPPLICATION_JSON): IRequest; overload;
    function AddBody(const AContent: TJSONObject; const AOwns: Boolean = True): IRequest; overload;
    function AddBody(const AContent: TJSONArray; const AOwns: Boolean = True): IRequest; overload;
    function AddBody(const AContent: TObject; const AOwns: Boolean = True): IRequest; overload;
    function ClearHeaders: IRequest;
    function AddHeader(const AName, AValue: string; const AOptions: TRESTRequestParameterOptions = []): IRequest;
    function ClearParams: IRequest;
    function UserAgent(const AName: string): IRequest;
    function AddParam(const AName, AValue: string; const AKind: TRESTRequestParameterKind = TRESTRequestParameterKind.pkGETorPOST): IRequest;
    function AddText(const AName: string; const AValue: string; const AContentType: TRESTContentType = TRESTContentType.ctAPPLICATION_JSON): IRequest;
  end;


implementation


end.
