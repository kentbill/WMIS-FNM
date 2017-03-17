{******************************************************************************}
{                                                                              }
{       软件名称 FNM CLIENT MODEL                                              }
{       版权所有 (C) 2004-2005 ESQUEL GROUP GET/IT                             }
{       单元名称 UFinishStr.pas                                                }
{       创建日期 2004-8-23 上午 10:25:24                                       }
{       创建人员 lvzd, zhangjy                                                 }
{       修改人员                                                               }
{       修改日期                                                               }
{       修改原因                                                               }
{       对应用例                                                               }
{       字段描述                                                               }
{       相关数据库表                                                           }
{       调用重要函数/SQL对象说明                                               }
{       功能描述 字符串资源文件                                                }
{******************************************************************************}
unit UFinishStr;

interface

resourcestring
{Messages}
  SaveDataSuccess='数据保存成功!';
  SaveDataFail='数据保存失败!';
  AskSaveDataStr='修改的数还没有保存,是否要保存数据?';
  SaveArtHdrDataError='工艺主表数据保存失败，请重新保存，或保存到本地文件中';
  SaveArtDtlDataError='工艺明细数据保存失败，请重新保存，或保存到本地文件中';
  InvalidGF_NO='无效的品名编号!';

{Field Define}



{调用方法:                                                                         }
{TMsgDialog.ShowMsgDialog(GetResourceString(@SaveArtHdrDataError)+sErrorMsg,2500); }
function GetResourceString(const ResString: Pointer): string;
implementation

function GetResourceString(const ResString: Pointer): string;
begin
  Result := LoadResString(PResStringRec(ResString));
end;
end.
