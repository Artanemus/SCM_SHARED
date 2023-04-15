unit SCMMemberObj;

interface
uses
  System.Classes;
type

TSCMMemberObj = class(TObject)
private
    fMemberID: integer;
    fName: string;
//protected
//
public

//  constructor Create(AOwner: TComponent); override;
//    destructor Destroy; override;

  constructor Create();
  destructor Destroy; override;

  property ID: integer read fMemberID write fMemberID;
  property Name: string read fName write fName;

published

end;

implementation

{ TscmMemberObj }

constructor TSCMMemberObj.Create;
begin
  fMemberID := 0;
  fName := '';
end;

destructor TSCMMemberObj.Destroy;
begin

  inherited;
end;

end.
