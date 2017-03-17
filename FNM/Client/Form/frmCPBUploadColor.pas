unit frmCPBUploadColor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, DB, DBClient, MakeSQL,iniFiles,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid,
  cxSplitter, frmBase;

type
  TCPBUploadColorForm = class(TBaseForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    cbbxRiteList: TComboBox;
    GroupBox5: TGroupBox;
    cbbDataColorList: TComboBox;
    cdsPub: TClientDataSet;
    msDataColor: TMakeSQL;
    TimerUpload: TTimer;
    cdsStock: TClientDataSet;
    cdsRecipe: TClientDataSet;
    cdsColor: TClientDataSet;
    cdsLab: TClientDataSet;
    dsRecipe: TDataSource;
    dsColor: TDataSource;
    dsLab: TDataSource;
    dsStock: TDataSource;
    Panel6: TPanel;
    btnRefreshxRite: TBitBtn;
    Panel7: TPanel;
    btnRefreshDataColor: TBitBtn;
    btnUploadxRite: TBitBtn;
    btnUploadDataColor: TBitBtn;
    Panel5: TPanel;
    Panel2: TPanel;
    Label2: TLabel;
    edtItemNO: TEdit;
    btnQuery: TBitBtn;
    cxSplitter2: TcxSplitter;
    Panel1: TPanel;
    pnRight: TPanel;
    pnlxRite: TPanel;
    gbColor: TGroupBox;
    cxGrid2: TcxGrid;
    cxGridtvColor: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxSpxRite: TcxSplitter;
    Panel3: TPanel;
    gbLab: TGroupBox;
    cxGrid3: TcxGrid;
    cxGridtvLab: TcxGridDBTableView;
    cxGridLevel2: TcxGridLevel;
    gbStock: TGroupBox;
    cxGrid4: TcxGrid;
    cxGridtvStock: TcxGridDBTableView;
    cxGridLevel3: TcxGridLevel;
    Panel8: TPanel;
    Label1: TLabel;
    edtColorCode1: TEdit;
    btnDiff: TBitBtn;
    Label3: TLabel;
    edtColorCode2: TEdit;
    GroupBox7: TGroupBox;
    cxGrid5: TcxGrid;
    cxGridtvDiff: TcxGridDBTableView;
    cxGridLevel4: TcxGridLevel;
    cdsDiff: TClientDataSet;
    dsDiff: TDataSource;
    cxSplitter1: TcxSplitter;
    gbRecipe: TGroupBox;
    cxGrid1: TcxGrid;
    cxGridtvRecipe: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxSplitter3: TcxSplitter;
    cxSplitter4: TcxSplitter;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnRefreshxRiteClick(Sender: TObject);
    procedure btnUploadxRiteClick(Sender: TObject);
    procedure btnRefreshDataColorClick(Sender: TObject);
    procedure btnUploadDataColorClick(Sender: TObject);
    procedure TimerUploadTimer(Sender: TObject);
    procedure cbbxRiteListClick(Sender: TObject);
    procedure cbbDataColorListChange(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure btnDiffClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure QueryData;
    procedure QueryDiffData;
    procedure UploadxRite;
    procedure ReadxRite(const INSERTSQL: string;FileName: string);
    procedure ReadDataColor(const INSERTSQL: string;FileName: string);
    procedure UploadDataColor;
  public
    { Public declarations }
  end;

var
  CPBUploadColorForm: TCPBUploadColorForm;

implementation

uses uGlobal, uGridDecorator, uLogin, uShowMessage, ServerDllPub;

{$R *.dfm}

procedure TCPBUploadColorForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CPBUploadColorForm := nil;
end;

procedure TCPBUploadColorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBUploadColorForm.UploadxRite;
var
  FileName,INSERTSQL:string;
begin
  TimerUpload.Enabled := False;

  FileName := 'D:\xriteData\xriteRecipe.txt';
  INSERTSQL := 'INSERT INTO dbo.xriteRecipe(Item_NO,Step_ID,Chemical_ID,Usage,Department_ID)' + #13#10;
  if FileExists(FileName) then
    ReadxRite(INSERTSQL,FileName);

  FileName := 'D:\xriteData\xriteColor.txt';
  INSERTSQL := 'INSERT INTO dbo.xriteColor(Item_NO,ill,DEcmc_data,DLcmc_data,Da_data,Db_data,DCcmc_data,DHcmc_data,PF,Department_ID)' + #13#10;
  if FileExists(FileName) then
    ReadxRite(INSERTSQL,FileName);
  TMsgdialog.ShowMsgDialog('上传数据成功!', mtInformation);

  FileName := 'D:\xriteData\xriteLab.txt';
  INSERTSQL := 'INSERT INTO dbo.xriteLab(Std_Color_Code,Item_NO,L,a,b,CMC_l,CMC_c,Light_Name,Item_Type,Department_ID)' + #13#10;
  if FileExists(FileName) then
    ReadxRite(INSERTSQL,FileName);
  TMsgdialog.ShowMsgDialog('上传数据成功!', mtInformation);

  TimerUpload.Enabled := True;
end;

procedure TCPBUploadColorForm.ReadxRite(const INSERTSQL: string;FileName: string);
const TotalLine = 100;
var
  AList: TStringList;
  i,j: Integer;
  SELECTStr: string;
  Stream: TStream;
  sErrorMsg: widestring;
begin
  Stream := nil;
  AList := TStringList.Create;
  try
    Alist.LoadFromFile(FileName);
    Stream := TFileStream.Create(FileName, fmOpenWrite or fmShareDenyWrite);
    j := 0;
    SELECTStr := '';
    for i := 0 to Alist.Count-1 do
    begin
      if Alist.Strings[i] <> '' then
      begin
        j := j + 1;
        if (j < TotalLine) and (i < Alist.Count-1) then
        begin
          SELECTStr := SELECTStr+Alist.Strings[i]+ #13#10;
        end else
        begin
          SELECTStr := SELECTStr+ StringReplace(Alist.Strings[i],'UNION ALL','',[rfReplaceAll]);
          FNMServerObj.SaveViaSqltext(INSERTSQL+SELECTStr, sErrorMsg);
          if sErrorMsg<>''then
          begin
            showmessage(sErrorMsg);
            exit;
          end;
          j := 0;
          SELECTStr := '';
        end;
      end;  
    end;
    Stream.Size :=0;
  finally
    Stream.Free;
    FreeAndNil(AList);
  end;
end;

procedure TCPBUploadColorForm.UploadDataColor;
var
  FileName,INSERTSQL:string;
begin
  TimerUpload.Enabled := False;

  FileName := 'D:\DataColor\DataColor.qtx';
  INSERTSQL := 'INSERT INTO dbo.xriteLab(Std_Color_Code,Item_NO,L,a,b,CMC_l,CMC_c,Light_Name,Item_Type,Department_ID)' + #13#10;
  if FileExists(FileName) then
    ReadDataColor(INSERTSQL,FileName);
  TMsgdialog.ShowMsgDialog('上传数据成功!', mtInformation);

  TimerUpload.Enabled := True;
end;

procedure TCPBUploadColorForm.ReadDataColor(const INSERTSQL: string; FileName: string);
  const TotalLine = 100;
var
  AList: TStringList;
  i,j: Integer;
  Ini: TIniFile;
  CMC_l,CMC_c,STD_NAME,BAT_NAME,BAT_CIEL,BAT_CIEa,BAT_CIEb,ILLNAME: string;
  iniFile, Section,SELECTStr:string;
  Stream: TFileStream;
  sErrorMsg: widestring;
begin
  if FileExists(FileName) then
  begin
    iniFile := ChangeFileExt(FileName, '.ini');
    if not RenameFile(FileName,iniFile) then Exit;
    Ini := TIniFile.Create(iniFile);
    Stream := TFileStream.Create(iniFile, fmOpenWrite or fmShareDenyWrite);
    try
      i := 0;
      j := 0;
      SELECTStr := '';
      CMC_l := Ini.ReadString('STANDARD_DATA 0', 'CMC_l', '');
      CMC_c := Ini.ReadString('STANDARD_DATA 0', 'CMC_c', '');
      if pos(',',CMC_l)>0 then
         CMC_l := Copy(CMC_l,1,length(CMC_l)-1);
      if pos(',',CMC_c)>0 then
         CMC_c := Copy(CMC_c,1,length(CMC_c)-1);

      Section :='BATCH_DATA '+IntToStr(i);
      STD_NAME := Ini.ReadString(Section, 'STD_NAME', '');
      while STD_NAME <> '' do
      begin
        inc(j);
        BAT_NAME := Ini.ReadString(Section, 'BAT_NAME', '');
        BAT_CIEL := Ini.ReadString(Section, 'BAT_CIEL', '');
        BAT_CIEa := Ini.ReadString(Section, 'BAT_CIEa', '');
        BAT_CIEb := Ini.ReadString(Section, 'BAT_CIEb', '');
        ILLNAME := Ini.ReadString(Section, 'ILLNAME', '');
        if pos(',',BAT_CIEL)>0 then
           BAT_CIEL := Copy(BAT_CIEL,1,length(BAT_CIEL)-1);
        if pos(',',BAT_CIEa)>0 then
           BAT_CIEa := Copy(BAT_CIEa,1,length(BAT_CIEa)-1);
        if pos(',',BAT_CIEb)>0 then
           BAT_CIEb := Copy(BAT_CIEb,1,length(BAT_CIEb)-1);
        SELECTStr := SELECTStr + 'SELECT '+ QuotedStr(STD_NAME)+','+QuotedStr(BAT_NAME)+','+
                     BAT_CIEL+','+BAT_CIEa+','+BAT_CIEb+','+ CMC_l+','+CMC_c+','+
                     QuotedStr(ILLNAME)+','+QuotedStr('DataColor')+','+QuotedStr('GEW2')+' UNION ALL'+#13#10;
        if (j = TotalLine) and (SELECTStr <> '') then
        begin
          SELECTStr := INSERTSQL+ SELECTStr;
          SELECTStr := Copy(SELECTStr,1,length(SELECTStr)-11);
          FNMServerObj.SaveViaSqltext(SELECTStr, sErrorMsg);
          if sErrorMsg<>''then
          begin
            showmessage(sErrorMsg);
            exit;
          end;
          j := 0;
          SELECTStr := '';
        end;
        Inc(i);
        Section :='BATCH_DATA '+IntToStr(i);
        STD_NAME := Ini.ReadString(Section, 'STD_NAME', '');
      end;
      if (SELECTStr <> '') then
      begin
        SELECTStr := INSERTSQL+ SELECTStr;
        SELECTStr := Copy(SELECTStr,1,length(SELECTStr)-11);
        FNMServerObj.SaveViaSqltext(SELECTStr, sErrorMsg);
        if sErrorMsg<>''then
        begin
          showmessage(sErrorMsg);
          exit;
        end;
      end;
      Stream.Size :=0;
    finally
      Stream.Free;
      Ini.Free;
      RenameFile(iniFile,FileName);
    end;
  end;
end;

procedure TCPBUploadColorForm.TimerUploadTimer(Sender: TObject);
begin
  inherited;
  if DirectoryExists('D:\xriteData\') then
    UploadxRite;
  if DirectoryExists('D:\DataColor\') then
    UploadDataColor;
end;

procedure TCPBUploadColorForm.btnRefreshxRiteClick(Sender: TObject);
var
  vData:OleVariant;
  sqlText,sErrorMsg:widestring;
begin
  inherited;
  sqlText := 'SELECT DISTINCT Item_NO FROM dbo.xRiteRecipe WITH(NOLOCK) WHERE Type = 0 AND Operate_Time>CONVERT(VARCHAR(10),GETDATE(),120)+'' 07:00:00''';
  FNMServerObj.GeneralQuery(Vdata, sqlText, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsPub.Data := vData;
  TGlobal.FillItemsFromDataSet(cdsPub,'Item_NO', '','',cbbxRiteList.Items);
end;

procedure TCPBUploadColorForm.btnUploadxRiteClick(Sender: TObject);
begin
  inherited;
  UploadxRite;
end;

procedure TCPBUploadColorForm.btnRefreshDataColorClick(Sender: TObject);
var
  vData:OleVariant;
  sqlText,sErrorMsg:widestring;
begin
  inherited;
  sqlText := 'SELECT DISTINCT Item_NO FROM dbo.xRiteLab WITH(NOLOCK) WHERE Item_Type = ''DataColor'' AND Operate_Time>CONVERT(VARCHAR(10),GETDATE(),120)+'' 07:00:00''';
  FNMServerObj.GeneralQuery(Vdata, sqlText, sErrorMsg);
  if sErrorMsg <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsPub.Data := vData;
  TGlobal.FillItemsFromDataSet(cdsPub,'Item_NO', '','',cbbDataColorList.Items);
end;

procedure TCPBUploadColorForm.btnUploadDataColorClick(Sender: TObject);
begin
  inherited;
  UploadDataColor;
end;

procedure TCPBUploadColorForm.cbbxRiteListClick(Sender: TObject);
var
  Color_Code: string;
begin
  inherited;
  Color_Code := cbbxRiteList.Items[cbbxRiteList.ItemIndex];
//  while not (Color_Code[1]in ['0'..'9']) do
//    Color_Code := Copy(Color_Code,2,length(Color_Code)-1);
  edtItemNO.Text := Color_Code;
  btnQuery.Click;
end;

procedure TCPBUploadColorForm.cbbDataColorListChange(Sender: TObject);
var
  Color_Code: string;
begin
  inherited;
  Color_Code := cbbDataColorList.Items[cbbDataColorList.ItemIndex];
  while not (Color_Code[1]in ['0'..'9']) do
    Color_Code := Copy(Color_Code,2,length(Color_Code)-1);
  edtItemNO.Text := Color_Code;
  btnQuery.Click;
end;

procedure TCPBUploadColorForm.btnQueryClick(Sender: TObject);
begin
  inherited;
  QueryData;
end;

procedure TCPBUploadColorForm.QueryData;
var vData: OleVariant;
    ColorCode : string;
    sCondition,sConStock,sqlText,sErrorMsg: WideString;
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;
    if cdsRecipe.Active then cdsRecipe.EmptyDataSet;
    if cdsColor.Active then cdsColor.EmptyDataSet;
    if cdsLab.Active then cdsLab.EmptyDataSet;
    if cdsStock.Active then cdsStock.EmptyDataSet;
//    ShowMsg( '正在获取数据稍等！', crHourGlass);
    ColorCode := Trim(edtItemNO.Text);
    if ColorCode = '' then Exit;
//    if Trim(edtColorCode1.Text) = '' then
//      edtColorCode1.Text := ColorCode;
//    if (Trim(edtColorCode1.Text) <> '') and (ColorCode <> Trim(edtColorCode1.Text)) then
//      edtColorCode2.Text := ColorCode;

    sCondition := QuotedStr(ColorCode)+','+IntToStr(PageControl1.ActivePageIndex);
    FNMServerObj.GetQueryData(vData,'GetxRiteData',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsRecipe.Data := vData[0];
    cdsLab.Data := vData[1];
    cdsStock.Data := vData[2];
    GridDecorator.BindCxViewWithDataSource(cxGridtvRecipe, dsRecipe,True);
    GridDecorator.BindCxViewWithDataSource(cxGridtvLab, dsLab,True);
    GridDecorator.BindCxViewWithDataSource(cxGridtvStock, dsStock,True);
    if PageControl1.ActivePageIndex = 0 then
    begin
      cdsColor.Data := vData[3];
      GridDecorator.BindCxViewWithDataSource(cxGridtvColor, dsColor,True);
    end
  finally
     Screen.Cursor := crDefault;
//    ShowMsg('', crDefault);
  end;
end;

procedure TCPBUploadColorForm.PageControl1Change(Sender: TObject);
begin
  inherited;
  if PageControl1.ActivePageIndex = 0 then
  begin
     if cxSpxRite.State = ssClosed then
        cxSpxRite.OpenSplitter;
     pnlxRite.Height := 120;
     gbRecipe.Caption := 'xRite配方信息';
  end else
  begin
    cxSpxRite.CloseSplitter;
    gbRecipe.Caption := 'LabDip OK方信息';
  end;
  if cdsRecipe.Active then cdsRecipe.EmptyDataSet;
  if cdsColor.Active then cdsColor.EmptyDataSet;
  if cdsLab.Active then cdsLab.EmptyDataSet;
  if cdsStock.Active then cdsStock.EmptyDataSet;
end;

procedure TCPBUploadColorForm.btnDiffClick(Sender: TObject);
begin
  inherited;
  QueryDiffData;
end;

procedure TCPBUploadColorForm.QueryDiffData;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  try
    Screen.Cursor := crHourGlass;
    if (Trim(edtColorCode1.Text)='') or (Trim(edtColorCode2.Text)='') then Exit;
    if cdsDiff.Active then cdsDiff.EmptyDataSet;
    sCondition := QuotedStr(edtColorCode1.Text)+','+QuotedStr(edtColorCode2.Text);
    FNMServerObj.GetQueryData(vData,'GetDiffLab',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    cdsDiff.Data := vData;
    GridDecorator.BindCxViewWithDataSource(cxGridtvDiff, dsDiff);
  finally
     Screen.Cursor := crDefault;
  end;
end;

procedure TCPBUploadColorForm.FormShow(Sender: TObject);
begin
  inherited;
  TControl(cbbxRiteList).Align := alClient;
  TControl(cbbDataColorList).Align := alClient;
  TimerUpload.Enabled := DirectoryExists('D:\xriteData\') or DirectoryExists('D:\DataColor\');
  btnUploadxRite.Enabled := DirectoryExists('D:\xriteData\');
  btnUploadDataColor.Enabled := DirectoryExists('D:\DataColor\');
  if DirectoryExists('D:\xriteData\') then
    PageControl1.ActivePageIndex := 0
  else if DirectoryExists('D:\DataColor\') then
    PageControl1.ActivePageIndex := 1
  else
    PageControl1.ActivePageIndex := 0;
  PageControl1.OnChange(self);    
end;

end.

