unit frmChemicalPriceEdit;
{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 frmChemicalPriceEdit.pas                                      }
{       创建日期 2004-8-26 13:50:57                                            }
{       创建人员 Lvzd                                                          }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述  调整化工料单价                                               }
{                                                                              }
{******************************************************************************}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxSpinEdit;

type
  TChemicalPriceEditForm = class(TForm)
    pnl_Only: TPanel;
    btn_Cancel: TButton;
    btn_Help: TButton;
    txt1: TStaticText;
    cbb_ChemicalName: TComboBox;
    txt2: TStaticText;
    dtp_ChemicalInBeginDate: TDateTimePicker;
    txt3: TStaticText;
    txt4: TStaticText;
    dtp_ChemicalInEndDate: TDateTimePicker;
    btn1: TButton;
    txt5: TStaticText;
    edt1: TEdit;
    chk1: TCheckBox;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ChemicalPriceEditForm: TChemicalPriceEditForm;

implementation

uses DateUtils, uDictionary, uFNMArtInfo;
{$R *.dfm}

procedure TChemicalPriceEditForm.FormActivate(Sender: TObject);
begin
  Application.ProcessMessages;
  //刷新界面数据
  dtp_ChemicalInBeginDate.Date:=IncDay(TDate(Now), -2);
  dtp_ChemicalInEndDate.Date:=TDate(Now);
  //加载化工料名称供用户选择
  FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_Short_Name', 'Chemical_Name', 'Chemical_ID', '--', cbb_ChemicalName.Items);
  OnActivate:=nil;
end;

end.
