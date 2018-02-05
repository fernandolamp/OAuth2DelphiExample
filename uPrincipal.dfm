object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 438
  ClientWidth = 725
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    725
    438)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_status: TLabel
    Left = -134
    Top = 2
    Width = 859
    Height = 13
    Anchors = [akLeft, akTop, akRight]
    AutoSize = False
  end
  object edt_GoogleTasks_BaseURL: TLabeledEdit
    Left = 32
    Top = 32
    Width = 273
    Height = 21
    EditLabel.Width = 50
    EditLabel.Height = 13
    EditLabel.Caption = 'Base-URL:'
    TabOrder = 0
    Text = 'https://www.googleapis.com/calendar/v3'
  end
  object edt_GoogleTasks_ResourceURI: TLabeledEdit
    Left = 32
    Top = 80
    Width = 273
    Height = 21
    EditLabel.Width = 71
    EditLabel.Height = 13
    EditLabel.Caption = 'Resource-URI:'
    TabOrder = 1
    Text = '/users/me/calendarList/primary'
  end
  object edt_GoogleTasks_AccessToken: TLabeledEdit
    Left = 320
    Top = 80
    Width = 161
    Height = 21
    EditLabel.Width = 70
    EditLabel.Height = 13
    EditLabel.Caption = 'Access-Token:'
    TabOrder = 2
  end
  object edt_GoogleTasks_ClientID: TLabeledEdit
    Left = 320
    Top = 32
    Width = 161
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Client-ID:'
    TabOrder = 3
  end
  object edt_GoogleTasks_AuthCode: TLabeledEdit
    Left = 320
    Top = 132
    Width = 161
    Height = 21
    EditLabel.Width = 56
    EditLabel.Height = 13
    EditLabel.Caption = 'Auth-Code:'
    TabOrder = 4
  end
  object btn_GoogleTasks_FetchAuthToken: TButton
    Left = 32
    Top = 132
    Width = 273
    Height = 49
    Caption = 'Step #1 fetch auch-code && access-token'
    TabOrder = 5
    OnClick = btn_GoogleTasks_FetchAuthTokenClick
  end
  object btn_GoogleTasks_FetchLists: TButton
    Left = 32
    Top = 195
    Width = 273
    Height = 49
    Caption = 'Step #2 fetch list of tasks'
    TabOrder = 6
  end
  object edt_GoogleTasks_RefreshToken: TLabeledEdit
    Left = 320
    Top = 187
    Width = 161
    Height = 21
    EditLabel.Width = 75
    EditLabel.Height = 13
    EditLabel.Caption = 'Refresh-Token:'
    TabOrder = 7
  end
  object edt_GoogleTasks_ClientSecret: TLabeledEdit
    Left = 487
    Top = 187
    Width = 230
    Height = 21
    EditLabel.Width = 66
    EditLabel.Height = 13
    EditLabel.Caption = 'Client-Secret:'
    TabOrder = 8
  end
  object edt_scope: TLabeledEdit
    Left = 487
    Top = 132
    Width = 230
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'Scope'
    TabOrder = 9
    Text = 'https://www.googleapis.com/auth/calendar'
  end
  object Memo1: TMemo
    Left = 32
    Top = 272
    Width = 685
    Height = 158
    Lines.Strings = (
      '')
    TabOrder = 10
  end
  object nmEmail: TLabeledEdit
    Left = 496
    Top = 32
    Width = 205
    Height = 21
    EditLabel.Width = 24
    EditLabel.Height = 13
    EditLabel.Caption = 'email'
    TabOrder = 11
  end
  object Button1: TButton
    Left = 640
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 12
    OnClick = Button1Click
  end
  object OAuth2_GoogleTasks: TOAuth2Authenticator
    AccessTokenEndpoint = 'https://accounts.google.com/o/oauth2/token'
    AccessTokenExpiry = 41488.448189351900000000
    AuthorizationEndpoint = 'https://accounts.google.com/o/oauth2/auth'
    RedirectionEndpoint = 'urn:ietf:wg:oauth:2.0:oob'
    Scope = 'https://www.googleapis.com/auth/tasks'
    Left = 288
    Top = 275
    AccessTokenExpiryDate = 41488.4481893519d
  end
  object RESTRequest: TRESTRequest
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    OnAfterExecute = RESTRequestAfterExecute
    SynchronizedEvents = False
    Left = 472
    Top = 242
  end
  object RESTResponse: TRESTResponse
    Left = 552
    Top = 242
  end
  object RESTClient: TRESTClient
    Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Params = <>
    HandleRedirects = True
    Left = 400
    Top = 242
  end
  object RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter
    FieldDefs = <>
    Left = 400
    Top = 306
  end
end
