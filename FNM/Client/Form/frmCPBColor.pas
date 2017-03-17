{*******************************************************}
{                                                       }
{       软件名称 W.MIS CLIENT MODEL                     }
{       版权所有 (C) 2006, 2007 Esquel.IT               }
{       创建日期 2008-10-5                              }
{       创建人员 Zhangjy                                 }
{       功能描述 色号编制                               }
{                                                       }
{*******************************************************}
unit frmCPBColor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, frmBase, ExtCtrls, cxStyles, cxCustomData, cxGraphics, cxFilter,
  cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxLookAndFeelPainters, StdCtrls, cxButtons,
  cxContainer, cxLabel, cxTextEdit, cxRadioGroup, cxMaskEdit,
  cxDropDownEdit, DBClient, cxDBEdit, cxCheckBox, cxCalendar, cxGroupBox,
  Buttons, cxSplitter, ComCtrls, ImgList,Math, StrUtils, Menus;

type
  TCPBColorForm = class(TBaseForm)
    dsTask: TDataSource;
    cdsTask: TClientDataSet;
    ColorDialog: TColorDialog;
    Panel4: TPanel;
    grp2: TGroupBox;
    cxGrid2: TcxGrid;
    cxgdTVTask: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    Label12: TLabel;
    Label14: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label17: TLabel;
    Label10: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    cbHasBulk: TCheckBox;
    mmoRemark: TMemo;
    plShowColor: TPanel;
    edtRGB: TEdit;
    edtLBNO: TEdit;
    edtFabColorName: TEdit;
    edtFinishMethod: TEdit;
    edtSeason: TEdit;
    edtDeliveryDate: TEdit;
    cbSimpleColor: TComboBox;
    edtFNColor: TEdit;
    cbColorMatcher: TComboBox;
    edtFactConstruction: TEdit;
    cbCustom: TCheckBox;
    edtPatternName: TEdit;
    edtStyleName: TEdit;
    edtHLNO: TEdit;
    ColorRGB: TGroupBox;
    Image: TImage;
    GroupBox2: TGroupBox;
    tvColorList: TTreeView;
    cxSplitter1: TcxSplitter;
    btnList: TSpeedButton;
    Panel2: TPanel;
    btnRefresh: TSpeedButton;
    lbLBNO: TLabel;
    btnQuery: TSpeedButton;
    btnSave: TSpeedButton;
    btnExit: TSpeedButton;
    btnTest: TSpeedButton;
    btnDelete: TSpeedButton;
    edtCPBColor: TEdit;
    ImageList2: TImageList;
    cbbDegree: TComboBox;
    Label24: TLabel;
    edtPpoType: TEdit;
    cdsCustomerColorName: TClientDataSet;
    edtLB_NO: TEdit;
    lbl1: TLabel;
    Label25: TLabel;
    edtLaunchTime: TEdit;
    mmoShade: TMemo;
    Label26: TLabel;
    edtColorTime: TEdit;
    Label27: TLabel;
    Label28: TLabel;
    edtSendTime: TEdit;
    cbbSender: TComboBox;
    GroupBox3: TGroupBox;
    cxGrid1: TcxGrid;
    cxdgTVColorMatchTrace: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    dsColorMatchTrace: TDataSource;
    cdsColorMatchTrace: TClientDataSet;
    Panel3: TPanel;
    Label15: TLabel;
    cbLight: TComboBox;
    Label8: TLabel;
    cbSendType: TComboBox;
    Label9: TLabel;
    edtSendCount: TEdit;
    Label16: TLabel;
    mmoCPBRequest: TMemo;
    Label29: TLabel;
    edtFabricType: TEdit;
    Label30: TLabel;
    edtYarnSkeinRef: TEdit;
    Label31: TLabel;
    edtPatternRef: TEdit;
    Label32: TLabel;
    edtBrushingRef: TEdit;
    Label33: TLabel;
    edtHandfeelRef: TEdit;
    Label34: TLabel;
    edtFinishingRef: TEdit;
    Label35: TLabel;
    mmoACHolderRemark: TMemo;
    Label18: TLabel;
    edtGFNO: TEdit;
    Label23: TLabel;
    edtApproveShade: TEdit;
    Label7: TLabel;
    cbConstruction: TComboBox;
    edtCustomer: TEdit;
    btCustomerColor: TButton;
    pmCustomerColor: TPopupMenu;
    NCustomerColor1: TMenuItem;
    NCustomerColor2: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure cxgdTVTaskDblClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure cbConstructionChange(Sender: TObject);
    procedure btnTestClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure ImageMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure plShowColorDblClick(Sender: TObject);
    procedure cbCustomClick(Sender: TObject);
    procedure btnListClick(Sender: TObject);
    procedure cbSimpleColorChange(Sender: TObject);
    procedure tvColorListDblClick(Sender: TObject);
    procedure edtCPBColorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtLB_NOKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mmoShadeExit(Sender: TObject);
    procedure btCustomerColorClick(Sender: TObject);
    procedure NCustomerColor1Click(Sender: TObject);
    procedure NCustomerColor2Click(Sender: TObject);
  private
    { Private declarations }
    PatternID: string;
    OLDFNColorCode: string;
    procedure GetColorList;
    procedure GetColorInfo(sCondition: string);
    procedure DeleteColorInfo;
    procedure SaveColorInfo;
   //检查客户、色名是否已经存在色号，如果已经存在请用户选择是否新编色号,如果不新编色号选择需要跟的色号
    function CheckColor:string;
    //--Content:取对色记录    Reason:    Added By Danny at 2015-02-02 16:28:49:445
    procedure GetfnCPBColorMatchTrace;
    //--Content:设置控件修改属性g    Reason:    Added By Danny at 2015-02-03 11:30:52:924
    procedure SetModified(bModified:Boolean);
  protected
    procedure UpdateActions; override;
  public
    { Public declarations }
  end;

var
  CPBColorForm: TCPBColorForm;

implementation

uses  ServerDllPub, uFNMResource ,uDictionary, uShowMessage, uLogin,
      uGlobal, uGridDecorator,frmSelectFNColorCode;
{$R *.dfm}

procedure TCPBColorForm.UpdateActions;
begin
  btnQuery.Enabled := edtCPBColor.Text <>'';
  btnSave.Enabled := (cbSimpleColor.Text <>'') and (plShowColor.Color >0);//2009-11-26 (edtGFNO.Text <>'') and
  cbColorMatcher.Enabled := (cbColorMatcher.Text='') or (edtFNColor.Text='');
//  cbbSender.Enabled := edtSendTime.Text='';  
end;

procedure TCPBColorForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
end;

procedure TCPBColorForm.FormDestroy(Sender: TObject);
begin
  inherited;
  CPBColorForm :=nil;
end;

procedure TCPBColorForm.FormCreate(Sender: TObject);
begin
  inherited;

  //--Content:自定义色号改变为询问方式   cbCustom去掉    Reason:    Added By Danny at 2015-02-05 17:22:10:281
  cbCustom.Visible:=False;

  OLDFNColorCode := '';
  edtLB_NO.Text := Copy(FormatDateTime('LByyyy-', Now()),1,7);
  btnQuery.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  btnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnList.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);
  btnTest.Glyph.LoadFromResourceName(HInstance, RES_EDIT);
  btnDelete.Glyph.LoadFromResourceName(HInstance, RES_DELETE);
  btnSave.Glyph.LoadFromResourceName(HInstance, RES_SAVE);
  btnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);
 {
  FNMServerObj.GetBaseTableInfo(vData, 'fnCPBCustomer', sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data := vData;
  cbCustomer.Items.Clear;
  TempClientDataSet.First;
  while not TempClientDataSet.Eof do
  begin
    cbCustomer.Items.Add(TempClientDataSet.FieldByName('Customer').AsString);
    TempClientDataSet.Next;
  end;
  TempClientDataSet.Close;
  }
  cbSimpleColor.Items.Text := Dictionary.GetItemList('CPB颜色简称',Login.CurrentDepartment,'');
  cbColorMatcher.Items.Text := Dictionary.GetItemList('CPB对色人员',Login.CurrentDepartment,'');
  cbbSender.Items.Text := Dictionary.GetItemList('CPB送样人员',Login.CurrentDepartment,'');
  cbLight.Items.Text := Dictionary.GetItemList('CPB光源',Login.CurrentDepartment,'');
  with Dictionary.cds_CPBStock do
  begin
    First;
    while not Eof do
    begin
      cbConstruction.Items.Add(FieldByName('Construction').AsString);
      Next;
    end;
  end;
  cbSimpleColor.DropDownCount := cbSimpleColor.Items.Count;
  cxSplitter1.CloseSplitter;
end;

procedure TCPBColorForm.btnRefreshClick(Sender: TObject);
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
begin
  inherited;
  sCondition := QuotedStr(Login.CurrentDepartment)+',6';
  FNMServerObj.GetQueryData(vData,'CPBGetTask',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  cdsTask.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxgdTVTask, dsTask);
  GridDecorator.HideFields(cxgdTVTask,['Pattern_ID']);
end;

procedure TCPBColorForm.btnQueryClick(Sender: TObject);
var
  sCondition: string;
begin
  if edtCPBColor.Text = '' then Exit;
  sCondition := '0,'+ ''''''+','+ QuotedStr(edtCPBColor.Text);
  GetColorInfo(sCondition);
end;

procedure TCPBColorForm.GetColorInfo(sCondition: string);
var vData: OleVariant;
    sErrorMsg: WideString;
begin
  try
    TStatusBarMessage.ShowMessageOnMainStatsusBar('正在获取数据稍等！',crHourGlass);
    FNMServerObj.GetQueryData(vData,'CPBGetColor',sCondition,sErrorMsg);
    if sErrorMsg<>'' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    if TempClientDataSet.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('没有此色号相关信息,请检查输入的来样编号或色号是否正确!',mtInformation);
      Exit;
    end;
    with TempClientDataSet do
    begin
      edtPpoType.Text := FieldByName('Ppo_Type').AsString;
      PatternID := FieldByName('Pattern_ID').AsString;
      edtLBNO.Text := FieldByName('LB_NO').AsString;
      edtHLNO.Text := FieldByName('HL_NO').AsString;
      edtPatternName.Text := TempClientDataSet.FieldByName('Pattern_Name').AsString;
      edtStyleName.Text := TempClientDataSet.FieldByName('Style_Name').AsString;
      edtFabColorName.Text := FieldByName('Fab_Color_Name').AsString;
      edtCustomer.Text := FieldByName('Customer').AsString;
      edtFinishMethod.Text := FieldByName('Finish_Method').AsString;
      edtLaunchTime.Text := FieldByName('Launch_Time').AsString;
      edtSeason.Text := FieldByName('Season').AsString;
      edtFabricType.Text := FieldByName('FabricType').AsString;
      edtYarnSkeinRef.Text := FieldByName('Yarn_Skein_Ref').AsString;
      edtPatternRef.Text := FieldByName('Pattern_Ref').AsString;
      edtBrushingRef.Text := FieldByName('Brushing_Ref').AsString;
      //edtHandfeelRef.Text := FieldByName('Handfeel_Ref').AsString;
      //edtFinishingRef.Text := FieldByName('Finishing_Ref').AsString;
      mmoACHolderRemark.Lines.Text := FieldByName('AC_Holder_Remarks').AsString;
      edtDeliveryDate.Text := FieldByName('Delivery_Date').AsString;
      TGlobal.SetComboBoxValue(cbSendType, FieldByName('Send_Type').AsString);
      TGlobal.SetComboBoxValue(cbConstruction, FieldByName('Construction').AsString);
      edtFactConstruction.Text := FieldByName('Fact_Construction').AsString;
      edtGFNO.Text := FieldByName('GF_NO').AsString;
      edtSendCount.Text := FieldByName('Send_Count').AsString;
      if FieldByName('Sender').AsString <> '' then
        TGlobal.SetComboBoxValue(cbbSender, FieldByName('Sender').AsString);
      edtSendTime.Text := FieldByName('Send_Time').AsString;
      TGlobal.SetComboBoxValue(cbSimpleColor, FieldByName('Simple_Color_Name').AsString);
      edtFNColor.Text := FieldByName('FN_Color_Code').AsString;
      //cbLight.Text := FieldByName('Light').AsString;
      edtHandfeelRef.Text := FieldByName('Light').AsString;
      edtFinishingRef.Text := FieldByName('Crocking').AsString;

      edtRGB.Text := FieldByName('RGB').AsString;
      plShowColor.Color := FieldByName('RGB').AsInteger;
      if FieldByName('Color_Matcher').AsString <> '' then
      TGlobal.SetComboBoxValue(cbColorMatcher, FieldByName('Color_Matcher').AsString);
      mmoShade.Text := FieldByName('Shade').AsString;
      TGlobal.SetComboBoxValue(cbbDegree, FieldByName('Degree').AsString);
      edtApproveShade.Text := FieldByName('Approve_Shade').AsString;
      cbHasBulk.Checked := FieldByName('Has_Bulk').AsBoolean;
      mmoCPBRequest.Lines.Text := FieldByName('CPB_Request').AsString;
      mmoRemark.Lines.Text := FieldByName('Remark').AsString;
      edtColorTime.Text := FieldByName('Color_Time').AsString;
      btnDelete.Enabled := edtFNColor.Text <> '';
      OLDFNColorCode := edtFNColor.Text;
    end;

    //--Content:取对色记录    Reason:    Added By Danny at 2015-02-02 16:28:49:445
    GetfnCPBColorMatchTrace();
    setModified(False);
  finally
    TStatusBarMessage.ShowMessageOnMainStatsusBar('',crDefault);
  end;
end;

procedure TCPBColorForm.cxgdTVTaskDblClick(Sender: TObject);
var
  sCondition: string;
begin
  inherited;
  if not cdsTask.Active then Exit;
  PatternID := cdsTask.FieldByName('Pattern_ID').AsString;
  edtLBNO.Text := cdsTask.FieldByName('LB_NO').AsString;
  edtFabColorName.Text := cdsTask.FieldByName('Fab_Color_Name').AsString;
  sCondition := QuotedStr(PatternID)+','+ QuotedStr(edtFabColorName.Text)+',''''';
  GetColorInfo(sCondition);
end;

procedure TCPBColorForm.btnSaveClick(Sender: TObject);
begin
  SaveColorInfo;
end;

procedure TCPBColorForm.SaveColorInfo;
var
  FN_Color_Code, sCondition, sCustomerColor, sErrorMsg: WideString;
  Node: TTreeNode;
  mResult:Integer;
begin
  inherited;
  if (cbSimpleColor.Text ='')then
  begin
    TMsgDialog.ShowMsgDialog('请选择颜色简称！',mtInformation);
    cbSimpleColor.SetFocus;
    Exit;
  end;
  if plShowColor.Color<=0 then
  begin
    TMsgDialog.ShowMsgDialog('请选择新色号的RGB值！',mtInformation);
    Exit;
  end;
  if cbColorMatcher.Text= '' then
  begin                                                             
    TMsgDialog.ShowMsgDialog('请选择对色人员！',mtInformation);
    cbColorMatcher.SetFocus;
    Exit;
  end;

  if mmoShade.Lines.Text <> '' then
  begin
    if edtHandfeelRef.Text= '' then
    begin
      TMsgDialog.ShowMsgDialog('请输入日晒值！',mtInformation);
      edtHandfeelRef.SetFocus;
      Exit;
    end;
    if edtFinishingRef.Text= '' then
    begin
      TMsgDialog.ShowMsgDialog('请输入湿磨值！',mtInformation);
      edtFinishingRef.SetFocus;
      Exit;
    end;
  end;

  if cbCustom.Checked then
  begin
    if edtFNColor.Text = '' then
    begin
      TMsgDialog.ShowMsgDialog('请输入色号编码！',mtInformation);
      Exit;
    end;
    if MidStr(edtFNColor.Text,5,2) <> cbSimpleColor.Text then
    begin
      TMsgDialog.ShowMsgDialog('色号编码中的颜色简称不一致,请重新编制！',mtInformation);
      Exit;
    end;
  end;

  //cuijf 2009-11-16
  //检查客户、色名是否已经存在色号，如果已经存在请用户选择是否新编色号
  //如果不新编色号在已有的色号后加流水号
  if edtFNColor.Text<>'' then //不需要新编制色号的不用检查
    sCustomerColor := ''
  else  //需要编制新色号的，选择不同的色号编制规则
  begin
    sCustomerColor := CheckColor;
    if sCustomerColor= '错误' then Exit;
    if sCustomerColor<>'' then
    begin //如果已经存在请用户选择是否新编色号
      mResult := TMsgDialog.ShowMsgDialog('该客户的色名已经做过色号：'+sCustomerColor+char(13)
            +'【是】新编全新色号'+char(13)
            +'【否】在已有色号基础上编新色号'+ char(13)
            +'【取消】取消生成新色号',
            mtConfirmation, [mebYes, mebNo, mebCancel], mebNo);
      if mResult= mrCancel then Exit;
      if mResult= mrYes then sCustomerColor := '';
    end;
  end;

  sCondition :=  QuotedStr(PatternID)+',' + QuotedStr(edtLBNO.Text)+','+ QuotedStr(edtFabColorName.Text)+',' +
                 QuotedStr(edtCustomer.Text)+',' +QuotedStr(edtGFNO.Text)+','+ QuotedStr(edtFNColor.Text)+',' +
                 QuotedStr(cbSimpleColor.Text)+',' +QuotedStr(edtRGB.Text)+',' + QuotedStr(edtHandfeelRef.Text)+','+
                 QuotedStr(cbSendType.Text)+','+ QuotedStr(edtSendCount.Text)+','+ QuotedStr(cbbSender.Text)+','+
                 QuotedStr(mmoShade.Text) +','+ QuotedStr(cbbDegree.Text) +','+  QuotedStr(cbColorMatcher.Text) +','+
                 ifThen(cbHasBulk.Checked,'1','0')+','+QuotedStr(mmoCPBRequest.Lines.Text)+','+QuotedStr(mmoRemark.Lines.Text)+','+
                 QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID)+','+QuotedStr(sCustomerColor) + ',' + QuotedStr(edtFinishingRef.Text);
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQLEx('CPBSaveColor',sCondition,FN_Color_Code,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtFNColor.Text := FN_Color_Code;
    if cdsTask.Active and (not cdsTask.IsEmpty) then
    begin
      while cdsTask.Locate('Pattern_ID', PatternID, []) do
        cdsTask.Delete;
    end;
    OLDFNColorCode := '';
    if tvColorList.Items.Count > 0 then
    begin
      Node := nil;
      if tvColorList.Selected.Text <> edtFNColor.Text then
        if tvColorList.Selected.HasChildren then
          Node := tvColorList.Selected
        else
          Node := tvColorList.Selected.Parent;
      with tvColorList.Items.AddChild(Node,edtFNColor.Text) do
      begin
        ImageIndex := 2;
        SelectedIndex := 2;
      end;
      Node.Data := pointer(Integer(pointer(Node.Data))+1);
      Node.Text := Node.Text + '【'+IntToStr(Integer(Node.Data))+'】';
    end;
    TMsgDialog.ShowMsgDialog('保存数据成功',mtInformation);
  finally
    ShowMsg('', crDefault);
  end;

  //--Content:取对色记录    Reason:    Added By Danny at 2015-02-02 16:28:49:445
  //保存后再根据色级取出对色记录
  GetfnCPBColorMatchTrace();

  setModified(False);
end;

procedure TCPBColorForm.btnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TCPBColorForm.cbConstructionChange(Sender: TObject);
begin
  inherited;
  with Dictionary.cds_CPBStock do
  begin
    if Locate('Construction',cbConstruction.Text,[]) then
    begin
      edtGFNO.Text :=  FieldByName('GF_NO').AsString;
    end;  
  end;
end;

procedure TCPBColorForm.btnTestClick(Sender: TObject);
var
  sCondition: string;
begin
  if InputQuery('输入色名', '请输入色名:', sCondition) then
  begin
     sCondition := '-1,'+ QuotedStr(sCondition)+',''''';
     GetColorInfo(sCondition);
  end;   
end;

procedure TCPBColorForm.btnDeleteClick(Sender: TObject);
begin
  DeleteColorInfo;
end;

procedure TCPBColorForm.DeleteColorInfo;
var
  sCondition, sErrorMsg: WideString;
begin
  inherited;
  if (edtFNColor.Text ='')then Exit;
  if IDNO = Application.MessageBox('是否删除当前色号？', '提示', MB_YESNO + MB_ICONQUESTION) then exit;

  sCondition :=  QuotedStr(PatternID)+',' + QuotedStr(edtLBNO.Text)+','+ QuotedStr(edtFabColorName.Text)+',' +
                 QuotedStr(edtFNColor.Text)+','+ QuotedStr(Login.CurrentDepartment)+','+QuotedStr(Login.LoginID);
  try
    ShowMsg('正在获取数据稍等！', crHourGlass);
    FNMServerObj.SaveDataBySQL('CPBDeleteColor',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    edtFNColor.Text := '';
    cbSimpleColor.Text := '';
    OLDFNColorCode := '';
    btnDelete.Enabled := False;
    TMsgDialog.ShowMsgDialog('删除数据成功',mtInformation);

    setModified(False);
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBColorForm.ImageMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  RGB:integer;
begin
  RGB:=Image.Canvas.Pixels[x,y];
  edtRGB.Text := InttoStr(RGB);
  plShowColor.Color := RGB;
end;

procedure TCPBColorForm.plShowColorDblClick(Sender: TObject);
var
  RGB: integer;
begin
  ColorDialog.Color := plShowColor.Color;
  if ColorDialog.Execute then
  begin
    if ColorDialog.Color <> NULL then
    begin
      RGB:= ColorDialog.Color;
      edtRGB.Text := InttoStr(RGB);
      plShowColor.Color := RGB;
    end;
  end;
end;

procedure TCPBColorForm.cbCustomClick(Sender: TObject);
begin
  inherited;
  if cbCustom.Checked then
  begin
    edtFNColor.ParentColor := False;
    edtFNColor.ReadOnly := False;
    edtFNColor.Color := clWindow;
    edtFNColor.Text := '';
    edtFNColor.TabStop := True;
  end else
  begin
    edtFNColor.ParentColor := True;
    edtFNColor.ReadOnly := True;
    edtFNColor.Color := clBtnFace;
    edtFNColor.Text := OLDFNColorCode;
    edtFNColor.TabStop := False;    
  end;
end;

procedure TCPBColorForm.btnListClick(Sender: TObject);
begin
  GetColorList;
end;

procedure TCPBColorForm.GetColorList;
var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
    ColorType: string;
    Node: TTreeNode;
    i: Integer;
begin
  inherited;
  sCondition := QuotedStr(Login.CurrentDepartment)+',11';
  FNMServerObj.GetQueryData(vData,'CPBGetTask',sCondition,sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
  TempClientDataSet.Data:=vData;
  ColorType := '';
  tvColorList.Items.Clear;
  Node := nil;
  i := 0 ;
  tvColorList.Items.BeginUpdate;
  with TempClientDataSet do
  begin
    First;
    while not Eof do
    begin
      if ColorType <> FieldByName('Color_Type').AsString then
      begin
        if (i<>0) and (Node <> nil) then
        begin
          Node.Data := pointer(i);
          Node.Text := Node.Text + '【'+IntToStr(Integer(Node.Data))+'】';
          i := 0;
        end;
        ColorType := FieldByName('Color_Type').AsString;
        Node := tvColorList.Items.AddChild(nil,ColorType);
        Node.ImageIndex := 0;
        Node.SelectedIndex := 1;
      end;
      with tvColorList.Items.AddChild(Node,FieldByName('FN_Color_Code').AsString) do
      begin
        inc(i);
        ImageIndex := 2;
        SelectedIndex := 2;
      end;
      Next;
      if Eof then
      begin
        Node.Data := pointer(i);
        Node.Text := Node.Text + '【'+IntToStr(Integer(Node.Data))+'】';
      end;
    end;
  end;
  tvColorList.Items.EndUpdate;
end;

procedure TCPBColorForm.cbSimpleColorChange(Sender: TObject);
var
 root: TTreeNode;
begin
  inherited;
  tvColorList.Items.BeginUpdate;
  root := tvColorList.Items.GetFirstNode;
  while root <> nil do
  begin
    root.Collapse(True);
    root := root.getNextSibling;
  end;
  root := tvColorList.Items.GetFirstNode;
  while root <> nil do
  begin
    if root.Text = cbSimpleColor.Text then
    begin
      root.Selected := True;
      root.Expand(True);
      break;
    end else
      root := root.getNextSibling;
  end;
  tvColorList.Items.EndUpdate;
end;

procedure TCPBColorForm.tvColorListDblClick(Sender: TObject);
begin
  inherited;
  if tvColorList.Selected.HasChildren then Exit;
  edtCPBColor.Text := tvColorList.Selected.Text;
  btnQuery.Click;
end;

//cuijf 2009-11-16
//检查客户、色名是否已经存在色号，如果已经存在请用户选择是否新编色号
//如果不新编色号选择需要跟的色号
function TCPBColorForm.CheckColor: string;
var
  vData:OleVariant;
  sFNColorCode, sSQL:string;
  sErrMsg:WideString;
begin
  Result := '';
  try
    ShowMsg('正在检查色号稍等！', crHourGlass);
    try
      if cdsCustomerColorName.Active then
        cdsCustomerColorName.EmptyDataSet;
      //修改色号
      sSQL := edtFabColorName.Text;
      if not InputQuery('输入色名', '请输入新色名:', sSQL) then
      begin
        Result := '错误';
        Exit;
      end;

      if Trim(sSQL) = '' then
      begin
        Result := '错误';
        Exit;
      end;

      //检查是否有色号
      sSQL := QuotedStr(edtCustomer.Text)+','+QuotedStr(sSQL)+','+ QuotedStr(cbSimpleColor.Text);
      FNMServerObj.GetQueryData(vData,'cpbGetCustomerColor',sSQL,sErrMsg);
      if sErrMsg <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrMsg,mtError);
        Result := '错误';
        Exit;
      end;
      cdsCustomerColorName.Data := vData;
      if cdsCustomerColorName.IsEmpty then
      begin
        Result := '';
        Exit;
      end;
      //返回做过的色号
      //只有一个的直接返回
      if cdsCustomerColorName.RecordCount = 1 then
        Result := cdsCustomerColorName.FieldByName('FN_Color_Code').AsString
      else
      begin
        sFNColorCode := SelectFNColorCode(cdsCustomerColorName);
        if sFNColorCode= '' then
        begin
          Result := '';
          Exit;
        end;

        with cdsCustomerColorName do
        begin
          if Locate('FN_Color_Code', sFNColorCode, []) then
          begin
            TGlobal.SetComboBoxValue(cbSimpleColor, FieldByName('Simple_Color_Name').AsString);
            TGlobal.SetComboBoxValue(cbbDegree, FieldByName('Degree').AsString);
            edtRGB.Text := FieldByName('RGB').AsString;
            plShowColor.Color := FieldByName('RGB').AsInteger;
          end;
        end;
        Result:= sFNColorCode;
        Exit;
      end;
    except
      Result := '错误';
    end;
  finally
    ShowMsg('', crDefault);
  end;
end;

procedure TCPBColorForm.edtCPBColorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key = 13 then
    btnQuery.Click;
end;

procedure TCPBColorForm.edtLB_NOKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if not cdsTask.Active then
    btnRefresh.Click;

  if (key = 13) and (Length(edtLB_NO.Text) > 7) then
  begin
    if Trim(edtLB_NO.Text)<>'' then
    begin
      with cxgdTVTask.DataController.Filter do
      try
        BeginUpdate;
        Root.Clear;
        Root.AddItem(cxgdTVTask.DataController.GetItemByFieldName('LB_NO'), foEqual,edtLB_NO.Text,edtLB_NO.Text);
        Active:=true;
      finally
        EndUpdate;
      end;
    end;
  end;
end;

//--Content:取对色记录    Reason:    Added By Danny at 2015-02-02 16:28:49:445
procedure TCPBColorForm.GetfnCPBColorMatchTrace;
var vData: OleVariant;
    sErrorMsg: WideString;
    sCondition:string;
begin
  try
    if Trim(edtFNColor.Text) <> '' then
    begin
      sCondition := QuotedStr(Login.CurrentDepartment)+',14,'+ QuotedStr(edtFNColor.Text)
                 +','+QuotedStr(TrimRight(mmoShade.Text));//--Content:    Reason:    Added By Danny at 2015-02-02 16:05:07:185
      FNMServerObj.GetQueryData(vData,'CPBGetTask',sCondition,sErrorMsg);
      if sErrorMsg<>'' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
        Exit;
      end;
      cdsColorMatchTrace.Data := vData;
      GridDecorator.BindCxViewWithDataSource(cxdgTVColorMatchTrace, dsColorMatchTrace);
    end;

  except
    on e:Exception do
    begin
      TMsgDialog.ShowMsgDialog('取对色记录出错!'+char(13)+e.Message,mtInformation);
    end;
  end;

end;

procedure TCPBColorForm.mmoShadeExit(Sender: TObject);
begin
  inherited;
  if mmoShade.Modified then
    GetfnCPBColorMatchTrace();
end;

//--Content:设置控件修改属性g    Reason:    Added By Danny at 2015-02-03 11:30:52:924
procedure TCPBColorForm.SetModified(bModified: Boolean);
begin
  mmoShade.Modified:=bModified;
end;


{-------------------------------------------------------------------------------
  过程名:    TCPBColorForm.btCustomerColorClick
  作者:      Danny duda
  日期:      2015.02.09 10:34:29
  参数:      Sender: TObject
  返回值:    无
  描述:      自定义色号
  修改内容:
-------------------------------------------------------------------------------}
procedure TCPBColorForm.btCustomerColorClick(Sender: TObject);
var
pt: TPoint;
begin
  GetCursorPos(pt);
  //pt := ScreenToClient(pt);
  pmCustomerColor.Popup(pt.X, pt.Y);
end;

{-------------------------------------------------------------------------------
  过程名:    TCPBColorForm.NCustomerColor1Click
  作者:      Danny duda
  日期:      2015.02.09 11:41:18
  参数:      Sender: TObject
  返回值:    无
  描述:      顺延子色号
  修改内容:
-------------------------------------------------------------------------------}
procedure TCPBColorForm.NCustomerColor1Click(Sender: TObject);
begin
  inherited;
  //
end;

{-------------------------------------------------------------------------------
  过程名:    TCPBColorForm.NCustomerColor2Click
  作者:      Danny duda
  日期:      2015.02.09 11:41:26
  参数:      Sender: TObject
  返回值:    无
  描述:      选择已存在的色号
  修改内容:
-------------------------------------------------------------------------------}
procedure TCPBColorForm.NCustomerColor2Click(Sender: TObject);
begin
  inherited;
  //
end;

end.

