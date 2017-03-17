
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressDataController                                        }
{                                                                    }
{       Copyright (c) 1998-2003 Developer Express Inc.               }
{       ALL RIGHTS RESERVED                                          }
{                                                                    }
{   The entire contents of this file is protected by U.S. and        }
{   International Copyright Laws. Unauthorized reproduction,         }
{   reverse-engineering, and distribution of all or any portion of   }
{   the code contained in this file is strictly prohibited and may   }
{   result in severe civil and criminal penalties and will be        }
{   prosecuted to the maximum extent possible under the law.         }
{                                                                    }
{   RESTRICTIONS                                                     }
{                                                                    }
{   THIS SOURCE CODE AND ALL RESULTING INTERMEDIATE FILES            }
{   (DCU, OBJ, DLL, ETC.) ARE CONFIDENTIAL AND PROPRIETARY TRADE     }
{   SECRETS OF DEVELOPER EXPRESS INC. THE REGISTERED DEVELOPER IS    }
{   LICENSED TO DISTRIBUTE THE EXPRESSDATACONTROLLER AND ALL         }
{   ACCOMPANYING VCL CONTROLS AS PART OF AN EXECUTABLE PROGRAM ONLY. }
{                                                                    }
{   THE SOURCE CODE CONTAINED WITHIN THIS FILE AND ALL RELATED       }
{   FILES OR ANY PORTION OF ITS CONTENTS SHALL AT NO TIME BE         }
{   COPIED, TRANSFERRED, SOLD, DISTRIBUTED, OR OTHERWISE MADE        }
{   AVAILABLE TO OTHER INDIVIDUALS WITHOUT EXPRESS WRITTEN CONSENT   }
{   AND PERMISSION FROM DEVELOPER EXPRESS INC.                       }
{                                                                    }
{   CONSULT THE END USER LICENSE AGREEMENT FOR INFORMATION ON        }
{   ADDITIONAL RESTRICTIONS.                                         }
{                                                                    }
{********************************************************************}

unit cxFilterConsts;

{$I cxDataVer.inc}

interface

resourcestring
//------------------------------------------------------------------------------
// 原始代码
//------------------------------------------------------------------------------
{
  // base operators
  cxSFilterOperatorEqual = 'equals';
  cxSFilterOperatorNotEqual = 'does not equal';
  cxSFilterOperatorLess = 'is less than';
  cxSFilterOperatorLessEqual = 'is less than or equal to';
  cxSFilterOperatorGreater = 'is greater than';
  cxSFilterOperatorGreaterEqual = 'is greater than or equal to';
  cxSFilterOperatorLike = 'like';
  cxSFilterOperatorNotLike = 'not like';
  cxSFilterOperatorBetween = 'between';
  cxSFilterOperatorNotBetween = 'not between';
  cxSFilterOperatorInList = 'in';
  cxSFilterOperatorNotInList = 'not in';

  cxSFilterOperatorYesterday = 'is yesterday';
  cxSFilterOperatorToday = 'is today';
  cxSFilterOperatorTomorrow = 'is tomorrow';

  cxSFilterOperatorLastWeek = 'is last week';
  cxSFilterOperatorLastMonth = 'is last month';
  cxSFilterOperatorLastYear = 'is last year';

  cxSFilterOperatorThisWeek = 'is this week';
  cxSFilterOperatorThisMonth = 'is this month';
  cxSFilterOperatorThisYear = 'is this year';

  cxSFilterOperatorNextWeek = 'is next week';
  cxSFilterOperatorNextMonth = 'is next month';
  cxSFilterOperatorNextYear = 'is next year';

  cxSFilterAndCaption = 'and';
  cxSFilterOrCaption = 'or';
  cxSFilterNotCaption = 'not';
  cxSFilterBlankCaption = 'blank';

  // derived
  cxSFilterOperatorIsNull = 'is blank';
  cxSFilterOperatorIsNotNull = 'is not blank';
  cxSFilterOperatorBeginsWith = 'begins with';
  cxSFilterOperatorDoesNotBeginWith = 'does not begin with';
  cxSFilterOperatorEndsWith = 'ends with';
  cxSFilterOperatorDoesNotEndWith = 'does not end with';
  cxSFilterOperatorContains = 'contains';
  cxSFilterOperatorDoesNotContain = 'does not contain';
  // filter listbox's values
  cxSFilterBoxAllCaption = '(All)';
  cxSFilterBoxCustomCaption = '(Custom...)';
  cxSFilterBoxBlanksCaption = '(Blanks)';
  cxSFilterBoxNonBlanksCaption = '(NonBlanks)';
}
//------------------------------------------------------------------------------
// End Of原始代码
//------------------------------------------------------------------------------
// Lv, zu de 汉化
//------------------------------------------------------------------------------
  // base operators
  cxSFilterOperatorEqual = '等于';
  cxSFilterOperatorNotEqual = '不等于';
  cxSFilterOperatorLess = '小于';
  cxSFilterOperatorLessEqual = '小于等于';
  cxSFilterOperatorGreater = '大于';
  cxSFilterOperatorGreaterEqual = '大于等于';
  cxSFilterOperatorLike = '相似于';
  cxSFilterOperatorNotLike = '不相似于';
  cxSFilterOperatorBetween = '在...之间';
  cxSFilterOperatorNotBetween = '不在...之间';
  cxSFilterOperatorInList = '在...之中';
  cxSFilterOperatorNotInList = '不在...之中';

  cxSFilterOperatorYesterday = '昨天';
  cxSFilterOperatorToday = '今天';
  cxSFilterOperatorTomorrow = '明天';

  cxSFilterOperatorLastWeek = '上周';
  cxSFilterOperatorLastMonth = '上个月';
  cxSFilterOperatorLastYear = '去年';

  cxSFilterOperatorThisWeek = '本周';
  cxSFilterOperatorThisMonth = '本月';
  cxSFilterOperatorThisYear = '今年';

  cxSFilterOperatorNextWeek = '下周';
  cxSFilterOperatorNextMonth = '下个月';
  cxSFilterOperatorNextYear = '明年';

  cxSFilterAndCaption = '与';
  cxSFilterOrCaption = '或';
  cxSFilterNotCaption = '非';
  cxSFilterBlankCaption = '空';

  // derived
  cxSFilterOperatorIsNull = '为空';
  cxSFilterOperatorIsNotNull = '不为空';
  cxSFilterOperatorBeginsWith = '始于';
  cxSFilterOperatorDoesNotBeginWith = '并非起始于';
  cxSFilterOperatorEndsWith = '结束于';
  cxSFilterOperatorDoesNotEndWith = '并非结束于';
  cxSFilterOperatorContains = '包含';
  cxSFilterOperatorDoesNotContain = '不包含';
  // filter listbox's values
  cxSFilterBoxAllCaption = '(所有)';
  cxSFilterBoxCustomCaption = '(自定义...)';
  cxSFilterBoxBlanksCaption = '(空)';
  cxSFilterBoxNonBlanksCaption = '(非空)';
//------------------------------------------------------------------------------
// End Of Lv, zu de 汉化
//------------------------------------------------------------------------------
function cxSFilterString(const ResString: Pointer): string;

type
  TcxFilterGetResourceStringFunc = function (const ResString: Pointer): string;

var
  cxFilterGetResourceStringFunc: TcxFilterGetResourceStringFunc = cxSFilterString;

implementation

function cxSFilterString(const ResString: Pointer): string;
begin
  if Assigned(cxFilterGetResourceStringFunc) then
    Result := cxFilterGetResourceStringFunc(ResString) 
  else
    Result := LoadResString(PResStringRec(ResString));
end;

end.
