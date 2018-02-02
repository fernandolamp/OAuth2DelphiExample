unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IPPeerClient, REST.Client, Vcl.StdCtrls,
  Vcl.ExtCtrls, Data.Bind.Components, Data.Bind.ObjectScope,Rest.json,
  REST.Authenticator.OAuth, REST.Response.Adapter,rest.utils,system.StrUtils,rest.types,
  Vcl.OleCtrls, SHDocVw;

type
  TForm1 = class(TForm)
    OAuth2_GoogleTasks: TOAuth2Authenticator;
    edt_GoogleTasks_BaseURL: TLabeledEdit;
    edt_GoogleTasks_ResourceURI: TLabeledEdit;
    edt_GoogleTasks_AccessToken: TLabeledEdit;
    edt_GoogleTasks_ClientID: TLabeledEdit;
    edt_GoogleTasks_AuthCode: TLabeledEdit;
    btn_GoogleTasks_FetchAuthToken: TButton;
    btn_GoogleTasks_FetchLists: TButton;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    RESTClient: TRESTClient;
    RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter;
    edt_GoogleTasks_RefreshToken: TLabeledEdit;
    edt_GoogleTasks_ClientSecret: TLabeledEdit;
    edt_scope: TLabeledEdit;
    Memo1: TMemo;
    lbl_status: TLabel;
    nmEmail: TLabeledEdit;
    Button1: TButton;
    procedure btn_GoogleTasks_FetchAuthTokenClick(Sender: TObject);
    procedure RESTRequestAfterExecute(Sender: TCustomRESTRequest);
    procedure Button1Click(Sender: TObject);
  private
    procedure ResetRESTComponentsToDefaults;
    procedure OAuth2_GoogleTasks_BrowserTitleChanged(const ATitle: string; var DoCloseWebView: boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  REST.Authenticator.OAuth.WebForm.Win;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
//  WebBrowser1.Navigate2('www.gmail.com');
end;

procedure TForm1.OAuth2_GoogleTasks_BrowserTitleChanged(const ATitle: string;
  var DoCloseWebView: boolean);
begin
  if (StartsText('Success code', ATitle)) then
  begin
    edt_GoogleTasks_AuthCode.Text := Copy(ATitle, 14, Length(ATitle));

    if (edt_GoogleTasks_AuthCode.Text <> '') then
      DoCloseWebView := TRUE;
  end;
end;

procedure TForm1.ResetRESTComponentsToDefaults;
begin
  /// reset all of the rest-components for a complete
  /// new request
  ///
  /// --> we do not clear the private data from the
  /// individual authenticators.
  ///
  RESTRequest.ResetToDefaults;
  RESTClient.ResetToDefaults;
  RESTResponse.ResetToDefaults;
  RESTResponseDataSetAdapter.ResetToDefaults;
end;

procedure TForm1.RESTRequestAfterExecute(Sender: TCustomRESTRequest);
begin
  memo1.Clear;
  lbl_status.Caption := 'URI: ' + Sender.GetFullRequestURL + ' Execution time: ' +
    IntToStr(Sender.ExecutionPerformance.TotalExecutionTime) + 'ms';
  if assigned(RESTResponse.JSONValue) then
  begin
    memo1.Lines.Text := TJson.Format(RESTResponse.JSONValue)
  end
  else
  begin
    memo1.Lines.Add(RESTResponse.Content);
  end;
end;

procedure TForm1.btn_GoogleTasks_FetchAuthTokenClick(Sender: TObject);
var
  LURL: string;
  wv: Tfrm_OAuthWebForm;
  LToken: string;
begin
  edt_GoogleTasks_AuthCode.Text := '';
  edt_GoogleTasks_AccessToken.Text := '';
  edt_GoogleTasks_RefreshToken.Text := '';

  /// step #1: get the auth-code
  LURL := 'https://accounts.google.com/o/oauth2/auth';
  LURL := LURL + '?response_type=' + URIEncode('code');
  LURL := LURL + '&client_id=' + URIEncode(edt_GoogleTasks_ClientID.Text);
  LURL := LURL + '&redirect_uri=' + URIEncode('urn:ietf:wg:oauth:2.0:oob');
  LURL := LURL + '&scope=' + URIEncode(edt_scope.Text);
  // optional
  LURL := LURL + '&login_hint=' + URIEncode(nmemail.Text);

  wv := Tfrm_OAuthWebForm.Create(self);
  try
    //wv.ShowWithURL('https://mail.google.com/mail/u/0/?logout&hl=en');
    wv.OnTitleChanged := self.OAuth2_GoogleTasks_BrowserTitleChanged;
//    wv.Browser.Silent := false;

    wv.ShowWithURL(LURL);
  finally
    wv.Release;
  end;

  /// step #2: get the access-token

  ResetRESTComponentsToDefaults;

  RESTClient.BaseURL := 'https://accounts.google.com/';

  RESTRequest.Method := TRESTRequestMethod.rmPOST;
  RESTRequest.Resource := 'o/oauth2/token';
  RESTRequest.Params.AddItem('code', edt_GoogleTasks_AuthCode.Text, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest.Params.AddItem('client_id', edt_GoogleTasks_ClientID.Text, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest.Params.AddItem('client_secret', edt_GoogleTasks_ClientSecret.Text, TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest.Params.AddItem('redirect_uri', 'urn:ietf:wg:oauth:2.0:oob', TRESTRequestParameterKind.pkGETorPOST);
  RESTRequest.Params.AddItem('grant_type', 'authorization_code', TRESTRequestParameterKind.pkGETorPOST);

  RESTRequest.Execute;

  if RESTRequest.Response.GetSimpleValue('access_token', LToken) then
  begin
     edt_GoogleTasks_AccessToken.Text := LToken;
    OAuth2_GoogleTasks.AccessToken := LToken;
  end;
  if RESTRequest.Response.GetSimpleValue('refresh_token', LToken) then
  begin
    edt_GoogleTasks_RefreshToken.Text := LToken;
    OAuth2_GoogleTasks.RefreshToken := LToken;
  end;
end;



end.
