{******************************************************************************}
{                                                                              }
{       ������� FNM CLIENT MODEL                                              }
{       ��Ȩ���� (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       ��Ԫ���� UFinishStr.pas                                                }
{       �������� 2004-8-23 ���� 10:25:24                                       }
{       ������Ա lvzd, zhangjy                                                 }
{       �޸���Ա                                                               }
{       �޸�����                                                               }
{       �޸�ԭ��                                                               }
{       ��Ӧ����                                                               }
{       �ֶ�����                                                               }
{       ������ݿ��                                                           }
{       ������Ҫ����/SQL����˵��                                               }
{       �������� �ַ�����Դ�ļ�                                                }
{******************************************************************************}
unit UFinishStr;

interface

resourcestring
{Messages}
  SaveDataSuccess='���ݱ���ɹ�!';
  SaveDataFail='���ݱ���ʧ��!';
  AskSaveDataStr='�޸ĵ�����û�б���,�Ƿ�Ҫ��������?';
  SaveArtHdrDataError='�����������ݱ���ʧ�ܣ������±��棬�򱣴浽�����ļ���';
  SaveArtDtlDataError='������ϸ���ݱ���ʧ�ܣ������±��棬�򱣴浽�����ļ���';
  InvalidGF_NO='��Ч��Ʒ�����!';

{Field Define}



{���÷���:                                                                         }
{TMsgDialog.ShowMsgDialog(GetResourceString(@SaveArtHdrDataError)+sErrorMsg,2500); }
function GetResourceString(const ResString: Pointer): string;
implementation

function GetResourceString(const ResString: Pointer): string;
begin
  Result := LoadResString(PResStringRec(ResString));
end;
end.
