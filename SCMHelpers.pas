unit SCMHelpers;

interface

uses
  System.SysUtils, System.Classes, System.UITypes, Vcl.DBGrids, Vcl.Grids,
  Vcl.Graphics, Winapi.Windows, Data.DB;

type
  TGridHelper = class helper for TDBGrid
    function ColumnByName(const AName: String): TColumn;
    procedure DrawCheckBoxes(oGrid: TObject; Rect: TRect; Column: TColumn;
      fontColor, bgColor: TColor);
    function GetCellRect(aPoint: TPoint): TRect;
  end;


implementation

{ TGridHelper }

function TGridHelper.GetCellRect(aPoint: TPoint): TRect;
var
  pt: TPoint;
  GridCoord: TGridCoord;
  aRect: TRect;
begin
  // NOTE: Function TPoint - Intended for Mouse.CursorPos.
  // SAFE to have illegal params.
  pt := ScreenToClient(aPoint);
  // Documentation says it uses screen coordinates. BUT IT DOESN'T.
  GridCoord := MouseCoord(pt.X, pt.Y); // get col, row
  aRect := CellRect(GridCoord.X, GridCoord.Y); // uses col, row
  result := ClientToScreen(aRect); // aRect position ready for dialogue display.
end;

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


// ---------------------------------------------------------------------------
// Draw a very basic checkbox (ticked) - not a nice as TCheckListBox
// ---------------------------------------------------------------------------
procedure TGridHelper.DrawCheckBoxes(oGrid: TObject; Rect: TRect;
  Column: TColumn; fontColor, bgColor: TColor);
var
  MyRect: TRect;
  oField: TField;
  iPos, iFactor: Integer;
  bValue: Boolean;
  g: TDBGrid;
  points: Array [0 .. 4] of TPoint;
begin
  // ---------------------------------------------------------------------------
  // Draw a very basic checkbox (ticked) - not a nice as TCheckListBox
  // ---------------------------------------------------------------------------
  // NOTE: DEFAULT DRAWING IS DISABLED ....
  // NOTE: DO NOT ENABLE TDBGRID OPTION dgAlwaysShowEditor.
  // (inconsistent OS MESSAGING)

  g := TDBGrid(oGrid);
  // is the cell checked?
  oField := Column.Field;
  if (oField.Value = -1) then
    bValue := true
  else
    bValue := false;

  g.Canvas.Pen.Color := fontColor; //
  g.Canvas.Brush.Color := bgColor;
  g.Canvas.Brush.Style := bsSolid;
  g.Canvas.FillRect(Rect);

  // calculate margins
  MyRect.Top := Trunc((Rect.Bottom - Rect.Top - 17) / 2) + Rect.Top;
  MyRect.Left := Trunc((Rect.Right - Rect.Left - 17) / 2) + Rect.Left;
  MyRect.Bottom := MyRect.Top + 16;
  MyRect.Right := MyRect.Left + 16;

  // USES PEN - draw the box (with cell margins)
  points[0].x := MyRect.Left;
  points[0].y := MyRect.Top;
  points[1].x := MyRect.Right;
  points[1].y := MyRect.Top;
  points[2].x := MyRect.Right;
  points[2].y := MyRect.Bottom;
  points[3].x := MyRect.Left;
  points[3].y := MyRect.Bottom;
  points[4].x := MyRect.Left;
  points[4].y := MyRect.Top;

  g.Canvas.Polyline(points);

  iPos := MyRect.Left;
  iFactor := 1;
  // USES PEN - DRAW A TICK - Cross would be nicer?
  if bValue then
  begin
    // 16x16 grid. Pen width is 1 pixel.
    // tick falls
    g.Canvas.MoveTo(iPos + (iFactor * 2), MyRect.Top + 8);
    g.Canvas.LineTo(iPos + (iFactor * 2), MyRect.Top + 11);
    g.Canvas.MoveTo(iPos + (iFactor * 3), MyRect.Top + 9);
    g.Canvas.LineTo(iPos + (iFactor * 3), MyRect.Top + 12);
    g.Canvas.MoveTo(iPos + (iFactor * 4), MyRect.Top + 10);
    g.Canvas.LineTo(iPos + (iFactor * 4), MyRect.Top + 13);
    g.Canvas.MoveTo(iPos + (iFactor * 5), MyRect.Top + 11);
    g.Canvas.LineTo(iPos + (iFactor * 5), MyRect.Top + 14);
    // bottom ... flattens
    g.Canvas.MoveTo(iPos + (iFactor * 6), MyRect.Top + 12);
    g.Canvas.LineTo(iPos + (iFactor * 6), MyRect.Top + 15);
    g.Canvas.MoveTo(iPos + (iFactor * 7), MyRect.Top + 12);
    g.Canvas.LineTo(iPos + (iFactor * 7), MyRect.Top + 15);
    // tick rises
    g.Canvas.MoveTo(iPos + (iFactor * 8), MyRect.Top + 11);
    g.Canvas.LineTo(iPos + (iFactor * 8), MyRect.Top + 14);
    g.Canvas.MoveTo(iPos + (iFactor * 9), MyRect.Top + 10);
    g.Canvas.LineTo(iPos + (iFactor * 9), MyRect.Top + 13);
    g.Canvas.MoveTo(iPos + (iFactor * 10), MyRect.Top + 9);
    g.Canvas.LineTo(iPos + (iFactor * 10), MyRect.Top + 12);
    g.Canvas.MoveTo(iPos + (iFactor * 11), MyRect.Top + 8);
    g.Canvas.LineTo(iPos + (iFactor * 11), MyRect.Top + 11);
    g.Canvas.MoveTo(iPos + (iFactor * 12), MyRect.Top + 7);
    g.Canvas.LineTo(iPos + (iFactor * 12), MyRect.Top + 10);
    g.Canvas.MoveTo(iPos + (iFactor * 13), MyRect.Top + 6);
    g.Canvas.LineTo(iPos + (iFactor * 13), MyRect.Top + 9);
    g.Canvas.MoveTo(iPos + (iFactor * 14), MyRect.Top + 5);
    g.Canvas.LineTo(iPos + (iFactor * 14), MyRect.Top + 8);
    g.Canvas.MoveTo(iPos + (iFactor * 15), MyRect.Top + 4);
    g.Canvas.LineTo(iPos + (iFactor * 15), MyRect.Top + 7);
    g.Canvas.MoveTo(iPos + (iFactor * 16), MyRect.Top + 3);
    g.Canvas.LineTo(iPos + (iFactor * 16), MyRect.Top + 6);
  end;
end;


end.
