{******************************************************************************
       软件名称 WMIS ——FNM
       文件名称 frmPrintFNCardAndLabel
       版权所有 (C) 2014 ESQUEL GROUP GET/IT
       创建日期 2014-09-08
       创建人员 APJ zhaogang
       修改人员
       修改日期
       修改原因
       对应用例
       数据库
       调用重要函数/SQL对象说明
            存储过程
                FNMDB.dbo.usp_getPrintCardAndLabelInfoByGI
                FNMDB.dbo.usp_giFullCarFabricsData
******************************************************************************}
unit frmPrintFNCardAndLabel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxControls, cxSplitter, ExtCtrls, cxStyles, cxCustomData,
  cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, StdCtrls, Buttons,
  frmBase, uFNMResource, DBClient, Grids, DBGrids, MakeSQL, uPrinterOption;

type
  TPrintFNCardAndLabelFrom = class(TBaseForm)
    cxSplitter1: TcxSplitter;
    CDSFullCar: TClientDataSet;
    CDSWaitPrintCard: TClientDataSet;
    DSFullCar: TDataSource;
    DSWaitPrintCard: TDataSource;
    CDSRePrintLabel: TClientDataSet;
    DSRePrintLabel: TDataSource;
    GroupBox1: TGroupBox;
    cxGrdPrintLabel: TcxGrid;
    cxTVPrintLabel: TcxGridDBTableView;
    cxLevelPrintLabel: TcxGridLevel;
    Panel6: TPanel;
    SBtnQueryReLab: TSpeedButton;
    SBtnRePrintLabel: TSpeedButton;
    GroupBox2: TGroupBox;
    PnlFullCar: TPanel;
    cxGrdFullCar: TcxGrid;
    cxTVFullCar: TcxGridDBTableView;
    cxLevelFullCar: TcxGridLevel;
    Panel5: TPanel;
    SBtnEmpty: TSpeedButton;
    SBtnCancel: TSpeedButton;
    SBtnAll: TSpeedButton;
    SBtnAdd: TSpeedButton;
    pnlWaitPrintCard: TPanel;
    cxGrdWaitPrintCard: TcxGrid;
    cxTVWaitPrintCard: TcxGridDBTableView;
    cxLevelWaitPrintCard: TcxGridLevel;
    Panel7: TPanel;
    cxSplitter2: TcxSplitter;
    Panel1: TPanel;
    MSQLRePrint: TMakeSQL;
    CBAll: TCheckBox;
    SBtnRefresh: TSpeedButton;
    Label2: TLabel;
    CBBSrcDepartment: TComboBox;
    chkPreviewLabel: TCheckBox;
    chkPreviewCard: TCheckBox;
    SBtnPrint: TSpeedButton;
    Label1: TLabel;
    CBBRePSrcDepartment: TComboBox;
    SBtnExit: TSpeedButton;
    CDSPrintReturn: TClientDataSet;
    CBBCardPrinter: TComboBox;
    Label4: TLabel;
    Label3: TLabel;
    CBBLabelPrinter: TComboBox;
    CDSFNCard: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SBtnRefreshClick(Sender: TObject);
    procedure SBtnExitClick(Sender: TObject);
    procedure cxTVFullCarDblClick(Sender: TObject);
    procedure cxTVWaitPrintCardDblClick(Sender: TObject);
    procedure SBtnAllClick(Sender: TObject);
    procedure SBtnCancelClick(Sender: TObject);
    procedure SBtnEmptyClick(Sender: TObject);
    procedure SBtnAddClick(Sender: TObject);
    procedure SBtnQueryReLabClick(Sender: TObject);
    procedure cxTVFullCarCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure SBtnPrintClick(Sender: TObject);
    procedure SBtnRePrintLabelClick(Sender: TObject);
    procedure CBBCardPrinterChange(Sender: TObject);
    procedure cxTVFullCarDataControllerFilterBeforeChange(
      Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
      const AFilterText: String);
  private
    { Private declarations }
    GWaitPaintCarNo, GSrcDepartment, GDestDepartment, GMaterialQuality, GGFID, GJodNo, GShade : String;//限制变量，待打印车号, 源部门、品名、排单、色级
    printer : TPrinterOption;

    procedure init;                                                             //初始化窗体
    //function GetQueryData(aProcedureName : String; sql : WideString) : OleVariant; //查询语句
    procedure GetGIDepartmentList;                                              //获取GI子部门列表
    procedure GetFullCarData;                                                   //获取满车数据

    procedure Move(srcCDS, destCDS : TClientDataSet; fieldName, aValue : String);//数据移动，将一条源CDS的数据添加到目标CDS，并删除源CDS的数据
    function add : Boolean;                                                     //CDSFullCar 的数据移动到 CDSWaitPrintCard
    procedure cancel;                                                           //CDSWaitPrintCard 的数据移动到 CDSFullCar
    procedure BatchAdd ;                                                        //批量将CDSFullCar 的数据移动到 CDSWaitPrintCard
    procedure BatchCancel;                                                      //批量将CDSWaitPrintCard 的数据移动到 CDSFullCar
    function GetFieldValueString(aCDS : TClientDataSet; aField, aSeparate : String; var count : Integer) : String;//获取指定CDS的指定字段，并根据指定字符进行分割
    procedure SetPrinterList;                                                   //设置打印机列表
    procedure Print;                                                            //打卡打标签
    function CheckIsHold(fabricNOList : String) : Boolean;                      //打卡打标签前检查打印布是否被Hold
    function SynchronizationCheck(fabricNOList : String) : Boolean;             //数据同步性检查

//打卡
    function PrintCard(fabricNOList : string; isPreview : Boolean) : String;
    //保存打卡数据并返回新的后整卡号
    function SavePrintCardInfoByGI(fabricNOList, CarNO, SrcDep, Operator: string; IsCutCloth : Integer) : String;
//打标签
    function PrintReportLabel(aDepartment, fabricNOList : string; isPreview : Boolean) : Boolean;
    //更新坯布验布主表打标签标识
    function UpdatePrintReportLabelFlag(aDepartment, fabricNOList : string) : Boolean;
//打卡、打标签完毕后更新满车记录表的打卡时间 和缝标签、缝头的产量、参数(卡号，目标部门，布号列表，品名ID，排单号，色级，打标签数量，打卡数量)
    function UpdatePrintCardTime(fnCard, aDest_Department, fabricNOList, aGfID, aJobNO, aShade : String; LabCount, CardCount : Integer) : Boolean; overload;
    //布号列表，源部门、目标部门，操作人ID、是否首落布，打标签数量，打卡数量
    function UpdatePrintCardTime(fabricNOList, aSrc_Dep, OperatorID : String; IsCutCloth, LabCount, CardCount : Integer) : String; overload;

//根据打卡打标签返回信息，判断是否已经满车并给出提示
    procedure PrintReturnMessage(aCds : TClientDataSet);
    //检查是否有不同的品名
    function IsDiverse(aCds : TClientDataSet; checkFieldName : array of String) : Boolean;

//重打标签
    procedure QueryRePrintLabel;
    procedure RePrintLabel;
    function GetRePrintLabelData : Boolean;
  public
    { Public declarations }
  end;

var
  PrintFNCardAndLabelFrom: TPrintFNCardAndLabelFrom;

implementation

uses uGlobal, uDictionary, ServerDllPub, uShowMessage, uGridDecorator, frmMain,
  rptFNCard, uLogin, rptGIReportLabel;

{$R *.dfm}

procedure TPrintFNCardAndLabelFrom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TPrintFNCardAndLabelFrom.FormDestroy(Sender: TObject);
begin
  PrintFNCardAndLabelFrom := nil;
end;

procedure TPrintFNCardAndLabelFrom.init;
begin
  SBtnAdd.Glyph.LoadFromResourceName(HInstance, RES_DOWN);
  SBtnAll.Glyph.LoadFromResourceName(HInstance, RES_DOWNALL);
  SBtnCancel.Glyph.LoadFromResourceName(HInstance, RES_UP);
  SBtnEmpty.Glyph.LoadFromResourceName(HInstance, RES_UPALL);
  SBtnRefresh.Glyph.LoadFromResourceName(HInstance, RES_REFRESH);

  SBtnPrint.Glyph.LoadFromResourceName(HInstance, RES_PRINT);
  SBtnExit.Glyph.LoadFromResourceName(HInstance, RES_EXIT);

  SBtnQueryReLab.Glyph.LoadFromResourceName(HInstance, RES_QUERY);
  SBtnRePrintLabel.Glyph.LoadFromResourceName(HInstance, RES_PRINT);

  CBAll.Checked := True;
  chkPreviewLabel.Checked := false;
  chkPreviewCard.Checked := false;

  SBtnRePrintLabel.Enabled := False;

  //TGlobal.FillComboBoxFromDataSet(Dictionary.cds_DepartmentList,'Department','Description','->', CbbCurrentDept);
  //CbbCurrentDept.Text := FNMMainForm.cbbCurrentDept.Text;

  //获取源部门列表
  GetGIDepartmentList;
  //设置打印机类
  printer := TPrinterOption.Create;
  SetPrinterList;

  cxTVWaitPrintCard.OptionsCustomize.ColumnFiltering := False;//禁止待打印网格进行字段过滤功能
end;

procedure TPrintFNCardAndLabelFrom.GetGIDepartmentList;
var
  sErrorMsg : WideString;
  vData : OleVariant;
begin
  {
  CDSRePrintLabel.Close;
  FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', 'GetGIDepartmentList,' + QuotedStr(''), sErrorMsg);

  if Trim(sErrorMsg) <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;//if

  CDSRePrintLabel.Data := vData;
  if (CDSRePrintLabel.Active) and (CDSRePrintLabel.RecordCount > 0 ) then
  begin
    TGlobal.FillItemsFromDataSet(CDSRePrintLabel, 'Department', '', '', CBBSrcDepartment.Items);
    CBBSrcDepartment.Items.Insert(0, 'ALL');
    TGlobal.FillItemsFromDataSet(CDSRePrintLabel, 'Department', '', '', CBBRePSrcDepartment.Items);
    CDSRePrintLabel.Close;
  end;//if
  }
  CBBSrcDepartment.Items.Add('ALL');
  CBBSrcDepartment.Items.Add('G1');
  CBBSrcDepartment.Items.Add('G2');
  CBBSrcDepartment.Items.Add('G3');
  CBBSrcDepartment.ItemIndex := 0;
  CBBRePSrcDepartment.Items := CBBSrcDepartment.Items;
  CBBRePSrcDepartment.Items.Delete(0);
end;


procedure TPrintFNCardAndLabelFrom.GetFullCarData;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  try
    if CBBSrcDepartment.Text = '' then
      Exit;
      
    ShowMsg('正在获取数据稍等!', crHourGlass);
    //copy(FNMMainForm.cbbCurrentDept.Text, 1, pos('->', FNMMainForm.cbbCurrentDept.Text) - 1);
    GWaitPaintCarNo := '';
    GSrcDepartment := '';
    GDestDepartment := '';
    GMaterialQuality := '';
    GGFID := '';
    GJodNo := '';
    GShade := '';

    //if CBAll.Checked then
      //sql := QuotedStr('ALL');
    //else
    //  sql := QuotedStr('NotAll');
    sql := QuotedStr(Login.LoginID) + ',' + QuotedStr(CBBSrcDepartment.Text) + ',' + QuotedStr(Login.CurrentDepartment);  //类型,来源部门, 当前登录部门

    FNMServerObj.GetQueryData(vData,'PrintCardAndLabelInfoByGI', sql, sErrorMsg);

    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if

    if CDSFullCar.Active then
      CDSFullCar.Close;
    CDSFullCar.Data := vData;
    if (CDSFullCar.Active) and (CDSFullCar.IsEmpty) then
    begin
      TMsgDialog.ShowMsgDialog('没有已满车待打卡的坯布数据', 2);
      Exit;
    end;//if

    //复制表结构
    if CDSFullCar.RecordCount > 0 then
    begin
      if CDSWaitPrintCard.Active then
      begin
        CDSWaitPrintCard.Edit;
        CDSWaitPrintCard.ClearFields;
        CDSWaitPrintCard.Close;
      end;
      CDSWaitPrintCard.FieldDefs := CDSFullCar.FieldDefs;
      CDSWaitPrintCard.CreateDataSet;
    end;//if

    GridDecorator.BindCxViewWithDataSource(cxTVFullCar, DSFullCar);
    GridDecorator.BindCxViewWithDataSource(cxTVWaitPrintCard, DSWaitPrintCard);
    //GridDecorator.HideFields(cxTVFullCar,['GF_ID','Is_Cut_Cloth','Is_Hold','WV_IsFinished','Src_Department','Dest_Department']);
    //GridDecorator.HideFields(cxTVWaitPrintCard,['GF_ID','Is_Cut_Cloth','Is_Hold','WV_IsFinished','Src_Department','Dest_Department']);
    GridDecorator.HideFields(cxTVFullCar,['GF_ID','Is_Cut_Cloth','Is_Hold','WV_IsFinished','MaterialType']);
    GridDecorator.HideFields(cxTVWaitPrintCard,['GF_ID','Is_Cut_Cloth','Is_Hold','WV_IsFinished','MaterialType']);

    CDSFullCar.IndexFieldNames := 'Car_NO;Fabric_NO';
    CDSFullCar.First;
  finally
    ShowMsg('', crDefault);
  end;//finally
end;

procedure TPrintFNCardAndLabelFrom.FormShow(Sender: TObject);
begin
  inherited;
  init;
end;

procedure TPrintFNCardAndLabelFrom.SBtnRefreshClick(Sender: TObject);
begin
  inherited;
  GetFullCarData;
end;

procedure TPrintFNCardAndLabelFrom.SBtnExitClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TPrintFNCardAndLabelFrom.Move(srcCDS, destCDS : TClientDataSet; fieldName, aValue : String);
var
  i: Integer;
  //fn : string;
begin
  if (srcCDS.Active) and (srcCDS.RecordCount > 0) and (destCDS.Active) then
  begin
    if (srcCDS.Locate(fieldName, aValue, [])) and (not destCDS.Locate(fieldName, aValue, [])) then
    begin
      destCDS.Append;
      for i := 0 to srcCDS.FieldList.Count - 1 do
      begin
          destCDS.Fields.Fields[i].Value := srcCDS.Fields.Fields[i].Value;
      end;//for
      destCDS.Post;
    end;//if
    srcCDS.Delete;
  end;//if
end;

function TPrintFNCardAndLabelFrom.add : Boolean;
begin
  Result := False;
  if CDSFullCar.FieldByName('Is_Car_Full').AsString = 'N' then //如果满车标识为N，则不能选择
    Exit;

  GWaitPaintCarNo := CDSFullCar.FieldByName('Car_NO').AsString;
  GSrcDepartment := CDSFullCar.FieldByName('Current_Department').AsString;
  GDestDepartment := CDSFullCar.FieldByName('Dest_Department').AsString;
  GMaterialQuality := CDSFullCar.FieldByName('Material_Quality').AsString;
  GGFID := CDSFullCar.FieldByName('GF_ID').AsString;
  GJodNo := CDSFullCar.FieldByName('Job_No').AsString;
  GShade := CDSFullCar.FieldByName('Shade').AsString;

  Move(CDSFullCar, CDSWaitPrintCard, 'Fabric_NO', CDSFullCar.FieldByName('Fabric_NO').AsString);
  Result := True;
end;

procedure TPrintFNCardAndLabelFrom.cancel;
begin
  if CDSWaitPrintCard.IsEmpty then
    Exit;
  Move(CDSWaitPrintCard, CDSFullCar, 'Fabric_NO', CDSWaitPrintCard.FieldByName('Fabric_NO').AsString);
  if CDSWaitPrintCard.RecordCount = 0 then
  begin
    GWaitPaintCarNo := '';
    GSrcDepartment := '';
    GDestDepartment := '';
    GMaterialQuality := '';
    GGFID := '';
    GJodNo := '';
    GShade := '';
  end;//if
end;

procedure TPrintFNCardAndLabelFrom.BatchAdd;
var
  fabricNO, car_No : string;
  filterStr : String;
begin
  //MaterialType 布料类型字段 0 为正常布、 1为试样布、 2为处理布
  if CDSFullCar.FieldByName('MaterialType').AsInteger = 0 then
  begin
    //防止处理布与正常布为同类型布
    if(CDSWaitPrintCard.RecordCount > 0) and (CDSWaitPrintCard.FieldByName('MaterialType').AsInteger > 0) then
      Exit;

    if (GWaitPaintCarNo <> '') or (GSrcDepartment <> '') or (GDestDepartment <> '') or (GMaterialQuality <> '')
      or (GGFID <> '') or (GJodNo <> '') or (GShade <> '') then //检查是否同车、同源部门
      if (GWaitPaintCarNo <> CDSFullCar.FieldByName('Car_NO').AsString)
        or (GSrcDepartment <> CDSFullCar.FieldByName('Current_Department').AsString)
        or (GDestDepartment <> CDSFullCar.FieldByName('Dest_Department').AsString)
        or (GMaterialQuality <> CDSFullCar.FieldByName('Material_Quality').AsString)
        or (GGFID <> CDSFullCar.FieldByName('GF_ID').AsString)
        or (GJodNo <> CDSFullCar.FieldByName('Job_No').AsString)
        or (GShade <> CDSFullCar.FieldByName('Shade').AsString) then
          Exit;
    try
      CDSFullCar.DisableControls;
      filterStr := CDSFullCar.Filter; //记录原过滤条件

      CDSFullCar.Filter := 'Car_No = ' + QuotedStr(CDSFullCar.FieldByName('Car_No').AsString) +
                            ' and GF_ID = ' + QuotedStr(CDSFullCar.FieldByName('GF_ID').AsString) +
                            ' and Job_No = ' + QuotedStr(CDSFullCar.FieldByName('Job_No').AsString) +
                            ' and Shade = ' + QuotedStr(CDSFullCar.FieldByName('Shade').AsString);
      CDSFullCar.Filtered := True;
      CDSFullCar.First;

      fabricNO := CDSFullCar.FieldByName('Fabric_NO').AsString;

      CDSFullCar.Filtered := False;
      CDSFullCar.Filter := '';
      CDSFullCar.Locate('Fabric_NO', fabricNO, []);
      while not CDSFullCar.Eof do
      begin
        if not add then
          CDSFullCar.Next;

        if (GWaitPaintCarNo <> CDSFullCar.FieldByName('Car_NO').AsString)
          or (GSrcDepartment <> CDSFullCar.FieldByName('Current_Department').AsString)
          or (GDestDepartment <> CDSFullCar.FieldByName('Dest_Department').AsString)
          or (GMaterialQuality <> CDSFullCar.FieldByName('Material_Quality').AsString)
          or (GGFID <> CDSFullCar.FieldByName('GF_ID').AsString)
          or (GJodNo <> CDSFullCar.FieldByName('Job_No').AsString)
          or (GShade <> CDSFullCar.FieldByName('Shade').AsString) then
          Break;
      end;//while
    finally
      if filterStr <> '' then
      begin
        CDSFullCar.Filtered := False;
        CDSFullCar.Filter := filterStr;
        CDSFullCar.Filtered := True;
      end;//if
      CDSFullCar.EnableControls;
    end;
  end
  else if (CDSFullCar.FieldByName('MaterialType').AsInteger = 1)
      or(CDSFullCar.FieldByName('MaterialType').AsInteger = 2) then
  begin
    if CDSWaitPrintCard.Active then
    begin  //试样布、处理布以布号为单位进行打卡
      if (CDSFullCar.FieldByName('IsHold').AsString = 'N') and (CDSWaitPrintCard.RecordCount = 0) then
        add;
    end;//if
  end;//else
end;

procedure TPrintFNCardAndLabelFrom.BatchCancel;
begin
  CDSWaitPrintCard.First;
  while not CDSWaitPrintCard.Eof do
    cancel;
end;

function TPrintFNCardAndLabelFrom.GetFieldValueString(aCDS: TClientDataSet; aField, aSeparate: String; var count : Integer): String;
var
  i : Integer;
begin
  Result := '';
  if (aField = '') or (aSeparate = '') then
    Exit;

  if(aCDS.Active) and (aCDS.RecordCount > 0) then
  begin
    i := 0;
    aCDS.First;
    while not aCDS.Eof do
    begin
      Result := Result + CDSWaitPrintCard.FieldByName(aField).AsString + aSeparate;
      aCDS.Next;
      Inc(i);
    end;//while
    count := i;
  end;//if
end;

procedure TPrintFNCardAndLabelFrom.cxTVFullCarDblClick(Sender: TObject);
begin
  inherited;
  //add;
  BatchAdd;
end;

procedure TPrintFNCardAndLabelFrom.cxTVWaitPrintCardDblClick(
  Sender: TObject);
begin
  inherited;
  //cancel;
  BatchCancel;
end;

procedure TPrintFNCardAndLabelFrom.SBtnAllClick(Sender: TObject);
begin
  inherited;
  BatchAdd;
end;

procedure TPrintFNCardAndLabelFrom.SBtnCancelClick(Sender: TObject);
begin
  inherited;
  //cancel;
  BatchCancel;
end;

procedure TPrintFNCardAndLabelFrom.SBtnEmptyClick(Sender: TObject);
begin
  inherited;
  BatchCancel;
end;

procedure TPrintFNCardAndLabelFrom.SBtnAddClick(Sender: TObject);
begin
  inherited;
  //add;
  BatchAdd;
end;

procedure TPrintFNCardAndLabelFrom.Print;
var
  fabricNOList, fnCard : String;
  labelCount, cardCount : Integer; //打标签、打卡数量

  //打卡2
  carNo ,srcDep : string;
  IsCutCloth : Integer;
begin
  if (CDSWaitPrintCard.Active) and (CDSWaitPrintCard.RecordCount > 0) then
  begin
    if CDSWaitPrintCard.RecordCount > 15 then
    begin
      TMsgDialog.ShowMsgDialog('本次打卡布的数量超过15条，请分车后再打印!', mtWarning);
      Exit;
    end;//if
      
    if IsDiverse(CDSWaitPrintCard, ['GF_NO','Job_No']) then
    begin
      TMsgDialog.ShowMsgDialog('本次打卡数据中含有多于一种的品名，请检查', mtWarning);
      Exit;
    end;//if

    ShowMsg('正在检查数据稍等！', crDefault);
    fabricNOList := GetFieldValueString(CDSWaitPrintCard, 'Fabric_NO', ',', labelCount);
    {if CheckIsHold(fabricNOList) then
    begin
      TMsgDialog.ShowMsgDialog('本次打卡打标签布号中有被Hold的布', mtWarning);
    end
    else}
    //加入数据同步检查
    if SynchronizationCheck(fabricNOList) then
    begin
      try
        ShowMsg('正在处理数据稍等！', crDefault);
        PnlFullCar.Enabled := False;
        pnlWaitPrintCard.Enabled := False;

        CDSWaitPrintCard.DisableControls;
        //组织要打标签的布号串
        //本地过滤掉出未打标签的布号和打标签布号数量
        labelCount := 0;
        CDSWaitPrintCard.Filter := 'isPrintLabel = ' + QuotedStr('N');
        CDSWaitPrintCard.Filtered := True;
        fabricNOList := GetFieldValueString(CDSWaitPrintCard, 'Fabric_NO', ',', labelCount);
        CDSWaitPrintCard.Filtered := False;

        //打标签
        if Trim(fabricNOList) = '' then
        begin
          TMsgDialog.ShowMsgDialog('本次所有布号已打标签', mtInformation);
        end
        else
        begin
          if not PrintReportLabel(CDSWaitPrintCard.FieldByName('Current_Department').AsString, fabricNOList, chkPreviewLabel.Checked) then
            Exit;
        end;//else

        //组织要打卡的布号串和获取打卡布号数量
        cardCount := 0;
        fabricNOList := GetFieldValueString(CDSWaitPrintCard, 'Fabric_NO', ',', cardCount);
        //打卡1
        {fnCard := PrintCard(fabricNOList, chkPreviewCard.Checked);//打印并获取卡号
        if fnCard = '' then
          Exit;
        //更新满车记录表的打卡时间 同时向产量记录表插入记录
        if UpdatePrintCardTime(fnCard,
                Login.CurrentDepartment,
                fabricNOList,
                CDSWaitPrintCard.FieldByName('GF_ID').AsString,
                CDSWaitPrintCard.FieldByName('Job_NO').AsString,
                CDSWaitPrintCard.FieldByName('Shade').AsString,
                labelCount, cardCount) then
        begin
          TMsgDialog.ShowMsgDialog('车号[' + GWaitPaintCarNo + ']打印完毕！', mtInformation);
          PrintReturnMessage(CDSPrintReturn); //根据返回值，判断是否已经满车并给出提示
          CDSWaitPrintCard.EmptyDataSet;    //清空本地待打卡记录
          //清空限制变量
          GWaitPaintCarNo := '';
          GSrcDepartment := '';
          GGFID := '';
          GJodNo := '';
          GShade := '';
        end;//if }

        //打卡2
        carNo := CDSWaitPrintCard.FieldByName('Car_No').AsString;
        srcDep := CDSWaitPrintCard.FieldByName('Current_Department').AsString;
        IsCutCloth := CDSWaitPrintCard.FieldByName('Is_Cut_Cloth').AsInteger;

        //布号列表，源部门、操作人ID、是否首落布，打标签数量，打卡数量
        fnCard := UpdatePrintCardTime(fabricNOList, srcDep, Login.LoginID, IsCutCloth, labelCount, cardCount);

        //获取卡号失败就会为空，则停止打卡
        if Trim(fnCard) <> '' then
        begin
          rptFNCard.PrintFNCard(fnCard, carNo, 2, chkPreviewCard.Checked);//打卡

          TMsgDialog.ShowMsgDialog('车号[' + GWaitPaintCarNo + ']打印完毕！', mtInformation);
          PrintReturnMessage(CDSPrintReturn); //根据返回值，判断是否已经满车并给出提示
          CDSWaitPrintCard.MergeChangeLog;
          CDSWaitPrintCard.EmptyDataSet;    //清空本地待打卡记录
          //清空限制变量
          GWaitPaintCarNo := '';
          GSrcDepartment := '';
          GDestDepartment := '';
          GMaterialQuality := '';
          GGFID := '';
          GJodNo := '';
          GShade := '';
        end;//if Trim(fnCard)
      finally
        CDSWaitPrintCard.EnableControls;
        PnlFullCar.Enabled := True;
        pnlWaitPrintCard.Enabled := True;
        ShowMsg('', crDefault);
      end;//finally
    end;//if
  end;//if
end;

function TPrintFNCardAndLabelFrom.PrintCard(fabricNOList : string; isPreview : Boolean) : string;
var
  carNo, fnCard ,srcDep : string;
  IsCutCloth : Integer;
begin
  Result := '';
  if (CDSWaitPrintCard.Active) and (CDSWaitPrintCard.RecordCount > 0) then
  begin
    //获取当前待打卡布的车号
    carNo := CDSWaitPrintCard.FieldByName('Car_No').AsString;
    srcDep := CDSWaitPrintCard.FieldByName('Current_Department').AsString;
    IsCutCloth := CDSWaitPrintCard.FieldByName('Is_Cut_Cloth').AsInteger;
    //保存打卡数据并获取后整卡号
    fnCard := SavePrintCardInfoByGI(fabricNOList, carNo, srcDep, Login.LoginName, IsCutCloth);

    //获取卡号失败就会为空，则停止打卡
    if Trim(fnCard) <> '' then
    begin
      //rptFNCard.FNCardReport.qrFNCard.PrinterSettings.PrinterIndex := CBBCardPrinter.ItemIndex;
      rptFNCard.PrintFNCard(fnCard, carNo, 2, isPreview);//打卡
      Result := fnCard;
    end;//if
  end;//if
end;

function TPrintFNCardAndLabelFrom.SavePrintCardInfoByGI(fabricNOList, CarNO, SrcDep, Operator: string; IsCutCloth : Integer): string;
var
  sql, rFN_Card, sErrorMsg : WideString;
begin
  Result := '';
  sql := QuotedStr(fabricNOList) + ',' + QuotedStr(CarNO) + ',' + QuotedStr(SrcDep) + ',' +IntToStr(IsCutCloth) +  ',' + QuotedStr(Operator);

  FNMServerObj.SaveDataBySQLEx('SavePrintCardInfoByGI', sql, rFN_Card, sErrorMsg);
  if Trim(sErrorMsg) <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;//if
  Result := rFN_Card;
end;

function TPrintFNCardAndLabelFrom.UpdatePrintCardTime(fnCard, aDest_Department, fabricNOList, aGfID, aJobNO, aShade : String;
  LabCount, CardCount : Integer) : Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  if fabricNOList <> '' then
  begin
    //存储过程中的 UpdateFNPrintCardTime 段程序会更新不同车、未打卡的同品名、同排单、同色级的布数据
    sql := QuotedStr('UpdateFNPrintCardTime') + ','
      + QuotedStr(aDest_Department + '|' + Login.LoginID + '|' + fnCard + '|' + fabricNOList + '|' +
                IntToStr(LabCount) + '|' + IntToStr(CardCount));
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if
    Result := True;
  end;//if
end;

function TPrintFNCardAndLabelFrom.PrintReportLabel(aDepartment, fabricNOList : string; isPreview : Boolean) : Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  if (aDepartment = '') or (fabricNOList = '') then
    Exit;

  if UpdatePrintReportLabelFlag(aDepartment, fabricNOList) then
  begin
    sql := QuotedStr('GetPrintLabelInfo') + ',' + QuotedStr(aDepartment + '|' + fabricNOList);
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);

    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg + #13#10+'打印热溶标签失败，请重试！',mtWarning);
      Exit;
    end;//if

    if not Assigned(GIReportLabelForm) then
       GIReportLabelForm := TGIReportLabelForm.Create(self);
    //设置打印机
    GIReportLabelForm.qkrpLabel.PrinterSettings.PrinterIndex := CBBLabelPrinter.ItemIndex;

    with GIReportLabelForm do
    begin
      CDS_Report.Data := vData;
      qkrpLabel.Refresh;
      qkrpLabel.Prepare;
      if isPreview then
        qkrpLabel.Preview
      else
        qkrpLabel.Print;
    end;//whit
    Result := True;
  end;//if
end;

function TPrintFNCardAndLabelFrom.UpdatePrintReportLabelFlag(aDepartment, fabricNOList: string): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  if fabricNOList <> '' then
  begin
    sql := QuotedStr('UpdatePrintLabelData') + ',' + QuotedStr(aDepartment + '|' + fabricNOList);
    FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if
    Result := True;
  end;//if
end;

procedure TPrintFNCardAndLabelFrom.RePrintLabel;
var
  fabricNOList : String;
begin
  if (CDSRePrintLabel.Active) and (CDSRePrintLabel.RecordCount > 0) then
  begin
    if not Assigned(GIReportLabelForm) then
      GIReportLabelForm := TGIReportLabelForm.Create(self);

    with GIReportLabelForm do
    begin
      qkrpLabel.PrinterSettings.PrinterIndex := CBBLabelPrinter.ItemIndex; //设置打印机
      CDS_Report.Data := CDSRePrintLabel.Data;
      qkrpLabel.Refresh;
      qkrpLabel.Prepare;
      qkrpLabel.Print;
    end;//whit
    TMsgDialog.ShowMsgDialog('重打标签完成', mtInformation);
    //请看打卡记录
    CDSRePrintLabel.EmptyDataSet;
  end;//if
end;

procedure TPrintFNCardAndLabelFrom.QueryRePrintLabel;
begin
  if GetRePrintLabelData then
    SBtnRePrintLabel.Enabled := True
  else
    SBtnRePrintLabel.Enabled := False;
end;

function TPrintFNCardAndLabelFrom.GetRePrintLabelData: Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  if Trim(CBBRePSrcDepartment.Text) = '' then
    Exit;

  sql := Trim(MSQLRePrint.GetSql);
  if sql = '' then
    Exit;
  //由于要组织SQL语句，所以在存储过程中是将条件加起来，这里需将条件中的''，更为为''''
  sql := StringReplace(sql,'''', '''''',[rfReplaceAll]);
  sql := QuotedStr('GetRePrintLabelInfo') + ',''' + Trim(CBBRePSrcDepartment.Text) + '|' + sql + '''';

  FNMServerObj.GetQueryData(vData,'GiFullCarFabricsData', sql, sErrorMsg);
  if Trim(sErrorMsg) <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;//if

  if CDSRePrintLabel.Active then
   CDSRePrintLabel.Close;
  CDSRePrintLabel.Data := vData;
  GridDecorator.BindCxViewWithDataSource(cxTVPrintLabel, DSRePrintLabel);
  
  Result := true;
end;

procedure TPrintFNCardAndLabelFrom.SBtnQueryReLabClick(Sender: TObject);
begin
  inherited;
  QueryRePrintLabel;
end;

procedure TPrintFNCardAndLabelFrom.cxTVFullCarCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  //如果已打过标签，则显示为绿色
  //if AViewInfo.GridRecord.DisplayTexts[cxTVFullCar.GetColumnByFieldName('isPrintLabel').Index] = '1' then
  //如果没有标准工艺
  if AViewInfo.GridRecord.DisplayTexts[cxTVFullCar.GetColumnByFieldName('ExistFnStdArt').Index] = 'N' then
  begin
    ACanvas.Brush.Color := $0080FFFF;//$0080FF80;
    ACanvas.Font.Color := clBlack;
  end;
end;

procedure TPrintFNCardAndLabelFrom.SBtnPrintClick(Sender: TObject);
begin
  inherited;
  Print;
end;

procedure TPrintFNCardAndLabelFrom.SBtnRePrintLabelClick(Sender: TObject);
begin
  inherited;
  RePrintLabel;
end;

procedure TPrintFNCardAndLabelFrom.PrintReturnMessage(aCds: TClientDataSet);
begin
  //Iden INT, Quantity NUMERIC(9,2), IsOut BIT
  if(aCds.Active) and (aCds.RecordCount > 0) then
  begin
    if aCds.FieldByName('IsOut').AsBoolean then
       TMsgDialog.ShowMsgDialog('当前布车[' + GWaitPaintCarNo + ']已经满车', mtInformation);
  end;//if
end;

procedure TPrintFNCardAndLabelFrom.SetPrinterList;
begin
  CBBCardPrinter.Items := printer.GetPrinters;
  CBBCardPrinter.ItemIndex := printer.GetDefaultPrinterIndex;
  CBBCardPrinter.Hint := '打卡所用打印机为默认打印机';
  CBBCardPrinter.ShowHint := True;

  CBBLabelPrinter.Items := printer.GetPrinters;
  CBBLabelPrinter.ItemIndex := 1;
  CBBLabelPrinter.Hint := '打标签所用打印机为第二台打印机';
  CBBLabelPrinter.ShowHint := True;
end;

procedure TPrintFNCardAndLabelFrom.CBBCardPrinterChange(Sender: TObject);
begin
  inherited;
  printer.SetDefaultPrinter(TComboBox(Sender).ItemIndex);
end;

function TPrintFNCardAndLabelFrom.IsDiverse(aCds: TClientDataSet; checkFieldName : array of String): Boolean;
var
  aValue : array of String;
  i : Integer;
begin
  Result := false;
  if (aCds.Active) and (aCds.RecordCount > 0) then
  begin
    SetLength(aValue, Length(checkFieldName));
    try
      aCds.DisableControls;
      aCds.First;
      while not aCds.Eof do
      begin
        for i := 0 to Length(checkFieldName) - 1 do
        begin
          if Trim(checkFieldName[i]) <> '' then
          if aValue[i] <> '' then
          begin
            if aValue[i] <> aCds.FieldByName(checkFieldName[i]).AsString then
            begin
              Result := true;
              Break;
            end;//if
          end else
            aValue[i] := aCds.FieldByName(checkFieldName[i]).AsString;
        end;//for
        aCds.Next;
      end;//while
    finally
      aCds.EnableControls;
    end;//finally
  end;//if
end;

procedure TPrintFNCardAndLabelFrom.cxTVFullCarDataControllerFilterBeforeChange(
  Sender: TcxDBDataFilterCriteria; ADataSet: TDataSet;
  const AFilterText: String);
begin
  inherited;
  if AFilterText <> '' then
  begin
    if Pos('= TRUE', UpperCase(AFilterText)) > 0 then
      ADataSet.Filter := Stringreplace(UpperCase(AFilterText), '= TRUE', '<> FALSE', [rfReplaceAll])
    else
      ADataSet.Filter := AFilterText;
    ADataSet.Filtered := True;
    ADataSet.First;
  end
  else
  begin
    ADataSet.Filtered := False;
    ADataSet.Filter := '';
  end;//else}
end;

//function TPrintFNCardAndLabelFrom.UpdatePrintCardTime(fabricNOList, aSrc_Dep, dest_Dep, Operator : String;
//  IsCutCloth, LabCount, CardCount, IsTransit : Integer): String;
function TPrintFNCardAndLabelFrom.UpdatePrintCardTime(fabricNOList, aSrc_Dep, OperatorID : String; IsCutCloth, LabCount, CardCount : Integer): String;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
  cds : TClientDataSet;
begin
  Result := '';
  if fabricNOList <> '' then
  begin
    cds := TClientDataSet.Create(nil);
    try
      //存储过程中的 UpdateFNPrintCardTime 段程序会更新不同车、未打卡的同品名、同排单、同色级的布数据
      sql := QuotedStr('UpdateFNPrintCardTime') + ','
            + QuotedStr(fabricNOList + '|' + aSrc_Dep + '|'
            + IntToStr(IsCutCloth) + '|' + IntToStr(LabCount) + '|' + IntToStr(CardCount) + '|'
            + OperatorID);

      FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', sql, sErrorMsg);
      if Trim(sErrorMsg) <> '' then
      begin
        TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
        Exit;
      end;//if
      cds.Data := vData;
      if (cds.Active) and (cds.RecordCount > 0) then
        Result := cds.FieldByName('fnCard').AsString;
    finally
      if Assigned(cds) then
      begin
        cds.Close;
        FreeAndNil(cds);
      end;//if
    end;//fianlly
  end;//if
end;

function TPrintFNCardAndLabelFrom.CheckIsHold(fabricNOList : String): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
  cds : TClientDataSet;
begin
  Result := False;
  cds := TClientDataSet.Create(nil);
  try
    sql := QuotedStr('CheckIsHold') + ',' + QuotedStr(fabricNOList);
    FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', sql, sErrorMsg);
    if Trim(sErrorMsg) <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
      Exit;
    end;//if
    cds.Data := vData;
    if (cds.Active) and (cds.RecordCount > 0) then
      Result := cds.FieldByName('IsHold').AsBoolean;
  finally
    if Assigned(cds) then
    begin
      cds.Close;
      FreeAndNil(cds);
    end;//if
  end;//finally
end;

function TPrintFNCardAndLabelFrom.SynchronizationCheck(fabricNOList: String): Boolean;
var
  sql, sErrorMsg : WideString;
  vData : OleVariant;
begin
  Result := False;
  sql := QuotedStr('SynchronizationCheckForPrintCard') + ',' + QuotedStr(fabricNOList);
  FNMServerObj.GetQueryData(vData, 'GiFullCarFabricsData', sql, sErrorMsg);
  if Trim(sErrorMsg) <> '' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg, mtError);
    Exit;
  end;//if
  Result := True;
end;

end.


