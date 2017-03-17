
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressFilterControl                                         }
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
{   LICENSED TO DISTRIBUTE THE EXPRESSEDITORS AND ALL                }
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

unit cxFilterControlStrs;

{$I cxFilterControlVer.inc} 

interface

resourcestring
//------------------------------------------------------------------------------
// 原始代码
//------------------------------------------------------------------------------
{
  // cxFilterBoolOperator
  cxSFilterBoolOperatorAnd = 'AND';        // all
  cxSFilterBoolOperatorOr = 'OR';          // any
  cxSFilterBoolOperatorNotAnd = 'NOT AND'; // not all
  cxSFilterBoolOperatorNotOr = 'NOT OR';   // not any
  //
  cxSFilterRootButtonCaption = 'Filter';
  cxSFilterAddCondition = 'Add &Condition';
  cxSFilterAddGroup = 'Add &Group';
  cxSFilterRemoveRow = '&Remove Row';
  cxSFilterClearAll = 'Clear &All';
  cxSFilterFooterAddCondition = 'press the button to add a new condition';

  cxSFilterGroupCaption = 'applies to the following conditions';
  cxSFilterRootGroupCaption = '<root>';
  cxSFilterControlNullString = '<empty>';

  cxSFilterErrorBuilding = 'Can''t build filter from source';

  //FilterDialog
  cxSFilterDialogCaption = 'Custom Filter';
  cxSFilterDialogInvalidValue = 'Invalid value';
  cxSFilterDialogUse = 'Use';
  cxSFilterDialogSingleCharacter = 'to represent any single character';
  cxSFilterDialogCharactersSeries = 'to represent any series of characters';
  cxSFilterDialogOperationAnd = 'AND';
  cxSFilterDialogOperationOr = 'OR';
  cxSFilterDialogRows = 'Show rows where:';

  // FilterControlDialog
  cxSFilterControlDialogCaption = 'Filter builder';
  cxSFilterControlDialogNewFile = 'untitled.flt';
  cxSFilterControlDialogOpenDialogCaption = 'Open an existing filter';
  cxSFilterControlDialogSaveDialogCaption = 'Save the active filter to file';
  cxSFilterControlDialogActionSaveCaption = '&Save As...';
  cxSFilterControlDialogActionOpenCaption = '&Open...';
  cxSFilterControlDialogActionApplyCaption = '&Apply';
  cxSFilterControlDialogActionOkCaption = 'OK';
  cxSFilterControlDialogActionCancelCaption = 'Cancel';
  cxSFilterControlDialogFileExt = 'flt';
  cxSFilterControlDialogFileFilter = 'Filters (*.flt)|*.flt';
}
//------------------------------------------------------------------------------
// End Of原始代码
//------------------------------------------------------------------------------
// Lv, zu de 汉化
//------------------------------------------------------------------------------
  // cxFilterBoolOperator
  cxSFilterBoolOperatorAnd = '与';        // all
  cxSFilterBoolOperatorOr = '或';          // any
  cxSFilterBoolOperatorNotAnd = '非(与)'; // not all
  cxSFilterBoolOperatorNotOr = '非(或)';   // not any
  //
  cxSFilterRootButtonCaption = '过滤条件';
  cxSFilterAddCondition = '增加条件(&C)';
  cxSFilterAddGroup = '增加分组(&G)';                
  cxSFilterRemoveRow = '删除行(&R)';
  cxSFilterClearAll = '删除所有(&A)';
  cxSFilterFooterAddCondition = '增加一个新条件';

  cxSFilterGroupCaption = '应用所有条件';
  cxSFilterRootGroupCaption = '<根节点>';
  cxSFilterControlNullString = '<空>';

  cxSFilterErrorBuilding = '不能建立过滤';

  //FilterDialog
  cxSFilterDialogCaption = '自定义条件';
  cxSFilterDialogInvalidValue = '无效的值';
  cxSFilterDialogUse = '使用';
  cxSFilterDialogSingleCharacter = '代表单个字符';
  cxSFilterDialogCharactersSeries = '代表任意多个字符';
  cxSFilterDialogOperationAnd = '与';
  cxSFilterDialogOperationOr = '或';
  cxSFilterDialogRows = '显示行:';

  // FilterControlDialog
  cxSFilterControlDialogCaption = '过滤条件编辑器';
  cxSFilterControlDialogNewFile = '无标题.flt';
  cxSFilterControlDialogOpenDialogCaption = '打开过滤条件';
  cxSFilterControlDialogSaveDialogCaption = '保存过滤条件';
  cxSFilterControlDialogActionSaveCaption = '另存为(&S)...';
  cxSFilterControlDialogActionOpenCaption = '打开(&O)...';
  cxSFilterControlDialogActionApplyCaption = '应用(&A)';
  cxSFilterControlDialogActionOkCaption = '确定';
  cxSFilterControlDialogActionCancelCaption = '取消';
  cxSFilterControlDialogFileExt = 'flt';
  cxSFilterControlDialogFileFilter = '过滤文件 (*.flt)|*.flt';
//------------------------------------------------------------------------------
// End Of Lv, zu de 汉化
//------------------------------------------------------------------------------
implementation

end.
