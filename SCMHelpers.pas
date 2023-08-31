unit SCMHelpers;

interface

uses
System.SysUtils, System.Classes,Vcl.DBGrids, Vcl.Grids;

type
  TGridHelper = class helper for TDBGrid
    function ColumnByName(const AName : String) : TColumn;
  end;

implementation

{ TGridHelper }

function TGridHelper.ColumnByName(const AName: String): TColumn;
var
  i: Integer;
begin
  result := Nil;
  for i := 0 to Columns.Count - 1 do
  begin
    if (Columns[i].Field <> Nil) and
      (CompareText(Columns[i].FieldName, AName) = 0) then
    begin
      result := Columns[i];
      exit;
    end;
  end;
end;

end.
