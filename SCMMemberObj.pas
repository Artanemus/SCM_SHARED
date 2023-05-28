unit SCMMemberObj;

interface
uses
  System.Classes;
type

TSCMMemberObj = class(TObject)
private
    fHRID: integer;   // SCM_COACH.dbo.HR IDENITY
    fSCMMemberID: integer; // SwimClubMeet.dbo.Member IDENITY
    fName: string;
public
  constructor Create();
  destructor Destroy; override;

  property SCMMemberID: integer read fSCMMemberID write fSCMMemberID;
  property HRID: integer read fHRID write fHRID;
  property Name: string read fName write fName;

//published

end;

implementation

{ TscmMemberObj }

constructor TSCMMemberObj.Create;
begin
  fSCMMemberID := 0;
  fHRID := 0;
  fName := '';
end;

destructor TSCMMemberObj.Destroy;
begin

  inherited;
end;

end.
