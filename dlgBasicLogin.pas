unit dlgBasicLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, dmSCM;

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
  public
    { Public declarations }
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

  sc := TSimpleConnect.CreateWithConnection(Self, SCM.scmConnection);
  sc.SimpleMakeTemporyConnection(edtServer.Text, edtUser.Text, edtPassword.Text,
    chkOsAuthent.Checked);
  lblMsg.Visible := false;
  if (SCM.scmConnection.Connected) then
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

procedure TBasicLogin.FormCreate(Sender: TObject);
var
  AValue, ASection, AName: string;

begin
  lblLoginErrMsg.Visible := false;
  lblMsg.Visible := false;

  if Assigned(SCM) then
  begin
      // Read last successful connection params and load into controls
      ASection := 'MSSQL_SwimClubMeet';
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
  end
  else
  begin
    // unexpected error
    ModalResult := mrAbort;
  end;

end;

procedure TBasicLogin.FormShow(Sender: TObject);
begin
  btnConnect.SetFocus;
end;

end.
