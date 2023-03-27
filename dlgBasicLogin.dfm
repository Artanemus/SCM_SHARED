object BasicLogin: TBasicLogin
  Left = 0
  Top = 0
  Caption = 'Login to the SwimClubMeet Database Server ...'
  ClientHeight = 283
  ClientWidth = 519
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    519
    283)
  TextHeight = 19
  object Label1: TLabel
    Left = 48
    Top = 19
    Width = 45
    Height = 19
    Alignment = taRightJustify
    Caption = 'Server'
  end
  object Label2: TLabel
    Left = 15
    Top = 59
    Width = 78
    Height = 19
    Alignment = taRightJustify
    Caption = 'User Name'
  end
  object Label3: TLabel
    Left = 26
    Top = 99
    Width = 67
    Height = 19
    Alignment = taRightJustify
    Caption = 'Password'
  end
  object lblLoginErrMsg: TLabel
    Left = 23
    Top = 184
    Width = 453
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Caption = 'The login failed - retry or abort.'
    Visible = False
  end
  object chkOsAuthent: TCheckBox
    Left = 99
    Top = 136
    Width = 206
    Height = 24
    Caption = 'Use OS Authentication'
    TabOrder = 0
  end
  object edtPassword: TEdit
    Left = 99
    Top = 96
    Width = 263
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'edtPassword'
    ExplicitWidth = 259
  end
  object edtServer: TEdit
    Left = 99
    Top = 16
    Width = 387
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
    Text = 'edtServer'
    ExplicitWidth = 383
  end
  object edtUser: TEdit
    Left = 99
    Top = 56
    Width = 335
    Height = 27
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
    Text = 'edtUser'
    ExplicitWidth = 331
  end
  object Panel1: TPanel
    Left = 0
    Top = 213
    Width = 519
    Height = 70
    Align = alBottom
    BevelEdges = [beTop]
    BevelKind = bkFlat
    BevelOuter = bvNone
    TabOrder = 4
    ExplicitTop = 212
    ExplicitWidth = 515
    DesignSize = (
      519
      68)
    object lblMsg: TLabel
      Left = 23
      Top = 21
      Width = 306
      Height = 27
      AutoSize = False
      Caption = 'Attempting to connect ... please wait.'
      Visible = False
    end
    object btnAbort: TButton
      Left = 319
      Top = 19
      Width = 81
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'Abort'
      ModalResult = 3
      TabOrder = 1
      OnClick = btnAbortClick
      ExplicitLeft = 315
    end
    object btnConnect: TButton
      Left = 406
      Top = 19
      Width = 81
      Height = 32
      Anchors = [akTop, akRight]
      Caption = 'Login'
      Default = True
      TabOrder = 0
      OnClick = btnConnectClick
      ExplicitLeft = 402
    end
  end
end
