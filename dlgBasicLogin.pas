unit dlgBasicLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, FireDAC.Stan.Def,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB;

type
  TBasicLogin = class(TForm)
    chkOsAuthent: TCheckBox;
    edtPassword: TEdit;
    edtServer: TEdit;
    edtUser: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblLoginErrMsg: TLabel;
    Panel1: TPanel;
    lblMsg: TLabel;
    btnAbort: TButton;
    btnConnect: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnAbortClick(Sender: TObject);
    procedure btnConnectClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fDBName: String;
    fDBConnection: TFDConnection;
  public
    { Public declarations }
  published
    property DBName: string read fDBName write fDBName;
    property DBConnection: TFDConnection read fDBConnection write fDBConnection;
  end;

var
  BasicLogin: TBasicLogin;

implementation

{$R *.dfm}

uses SCMSimpleConnect, SCMUtility;

procedure TBasicLogin.btnAbortClick(Sender: TObject);
begin
  // setting modal result will Close() the form;
  ModalResult := mrAbort;
end;

procedure TBasicLogin.btnConnectClick(Sender: TObject);
var
  sc: TSimpleConnect;
begin
  // Hide the Login and abort buttons while attempting connection
  lblLoginErrMsg.Visible := false;
  btnAbort.Visible := false;
  btnConnect.Visible := false;
  lblMsg.Visible := true;
  lblMsg.Update();
  Application.ProcessMessages();

  if Assigned(fDBConnection) then
  begin
    sc := TSimpleConnect.CreateWithConnection(Self, fDBConnection);
    // DEFAULT : SwimClubMeet
    sc.DBName := fDBName;
    sc.SimpleMakeTemporyConnection(edtServer.Text, edtUser.Text,
      edtPassword.Text, chkOsAuthent.Checked);
    lblMsg.Visible := false;

    if (fDBConnection.Connected) then
    begin
      // setting modal result will Close() the form;
      ModalResult := mrOk;
    end
    else
    begin
      // show error message - let user try again or abort
      lblLoginErrMsg.Visible := true;
      btnAbort.Visible := true;
      btnConnect.Visible := true;
    end;
    sc.Free;
  end;

end;

procedure TBasicLogin.FormCreate(Sender: TObject);
var
  AValue, ASection, AName: string;

begin
  lblLoginErrMsg.Visible := false;
  lblMsg.Visible := false;
  fDBName := 'SwimClubMeet'; // DEFAULT

  // Read last successful connection params and load into controls
  ASection := 'MSSQL_Connection';
  AName := 'Server';
  edtServer.Text := LoadSharedIniFileSetting(ASection, AName);
  AName := 'User';
  edtUser.Text := LoadSharedIniFileSetting(ASection, AName);
  AName := 'Password';
  edtPassword.Text := LoadSharedIniFileSetting(ASection, AName);
  AName := 'OsAuthent';
  AValue := LoadSharedIniFileSetting(ASection, AName);
  if ((UpperCase(AValue) = 'YES') or (UpperCase(AValue) = 'TRUE')) then
    chkOsAuthent.Checked := true
  else
    chkOsAuthent.Checked := false;

end;

procedure TBasicLogin.FormShow(Sender: TObject);
begin
  Caption := 'Login to the ' + fDBName + ' Database Server ...';

  if not Assigned(fDBConnection) then
  begin
    lblLoginErrMsg.Visible := false;
    lblLoginErrMsg.Caption := 'SCM SYSTEM ERROR : Connection not assigned!';
    btnAbort.Visible := true;
    btnConnect.Visible := false;
  end;

  btnConnect.SetFocus;
end;

end.
