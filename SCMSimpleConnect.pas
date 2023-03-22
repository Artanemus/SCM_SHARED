unit SCMSimpleConnect;

interface

uses
  Classes, FireDAC.Stan.Def, FireDAC.Comp.Client;

type
  TSimpleConnect = class(TComponent)
  private
    { private declarations }
    FscmConnection: TFDConnection;
  protected
    { protected declarations }
  public
    { public declarations }
    procedure SimpleMakeTemporyConnection(Server, User, Password: string;
      OsAuthent: boolean);
    constructor Create(AOwner: TComponent); override;
    constructor CreateWithConnection(AOwner: TComponent; AConnection: TFDConnection);

  published
    { published declarations }
    property scmConnection: TFDConnection read FscmConnection
      write FscmConnection;
  end;

  { TSimpleConnect }
implementation

uses
  SysUtils, SCMUtility, System.IniFiles;

constructor TSimpleConnect.Create(AOwner: TComponent);
begin
  inherited;
end;

constructor TSimpleConnect.CreateWithConnection(AOwner: TComponent;
  AConnection: TFDConnection);
begin
  Create(AOwner);
  FscmConnection := AConnection;
end;

procedure TSimpleConnect.SimpleMakeTemporyConnection(Server, User,
  Password: string; OsAuthent: boolean);
var
  AValue, ASection, AName: string;
begin
  if (FscmConnection.Connected) then
  begin
    FscmConnection.Close();
  end;

  FscmConnection.Params.Add('Server=' + Server);
  FscmConnection.Params.Add('DriverID=MSSQL');
  FscmConnection.Params.Add('Database=SwimClubMeet');
  FscmConnection.Params.Add('User_name=' + User);
  FscmConnection.Params.Add('Password=' + Password);
  if (OsAuthent) then
    AValue := 'Yes'
  else
    AValue := 'No';
  FscmConnection.Params.Add('OSAuthent=' + AValue);
  FscmConnection.Params.Add('Mars=yes');
  FscmConnection.Params.Add('MetaDefSchema=dbo');
  FscmConnection.Params.Add('ExtendedMetadata=False');
  FscmConnection.Params.Add('ApplicationName=scmTimeKeeper');
  FscmConnection.Connected := True;

  // ON SUCCESS - Save connection details.
  if (FscmConnection.Connected) then
  begin
    ASection := 'MSSQL_SwimClubMeet';
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
