unit frmMachineRules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, DB, cxDBData, StdCtrls, cxGridLevel, cxClasses,
  cxControls, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, DBClient;

type
  TMachineRulesForm = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox3: TGroupBox;
    cbMachine: TComboBox;
    cbMode: TComboBox;
    white_type_t: TCheckBox;
    white_type_s: TCheckBox;
    white_type_p: TCheckBox;
    white_type_b: TCheckBox;
    Degree_24: TCheckBox;
    spring_y: TCheckBox;
    spring_n: TCheckBox;
    cb_MC: TCheckBox;
    cb_ETI: TCheckBox;
    cb_AP: TCheckBox;
    MM_y: TCheckBox;
    MM_n: TCheckBox;
    Royal_n: TCheckBox;
    sm_n: TCheckBox;
    roll_y: TCheckBox;
    roll_n: TCheckBox;
    cxgrdCondition: TcxGrid;
    cxgdtvCondition: TcxGridDBTableView;
    cxgrdlvlCondition: TcxGridLevel;
    lblContents: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Degree_18: TCheckBox;
    Royal_y: TCheckBox;
    sm_y: TCheckBox;
    Label3: TLabel;
    GroupBox2: TGroupBox;
    cdsCondition: TClientDataSet;
    dsCondition: TDataSource;
    btnSave: TButton;
    Label4: TLabel;
    Button1: TButton;
    cbOthers: TCheckBox;
    cb_0: TCheckBox;
    cb_1000: TCheckBox;
    cb_10000: TCheckBox;
    cb_25000: TCheckBox;
    cb_40000: TCheckBox;
    cb_max: TCheckBox;
    white_type_cpbb: TCheckBox;
    cb_60000: TCheckBox;
    cb_TQ: TCheckBox;
    cb_OR: TCheckBox;
    cb_RD: TCheckBox;
    cb_GN: TCheckBox;
    CheckBox1: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure cbModeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function CombinCondition():string;
    procedure QueryData();
    procedure ClearControls();
    procedure SetControls();
    procedure ShowCondition();
    procedure btnSaveClick(Sender: TObject);
    procedure cbMachineChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure AutoPlan();
  private
    { Private declarations }
    sConditions,sMode:string;

  public
    { Public declarations }
  end;

var
  MachineRulesForm: TMachineRulesForm;

procedure FillAllOperationToItems(Department: String; AItems: TStrings);


implementation

uses
  StrUtils, Math, frmMachineSample, uAppOption, uGlobal, uShowMessage, 
     ServerDllPub, uCADInfo, uDictionary, uLogin, uGridDecorator;
{$R *.dfm}

procedure FillAllOperationToItems(Department: String; AItems: TStrings);
begin
  with Dictionary do
  try
    with cds_FinishMachineList do
    begin
      Filter := 'Department ='+ QuotedStr(Department) + ' AND Machine_ID LIKE ''MC%'' ';
      Filtered := True;
      TGlobal.FillItemsFromDataSet(cds_FinishMachineList, 'Machine_ID', 'Machine_Model_CHN', '->', AItems);
    end;
  finally
    cds_FinishMachineList.Filtered:=false;
  end;
end;

function TMachineRulesForm.CombinCondition():string;
var
  sContion,sContionAfter,sConditionAND,sContion1,sContion2,sContion3,sContion4,sContion5,sContion6,sContion7,sContion8,sContion9,sContion10 :string;
  //sOperator1,sOperator2,sOperator3,sOperator4,sOperator5,sOperator6,sOperator7,sOperator8:string;
  sWhitType:string;
begin
  //特漂白
  if white_type_t.Checked then
    sContion1 := sContion1 + ' OR White_Type = ''特白''';
  if white_type_s.Checked then
    sContion1 := sContion1 + ' OR White_Type = ''少荧''';
  if white_type_p.Checked then
    sContion1 := sContion1 + ' OR White_Type = ''漂白''';
  if white_type_b.Checked then
    sContion1 := sContion1 + ' OR (White_Type = ''本白'' AND GF_NO NOT LIKE ''PD%'')';
  if white_type_cpbb.Checked then
    sContion1 := sContion1 + ' OR (White_Type = ''本白'' AND GF_NO LIKE ''PD%'')';

  //碱浓
  if Degree_18.Checked then
    sContion2 := sContion2 + ' OR Degree = ''18''';
  if Degree_24.Checked then
    sContion2 := sContion2 + ' OR Degree = ''24''';

  //特殊色
  if cb_TQ.Checked then
    sContion10 := sContion10 + ' OR TQOR = ''TQ''';
  if cb_OR.Checked then
    sContion10 := sContion10 + ' OR TQOR = ''OR''';
  if cb_RD.Checked then
    sContion10 := sContion10 + ' OR TQOR = ''RD''';
  if cb_GN.Checked then
    sContion10 := sContion10 + ' OR TQOR = ''GN''';

  //弹力布
  if spring_y.Checked then
    sContion3 := sContion3 + ' OR spring = 1';
  if spring_n.Checked then
    sContion3 := sContion3 + ' OR spring = 0';
  //MC ETI AP
  if cb_MC.Checked then
    sContion4 := sContion4 + ' OR sType = ''MC''';
  if cb_ETI.Checked then
    sContion4 := sContion4 + ' OR sType = ''ETI''';
  if cb_AP.Checked then
    sContion4 := sContion4 + ' OR sType = ''AP''';
  if cbOthers.Checked then
    sContion4 := sContion4 + ' OR sType = ''''';
  //磨毛
  if MM_y.Checked then
    sContion5 := sContion5 + ' OR MM = 1';
  if MM_n.Checked then
    sContion5 := sContion5 + ' OR MM = 0';
  //液氨
  if Royal_y.Checked then
    sContion6 := sContion6 + ' OR Royal = 1';
  if Royal_n.Checked then
    sContion6 := sContion6 + ' OR Royal = 0';
  //前工序是否烧毛
  if sm_y.Checked then
    sContion7 := sContion7 + ' OR sm = 1';
  if sm_n.Checked then
    sContion7 := sContion7 + ' OR sm = 0';
  //普通品种
  if cb_0.Checked then
    sContion8 := sContion8 + ' OR Dosage_Factor between 0 and 1000';
  if cb_1000.Checked then
    sContion8 := sContion8 + ' OR Dosage_Factor between 1001 and 10000';
  if cb_10000.Checked then
    sContion8 := sContion8 + ' OR Dosage_Factor between 10001 and 25000';
  if cb_25000.Checked then
    sContion8 := sContion8 + ' OR Dosage_Factor between 25001 and 40000';
  if cb_40000.Checked then
    sContion8 := sContion8 + ' OR Dosage_Factor between 40001 and 60000';
  if cb_60000.Checked then
    sContion8 := sContion8 + ' OR Dosage_Factor between 60001 and 80000';
  if cb_max.Checked then
    sContion8 := sContion8 + ' OR Dosage_Factor between 80001 and 99999999';

  //卷装
  if roll_y.Checked then
    sContion9 := sContion9 + ' OR Roll = 1';
  if roll_n.Checked then
    sContion9 := sContion9 + ' OR Roll = 0';

  // 逻辑符
//  if ComboBox1.Text = '或' then
//    sOperator1 := '  OR  '
//  else
//    sOperator1 := '  AND ';
//  if ComboBox2.Text = '或' then
//    sOperator2 := '  OR  '
//  else
//    sOperator2 := '  AND ';
//  if ComboBox3.Text = '或' then
//    sOperator3 := '  OR  '
//  else
//    sOperator3 := '  AND ';
//  if ComboBox4.Text = '或' then
//    sOperator4 := '  OR  '
//  else
//    sOperator4 := '  AND ';
//  if ComboBox5.Text = '或' then
//    sOperator5 := '  OR  '
//  else
//    sOperator5 := '  AND ';
//  if ComboBox6.Text = '或' then
//    sOperator6 := '  OR  '
//  else
//    sOperator6 := '  AND ';
//  if ComboBox7.Text = '或' then
//    sOperator7 := '  OR  '
//  else
//    sOperator7 := '  AND ';
//  if ComboBox8.Text = '或' then
//    sOperator8 := '  OR  '
//  else
//    sOperator8 := '  AND ';

  if sContion1 <> '' then
    sContion := sContion +  '  AND (' + MidStr(sContion1,4,Length(sContion1)- 3) + ')';
  
  if (sContion2 <> '') then
    sContion := sContion +  '  AND (' + MidStr(sContion2,4,Length(sContion2)- 3) + ')';
    
  if (sContion10 <> '') then
    sContion := sContion +  '  AND (' + MidStr(sContion10,4,Length(sContion10)- 3) + ')';

  if (sContion3 <> '') and (Pos('= 0',sContion3) > 0) then
    sConditionAND := sConditionAND  + '  AND (' + MidStr(sContion3,4,Length(sContion3)- 3) + ')'
  else if (sContion3 <> '') then
    sContionAfter := sContionAfter  + '  OR  (' + MidStr(sContion3,4,Length(sContion3)- 3) + ')';

  if (sContion4 <> '') and (Pos('= 0',sContion4) > 0) then
    sConditionAND := sConditionAND  + '  AND (' + MidStr(sContion4,4,Length(sContion4)- 3) + ')'
  else if (sContion4 <> '') then
    sContionAfter := sContionAfter  + '  OR  (' + MidStr(sContion4,4,Length(sContion4)- 3) + ')';


  if (sContion5 <> '')  and (Pos('= 0',sContion5) > 0) then
    sConditionAND := sConditionAND  + '  AND (' + MidStr(sContion5,4,Length(sContion5)- 3) + ')'
  else  if (sContion5 <> '') then
    sContionAfter := sContionAfter  + '  OR  (' + MidStr(sContion5,4,Length(sContion5)- 3) + ')';


  if (sContion6 <> '')  and (Pos('= 0',sContion6) > 0) then
    sConditionAND := sConditionAND  + '  AND (' + MidStr(sContion6,4,Length(sContion6)- 3) + ')'
  else if (sContion6 <> '')  then
    sContionAfter := sContionAfter  + '  OR  (' + MidStr(sContion6,4,Length(sContion6)- 3) + ')';


  if (sContion7 <> '')  and (Pos('= 0',sContion7) > 0) then
    sConditionAND := sConditionAND  + '  AND (' + MidStr(sContion7,4,Length(sContion7)- 3) + ')'
  else  if (sContion7 <> '')  then
    sContionAfter := sContionAfter  + '  OR  (' + MidStr(sContion7,4,Length(sContion7)- 3) + ')';


  if (sContion8 <> '')  and (Pos('= 0',sContion8) > 0) then
    sConditionAND := sConditionAND  + '  OR  (' + MidStr(sContion8,4,Length(sContion8)- 3) + ')'
  else if (sContion8 <> '') then
    sContionAfter := sContionAfter  + '  OR  (' + MidStr(sContion8,4,Length(sContion8)- 3) + ')';


  if (sContion9 <> '')  and (Pos('= 0',sContion9) > 0) then
    sConditionAND := sConditionAND  + '  AND (' + MidStr(sContion9,4,Length(sContion9)- 3) + ')'
  else if (sContion9 <> '') then
    sContionAfter := sContionAfter  + '  OR  (' + MidStr(sContion9,4,Length(sContion9)- 3) + ')';


  //Label3.Caption := MidStr(sContion,6,Length(sContion)-5);
  if (sContionAfter = '') and (sConditionAND = '')  then
    Result := MidStr(sContion,6,Length(sContion)-5)
  else if  (sContionAfter <> '') and (sConditionAND = '') then
    Result := MidStr(sContion,6,Length(sContion)-5) + '  AND (' + MidStr(sContionAfter,6,Length(sContionAfter)-5)  + ' )'
  else if  (sContionAfter = '') and (sConditionAND <> '') then
    Result := MidStr(sContion,6,Length(sContion)-5) + '  AND (' + MidStr(sConditionAND,6,Length(sConditionAND)-5)  + ' )'
  else
    Result := MidStr(sContion,6,Length(sContion)-5) + '  AND (' + MidStr(sContionAfter,6,Length(sContionAfter)-5)  + sConditionAND + ' )';
end;

procedure TMachineRulesForm.QueryData();
var
  vData: OleVariant;
  sSQL, sErrMsg,sCondition: WideString;
begin
  sSQL := QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(LeftStr(cbMachine.Text,4)) + ','''','''',1';
  FNMServerObj.GetQueryData(vData, 'PlanMachineCondition', sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  cdsCondition.Data := vData[0];
  GridDecorator.BindCxViewWithDataSource(cxgdtvCondition,dsCondition);
  sConditions := cdsCondition.FieldByName('Condition').AsString;
  sMode := cdsCondition.FieldByName('Mode').AsString;
end;

procedure TMachineRulesForm.ClearControls();
begin
  cbMode.ItemIndex := 2;

  white_type_t.Checked := False;
  white_type_s.Checked := False;
  white_type_p.Checked := False;
  white_type_b.Checked := False;
  white_type_cpbb.Checked := False;

  cb_TQ.Checked := False;
  cb_OR.Checked := False;
  cb_RD.Checked := False;
  cb_GN.Checked := False;

  Degree_18.Checked := False;
  Degree_24.Checked := False;

  spring_y.Checked := False;
  spring_n.Checked := false;

  cb_MC.Checked := false;
  cb_ETI.Checked := False;
  cb_AP.Checked :=False;

  MM_y.Checked := false;
  MM_n.Checked := False;

  Royal_y.Checked := False;
  Royal_n.Checked := False;

  sm_y.Checked := False;
  sm_n.Checked := False;

  cb_0.Checked := False;
  cb_1000.Checked :=False;
  cb_10000.Checked :=False;
  cb_25000.Checked :=False;
  cb_40000.Checked :=False;
  cb_60000.Checked :=False;
  cb_max.Checked :=False;

  roll_y.Checked := False;
  roll_n.Checked := False;
  
end;

procedure TMachineRulesForm.SetControls();
begin

  ClearControls;

  if (sConditions = '') or (sMode = '') then
    Exit;

  if Trim(sMode) = '1' then
    cbMode.ItemIndex := 0
  else if Trim(sMode) = '2' then
    cbMode.ItemIndex := 1
  else if Trim(sMode) = '3' then
    cbMode.ItemIndex := 2
  else if Trim(sMode) = '4' then
    cbMode.ItemIndex := 3;

  if cbMode.Text = '模式1' then
    lblContents.Caption := '18度【0】－24度【0】-24度【1-1000】-18度【1-1000】-18度【TQ】 -24度【TQ】-洗机-24度【OR】-18【OR】 (符合浅模式一的试样都要排入对应的任务栏)' + Char(13) +
                           '18度【1001-10000】-24度【1001-10000】-24度【10001-40000】-18度【10001-40000】-18度【40001-80000】-24度【40001-80000】-洗机' + Char(13) +
                           '24度【80001-MAX】- 18度【80001-MAX】-洗机回收碱'
  else if cbMode.Text = '模式2' then
    lblContents.Caption := '24度【0】－18度【0】-18度【1-1000】-24度【1-1000】-24度【TQ】-18度【TQ】-洗机-18度【OR】-24【OR】符合浅模式一的试样都要排入对应的任务栏)' + Char(13) +
                           '24度【1001-10000】-18度【1001-10000】-18度【10001-40000】-24度【10001-40000】-24度【40001-80000】-18度【40001-80000】-洗机' + Char(13) +
                           '18度【80001-MAX】- 24度【80001-MAX】-洗机回收碱'
  else if cbMode.Text = '模式3' then
    lblContents.Caption := '24度【80001-MAX】- 18度【80001-MAX】'
  else if cbMode.Text = '模式4' then
    lblContents.Caption := '18度【80001-MAX】- 24度【80001-MAX】';

  if Pos('特白',sConditions) > 0 then
     white_type_t.Checked := True;
  if Pos('少荧',sConditions) > 0 then
     white_type_s.Checked := True;
  if Pos('漂白',sConditions) > 0 then
     white_type_p.Checked := True;
  if Pos('本白',sConditions) > 0 and Pos('GF_NO NOT LIKE ''PD%''',sConditions) then
     white_type_b.Checked := True;
  if Pos('本白',sConditions) > 0 and Pos('GF_NO LIKE ''PD%''',sConditions) then
     white_type_cpbb.Checked := True;

  if Pos('TQOR = ''TQ''',sConditions) > 0 then
    cb_TQ.Checked := True;
  if Pos('TQOR = ''OR''',sConditions) > 0 then
    cb_TQ.Checked := True;
  if Pos('TQOR = ''RD''',sConditions) > 0 then
    cb_TQ.Checked := True;
  if Pos('TQOR = ''GN''',sConditions) > 0 then
    cb_TQ.Checked := True;

//  if Pos('OR (Degree',sConditions) > 0 then
//     ComboBox1.Text := '或'
//  else
//     ComboBox1.Text := '且';
//  if Pos('OR (spring',sConditions) > 0 then
//     ComboBox1.Text := '或'
//  else
//     ComboBox1.Text := '且';
//  if Pos('OR (sType',sConditions) > 0 then
//     ComboBox1.Text := '或'
//  else
//     ComboBox1.Text := '且';
//  if Pos('OR (MM',sConditions) > 0 then
//     ComboBox1.Text := '或'
//  else
//     ComboBox1.Text := '且';
//  if Pos('OR (Royal',sConditions) > 0 then
//     ComboBox1.Text := '或'
//  else
//     ComboBox1.Text := '且';
//  if Pos('OR (sm',sConditions) > 0 then
//     ComboBox1.Text := '或'
//  else
//     ComboBox1.Text := '且';
//  if Pos('OR (ordinary',sConditions) > 0 then
//     ComboBox1.Text := '或'
//  else
//     ComboBox1.Text := '且';
//  if Pos('OR (Roll',sConditions) > 0 then
//     ComboBox1.Text := '或'
//  else
//     ComboBox1.Text := '且';

  if Pos('Degree = ''18''',sConditions) > 0 then
     Degree_18.Checked := True;
  if Pos('Degree = ''24''',sConditions) > 0 then
     Degree_24.Checked := True;

  if Pos('spring = 1',sConditions) > 0 then
     spring_y.Checked := True;
  if Pos('spring = 0',sConditions) > 0 then
     spring_n.Checked := True;

  if Pos('sType = ''MC''',sConditions) > 0 then
     cb_MC.Checked := True;
  if Pos('sType = ''ETI''',sConditions) > 0 then
     cb_ETI.Checked := True;
  if Pos('sType = ''AP''',sConditions) > 0 then
     cb_AP.Checked := True;
  if Pos('sType = ''''',sConditions) > 0 then
     cbOthers.Checked := True;

  if Pos('MM = 1',sConditions) > 0 then
     MM_y.Checked := True;
  if Pos('MM = 0',sConditions) > 0 then
     MM_n.Checked := True;

  if Pos('Royal = 1',sConditions) > 0 then
     Royal_y.Checked := True;
  if Pos('Royal = 0',sConditions) > 0 then
     Royal_n.Checked := True;

  if Pos('sm = 1',sConditions) > 0 then
     sm_y.Checked := True;
  if Pos('sm = 0',sConditions) > 0 then
     sm_n.Checked := True;

  if Pos('Dosage_Factor between 0 and 1000',sConditions) > 0 then
     cb_0.Checked := True;
  if Pos('Dosage_Factor between 1001 and 10000',sConditions) > 0 then
     cb_1000.Checked := True;
  if Pos('Dosage_Factor between 10001 and 25000',sConditions) > 0 then
     cb_10000.Checked := True;
  if Pos('Dosage_Factor between 25001 and 40000',sConditions) > 0 then
     cb_25000.Checked := True;
  if Pos('Dosage_Factor between 40001 and 60000',sConditions) > 0 then
     cb_40000.Checked := True;
  if Pos('Dosage_Factor between 60001 and 80000',sConditions) > 0 then
     cb_60000.Checked := True;
  if Pos('Dosage_Factor between 80001 and 99999999',sConditions) > 0 then
     cb_max.Checked := True;

  if Pos('Roll = 1',sConditions) > 0 then
     roll_y.Checked := True;
  if Pos('Roll = 0',sConditions) > 0 then
     roll_n.Checked := True;
     
  ShowCondition;

end;

procedure TMachineRulesForm.ShowCondition();
var
  sInfo: WideString ;
begin
  sInfo := sConditions;

  sInfo := StringReplace(sInfo,'OR','或者',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'AND','并且' + Char(13),[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'TQOR = ''TQ''','TQ',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'TQOR = ''OR''','OR',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'TQOR = ''RD''','RD',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'TQOR = ''GN''','GN',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'White_Type = ''特白''','特白',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'White_Type = ''少荧''','少荧',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'White_Type = ''漂白''','漂白',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'White_Type = ''本白''','本白',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'Degree = ''18''','碱浓为18',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'Degree = ''24''','碱浓为24',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'spring = 1','是弹力布',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'spring = 0','非弹力布',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'sType = ''MC''','MC整理',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'sType = ''ETI''','ETI整理',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'sType = ''AP''','AP整理',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'MM = 1','磨毛',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'MM = 0','非磨毛',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'Royal = 1','液氨丝光',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'Royal = 0','非液氨丝光',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'sm = 1','前工序含烧毛',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'sm = 0','前工序不含烧毛',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'ordinary = 1','普通品种',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'ordinary = 0','非普通品种',[rfReplaceAll]);

  sInfo := StringReplace(sInfo,'Roll = 1','卷装',[rfReplaceAll]);
  sInfo := StringReplace(sInfo,'Roll = 0','不卷装',[rfReplaceAll]);

  Label3.Caption := sInfo;
end;

procedure TMachineRulesForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMachineRulesForm.FormDestroy(Sender: TObject);
begin
  MachineRulesForm := nil;
end;

procedure TMachineRulesForm.cbModeChange(Sender: TObject);
begin
  if cbMode.Text = '模式1' then
    lblContents.Caption := '18度【0】－24度【0】-24度【1-1000】-18度【1-1000】-18度【TQ】 -24度【TQ】-洗机-24度【OR】-18【OR】 (符合浅模式一的试样都要排入对应的任务栏)' + Char(13) +
                           '18度【1001-10000】-24度【1001-10000】-24度【10001-40000】-18度【10001-40000】-18度【40001-80000】-24度【40001-80000】-洗机' + Char(13) +
                           '24度【80001-MAX】- 18度【80001-MAX】-洗机回收碱'
  else if cbMode.Text = '模式2' then
    lblContents.Caption := '24度【0】－18度【0】-18度【1-1000】-24度【1-1000】-24度【TQ】-18度【TQ】-洗机-18度【OR】-24【OR】符合浅模式一的试样都要排入对应的任务栏)' + Char(13) +
                           '24度【1001-10000】-18度【1001-10000】-18度【10001-40000】-24度【10001-40000】-24度【40001-80000】-18度【40001-80000】-洗机' + Char(13) +
                           '18度【80001-MAX】- 24度【80001-MAX】-洗机回收碱'
  else if cbMode.Text = '模式3' then
    lblContents.Caption := '24度【80001-MAX】- 18度【80001-MAX】'
  else if cbMode.Text = '模式4' then
    lblContents.Caption := '18度【80001-MAX】- 24度【80001-MAX】';
end;

procedure TMachineRulesForm.FormCreate(Sender: TObject);
begin
  FillAllOperationToItems(Login.CurrentDepartment,cbMachine.Items)
end;

procedure TMachineRulesForm.btnSaveClick(Sender: TObject);
var
 vData: OleVariant;
  sSQL, sErrMsg,sCondition: WideString;
begin

  if cbMachine.Text = '' then
  begin
    ShowMessage('请选择机台!');
    Exit;
  end;
  if cbMode.Text = '' then
  begin
    ShowMessage('请选择模式!');
    Exit;
  end;
  if not (white_type_t.Checked  or white_type_s.Checked or white_type_p.Checked or white_type_b.Checked or white_type_cpbb.Checked) then
  begin
    ShowMessage('请选择 ‘特漂白’!');
    Exit;
  end;

  sCondition := CombinCondition;
  sSQL := QuotedStr(login.CurrentDepartment) + ',' + QuotedStr(LeftStr(cbMachine.Text,4)) + ',' + QuotedStr(rightstr(cbMode.Text,1)) + ',' + QuotedStr(sCondition) + ',0,' + QuotedStr(Login.LoginID);
  FNMServerObj.GetQueryData(vData, 'PlanMachineCondition', sSQL, sErrMsg);
  if sErrMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrMsg, mtError);
    Exit;
  end;
  QueryData;
  ShowCondition;
end;

procedure TMachineRulesForm.cbMachineChange(Sender: TObject);
begin
  QueryData;
  SetControls;
end;

procedure TMachineRulesForm.Button1Click(Sender: TObject);
begin
  if TMsgDialog.ShowMsgDialog('确定要重排计划？',mtConfirmation,[mebYes,mebNo],mebYes)=mrYes then
    AutoPlan;
end;

procedure TMachineRulesForm.AutoPlan();
var
  vData: OleVariant;
  sSQL, sErrorMsg: WideString;
begin
  sSQL := QuotedStr(login.CurrentDepartment)+ ','+ QuotedStr('MC') + ',0';

  FNMServerObj.GetQueryData(vData, 'AutoPlan', sSQL, sErrorMsg);
  if sErrorMsg<>'' then
  begin
    TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
    Exit;
  end;
end;

end.
