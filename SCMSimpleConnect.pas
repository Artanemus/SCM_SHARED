unit SCMSimpleConnect;

interface

uses
  Classes, FireDAC.Stan.Def, FireDAC.Comp.Client, vcl.Forms;

type
  TSimpleConnect = class(TComponent)
  private
    { private declarations }
    FAConnection: TFDConnection;
    fDatabaseName: String;
    fAppShortName: String;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure SimpleMakeTemporyConnection(Server, User, Password: string;
      OsAuthent: boolean);
    constructor Create(AOwner: TComponent); override;
    constructor CreateWithConnection(AOwner: TComponent;
      AConnection: TFDConnection);

  published
    { published declarations }
    property scmConnection: TFDConnection read FAConnection write FAConnection;
    property DatabaseName: string read fDatabaseName write fDatabaseName;

  end;

  { TSimpleConnect }
implementation

uses
  SysUtils, SCMUtility, System.IniFiles, System.IOUtils;

constructor TSimpleConnect.Create(AOwner: TComponent);
begin
  inherited;
  // default
  fDatabaseName := 'SwimClubMeet';
  fAppShortName := TPath.GetFileNameWithoutExtension(Application.ExeName);
end;

constructor TSimpleConnect.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  Create(AOwner);
  FAConnection := AConnection;
end;

procedure TSimpleConnect.SimpleMakeTemporyConnection(Server, User,
  Password: string; OsAuthent: boolean);
var
  AValue, ASection, AName: string;
begin

  if not Assigned(FAConnection) then
    exit;

  if (FAConnection.Connected) then
  begin
    FAConnection.Close();
  end;
  FAConnection.Params.Clear;

  FAConnection.Params.Add('Server=' + Server);
  FAConnection.Params.Add('DriverID=MSSQL');
  FAConnection.Params.Add('Database=' + fDatabaseName);
  FAConnection.Params.Add('User_name=' + User);
  FAConnection.Params.Add('Password=' + Password);
  if (OsAuthent) then
    AValue := 'Yes'
  else
    AValue := 'No';
  FAConnection.Params.Add('OSAuthent=' + AValue);
  FAConnection.Params.Add('Mars=yes');
  FAConnection.Params.Add('MetaDefSchema=dbo');
  FAConnection.Params.Add('ExtendedMetadata=False');
  FAConnection.Params.Add('ApplicationName=' + fAppShortName);
  try
    FAConnection.Open;
  except
    // Display the server error?
  end;

    // ON SUCCESS - Save connection details.
  if (FAConnection.Connected) then
  begin
    ASection := 'MSSQL_Connection';
    AName := 'Server';
    SaveSharedIniFileSetting(ASection, AName, Server);
    AName := 'User';
    SaveSharedIniFileSetting(ASection, AName, User);
    AName := 'Password';
    SaveSharedIniFileSetting(ASection, AName, Password);
    AName := 'OSAuthent';
    SaveSharedIniFileSetting(ASection, AName, AValue);
  end

end;

end.
