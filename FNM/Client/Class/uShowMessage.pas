unit uShowMessage;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT
       ��Ԫ���� uShowMessage.pas
       �������� 2004-7-30 9:36:55
       ������Ա wuwj
       �޸���Ա lvzd
       �޸����� 2004-09-09
       �޸�ԭ�� ԭ�಻�߱�ͨ����,���Ӧ�ó�����������������.
       ��������
         1.TStatusBarMessage:���������״̬������ʾ�Զ�����Ϣ,
         2.MessageDlg����չ����MessageDlgEx
         3.Input dialogEx����ʽ����¶Ի���
******************************************************************************}

interface

uses Controls, Forms, ComCtrls, Windows, Dialogs, StdCtrls, Classes, SysUtils, Consts,
     Graphics, Math, ExtCtrls, ShellApi, Mapi, Jpeg, StrUtils, UOutLookMail, uLogin, Mask, StdActns;

resourcestring
  SMsgDlgWarning = '����';
  SMsgDlgError= '����';
  SMsgDlgInformation= '��ʾ';
  SMsgDlgConfirm = 'ȷ��';
  SMsgDlgYes = '��';
  SMsgDlgNo = '��';
  SMsgDlgOK = 'ȷ��';
  SMsgDlgCancel = 'ȡ��';
  SMsgDlgAbort = '��ֹ';
  SMsgDlgRetry = '����';
  SMsgDlgIgnore = '����';
  SMsgDlgAll = 'ȫ��';
  SMsgDlgNoToAll = 'ȫ����';
  SMsgDlgYesToAll = 'ȫ����';
  SMsgDlgHelp = '����';
  SMsgSendMail = '����Mail';
  SMsgIncludeScreenMap = 'Mail�к���ĻͼƬ';

type
  TStatusBarMessage = class
  {* ��Ӧ�ó���������״̬����ʾ��ʾ��}
    class procedure ShowMessageOnMainStatsusBar(AMessage: string; ACursor: TCursor = crDefault);
    {* �ú�����Ϊ�˼��ݾ͵ĺ������ڵ�,��ʹ���º���:SetMianFormStatusMessage �� ReSetMianFormStatusMessage}
  end;

{ TMessageFormEx }
  TMsgDlgExBtn = (mebYes, mebNo, mebOK, mebCancel, mebAbort, mebRetry, mebIgnore,
    mebAll, mebNoToAll, mebYesToAll, mebHelp, mebSendMail, mecIncScreenMap);
  TMsgDlgExButtons = set of TMsgDlgExBtn;

const
  mebYesNoCancel = [mebYes, mebNo, mebCancel];
  mebYesAllNoAllCancel = [mebYes, mebYesToAll, mebNo, mebNoToAll, mebCancel];
  mebOKCancel = [mebOK, mebCancel];
  mebAbortRetryIgnore = [mebAbort, mebRetry, mebIgnore];
  mebAbortIgnore = [mebAbort, mebIgnore];

{ TMsgDialog }
type
  TMsgDialog = class
    class function ShowMsgDialog(msg: string; msgType: TMsgDlgType): Integer; overload;
    {* ��ʾָ���ķ���MessageDialog}
    class function ShowMsgDialog(Msg: string; msgType: TMsgDlgType; Buttons:
        TMsgDlgExButtons; DefaultButton: TMsgDlgExBtn = mebOK): Integer; overload;
    {* ��ʾָ���ķ���,ָ����ť��Ĭ�ϰ�ť��MessageDialog}
    class function ShowMsgDialog(Msg: string; AVisibleTime:Integer): Integer; overload;
    {* �ɽӿڲ�Ҫʹ��}
  end;

{ ShowStatusMessage }
procedure ShowStatusMessage(AMessage: string; ACursor: TCursor);

implementation

{ TMessageFormEx }
const
  WarningWaitSecond = 20;
  InformationWaitSecond= 1;

type
  TMessageFormEx=class(TForm)
  {* ��չ��MessageDlg��}
  private
    TimerControler: TTimer;
    MessageText: TLabel;
    TheCheckBox: TCheckBox;
    CountDownText: TLabel;
    procedure HelpButtonClick(Sender: TObject);
    procedure SendMailButtonClick(Sender: TObject);
    procedure TimerControlerOnTimer(Sender: TObject);
  protected
    procedure CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure WriteToClipBoard(Text: String);
    function GetFormText: String;
  public
    constructor CreateNew(AOwner: TComponent); reintroduce;
  end;

function GetScreenBitmap: TBitMap;
var
  ScreenBmp: TBitMap;
begin
//ȡ��Ļͼ��,���������߸����ͷ�BitMap
  try
    ScreenBmp:=TBitMap.Create;
    ScreenBmp.Width:=Screen.Width;
    ScreenBmp.Height:=Screen.Height;
    BitBlt(ScreenBmp.Canvas.Handle, 0, 0, Screen.Width, Screen.Height, GetDc(0), 0, 0, SRCCOPY);
    result:=ScreenBmp;
  except
    result:=nil;
    FreeAndNil(ScreenBmp);
  end;
end;

constructor TMessageFormEx.CreateNew(AOwner: TComponent);
var
  NonClientMetrics: TNonClientMetrics;
begin
  inherited CreateNew(AOwner);
  NonClientMetrics.cbSize := sizeof(NonClientMetrics);
  if SystemParametersInfo(SPI_GETNONCLIENTMETRICS, 0, @NonClientMetrics, 0) then
    Font.Handle := CreateFontIndirect(NonClientMetrics.lfMessageFont);
end;

procedure TMessageFormEx.HelpButtonClick(Sender: TObject);
begin
  Application.HelpContext(HelpContext);
end;

procedure TMessageFormEx.SendMailButtonClick(Sender: TObject);
var
  ScreenBmp: TBitMap;
  BmpSavePath: String;
  JpgImage: TJpegImage;
  MailDetail: TMailRecord;
begin
  //ȡ��Ļͼ�񲢱��浽��ʱĿ¼,�ļ���ʽ����,��Ҫת��ΪJPG��ʽ
  if (TheCheckBox <> nil) and TheCheckBox.Checked then
  begin
    try
      ScreenBmp:=nil;
      Self.Visible:=false;
      Application.ProcessMessages;
      BmpSavePath:='';
      ScreenBmp:=GetScreenBitmap;
      if ScreenBmp <> nil then
      begin
        JpgImage:=TJpegImage.Create;
        BmpSavePath:=GetEnvironmentVariable('TEMP')+'\Screen.Jpg';
        JpgImage.Assign(ScreenBmp);
        JpgImage.SaveToFile(BmpSavePath);
      end;
    finally
      Self.Visible:=true;
      FreeAndNil(ScreenBmp);
      FreeAndNil(JpgImage);
    end;
  end;

  MailDetail.FileToAttach:=BmpSavePath;
  MailDetail.MailTo:=Login.MailBox;
  MailDetail.CC:='';
  MailDetail.Subject:=Application.title +'--���������';
  MailDetail.Body:='#######�ر�ע��#########'#13#10 +
                   '����ǰ����д���������:'#13#10 +
                   '�����Ƿ��������:               (ż����/���ʱȽϴ�/100%��������)'#13#10 +
                   '��ǰ�Ƿ��з���:                 (Y/N)'#13#10 +
                   '���ִ���Ĳ�������:             (����д��������ľ���������������˵��)'#13#10 +
                   'ע:'#13#10 +
                   '  �����������û����д���ǽ��ͺ�����߲��������ظ���'#13#10 +
                   '----------------------------------------------' + #13#10 +
                   '����ϵͳ:'   + Login.OS            + #13#10 +
                   '��������:'   + Login.WorkStation   + #13#10 +
                   '�û�����:'   + Login.LoginName     + #13#10 +
                   'Ӧ�÷�����:' + Login.ComPlusServer + #13#10 +
                   GetFormText;
  OutLookMailProc(MailDetail);
end;

procedure TMessageFormEx.TimerControlerOnTimer(Sender: TObject);
begin
  TimerControler.Tag:=TimerControler.Tag - 1;
  CountDownText.Caption:=IntToStr(TimerControler.Tag)+'s';
  if TimerControler.Tag <= 0 then
    Close;
end;

procedure TMessageFormEx.CustomKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Key = Word('C')) then
  begin
    Beep;
    WriteToClipBoard(GetFormText);
  end;
end;

procedure TMessageFormEx.WriteToClipBoard(Text: String);
var
  Data: THandle;
  DataPtr: Pointer;
begin
  if OpenClipBoard(0) then
  begin
    try
      Data := GlobalAlloc(GMEM_MOVEABLE+GMEM_DDESHARE, Length(Text) + 1);
      try
        DataPtr := GlobalLock(Data);
        try
          Move(PChar(Text)^, DataPtr^, Length(Text) + 1);
          EmptyClipBoard;
          SetClipboardData(CF_TEXT, Data);
        finally
          GlobalUnlock(Data);
        end;
      except
        GlobalFree(Data);
        raise;
      end;
    finally
      CloseClipBoard;
    end;
  end
  else
    raise Exception.CreateRes(@SCannotOpenClipboard);
end;

function TMessageFormEx.GetFormText: String;
var
  DividerLine, ButtonCaptions: string;
  I: integer;
begin
  DividerLine := '----------------------------------------------' + sLineBreak;
  for I := 0 to ComponentCount - 1 do
    if Components[I] is TButton then
      ButtonCaptions := ButtonCaptions + TButton(Components[I]).Caption +
        StringOfChar(' ', 3);
  ButtonCaptions := StringReplace(ButtonCaptions,'&','', [rfReplaceAll]);
  Result := Format('%s%s%s%s%s%s%s%s%s%s', [DividerLine, Caption, sLineBreak,
    DividerLine, MessageText.Caption, sLineBreak, DividerLine, ButtonCaptions,
    sLineBreak, DividerLine]);
end;

function GetAveCharSize(Canvas: TCanvas): TPoint;
var
  I: Integer;
  Buffer: array[0..51] of Char;
begin
  for I := 0 to 25 do Buffer[I] := Chr(I + Ord('A'));
  for I := 0 to 25 do Buffer[I + 26] := Chr(I + Ord('a'));
  GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
  Result.X := Result.X div 52;
end;

var
  ButtonWidths : array[TMsgDlgExBtn] of integer;  // initialized to zero
  ButtonCaptions: array[TMsgDlgExBtn] of Pointer = (
    @SMsgDlgYes, @SMsgDlgNo, @SMsgDlgOK, @SMsgDlgCancel, @SMsgDlgAbort,
    @SMsgDlgRetry, @SMsgDlgIgnore, @SMsgDlgAll, @SMsgDlgNoToAll, @SMsgDlgYesToAll,
    @SMsgDlgHelp, @SMsgSendMail, @SMsgIncludeScreenMap);
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND,
    IDI_ASTERISK, IDI_QUESTION, nil);
  Captions: array[TMsgDlgType] of Pointer = (@SMsgDlgWarning, @SMsgDlgError,
    @SMsgDlgInformation, @SMsgDlgConfirm, nil);
  ButtonNames: array[TMsgDlgExBtn] of string = (
    'Yes', 'No', 'OK', 'Cancel', 'Abort', 'Retry', 'Ignore', 'All', 'NoToAll',
    'YesToAll', 'Help', 'SendMail', 'IncludeScreenMap');
  ModalResults: array[TMsgDlgExBtn] of Integer = (
    mrYes, mrNo, mrOk, mrCancel, mrAbort, mrRetry, mrIgnore, mrAll, mrNoToAll,
    mrYesToAll, 0, 0, 0);

function CreateMessageDialog(const Msg: string; DlgType: TMsgDlgType; Buttons:
  TMsgDlgExButtons; TheDefaultButton: TMsgDlgExBtn): TForm;
const
  mcHorzMargin = 8;
  mcVertMargin = 8;
  mcHorzSpacing = 10;
  mcVertSpacing = 10;
  mcButtonWidth = 50;
  mcButtonHeight = 14;
  mcButtonSpacing = 4;
var
  IconID: PChar;
  TextRect: TRect;
  AButton: TButton;
  DialogUnits: TPoint;
  B, DefaultButton, CancelButton: TMsgDlgExBtn;
  HorzMargin, VertMargin, HorzSpacing, VertSpacing, ButtonWidth,
  ButtonHeight, ButtonSpacing, ButtonCount, ButtonGroupWidth,
  IconTextWidth, IconTextHeight, X, ALeft: Integer;
begin
  Result := TMessageFormEx.CreateNew(Application);
  with Result do
  begin
    BiDiMode := Application.BiDiMode;
    BorderStyle := bsDialog;
    Canvas.Font := Font;
    KeyPreview := True;
    OnKeyDown := TMessageFormEx(Result).CustomKeyDown;
    DialogUnits := GetAveCharSize(Canvas);
    HorzMargin := MulDiv(mcHorzMargin, DialogUnits.X, 4);
    VertMargin := MulDiv(mcVertMargin, DialogUnits.Y, 8);
    HorzSpacing := MulDiv(mcHorzSpacing, DialogUnits.X, 4);
    VertSpacing := MulDiv(mcVertSpacing, DialogUnits.Y, 8);
    ButtonWidth := MulDiv(mcButtonWidth, DialogUnits.X, 4);

    for B := Low(TMsgDlgExBtn) to High(TMsgDlgExBtn) do
    begin
      if B in Buttons then
      begin
        if ButtonWidths[B] = 0 then
        begin
          TextRect := Rect(0,0,0,0);
          Windows.DrawText(canvas.handle, PChar(LoadResString(ButtonCaptions[B])), -1,
            TextRect, DT_CALCRECT or DT_LEFT or DT_SINGLELINE or DrawTextBiDiModeFlagsReadingOnly);
          with TextRect do ButtonWidths[B] := Right - Left + 8;
        end;
        if ButtonWidths[B] > ButtonWidth then
          ButtonWidth := ButtonWidths[B];
      end;
    end;
    ButtonHeight := MulDiv(mcButtonHeight, DialogUnits.Y, 8);
    ButtonSpacing := MulDiv(mcButtonSpacing, DialogUnits.X, 4);
    SetRect(TextRect, 0, 0, Screen.Width div 2, 0);
    DrawText(Canvas.Handle, PChar(Msg), Length(Msg)+1, TextRect,
      DT_EXPANDTABS or DT_CALCRECT or DT_WORDBREAK or DrawTextBiDiModeFlagsReadingOnly);
    //����ͼ��
    IconID := IconIDs[DlgType];
    IconTextWidth := TextRect.Right;
    IconTextHeight := TextRect.Bottom;
    if IconID <> nil then
    begin
      Inc(IconTextWidth, 32 + HorzSpacing);
      if IconTextHeight < 32 then IconTextHeight := 32;
    end;
    ButtonCount := 0;
    for B := Low(TMsgDlgExBtn) to High(TMsgDlgExBtn) do
      if B in Buttons then Inc(ButtonCount);
    ButtonGroupWidth := 0;
    if ButtonCount <> 0 then
      ButtonGroupWidth := ButtonWidth * ButtonCount +
        ButtonSpacing * (ButtonCount - 1);
    ClientWidth := Max(IconTextWidth, ButtonGroupWidth) + HorzMargin * 2;
    ClientHeight := IconTextHeight + ButtonHeight + VertSpacing +
      VertMargin * 2;
    Left := (Screen.Width div 2) - (Width div 2);
    Top := (Screen.Height div 2) - (Height div 2);
    if DlgType <> mtCustom then
      Caption := LoadResString(Captions[DlgType])
    else
      Caption := Application.Title;
    if IconID <> nil then
      with TImage.Create(Result) do
      begin
        Name := 'Image';
        Parent := Result;
        Picture.Icon.Handle := LoadIcon(0, IconID);
        SetBounds(HorzMargin, VertMargin, 32, 32);
      end;

    //�������ʾMessageText
    TMessageFormEx(Result).MessageText := TLabel.Create(Result);
    with TMessageFormEx(Result).MessageText do
    begin
      Name := 'Message';
      Parent := Result;
      WordWrap := True;
      Caption := Msg;
      BoundsRect := TextRect;
      BiDiMode := Result.BiDiMode;
      ALeft := IconTextWidth - TextRect.Right + HorzMargin;
      if UseRightToLeftAlignment then
        ALeft := Result.ClientWidth - ALeft - Width;
      SetBounds(ALeft, VertMargin, TextRect.Right, TextRect.Bottom);
    end;

    //����Dlg��Ĭ��ȷ�ϰ�ť
    if not(TheDefaultButton in Buttons) then
    begin
      if mebOk in Buttons then
        DefaultButton := mebOk
      else if mebYes in Buttons then
        DefaultButton := mebYes
      else
        DefaultButton := mebRetry;
    end;

    //����Dlg��Ĭ��ȡ����ť
    if mebCancel in Buttons then
      CancelButton := mebCancel
    else if mebNo in Buttons then
      CancelButton := mebNo
    else
      CancelButton := mebOk;

    //������ť
    X := (ClientWidth - ButtonGroupWidth) div 2;
    for B := Low(TMsgDlgExBtn) to High(TMsgDlgExBtn) do
    begin
      if not(B in Buttons) then
        Continue;
      if TheDefaultButton = B then
        DefaultButton:= B;

      if B = mecIncScreenMap then
      begin
        //��ʾ�Ƿ������ĻͼƬ��ѡ��
        TMessageFormEx(Result).TheCheckBox:=TCheckBox.Create(Result);
        with TMessageFormEx(Result).TheCheckBox do
        begin
          Parent := Result;
          Name := ButtonNames[B];
          Checked:=true;
          Caption := LoadResString(ButtonCaptions[B]);
          SetBounds(X, IconTextHeight + VertMargin + VertSpacing, 126{CheckBoxWith}, ButtonHeight);
        end;
        Inc(X, 126{CheckBoxWith} + ButtonSpacing);
      end
      else
      begin
        //Create Buttons
        AButton:=TButton.Create(Result);
        with AButton do
        begin
          Parent := Result;
          Name := ButtonNames[B];
          ModalResult := ModalResults[B];
          Caption := LoadResString(ButtonCaptions[B]);
          SetBounds(X, IconTextHeight + VertMargin + VertSpacing, ButtonWidth, ButtonHeight);
          Inc(X, ButtonWidth + ButtonSpacing);

          if B = DefaultButton then
          begin
            Default := True;
            TMessageFormEx(Result).ActiveControl:=AButton;
          end;
          if B = CancelButton  then Cancel := True;
          if B = mebHelp       then OnClick := TMessageFormEx(Result).HelpButtonClick;
          if B = mebSendMail   then OnClick := TMessageFormEx(Result).SendMailButtonClick;
        end
      end;
    end;

    //�����������ʱ��
    if (DlgType = mtInformation) or (DlgType = mtWarning) then
    begin
      TMessageFormEx(Result).TimerControler:=TTimer.Create(Result);
      with TMessageFormEx(Result).TimerControler do
      begin
        //����ʱ��
        Interval:= 1000;
        //��������
        if DlgType <> mtInformation then
          Tag:=WarningWaitSecond
        else
          Tag:=InformationWaitSecond;

        OnTimer:=TMessageFormEx(Result).TimerControlerOnTimer;
        TMessageFormEx(Result).CountDownText:=TLabel.Create(Result);
        with TMessageFormEx(Result).CountDownText do
        begin
          Parent:=Result;
          SetBounds(HorzMargin + 10, VertMargin + 36, 32, 17);
          Caption:=IntToStr(TMessageFormEx(Result).TimerControler.Tag) + 's';
        end;
      end;
    end;
  end;
end;

function MessageDlgPosHelp(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgExButtons; DefaultButton: TMsgDlgExBtn; X, Y: Integer;
  const HelpFileName: string): Integer;
begin
  with CreateMessageDialog(Msg, DlgType, Buttons, DefaultButton) do
    try
      HelpFile := HelpFileName;
      if X >= 0 then Left := X;
      if Y >= 0 then Top := Y;
      if (Y < 0) and (X < 0) then Position := poScreenCenter;
      Result := ShowModal;
    finally
      Free;
    end;
end;

function MessageDlgEx(const Msg: string; DlgType: TMsgDlgType;
  Buttons: TMsgDlgExButtons; DefaultButton: TMsgDlgExBtn): Integer;
begin
  if DlgType = mtError then Buttons:= Buttons + [mebSendMail];
  if mebSendMail in Buttons then Buttons:= Buttons + [mecIncScreenMap];

  Result := MessageDlgPosHelp(Msg, DlgType, Buttons, DefaultButton, -1, -1, '');
end;

{ TStatusBarMessage }

var
  lHintAction: THintAction;
  lMainFormStatusBar:TStatusBar;

function HintAction: THintAction;
begin
  if lHintAction = nil then
    lHintAction:=THintAction.Create(nil);
  result:=lHintAction;
end;

function GetMainFormStatusBar: TStatusBar;
var
  i: Integer;
begin
//ȡ�������״̬��
  if (lMainFormStatusBar = nil) and (Application.MainForm <> nil)then
  for i := 0 to Application.MainForm.ControlCount - 1 do
  begin
    if Application.MainForm.Controls[i].ClassNameIs('TStatusBar') then
    begin
      lMainFormStatusBar:=Application.MainForm.Controls[i] as TStatusBar;
      Break;
    end
  end;

  result:=lMainFormStatusBar;
end;

procedure ShowStatusMessage(AMessage: string; ACursor: TCursor);
begin
  Screen.Cursor:=ACursor;
  with HintAction do
  begin
    HintAction.Hint := AMessage;
    Execute;
    if GetMainFormStatusBar <> nil then
      GetMainFormStatusBar.Refresh;
  end;
end;

class procedure TStatusBarMessage.ShowMessageOnMainStatsusBar(AMessage: string;
  ACursor: TCursor = crDefault);
begin
  ShowStatusMessage(AMessage, ACursor)
end;

{ TMsgDialog }

class function TMsgDialog.ShowMsgDialog(msg: string; msgType: TMsgDlgType): Integer;
var
  Buttons: TMsgDlgExButtons;
begin
  Buttons:= [mebOK];

  if LeftStr(msg,3) = 'WAR' then
    msgType := mtWarning
  else if LeftStr(msg,3) = 'INF' then
    msgType := mtInformation
  else if LeftStr(msg,3) = 'ERR' then
    msgType := mtError
  else if LeftStr(msg,3) = 'CON' then
    msgType := mtConfirmation;

  if msgType = mtConfirmation then
    Buttons:= Buttons + [mebCancel];
  if Pos('_',msg) = 4 then
    system.Delete(msg,1,4);
  result:=MessageDlgEx(msg, msgType, Buttons, mebOK);
end;

class function TMsgDialog.ShowMsgDialog(Msg: string; msgType: TMsgDlgType; Buttons:
  TMsgDlgExButtons; DefaultButton: TMsgDlgExBtn = mebOK): Integer;
begin
  result:=MessageDlgEx(msg, msgType, Buttons, DefaultButton);
end;

class function TMsgDialog.ShowMsgDialog(Msg:string; AVisibleTime:Integer): Integer;
begin
  result:=MessageDlgEx(msg, mtWarning, [mebOK], mebOK);
end;

initialization
  lHintAction:=nil;
  lMainFormStatusBar:=nil;

finalization
  if lHintAction <> nil then
    lHintAction.Destroy;

end.
