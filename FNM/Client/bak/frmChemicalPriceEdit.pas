unit frmChemicalPriceEdit;
{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� frmChemicalPriceEdit.pas                                      }
{       �������� 2004-8-26 13:50:57                                            }
{       ������Ա Lvzd                                                          }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       ��������  ���������ϵ���                                               }
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
  //ˢ�½�������
  dtp_ChemicalInBeginDate.Date:=IncDay(TDate(Now), -2);
  dtp_ChemicalInEndDate.Date:=TDate(Now);
  //���ػ��������ƹ��û�ѡ��
  FillItemsFromDataSet(Dictionary.cds_ChemicalList, 'Chemical_Short_Name', 'Chemical_Name', 'Chemical_ID', '--', cbb_ChemicalName.Items);
  OnActivate:=nil;
end;

end.
