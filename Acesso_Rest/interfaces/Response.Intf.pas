unit Response.Intf;

interface

uses System.SysUtils, System.JSON,System.Classes;

type
  IResponse = interface
    ['{450B980A-74B2-4204-BE86-E1D62200EDF5}']
    function Content: string;
    function JSONText:string;
    function ContentLength: Cardinal;
    function ContentType: string;
    function ContentEncoding: string;
    function StatusCode: Integer;
    function ErrorMessage: string;
    function RawBytes: TBytes;
    function JSONValue: TJSONValue;
    function Headers: TStrings;
    procedure RootElement(const PRootElement:String);
  end;

implementation

end.

