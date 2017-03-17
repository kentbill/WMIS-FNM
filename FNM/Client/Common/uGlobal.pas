unit uGlobal;
{*|<PRE>*****************************************************************************
                                                                             
       ������� FNM CLIENT MODEL                                               
       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                              
       ��Ԫ���� uGlobal.pas                                                    
       �������� 2004-11-04 16:33:09                                            
       ������Ա wuwj                                                              
       �������� ͨ�ú�����Ԫ

******************************************************************************}

interface

uses Windows, Messages, DBClient, Classes, Dialogs, DB, StdCtrls, DBGrids,
     SysUtils, StrUtils, Types, Forms, ComCtrls,  Controls, uDictionary,
     DateUtils, adoDB, MakeSQL, XMLDoc, XMLIntf, Registry, uLogin, ServerDllPub,
     cxGridCustomView, cxGridCustomTableView, uShowMessage, Graphics;

type
  TSaveFileType=(sftXLS, sftCSV, sftTXT); //�����ļ��ĸ�ʽ��
  TSeparateSymbol=(ssTAB, ssSPACE, ssCOMMA, ssVERTICALLINE, ssSEMICOLON); //�ָ���

  TGlobal = class (TObject)
  {* ͨ�ú�����װ��}
  private
    class function GetSeparateSymbol(ss: TSeparateSymbol): string; overload; 
  protected
    constructor CreateInstance; 

    class function AccessInstance(Request: Integer): TGlobal; 
    class function CanGridSaveFile(grid: TObject): Boolean; overload; 
    class function GetSaveFileName(saveFileType: TSaveFileType): string; overload; 
  public
    constructor Create; 
    destructor Destroy; override; 
    class function Instance: TGlobal; 
    class procedure ReleaseInstance; 

//    class function DeltaIsNull(cds: TClientDataSet): Boolean; 
//    {* �ú�����cds_ChemicalInDtl.LogChanges ����}
    class procedure FillComboBoxFromDataSet(cds: TDataSet; firstField, secondField, linkSymbol: string; comboBox: TComboBox); 
    {* �����ݼ���¼��ʾ��Combox��}
    class procedure FillItemsFromDataSet(cds: TDataSet; firstField, secondField, linkSymbol: string; theItems: TStrings); overload; 
    {* ������ݼ���һ��TStrings������}
    class procedure FillItemsFromDataSet(cds: TClientDataSet; KeyField: string; FieldNames: array of String;
        edtRoll, edtQuantity: TEdit; theItems: TListItems); overload;
   class procedure FillItemsFromDataSet(cds: TClientDataSet; FieldNames: array of String;
     theItems: TListItems); overload;
    {* }
    class procedure FillItemsFromString(AString: String; linkSymbol: Char; MaxCol: Integer; TheItems: TStrings); 
    {* �ֽ�̶��ָ�����ַ�����TStrings������}
    class procedure SaveDataToFile(dataSet: TDataSet; FileType: TSaveFileType; ss: TSeparateSymbol = ssTAB); overload; 
    {* ��һ�����ݼ��еļ�¼�������ļ���}
    class procedure SaveDataToFile(Grid: TDBGrid; FileType: TSaveFileType = sftXLS; ss: TSeparateSymbol = ssTAB); overload; 
    {* ��DBGrid���ݵ������ļ���}
//    class procedure SaveDataToFile(DxDBGrid: TDxDBGrid; FileType: TSaveFileType; ss: TSeparateSymbol = ssTAB); overload; 
//    {* ��DxDbGrid���ݵ������ļ��� }
    class function CheckValueIsNull(sValue: String): Boolean; overload; 
    {* ���һ��stringֵ�Ƿ�Ϊ�հ�}
    class function CheckValueIsNull(sValue: String; sMsg: String): Boolean; overload; 
    {* ���һ��stringֵ�Ƿ�Ϊ�հף�������ʾ��Ϣ}
    class function CheckEditIsNull(aEdit: TEdit): Boolean; overload; 
    {* ���һ��Edit.Text�Ƿ�Ϊ�հ�}
    class function CheckEditIsNull(aEdit: TEdit; sMsg: String): Boolean; overload; 
    {* ���һ��Edit.Text�Ƿ�Ϊ�հף�������ʾ��Ϣ}
    class function CheckValueLength(sValue: string; iValueLength: Integer): Boolean; overload; 
    {* ���һ��stringֵ�Ƿ���ĳһ���̶�����}
    class function CheckValueLength(aEdit: TEdit; iValueLength: Integer): Boolean; overload; 
    {* ���һ��Edit.Text�Ƿ���ĳһ���̶�����}
    class function CheckValueIsDateType(sValue: String): Boolean; overload; 
    {* ���һ��stringֵ�Ƿ����ת������������}
    class function CheckValueIsDateType(sValue: String; sMsg: String): Boolean; overload; 
    {* ���һ��stringֵ�Ƿ����ת�����������ͣ���������ת��������Ϣ}
    class function CheckValueIsNumeric(sValue: String): Boolean; overload; 
    {* ���һ��stringֵ�Ƿ����ת������ֵ����}
    class function CheckValueIsNumeric(sValue: String; sMsg: String): Boolean; overload; 
    {* ���һ��stringֵ�Ƿ����ת������ֵ���ͣ���������ת��������Ϣ}
    class function IsMoreThanFixdValue(sValue: string; fValue: double): Boolean; 
    {* ���һ��string�Ƿ�ת������ֵ��>=ĳһ���̶�ֵ}
    class function IsLessThanFixedValue(sValue: string; fValue: double): Boolean; 
    {* ���һ��string�Ƿ�ת������ֵ��<=ĳһ���̶�ֵ}
    class function IsBetweenFixedValue(sValue: String; fMinValue: Double; fMaxValue: double): Boolean; 
    {* ���һ��string�Ƿ�ת������ֵ����������ֵ֮��}
    class procedure MoveData(aSrc: TListBox; aDes: TListBox; aAll: Boolean=False); overload; 
    {* �����ƶ�}
    class procedure MoveData(aSrc: TListView; aDes: TListView; aAll: Boolean=False); overload; 
    {* }
    class procedure SortListView(aSrc: TListView; Column: TListColumn);
    {* ListView �ؼ�����}
    class procedure DblClickAListview(Sender: TObject);
    {* ListView �ؼ�˫���¼�}
    class procedure DblClickATreeview(Sender: TObject);
    {* Treeview �ؼ�˫���¼�}
    class procedure DblClickAWinControl(Sender: TObject);
    {* TWinControl �ؼ�˫���¼�}
    class procedure FormShow(FormClass: TFormClass; IsModal: Boolean = false);
    {* ��ʾָ�����͵�Form}
    class procedure OnException(Sender: TObject; E: Exception);
    {* Ӧ�ó����������}
    class procedure SetButtonState(BtnFrom, BtnAllfrom, BtnTo, BtnAllTo: TControl; aSrc, aDes: Tlistbox); overload;
    {* ����Control��״̬}
    class procedure SetButtonState(BtnFrom, BtnAllfrom, BtnTo, BtnAllTo: TControl; aSrc, aDes: TListView); overload;
    {* }
//    class procedure ArrangeControl(aOwner: TWinControl; VorH: string);
//    {* �Զ�����������ؼ����ӿؼ�λ��.�벻Ҫʹ�øú���,�뿼��ؼ���Anchors����,��������Ǻÿ�����?}
    class function GetColorByID(WV_IsFinished, Urgent_Type: string; Is_Cut_Cloth: Boolean; Is_Hold :Integer;Is_HoldAff:Integer): Integer;
    {* }
    class function GetClass(): string; 
    {* }
    class procedure SetStatInfo(lv: TListView; iSubIndex: Integer; edtRoll, edtQuantity: TEdit); 
    {* }
    class procedure MoveDataEx(lvSrc: TListView; lvDes: TListView; iSubIndex: Integer; edtRollSrc, edtQuantitySrc: TEdit;
      edtRollDes, edtQuantityDes: TEdit; aAll: Boolean = False); 
    {* }
    class procedure LocateData(cds: TClientDataSet; const sKeyField, sValue: string); 
    {* }
    class procedure FilterData(cds: TClientDataSet; const sFilter: string); 
    {* }
    class procedure GetRecordSetFromXLS(adors: TADODataSet);
    class function RMBSmallToBig(small: real): string;
    class function DeltaIsNull(cds:TclientDataSet):boolean;
{* -----------------------------------------------------------------------------
   �������� FillsqmmkItems
   ������Ա cuijf
   �������� 2004-9-2 11:18:22
   �����б� sqmmkName:TMakeSQL;ParaCaption,ParaName:String;ParaType:TParaType=SqlString;bClear:Boolean=False
   ����ֵ   ��
   �������� �������ѡ����б�
   ��������
   ����˵��
-------------------------------------------------------------------------------}
   class procedure FillsqmmkItems(sqmmkName:TMakeSQL;ParaCaption,ParaName:String;
        ParaType:TParaType=SqlString;bClear:Boolean=False);    overload;

{* -----------------------------------------------------------------------------
   �������� FillsqmmkItems
   ������Ա luoty
   �������� 2004-9-20 11:18:22
   �����б� sqmmkName:TMakeSQL;QueryType��ѯ���
   �������� �������ѡ����б�
-------------------------------------------------------------------------------}
    class procedure FillsqmmkItems(sqmmkName:TMakeSQL;QueryType:String);  overload;
    class procedure SetComboBoxValue(AComboBox: TComboBox; itemValue: String);  overload;
    class procedure SetTreeViewSelected(ATreeView: TTreeView; TextValue: String);  overload;
    class function GetServerTime: TDateTime; // cuijf 2008-4-30 ��ȡ������ʱ��
    class procedure GenerateRCPFile(RecipeNOStr: string);
    class function InvertColor(AColor:TColor): TColor;
end;


implementation

constructor TGlobal.Create; 
begin
  inherited Create; 
  raise Exception.CreateFmt('������Singleton�ֻ࣬��ͨ���� %s ��CreateInstance��������ʵ����', [ClassName]); 
end; 

constructor TGlobal.CreateInstance; 
begin
  inherited Create; 
end; 

destructor TGlobal.Destroy; 
begin
  if AccessInstance(0) = Self then AccessInstance(2);

  inherited Destroy; 
end; 

class function TGlobal.AccessInstance(Request: Integer): TGlobal; 
  {$WRITEABLECONST ON}
  const FInstance: TGlobal = nil; 
  {$WRITEABLECONST OFF}
begin
  case Request of
    1: if not Assigned(FInstance) then FInstance:= CreateInstance; 
    2: FInstance:= nil; 
  else
    raise Exception.CreateFmt('Illegal request %d in AccessInstance', [Request]); 
  end; 
  Result:= FInstance; 
end; 

class function TGlobal.CanGridSaveFile(grid: TObject): Boolean;
begin
  result:= False;
  if grid is TDBGrid then
  with grid as TDBGrid do
  begin
    if DataSource=nil then
      Raise Exception.Create('Grid�ؼ�û��ָ��DataSource���ԣ�');

    if DataSource.DataSet=nil then
      Raise Exception.Create('DataSourceû��ָ��DataSet���ԣ�');

    if (not DataSource.DataSet.Active) or DataSource.DataSet.IsEmpty then
      Raise Exception.Create('DataSet��û�����ݣ�');
    Result:=True;
  end;
end;

class procedure TGlobal.FillComboBoxFromDataSet(cds: TDataSet; firstField, 
    secondField, linkSymbol: string; comboBox: TComboBox); 
begin
  FillItemsFromDataSet(cds, firstField, secondField, linkSymbol, comboBox.Items);
end; 

class function TGlobal.GetSaveFileName(saveFileType: TSaveFileType): string; 
var
  SaveDialog: TSaveDialog; 
  FileName, extendFileType: string; 
  dotPosition: integer; 
begin
  SaveDialog:=TSaveDialog.Create(nil); 
  SaveDialog.Filter:='Excel Files|*.xls|CSV Files|*.csv|Text Files|*.txt|All Files|*.*'; 

  case saveFileType of
  sftXLS: 
       SaveDialog.FilterIndex:=0; 
  sftCSV: 
       SaveDialog.FilterIndex:=1; 
  sftTXT: 
       SaveDialog.FilterIndex:=2; 
  else
       SaveDialog.FilterIndex:=3; 
  end; 

  if not SaveDialog.Execute then
     Result:=''
  else
  begin
      case SaveDialog.FilterIndex of
      1: extendFileType:='.XLS';
      2: extendFileType:='.CSV';
      3: extendFileType:='.TXT';
      else
        extendFileType:='.TXT';
      end; 

     FileName:=SaveDialog.FileName; 
     dotPosition:=pos('.', FileName); 
     if dotPosition=0 then
       FileName:=FileName+extendFileType
     else
       FileName:=copy(FileName, 1, dotPosition-1)+extendFileType; 
     Result:=FileName; 
  end; 
end; 

class function TGlobal.GetSeparateSymbol(ss: TSeparateSymbol): string; 
begin
  case ss of
    ssTAB:          Result:=#9; 
    ssSPACE:        Result:=' '; 
    ssCOMMA:        Result:=', '; 
    ssVERTICALLINE: Result:='|'; 
    ssSEMICOLON:    Result:='; '; 
  end; 
end; 

class function TGlobal.Instance: TGlobal; 
begin
  Result:= AccessInstance(1); 
end; 

class procedure TGlobal.ReleaseInstance; 
begin
  AccessInstance(0).Free; 
end; 

class procedure TGlobal.SaveDataToFile(dataSet: TDataSet; 
        FileType: TSaveFileType; ss: TSeparateSymbol = ssTAB); 
var  stringWriter: TStringList; 
  FileName: string; 

  { Local Procedures }

  procedure WriteFileHead(sl: TStringList); 
  var
    i: Integer; 
    GridCaption: string; 
    separateSymbol: string; 
  begin
    GridCaption:=''; 
    separateSymbol:=GetSeparateSymbol(ss); 
    for i:=0 to dataset.Fields.Count-1 do
      begin
        GridCaption:=GridCaption+dataset.Fields[i].FieldName; 
        if i<(dataset.Fields.Count-1) then GridCaption:=GridCaption+separateSymbol; 
      end; 
    sl.Add(GridCaption); 
  end; 

  procedure WriteFileBody(sl: TStringList); 
  var
    aRow: string; 
    i: integer; 
    separateSymbol: string; 
  begin
    separateSymbol:=GetSeparateSymbol(ss); 

    with dataSet do
    begin
      try
        DisableControls;
        aRow:='';
        First;
        while not Eof do
        begin
          for i:=0 to Fields.Count-1 do
            aRow:=aRow+Fields[i].AsString +separateSymbol;
          aRow:=Copy(aRow, 1, Length(aRow)-1);
          sl.Add(aRow);
          aRow:='';
          Next;
        end;
      finally
        EnableControls;
      end;
    end;
  end;

begin
  FileName:=GetSaveFileName(fileType); 
  if FileName='' then exit; 

  stringWriter:=TStringList.Create; 
  try
    WriteFileHead(stringWriter); 
    WriteFileBody(stringWriter); 
    stringWriter.SaveToFile(FileName); 
  finally
    stringWriter.Free; 
  end; 
end; 

class procedure TGlobal.SaveDataToFile(Grid: TDBGrid; FileType: TSaveFileType =
        sftXLS; ss: TSeparateSymbol = ssTAB); 
var
  stringWriter: TStringList; 
  FileName: string; 

  { Local Procedures }

  procedure WriteFileHead(sl: TStringList); 
  var
    i: Integer; 
    GridCaption: string; 
    separateSymbol: string; 
  begin
    GridCaption:=''; 
    separateSymbol:=GetSeparateSymbol(ss); 
    for i:=0 to Grid.Columns.Count-1 do
      begin
        GridCaption:=GridCaption+Grid.Columns[i].Title.Caption; 
        if i<(Grid.Columns.Count-1) then GridCaption:=GridCaption+separateSymbol; 
      end; 
    sl.Add(GridCaption); 
  end; 

  procedure WriteFileBody(sl: TStringList); 
  var
    aRow: string; 
    i: integer; 
    separateSymbol: string; 
  begin
    separateSymbol:=GetSeparateSymbol(ss); 
    with Grid.DataSource.DataSet do
      begin
        First; 
        aRow:=''; 
        DisableControls; 
        try
          while not Eof do
          begin
            for i:=0 to Grid.Columns.Count-1 do
              aRow:=aRow+FieldByName(Grid.Fields[i].FieldName).AsString+separateSymbol;
            aRow:=Copy(aRow, 1, Length(aRow)-1);
            sl.Add(aRow);
            aRow:='';
            Next;
          end;
        finally
          EnableControls; 
        end; 
      end; 
  end; 

begin
  FileName:=GetSaveFileName(fileType); 
  if FileName='' then
     exit; 

  if CanGridSaveFile(Grid)=False then Exit; 
  stringWriter:=TStringList.Create; 
  try
    WriteFileHead(stringWriter); 
    WriteFileBody(stringWriter); 
    stringWriter.SaveToFile(FileName); 
  finally
    stringWriter.Free; 
  end; 
end; 

//class procedure TGlobal.SaveDataToFile(DxDBGrid: TDxDBGrid; 
//        FileType: TSaveFileType; ss: TSeparateSymbol = ssTAB); 
//var
//  stringWriter: TStringList; 
//  FileName: string; 
//
//  { Local Procedures }
//  
//  procedure WriteFileHead(sl: TStringList); 
//  var
//    i: Integer; 
//    GridCaption: string; 
//    separateSymbol: string; 
//  begin
//    GridCaption:=''; 
//    separateSymbol:=GetSeparateSymbol(ss); 
//    for i:=0 to DxDBGrid.ColumnCount -1 do
//      begin
//        GridCaption:=GridCaption+DxDBGrid.Columns[i].Caption; 
//        if i<(DxDBGrid.ColumnCount-1) then GridCaption:=GridCaption+separateSymbol; 
//      end; 
//    sl.Add(GridCaption); 
//  end; 
//  
//  procedure WriteFileBody(sl: TStringList); 
//  var
//    aRow: string; 
//    i: integer; 
//    separateSymbol: string; 
//  begin
//    separateSymbol:=GetSeparateSymbol(ss); 
//    with DxDBGrid.DataSource.DataSet do
//      begin
//        First; 
//        aRow:=''; 
//        DisableControls; 
//        try
//          while not Eof do
//            begin
//              for i:=0 to DxDBGrid.ColumnCount-1 do
//                begin
//                  aRow:=aRow+FieldByName(DxDBGrid.Columns[i].FieldName).AsString+separateSymbol; 
//                end; 
//              aRow:=Copy(aRow, 1, Length(aRow)-1); 
//              sl.Add(aRow); 
//              aRow:=''; 
//              Next; 
//            end; 
//        finally
//          EnableControls; 
//        end; 
//      end; 
//  end; 
//  
//begin
//  FileName:= GetSaveFileName(fileType); 
//  if FileName='' then
//    exit; 
//  if CanGridSaveFile(dxDBGrid)=False then Exit; 
//  stringWriter:=TStringList.Create; 
//  try
//    WriteFileHead(stringWriter); 
//    WriteFileBody(stringWriter); 
//    stringWriter.SaveToFile(FileName); 
//  finally
//    stringWriter.Free; 
//  end; 
//end; 

class procedure TGlobal.FillItemsFromDataSet(cds: TDataSet; firstField, 
    secondField, linkSymbol: string; theItems: TStrings); 
var
  Item: string; 
begin
  with cds do
  begin
    if Active=False then Exit;
    
    theItems.Clear;
    First;
    if secondField='' then
    while not Eof do
    begin
      Item:=FieldByName(firstField).AsString;
      if theItems.IndexOf(Item)=-1 then
        theItems.Add(Item);
      Next;
    end
    else
    while not Eof do
    begin
     Item:=FieldByName(firstField).AsString+linkSymbol+FieldByName(secondField).AsString;
     if theItems.IndexOf(Item)=-1 then
        theItems.Add(Item);
     Next;
    end;
  end;
end;

class procedure TGlobal.FillItemsFromString(AString: String; LinkSymbol: Char; MaxCol: Integer; TheItems: TStrings);
begin
  if not IsDelimiter(LinkSymbol, AString, Length(AString)) then
    AString:=AString + LinkSymbol; 
    
  AString:= WrapText(AString, #13, [LinkSymbol], MaxCol); 
  AString:= StringReplace(AString, linkSymbol, '', [rfReplaceAll]); 
  TheItems.Text:=AString; 
end; 

class function TGlobal.CheckEditIsNull(aEdit: TEdit): Boolean; 
begin
  result:=CheckValueIsNull(aEdit.Text); 
end; 

class function TGlobal.CheckValueIsNull(sValue: String): Boolean; 
begin
  result:=trim(sValue)='';
end;

class function TGlobal.CheckEditIsNull(aEdit: TEdit; 
  sMsg: String): Boolean; 
begin
  result:=CheckValueIsNull(aEdit.Text, sMsg); 
end; 

class function TGlobal.CheckValueIsNull(sValue, sMsg: String): Boolean; 
begin
  result:= CheckValueIsNull(sValue);
  if result then
    Application.MessageBox(pChar(sMsg), '����', mb_ok+mb_iconerror);
end;

class function TGlobal.CHeckValueLength(aEdit: TEdit; 
  iValueLength: Integer): Boolean; 
begin
  result:=CheckValueLength(aEdit.Text, iValueLength); 
end; 

class function TGlobal.CheckValueLength(sValue: string; iValueLength: Integer): Boolean; 
begin
  result:= Length(Trim(sValue))=iValueLength;
end;

class function TGlobal.CheckValueIsDateType(sValue: String): Boolean; 
var
  aDate: TDateTime; 
begin
  try
  begin
    aDate:=strToDate(sValue); 
    result:=true; 
  end; 
  except
    result:=false; 
  end; 
end; 

class function TGlobal.CheckValueIsDateType(sValue, sMsg: String): Boolean; 
begin
  result:= CheckValueIsDateType(sValue);
  if not result then
    Application.MessageBox(pChar(sMsg), '����', mb_ok+mb_iconerror);
end;

class function TGlobal.CheckValueIsNumeric(sValue: String): Boolean; 
var aNumeric: Double; 
begin
  if sValue='' then
  begin
        result:=false;
  end
  else
  begin
  try
    aNumeric:=strtofloat(sValue);
    result:=true;
  except
    result:=false;
  end;
  end;
end; 

class function TGlobal.CheckValueIsNumeric(sValue, sMsg: String): Boolean; 
begin
  result:= CheckValueIsNumeric(sValue);
  if not result then
    Application.MessageBox(pChar(sMsg), '����', mb_ok+mb_iconerror);
end;

class function TGlobal.IsBetweenFixedValue(sValue: String; fMinValue, 
  fMaxValue: double): Boolean; 
begin
  result:=(IsMoreThanFixdValue(sValue, fMinValue)) and (IsLessThanFixedValue(sValue, fMaxValue));
end;

class function TGlobal.IsLessThanFixedValue(sValue: string; 
  fValue: double): Boolean; 
begin
  result:=CheckValueIsNumeric(sValue, '��Ч����ֵ��') and (StrToFloat(sValue) <= fValue)
end;

class function TGlobal.IsMoreThanFixdValue(sValue: string; fValue: double): Boolean; 
begin
  result:= CheckValueIsNumeric(sValue, '��Ч����ֵ��') and (strToFloat(sValue) >= fValue)
end;

class procedure TGlobal.MoveData(aSrc: TListBox; aDes: TListBox; aAll: Boolean=False); 
var i: Integer; 
begin
  if aSrc.Items.Count = 0 then Exit; 
  if aAll then
  begin
    for i:= 0 to aSrc.Items.Count -1 do
      aDes.Items.Add(aSrc.Items[i]); 
    aSrc.Items.Clear; 
  end
  else  begin
    if aSrc.SelCount = 0 then Exit; 
    for i:= 0 to aSrc.Items.Count -1 do
    begin
      if aSrc.Selected[i] then
         aDes.Items.Add(aSrc.Items[i]); 
    end; 
    aSrc.DeleteSelected; 
  end; 
end; 

class procedure TGlobal.MoveData(aSrc: TListView; aDes: TListView; aAll: Boolean=False); 
var i, j: Integer; 
begin
  if aSrc.Items.Count = 0 then Exit; 
  if aAll then
  begin
    for i:= 0 to aSrc.Items.Count -1 do
    begin
      with aDes.Items.Add do
      begin
        Caption:= aSrc.Items[i].Caption ;
        for j:= 0 to aSrc.Items[i].SubItems.Count - 1 do
          SubItems.Add(aSrc.Items[i].SubItems.Strings[j]);
      end;
    end; 
    aSrc.Items.Clear;
  end
  else
  begin
    if aSrc.SelCount = 0 then Exit;
    for i:= 0 to aSrc.Items.Count -1 do
    begin
      if aSrc.Items[i].Selected then
      begin
        with aDes.Items.Add do
        begin
          Caption:= aSrc.Items[i].Caption ;
          for j:= 0 to aSrc.Items[i].SubItems.Count - 1 do
            SubItems.Add(aSrc.Items[i].SubItems.Strings[j]);
        end;
      end;
    end;
    aSrc.DeleteSelected;
  end; 
end; 

class procedure TGlobal.SortListView(aSrc: TListView; Column: TListColumn); 
  function CustomSortProc(Item1, Item2: TListItem; ParamSort: integer): integer; stdcall; 
  begin
    if ParamSort > 0 then
      Result:= CompareText(Item1.SubItems.Strings[ParamSort-1], Item2.SubItems.Strings[ParamSort-1])
    else
      Result:= CompareText(Item1.Caption, Item2.Caption);
 end; 
begin
  aSrc.CustomSort(@CustomSortProc, Column.Index); 
end; 

class procedure TGlobal.DblClickAListview(Sender: TObject);
var
  MousePoint: TPoint;
  DbClickListItem: TListItem;
begin
  with Sender as TListView do
  begin
    MousePoint:=ScreenToClient(Mouse.CursorPos);
    DbClickListItem:=GetItemAt(MousePoint.X, MousePoint.Y);
    if DbClickListItem = nil then exit;
    Selected:= DbClickListItem;
    SendMessage(Handle, WM_KEYDOWN, VK_RETURN, 0);
  end;   
end;

class procedure TGlobal.DblClickATreeview(Sender: TObject);
var
  MousePoint: TPoint;
  DbClickNode: TTreeNode;
begin
  with Sender as TTreeView do
  begin
    MousePoint:=ScreenToClient(Mouse.CursorPos);
    DbClickNode:=GetNodeAt(MousePoint.X, MousePoint.Y);
    if DbClickNode = nil then exit;
    
    (Sender as TTreeView).Selected:=DbClickNode;
    SendMessage(Handle, WM_KEYDOWN, VK_RETURN, 0);
  end;
end;

class procedure TGlobal.DblClickAWinControl(Sender: TObject);
begin
  with Sender as TWinControl do
      SendMessage(Handle, WM_KEYDOWN, VK_RETURN, 0);
end;

class procedure TGlobal.FormShow(FormClass: TFormClass; IsModal: Boolean = false);
var
  i: Integer;
  AForm: TForm;
begin
  for i := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[i] is FormClass then
    begin
      Screen.Forms[i].Show;
      exit;
    end
  end;

  try
    AForm:=FormClass.Create(Application.MainForm);
    AForm.Font.Name:='����';
    AForm.Font.Size:=9;
    
    if IsModal then AForm.ShowModal else AForm.Show;
  finally
    if IsModal then
      AForm.Free;
  end;    
end;

class procedure TGlobal.OnException(Sender: TObject; E: Exception);
var
  MSG: String;
  Prefix: String;
begin
  if E.Message[4] = '_' then
  begin
    MSG:=E.Message;
    Prefix:= LeftStr(MSG, 4);
    system.Delete(MSG, 1, 4);

    if Prefix='WAR_' then
      TMsgDialog.ShowMsgDialog(MSG, mtWarning);

    if Prefix='INF_' then
      TMsgDialog.ShowMsgDialog(MSG, mtInformation);

    if Prefix='ERR_' then
      TMsgDialog.ShowMsgDialog(MSG, mtError);

    exit;
  end;

  TMsgDialog.ShowMsgDialog(E.Message, mtError);
end;

class procedure TGlobal.SetButtonState(BtnFrom, BtnAllfrom, BtnTo, BtnAllTo: TControl; aSrc, aDes: Tlistbox);
begin
  BtnFrom.Enabled:= aSrc.SelCount>0; 
  BtnAllFrom.Enabled:= aSrc.Items.Count>0;
  BtnTo.Enabled:= aDes.SelCount>0; 
  BtnAllTo.Enabled:= aDes.Items.Count>0; 
end; 

class procedure TGlobal.SetButtonState(BtnFrom, BtnAllfrom, BtnTo, BtnAllTo: TControl; aSrc, aDes: TListView); 
begin
  BtnFrom.Enabled:= aSrc.SelCount>0; 
  BtnAllFrom.Enabled:= aSrc.Items.Count>0; 
  BtnTo.Enabled:= aDes.SelCount>0; 
  BtnAllTo.Enabled:= aDes.Items.Count>0; 
end; 

//class procedure TGlobal.ArrangeControl(aOwner: TWinControl; VorH: string); 
//var i, j, iControlCount, iSpace, iControlHeight, iControlWidth, iOwnerHeight, iOwnerWidth: integer; 
//    arrControlList: Array of TControl; 
//begin
//  iControlCount:=aOwner.ControlCount ; 
//  if iControlCount>0 then
//  begin
//    iControlHeight:=aOwner.Controls[0].Height ; 
//    iControlWidth:=aOwner.Controls[0].Width ; 
//  end
//  else
//    exit; 
//
//  setlength(arrControlList, iControlCount); 
//
//  for i:=0 to iControlCount -1 do
//  begin
//      for j:=0 to iControlCount-1 do
//      begin
//        if aOwner.Controls[j].Tag =0 then
//        begin
//          arrControlList[i]:=aOwner.Controls[j]; 
//          arrControlList[i].Tag:=1; 
//          break; 
//        end; 
//      end; 
//      for j:=0 to iControlCount -1 do
//      begin
//        if VorH='V' then
//        begin
//          if aOwner.Controls[j].Top < arrControlList[i].Top then
//          begin
//            if aOwner.Controls[j].Tag = 0 then
//            begin
//              arrControlList[i].Tag:=0; 
//              arrControlList[i]:=aOwner.Controls[j]; 
//              arrControlList[i].Tag:=1; 
//            end; 
//          end; 
//        end ; 
//
//        if VorH='H' then
//        begin
//          if aOwner.Controls[j].Left < arrControlList[i].Left then
//          begin
//            if aOwner.Controls[j].Tag = 0 then
//            begin
//              arrControlList[i].Tag:=0; 
//              arrControlList[i]:=aOwner.Controls[j]; 
//              arrControlList[i].Tag:=1; 
//            end; 
//          end; 
//        end ; 
//
//      end; 
//  end; 
//
//
//  iOwnerWidth:=aOwner.Width ; 
//  iOwnerHeight:=aOwner.Height ; 
//
//  if VorH='V' then //��������
//  begin
//    iSpace:=Round((iOwnerHeight-iControlCount*iControlHeight)/(iControlCount+1)); 
//    if iSpace<0 then
//      iSpace:=0; 
//    for i:=0 to iControlCount-1  do
//    begin
//      arrControlList[i].Tag:=0; 
//      arrControlList[i].Top:=(i+1)*iSpace+i*iControlHeight; 
//      arrControlList[i].Left:=Round((iOwnerWidth-iControlWidth)/2); 
//    end; 
//  end; 
//  if VorH='H' then //��������
//  begin
//    iSpace:=Round((iOwnerWidth-iControlCount*iControlWidth)/(iControlCount+1)); 
//    if iSpace<0 then
//      iSpace:=0; 
//    for i:=0 to iControlCount-1  do
//    begin
//      arrControlList[i].Tag:=0; 
//      arrControlList[i].Left:=(i+1)*iSpace+i*iControlWidth; 
//      arrControlList[i].Top:=Round((iOwnerHeight-iControlHeight)/2); 
//    end; 
//  end; 
//
//  arrControlList:=nil; 
//end;

class function TGlobal.GetColorByID(WV_IsFinished, Urgent_Type: string; Is_Cut_Cloth: Boolean; Is_Hold: Integer;Is_HoldAff:Integer): Integer;
begin
  Result:= $000000;
  if WV_IsFinished = 'Y' then
  begin
    Result := clBlue; //����ɫ
    Exit;
  end;
  if Is_Hold=1 then
     Result := Integer(clGrayText)//��ɫ
  else if Is_Cut_Cloth then
          Result:= $FF00FF //�ۺ�
       else if Urgent_Type <>'' then
          Result:= $0000FF; //��ɫ
  if Is_HoldAff = 1 then
    Result:= $0054FF; //�ۺ�ɫ
end;

class function TGlobal.GetClass(): string; 
begin
  if HourOf(Now) < 7 then
    Result:= '���'
  else if HourOf(Now) < 15 then
    Result:= '���'
  else if HourOf(Now) < 23 then
    Result:= '�а�'
  else
    Result:= '���'
end; 

class procedure TGlobal.SetStatInfo(lv: TListView; iSubIndex: Integer; edtRoll, edtQuantity: TEdit); 
var i: Integer; 
  dQuantity: Double; 
begin
  dQuantity:= 0.0; 
  edtRoll.Text:= IntToStr(lv.Items.Count); 
  if lv.Items.Count = 0 then
    edtQuantity.Text:= '0.0'
  else begin
    for i:= 0 to lv.Items.Count - 1 do
    begin
      dQuantity:= dQuantity + StrToFloat(lv.Items[i].SubItems[iSubIndex])
    end; 
    edtQuantity.Text:= FloatToStr(dQuantity); 
  end; 
end; 

class procedure TGlobal.MoveDataEx(lvSrc: TListView; lvDes: TListView; 
   iSubIndex: Integer; edtRollSrc, edtQuantitySrc: TEdit; 
   edtRollDes, edtQuantityDes: TEdit; aAll: Boolean = False); 
begin
  //�ƶ�����
  MoveData(lvSrc, lvDes, aAll); 
  SetStatInfo(lvSrc, iSubIndex, edtRollSrc, edtQuantitySrc); 
  SetStatInfo(lvDes, iSubIndex, edtRollDes, edtQuantityDes); 
end; 

class procedure TGlobal.LocateData(cds: TClientDataSet; const sKeyField, sValue: string); 
begin
 with cds do
 begin
   if (not Active) or IsEmpty then Exit; 
   Locate(sKeyField, sValue, []); 
 end; 
end; 

class procedure TGlobal.FilterData(cds: TClientDataSet; const sFilter: string); 
begin
 with cds do
 begin
   if (not Active) then Exit; 
   Filtered:= False; 
   Filter:= sFilter; 
   Filtered:= True; 
 end; 
end;

class procedure TGlobal.FillItemsFromDataSet(cds: TClientDataSet; KeyField: string; FieldNames: array of String; 
  edtRoll, edtQuantity: TEdit; theItems: TListItems);
var
  i: Integer; 
  ItemList: TListItem; 
  dQuantity: Double;
begin
  dQuantity:= 0.0; 
  with cds do
  begin
    if not Active then Exit; 
    theItems.Clear; 
    First; 
    while not Eof do
    begin
      ItemList:= theItems.Add; 
      ItemList.Caption:= FieldByName(FieldNames[0]).AsString;
       
      for i:= 1 to High(FieldNames) do
        ItemList.SubItems.Add(FieldByName(FieldNames[i]).AsString);

      if KeyField<>'' then
        dQuantity:= dQuantity + FieldByName(KeyField).AsFloat;

      Next; 
    end; 
  end; 
  edtRoll.Text:= IntToStr(cds.RecordCount); 
  edtQuantity.Text:= FloatToStr(dQuantity);
end; 

class procedure TGlobal.FillItemsFromDataSet(cds: TClientDataSet; FieldNames: array of String;
  theItems: TListItems);
var
  i: Integer; 
  ItemList: TListItem; 
begin
  with cds do
  begin
    if not Active then Exit; 
    theItems.Clear; 
    First; 
    while not Eof do
    begin
      ItemList:= theItems.Add; 
      ItemList.Caption:= FieldByName(FieldNames[0]).AsString;
      for i:= 1 to High(FieldNames) do
        ItemList.SubItems.Add(FieldByName(FieldNames[i]).AsString);
      Next;
    end; 
  end; 
end;

class procedure TGlobal.GetRecordSetFromXLS(adors: TADODataSet);
var
  TableName: string;
  FileName: String;
  dlgOpen : TOpenDialog;
  ADOConnection: TADOConnection;
  List: TStrings;
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

  function InputCombobox(const ACaption, APrompt: string;
    var Value: string): Boolean;
  var
    Form: TForm;
    Prompt: TLabel;
    Combobox: TCombobox;
    DialogUnits: TPoint;
    ButtonTop, ButtonWidth, ButtonHeight: Integer;
  begin
    Result := False;
    Form := TForm.Create(Application);
    with Form do
      try
        Canvas.Font := Font;
        DialogUnits := GetAveCharSize(Canvas);
        BorderStyle := bsDialog;
        Caption := ACaption;
        ClientWidth := MulDiv(180, DialogUnits.X, 4);
        Position := poScreenCenter;
        Prompt := TLabel.Create(Form);
        with Prompt do
        begin
          Parent := Form;
          Caption := APrompt;
          Left := MulDiv(8, DialogUnits.X, 4);
          Top := MulDiv(8, DialogUnits.Y, 8);
          Constraints.MaxWidth := MulDiv(164, DialogUnits.X, 4);
          WordWrap := True;
        end;
        Combobox := TCombobox.Create(Form);
        with Combobox do
        begin
          Parent := Form;
          Left := Prompt.Left;
          Top := Prompt.Top + Prompt.Height + 5;
          Width := MulDiv(164, DialogUnits.X, 4);
          MaxLength := 255;
          Items.Text := Value;
          if Items.Count > -1 then
           ItemIndex := 0;
  //        SelectAll;
        end;
        ButtonTop := Combobox.Top + Combobox.Height + 15;
        ButtonWidth := MulDiv(50, DialogUnits.X, 4);
        ButtonHeight := MulDiv(14, DialogUnits.Y, 8);
        with TButton.Create(Form) do
        begin
          Parent := Form;
          Caption := SMsgDlgOK;
          ModalResult := mrOk;
          Default := True;
          SetBounds(MulDiv(38, DialogUnits.X, 4), ButtonTop, ButtonWidth,
            ButtonHeight);
        end;
        with TButton.Create(Form) do
        begin
          Parent := Form;
          Caption := SMsgDlgCancel;
          ModalResult := mrCancel;
          Cancel := True;
          SetBounds(MulDiv(92, DialogUnits.X, 4), Combobox.Top + Combobox.Height + 15,
            ButtonWidth, ButtonHeight);
          Form.ClientHeight := Top + Height + 13;          
        end;
        if ShowModal = mrOk then
        begin
          Value := Combobox.Text;
          Result := True;
        end;
      finally
        Form.Free;
      end;
  end;
begin
  dlgOpen := TOpenDialog.Create(nil);
  ADOConnection := TADOConnection.Create(nil);
  List := TStringList.Create;
  try
    dlgOpen.Filter := 'EXCEL �ļ�(*.xls)|*.xls';
    if dlgOpen.Execute then
    begin
      ADOConnection.ConnectionString :=' Provider=Microsoft.Jet.OLEDB.4.0;'+
          'Data Source='+dlgOpen.FileName+';'+
          'Mode=Read;Extended Properties=Excel 8.0;Persist Security Info=False ';
      ADOConnection.LoginPrompt := False;
      ADOConnection.Open;
      ADOConnection.GetTableNames(List);
      TableName := List.Text;
      if InputCombobox('��ѡ������','��ѡ������',TableName) then
      begin
        adors.Close;
        adors.ConnectionString := ADOConnection.ConnectionString;
        adors.CommandText := ' select * from ['+TableName+'] ';
        adors.Prepared := true ;
        adors.Open ;
      end;
    end;
  finally
    List.Free;
    ADOConnection.Free;
    dlgOpen.Free;
  end;
end;

class function TGlobal.RMBSmallToBig(small: real): string;
var
  SmallMonth, BigMonth: string;
  wei1, qianwei1: string[2];
  qianwei, dianweizhi, qian: integer;
begin
  qianwei := -3;
  Smallmonth := formatfloat('0.000', small);
  dianweizhi := pos('.', smallmonth);
  for qian := length(Smallmonth) downto 1 do
  begin
    if qian <> dianweizhi then
    begin
      case strtoint(copy(Smallmonth, qian, 1)) of
        1: wei1 := 'Ҽ'; 2: wei1 := '��';
        3: wei1 := '��'; 4: wei1 := '��';
        5: wei1 := '��'; 6: wei1 := '½';
        7: wei1 := '��'; 8: wei1 := '��';
        9: wei1 := '��'; 0: wei1 := '��';
      end;

      case qianwei of
        -3: qianwei1 := '��';
        -2: qianwei1 := '��';
        -1: qianwei1 := '��';
        0: qianwei1 := 'Բ';
        1: qianwei1 := 'ʰ';
        2: qianwei1 := '��';
        3: qianwei1 := 'Ǫ';
        4: qianwei1 := '��';
        5: qianwei1 := 'ʰ';
        6: qianwei1 := '��';
        7: qianwei1 := 'Ǫ';
        8: qianwei1 := '��';
        9: qianwei1 := 'ʰ';
        10: qianwei1 := '��';
        11: qianwei1 := 'Ǫ';
      end;
      inc(qianwei);
      bigmonth := wei1 + qianwei1 + bigmonth;
    end;
  end;
  RMBSmallTOBig := bigmonth;
end;

class procedure TGlobal.FillsqmmkItems(sqmmkName: TMakeSQL; ParaCaption,
  ParaName: String; ParaType: TParaType=SqlString;bClear:Boolean=False);
var
  cItems:TItemNames;
  i:integer;
begin
  //�������ԭ�е�Itemes
  if bClear then
    sqmmkName.ItemNames.Clear;
  cItems:=sqmmkName.ItemNames;
  //�������ѡ����б�
  cItems.Add;
  i:=sqmmkName.ItemNames.Count-1;
  //������ʾ������
  cItems.Items[i].ParaCaption:=ParaCaption;
  //����ʵ�ʵ������ֶ�����
  cItems.Items[i].ParaName:=ParaName;
  //���������ֶε���������
  cItems.Items[i].ParaType:=SqlString;
end;

class procedure TGlobal.FillsqmmkItems(sqmmkName: TMakeSQL;
  QueryType: String);
var
  ConfigFileName,sparaCaption,sparaName,FilePath:String;
  sparaType:TParaType;
  xmlDoc: TXMLDocument;
  ANode, ARoot,AChildNode: IXMLNode;
  Reg:TRegistry;
  i:integer;
begin
  try
    if Copy(Login.UpdatePath,Length(Login.UpdatePath),1)='\' then
      ConfigFileName:=login.UpdatePath+'FNMConfig.xml'
    else
      ConfigFileName:=login.UpdatePath+'\FNMConfig.xml' ;
    //����������ļ���������ȡ�����ļ�
    if not FileExists(ConfigFileName) then
    begin
      try
        Reg:=TRegistry.Create;
        with Reg do
        begin
          RootKey:=HKEY_Local_Machine;
          if OpenKey('\Software\W.MIS\FNM', False) then
          begin
            if ValueExists('FilePath') then
              FilePath := UpperCase(ReadString('FilePath'));
            CloseKey;
          end;
        end;
      finally
        Reg.Free;
      end;
      ConfigFileName:=copy(FilePath,1,length(FilePath)-7)+'FNMConfig.xml';
    end;
    xmlDoc:=TXMLDocument.Create(sqmmkName);
    try
      xmlDoc.FileName := ConfigFileName;
      xmlDoc.Active := True;
      ARoot := xmlDoc.ChildNodes.FindNode('Sqlmake');
      ANode := ARoot.ChildNodes.FindNode(QueryType);
      i:=0;
      while i<=ANode.ChildNodes.Count-1 do
      begin
        AChildNode:=ANode.ChildNodes[i];
        sParaCaption:=AChildNode.Attributes['Caption'];
        sParaName:=AChildNode.Attributes['Name'];
        if AChildNode.Attributes['Type']='SQLNumber' then
          sParaType:=SQLNumber
        else if AChildNode.Attributes['Type']='SQLDate' then
          sParaType:=SQLDate
        else
          sParaType:=SQLString;

        if i=0 then
        begin
          FillsqmmkItems(sqmmkName,sParaCaption,sParaName,sParaType,true)
        end
        else
          FillsqmmkItems(sqmmkName,sParaCaption,sParaName,sParaType);
        Inc(i);
      end;
    finally
      xmlDoc.Active := False;
      xmlDoc.Free;
    end;
  except
    Raise;
  end;

end;

class procedure TGlobal.SetComboBoxValue(AComboBox: TComboBox; itemValue: String);
var
  i: Integer;
begin
  AComboBox.ItemIndex:=-1;
  with AComboBox do
  for i := 0 to AComboBox.Items.Count - 1 do
  if Pos(itemValue, AComboBox.Items.Strings[i]) <> 0 then
  begin
    ItemIndex:=i;
    break;
  end;
end;

class procedure TGlobal.SetTreeViewSelected(ATreeView: TTreeView; TextValue: String);
var
  i: Integer;
begin
  ATreeView.Selected:=nil;
  with ATreeView do
  for i := 0 to Items.Count - 1 do    
  begin
    if Pos(TextValue, Items.Item[i].Text) <> 0 then
    begin
      Selected:=Items.Item[i];
      Selected.MakeVisible;
      break;
    end;
  end;
end;


class function TGlobal.DeltaIsNull(cds: TClientDataSet): Boolean;
begin
  if cds.State in [dsEdit, dsInsert] then
    cds.Post;
  result := not (cds.ChangeCount > 0);
end;

class function TGlobal.GetServerTime: TDateTime;
var
  vDateTime: OleVariant;
begin
  FNMServerObj.ServerTime(vDateTime);
  Result := TDateTime(vDateTime);
end;

class procedure TGlobal.GenerateRCPFile(RecipeNOStr: string);
var
   RCPList: TStringList;
//   FileName,TransPath,BakFileName,BakTransPath: string;
   FilePath,BakFilePath: string;
   vData: OleVariant;
   sCondition,sErrorMsg: WideString;
   ef:textfile;
begin
  try
    sCondition := QuotedStr(RecipeNOStr);
    FNMServerObj.GetQueryData(vData,'CPBGenerateRCP',sCondition,sErrorMsg);
    if sErrorMsg <> '' then
    begin
      TMsgDialog.ShowMsgDialog(sErrorMsg,mtError);
      Exit;
    end;
    TempClientDataSet.Data := vData;
    if TempClientDataSet.IsEmpty then
    begin
      TMsgDialog.ShowMsgDialog('û�д�ǩ�յ�ɫ����Ϣ!',mtInformation);
      Exit;
    end;
    FilePath := TempClientDataSet.FieldByName('FilePath').AsString;
    BakFilePath := TempClientDataSet.FieldByName('BakFilePath').AsString;

    if FileExists(FilePath) then
    begin
      ShowMessage('����ϵͳ����ת��,�롾10�롿���ٲ���,лл��');
      Exit;
    end;

    RCPList := TStringList.Create;
    RCPList.Clear;

    with TempClientDataSet do
    begin
      First;
      while not Eof do
      begin
        RCPList.Add(FieldByName('Record').AsString);
        Next;
      end;
      Close;
    end;
    RCPList.SaveToFile(FilePath);
    RCPList.SaveToFile(BakFilePath);

  { RCPList.SaveToFile('C:\'+FileName);
    RCPList.SaveToFile('C:\'+BakFileName);
    if FileExists('C:\'+FileName) then
    begin
      AssignFile(ef, 'C:\CopyBat.bat');
      Rewrite(ef);
      Writeln(ef,'COPY C:\'+FileName + '  '+ TransPath+'  /Y' );
      Writeln(ef,'COPY C:\'+BakFileName + '  '+ BakTransPath+'  /Y' );
      CloseFile(ef);
      WinExec(PChar('C:\CopyBat.bat'), SW_HIDE);
    end;
   }
  finally
    FreeAndNil(RCPList);
  end;
end;
class function TGlobal.InvertColor(AColor: TColor): TColor;
var
   iValue: Integer;
begin
  iValue := ColorToRGB(AColor);
  Result := RGB((GetRValue(iValue)+100) mod 255,(GetGValue(iValue)+120) mod 255,(GetBValue(iValue)+150) mod 255);
//  Result := ColorToRGB(AColor) xor $00FFFFFF;

end;

end.


