unit frmMFQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, cxGridLevel,
  cxClasses, cxControls, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, ComCtrls, ADODB, Grids,
  DBGrids,Comobj;

type
  TMFQueryForm = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtMachine: TEdit;
    Label2: TLabel;
    dtpDate: TDateTimePicker;
    btnQuery: TButton;
    conn: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    btnToExcel: TButton;
    dtpEnd: TDateTimePicker;
    Label3: TLabel;
    SaveDialog1: TSaveDialog;
    dtptime: TDateTimePicker;
    dtptimeend: TDateTimePicker;
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnQueryClick(Sender: TObject);
    procedure DBGridInFoToExcel(FileName, TitleCaption: string;  MakeDataSource: TDataSet; makeDBGrid: TDBGrid);
    procedure btnToExcelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MFQueryForm: TMFQueryForm;

implementation

{$R *.dfm}

procedure TMFQueryForm.FormDestroy(Sender: TObject);
begin
  MFQueryForm := nil;
end;

procedure TMFQueryForm.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TMFQueryForm.btnQueryClick(Sender: TObject);
var
  connString:WideString;
begin
  ADOQuery1.Close;
  //ADOQuery1.ConnectionString :=  'Provider=SQLNCLI.1;Persist Security Info=True;User ID=Gewmfreader;pwd=Reader#2!@;Initial Catalog=GEWMFDB;Data Source=GETNT15;Auto Translate=True;Workstation ID=PO131832102;MARS Connection=False;';
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Add('select  b.ID,b.MacName,a.PLCValue,a.CreateDate from dbo.PLC a WITH(NOLOCK) ' +
                    '  INNER JOIN dbo.tb_Machine b WITH(NOLOCK) ON b.MacIP = REPLACE(REPLACE(a.IPValue,''#'',''.''),''.menfu.mf1'','''')' +
                    'WHERE a.PLCValue>0 AND a.CreateDate between ' + QuotedStr(DateToStr(dtpDate.DateTime) + ' ' + TimeToStr(dtptime.Time)) +
                    ' AND ' +  QuotedStr(DateToStr(dtpEnd.DateTime) + ' ' + TimeToStr(dtptimeend.Time)) +
                    ' and b.ID = ' + QuotedStr(edtMachine.Text));
  ADOQuery1.Open;
end;

procedure TMFQueryForm.DBGridInFoToExcel(FileName, TitleCaption: string;  MakeDataSource: TDataSet; makeDBGrid: TDBGrid);
var
  xlApp, xlSheet, szValue: Variant;  ARow, iLoop: word;
  ds:TDataSet;
begin  
  xlApp := CreateOleObject('Excel.Application');
  try
    xlSheet := CreateOleObject('Excel.Sheet');
    xlSheet := xlApp.WorkBooks.Add;//   表格标题
    for iLoop := 0 to makeDBGrid.Columns.Count - 1 do
      xlSheet.WorkSheets[1].Cells[1, iLoop + 1] := makeDBGrid.Columns[iLoop].Title.Caption;     // 数据
      ARow := 2;    
      with MakeDataSource do
      begin      
        DisableControls;      
        First;      
        while not Eof do
        begin        
          for iLoop := 0 to Fields.Count - 1 do        
          begin
            szValue := Fields[iLoop].Value;
            xlSheet.WorkSheets[1].Cells[ARow, iLoop + 1] := szValue;
          end;        
          inc(ARow);        
          Next;
        end;
        First;
        EnableControls;
      end;
      try      
        xlSheet.SaveAs(FileName);
        Application.MessageBox('导出完毕!', '提示', MB_IconExclamation);
      finally     
        xlSheet.Close;
        xlApp.Quit;
        xlApp := UnAssigned;    
      end;  
      except
        Application.MessageBox('本机没有安装Excel.', '错误', MB_OK);
    end;
end;

procedure TMFQueryForm.btnToExcelClick(Sender: TObject);
var
  path:string;
  ds:TDataSet;
begin
  if DataSource1.DataSet.RecordCount <=0 then Exit;
  
  SaveDialog1.Filter :='EXCEL文件(*.xls)|*.xls';
  SaveDialog1.Title := '*.xls';
  if SaveDialog1.Execute then
  begin
     path := SaveDialog1.FileName;

     ds :=  DataSource1.DataSet;
     DBGridInFoToExcel(path,'',ds,DBGrid1);
  end;
end;

procedure TMFQueryForm.FormCreate(Sender: TObject);
begin
  dtpDate.DateTime := Now;
  dtptime.Time := Time;
  dtpEnd.DateTime := Now;
  dtptimeend.Time := Time;
end;

end.
