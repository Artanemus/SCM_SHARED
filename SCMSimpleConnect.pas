unit SCMSimpleConnect;

interface

uses
  Classes, FireDAC.Stan.Def, FireDAC.Comp.Client, vcl.Forms;

type
  TSimpleConnect = class(TComponent)
  private
    { private declarations }
    fDBConnection: TFDConnection;
    fDBName: String;
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
    property DBConnection: TFDConnection read fDBConnection write fDBConnection;
    property DBName: string read fDBName write fDBName;

  end;

  { TSimpleConnect }
implementation

uses
  SysUtils, SCMUtility, System.IniFiles, System.IOUtils;

constructor TSimpleConnect.Create(AOwner: TComponent);
begin
  inherited;
  // default
  fDBName := 'SwimClubMeet';
  fAppShortName := TPath.GetFileNameWithoutExtension(Application.ExeName);
end;

constructor TSimpleConnect.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  Create(AOwner);
  fDBConnection := AConnection;
end;

procedure TSimpleConnect.SimpleMakeTemporyConnection(Server, User,
  Password: string; OsAuthent: boolean);
var
  AValue, ASection, AName: string;
begin

  if not Assigned(fDBConnection) then
    exit;

  if (fDBConnection.Connected) then
  begin
    fDBConnection.Close();
  end;

  // Required for multi connection attempts to work
  fDBConnection.Params.Clear;

  fDBConnection.Params.Add('Server=' + Server);
  fDBConnection.Params.Add('DriverID=MSSQL');
  fDBConnection.Params.Add('Database=' + fDBName);
  fDBConnection.Params.Add('User_name=' + User);
  fDBConnection.Params.Add('Password=' + Password);
  if (OsAuthent) then
    AValue := 'Yes'
  else
    AValue := 'No';
  fDBConnection.Params.Add('OSAuthent=' + AValue);
  fDBConnection.Params.Add('Mars=yes');
  fDBConnection.Params.Add('MetaDefSchema=dbo');
  fDBConnection.Params.Add('ExtendedMetadata=False');
  fDBConnection.Params.Add('ApplicationName=' + fAppShortName);
  try
    fDBConnection.Open;
  except
    // Display the server error?
  end;

    // ON SUCCESS - Save connection details.
  if (fDBConnection.Connected) then
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
