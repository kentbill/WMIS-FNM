
{********************************************************************}
{                                                                    }
{       Developer Express Visual Component Library                   }
{       ExpressEditors                                               }
{                                                                    }
{       Copyright (c) 1998-2004 Developer Express Inc.               }
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

unit cxEditConsts;

interface

resourcestring
//------------------------------------------------------------------------------
// 原始代码
//------------------------------------------------------------------------------
{
  cxSEditDateConvertError = 'Could not convert to date';
  cxSEditInvalidRepositoryItem = 'The repository item is not acceptable';
  cxSEditNumericValueConvertError = 'Could not convert to numeric value';
  cxSEditPopupCircularReferencingError = 'Circular referencing is not allowed';
  cxSEditPostError = 'An error occured during posting edit value';
  cxSEditTimeConvertError = 'Could not convert to time';
  cxSEditValidateErrorText = 'Invalid input value. Use escape key to abandon changes';
  cxSEditValueOutOfBounds = 'Value out of bounds';

  // TODO
  cxSEditCheckBoxChecked             = 'True';
  cxSEditCheckBoxGrayed              = '';
  cxSEditCheckBoxUnchecked           = 'False';
  cxSRadioGroupDefaultCaption        = '';

  cxSTextTrue                        = 'True';
  cxSTextFalse                       = 'False';

  // blob
  cxSBlobButtonOK                    = '&OK';
  cxSBlobButtonCancel                = '&Cancel';
  cxSBlobButtonClose                 = '&Close';
  cxSBlobMemo                        = '(MEMO)';
  cxSBlobMemoEmpty                   = '(memo)';
  cxSBlobPicture                     = '(PICTURE)';
  cxSBlobPictureEmpty                = '(picture)';

  // popup menu items
  cxSMenuItemCaptionCut              = 'Cu&t';
  cxSMenuItemCaptionCopy             = '&Copy';
  cxSMenuItemCaptionPaste            = '&Paste';
  cxSMenuItemCaptionDelete           = '&Delete';
  cxSMenuItemCaptionLoad             = '&Load...';
  cxSMenuItemCaptionSave             = 'Save &As...';

  // date
  cxSDatePopupClear                  = 'Clear';
  cxSDatePopupNow                    = 'Now';
  cxSDatePopupOK                     = 'OK';
  cxSDatePopupToday                  = 'Today';
  cxSDateError                       = 'Invalid Date';
  // smart input consts
  cxSDateToday                       = 'today';
  cxSDateYesterday                   = 'yesterday';
  cxSDateTomorrow                    = 'tomorrow';
  cxSDateSunday                      = 'Sunday';
  cxSDateMonday                      = 'Monday';
  cxSDateTuesday                     = 'Tuesday';
  cxSDateWednesday                   = 'Wednesday';
  cxSDateThursday                    = 'Thursday';
  cxSDateFriday                      = 'Friday';
  cxSDateSaturday                    = 'Saturday';
  cxSDateFirst                       = 'first';
  cxSDateSecond                      = 'second';
  cxSDateThird                       = 'third';
  cxSDateFourth                      = 'fourth';
  cxSDateFifth                       = 'fifth';
  cxSDateSixth                       = 'sixth';
  cxSDateSeventh                     = 'seventh';
  cxSDateBOM                         = 'bom';
  cxSDateEOM                         = 'eom';
  cxSDateNow                         = 'now';

  // calculator
  scxSCalcError                      = 'Error';

  // HyperLink
  scxSHyperLinkPrefix                = 'http://';
  scxSHyperLinkDoubleSlash           = '//';

  // edit repository
  scxSEditRepositoryBlobItem         = 'BlobEdit|Represents the BLOB editor';
  scxSEditRepositoryButtonItem       = 'ButtonEdit|Represents an edit control with embedded buttons';
  scxSEditRepositoryCalcItem         = 'CalcEdit|Represents an edit control with a dropdown calculator window';
  scxSEditRepositoryCheckBoxItem     = 'CheckBox|Represents a check box control that allows selecting an option';
  scxSEditRepositoryComboBoxItem     = 'ComboBox|Represents the combo box editor';
  scxSEditRepositoryCurrencyItem     = 'CurrencyEdit|Represents an editor enabling editing currency data';
  scxSEditRepositoryDateItem         = 'DateEdit|Represents an edit control with a dropdown calendar';
  scxSEditRepositoryHyperLinkItem    = 'HyperLink|Represents a text editor with hyperlink functionality';
  scxSEditRepositoryImageComboBoxItem = 'ImageComboBox|Represents an editor displaying the list of images and text strings within the dropdown window';
  scxSEditRepositoryImageItem        = 'Image|Represents an image editor';
  scxSEditRepositoryLookupComboBoxItem = 'LookupComboBox|Represents a lookup combo box control';
  scxSEditRepositoryMaskItem         = 'MaskEdit|Represents a generic masked edit control.';
  scxSEditRepositoryMemoItem         = 'Memo|Represents an edit control that allows editing memo data';
  scxSEditRepositoryMRUItem          = 'MRUEdit|Represents a text editor displaying the list of most recently used items (MRU) within a dropdown window';
  scxSEditRepositoryPopupItem        = 'PopupEdit|Represents an edit control with a dropdown list';
  scxSEditRepositorySpinItem         = 'SpinEdit|Represents a spin editor';
  scxSEditRepositoryRadioGroupItem   = 'RadioGroup|Represents a group of radio buttons';
  scxSEditRepositoryTextItem         = 'TextEdit|Represents a single line text editor';
  scxSEditRepositoryTimeItem         = 'TimeEdit|Represents an editor displaying time values';

  scxRegExprLine = 'Line';
  scxRegExprChar = 'Char';
  scxRegExprNotAssignedSourceStream = 'The source stream is not assigned';
  scxRegExprEmptySourceStream = 'The source stream is empty';
  scxRegExprCantUsePlusQuantifier = 'The ''+'' quantifier cannot be applied here';
  scxRegExprCantUseStarQuantifier = 'The ''*'' quantifier cannot be applied here';
  scxRegExprCantCreateEmptyAlt = 'The alternative should not be empty';
  scxRegExprCantCreateEmptyBlock = 'The block should not be empty';
  scxRegExprIllegalSymbol = 'Illegal ''%s''';
  scxRegExprIllegalQuantifier = 'Illegal quantifier ''%s''';
  scxRegExprNotSupportQuantifier = 'The parameter quantifiers are not supported';
  scxRegExprIllegalIntegerValue = 'Illegal integer value';
  scxRegExprTooBigReferenceNumber = 'Too big reference number';
  scxRegExprCantCreateEmptyEnum = 'Can''t create empty enumeration';
  scxRegExprSubrangeOrder = 'The starting character of the subrange must be less than the finishing one';
  scxRegExprHexNumberExpected0 = 'Hexadecimal number expected';
  scxRegExprHexNumberExpected = 'Hexadecimal number expected but ''%s'' found';
  scxRegExprMissing = 'Missing ''%s''';
  scxRegExprUnnecessary = 'Unnecessary ''%s''';
  scxRegExprIncorrectSpace = 'The space character is not allowed after ''\''';
  scxRegExprNotCompiled = 'Regular expression is not compiled';
  scxRegExprIncorrectParameterQuantifier = 'Incorrect parameter quantifier';
  scxRegExprCantUseParameterQuantifier = 'The parameter quantifier cannot be applied here';

  scxMaskEditRegExprError = 'Regular expression errors:';
  scxMaskEditInvalidEditValue = 'The edit value is invalid';
  scxMaskEditNoMask = 'None';
  scxMaskEditIllegalFileFormat = 'Illegal file format';
  scxMaskEditEmptyMaskCollectionFile = 'The mask collection file is empty';
  scxMaskEditMaskCollectionFiles = 'Mask collection files';
  cxSSpinEditInvalidNumericValue = 'Invalid numeric value';
}
//------------------------------------------------------------------------------
// End Of原始代码
//------------------------------------------------------------------------------
// Lv, zu de 汉化
//------------------------------------------------------------------------------
  cxSEditDateConvertError = 'Could not convert to date';
  cxSEditInvalidRepositoryItem = 'The repository item is not acceptable';
  cxSEditNumericValueConvertError = 'Could not convert to numeric value';
  cxSEditPopupCircularReferencingError = 'Circular referencing is not allowed';
  cxSEditPostError = 'An error occured during posting edit value';
  cxSEditTimeConvertError = 'Could not convert to time';
  cxSEditValidateErrorText = 'Invalid input value. Use escape key to abandon changes';
  cxSEditValueOutOfBounds = 'Value out of bounds';

  // TODO
  cxSEditCheckBoxChecked             = 'True';
  cxSEditCheckBoxGrayed              = '';
  cxSEditCheckBoxUnchecked           = 'False';
  cxSRadioGroupDefaultCaption        = '';

  cxSTextTrue                        = 'True';
  cxSTextFalse                       = 'False';

  // blob
  cxSBlobButtonOK                    = '&OK';
  cxSBlobButtonCancel                = '&Cancel';
  cxSBlobButtonClose                 = '&Close';
  cxSBlobMemo                        = '(MEMO)';
  cxSBlobMemoEmpty                   = '(memo)';
  cxSBlobPicture                     = '(PICTURE)';
  cxSBlobPictureEmpty                = '(picture)';

  // popup menu items
  cxSMenuItemCaptionCut              = 'Cu&t';
  cxSMenuItemCaptionCopy             = '&Copy';
  cxSMenuItemCaptionPaste            = '&Paste';
  cxSMenuItemCaptionDelete           = '&Delete';
  cxSMenuItemCaptionLoad             = '&Load...';
  cxSMenuItemCaptionSave             = 'Save &As...';

  // date
  cxSDatePopupClear                  = '清除';
  cxSDatePopupNow                    = 'Now';
  cxSDatePopupOK                     = 'OK';
  cxSDatePopupToday                  = '今天';
  cxSDateError                       = 'Invalid Date';
  // smart input consts
  cxSDateToday                       = '今天';
  cxSDateYesterday                   = 'yesterday';
  cxSDateTomorrow                    = 'tomorrow';
  cxSDateSunday                      = 'Sunday';
  cxSDateMonday                      = 'Monday';
  cxSDateTuesday                     = 'Tuesday';
  cxSDateWednesday                   = 'Wednesday';
  cxSDateThursday                    = 'Thursday';
  cxSDateFriday                      = 'Friday';
  cxSDateSaturday                    = 'Saturday';
  cxSDateFirst                       = 'first';
  cxSDateSecond                      = 'second';
  cxSDateThird                       = 'third';
  cxSDateFourth                      = 'fourth';
  cxSDateFifth                       = 'fifth';
  cxSDateSixth                       = 'sixth';
  cxSDateSeventh                     = 'seventh';
  cxSDateBOM                         = 'bom';
  cxSDateEOM                         = 'eom';
  cxSDateNow                         = 'now';

  // calculator
  scxSCalcError                      = 'Error';

  // HyperLink
  scxSHyperLinkPrefix                = 'http://';
  scxSHyperLinkDoubleSlash           = '//';

  // edit repository
  scxSEditRepositoryBlobItem         = 'BlobEdit|Represents the BLOB editor';
  scxSEditRepositoryButtonItem       = 'ButtonEdit|Represents an edit control with embedded buttons';
  scxSEditRepositoryCalcItem         = 'CalcEdit|Represents an edit control with a dropdown calculator window';
  scxSEditRepositoryCheckBoxItem     = 'CheckBox|Represents a check box control that allows selecting an option';
  scxSEditRepositoryComboBoxItem     = 'ComboBox|Represents the combo box editor';
  scxSEditRepositoryCurrencyItem     = 'CurrencyEdit|Represents an editor enabling editing currency data';
  scxSEditRepositoryDateItem         = 'DateEdit|Represents an edit control with a dropdown calendar';
  scxSEditRepositoryHyperLinkItem    = 'HyperLink|Represents a text editor with hyperlink functionality';
  scxSEditRepositoryImageComboBoxItem = 'ImageComboBox|Represents an editor displaying the list of images and text strings within the dropdown window';
  scxSEditRepositoryImageItem        = 'Image|Represents an image editor';
  scxSEditRepositoryLookupComboBoxItem = 'LookupComboBox|Represents a lookup combo box control';
  scxSEditRepositoryMaskItem         = 'MaskEdit|Represents a generic masked edit control.';
  scxSEditRepositoryMemoItem         = 'Memo|Represents an edit control that allows editing memo data';
  scxSEditRepositoryMRUItem          = 'MRUEdit|Represents a text editor displaying the list of most recently used items (MRU) within a dropdown window';
  scxSEditRepositoryPopupItem        = 'PopupEdit|Represents an edit control with a dropdown list';
  scxSEditRepositorySpinItem         = 'SpinEdit|Represents a spin editor';
  scxSEditRepositoryRadioGroupItem   = 'RadioGroup|Represents a group of radio buttons';
  scxSEditRepositoryTextItem         = 'TextEdit|Represents a single line text editor';
  scxSEditRepositoryTimeItem         = 'TimeEdit|Represents an editor displaying time values';

  scxRegExprLine = 'Line';
  scxRegExprChar = 'Char';
  scxRegExprNotAssignedSourceStream = 'The source stream is not assigned';
  scxRegExprEmptySourceStream = 'The source stream is empty';
  scxRegExprCantUsePlusQuantifier = 'The ''+'' quantifier cannot be applied here';
  scxRegExprCantUseStarQuantifier = 'The ''*'' quantifier cannot be applied here';
  scxRegExprCantCreateEmptyAlt = 'The alternative should not be empty';
  scxRegExprCantCreateEmptyBlock = 'The block should not be empty';
  scxRegExprIllegalSymbol = 'Illegal ''%s''';
  scxRegExprIllegalQuantifier = 'Illegal quantifier ''%s''';
  scxRegExprNotSupportQuantifier = 'The parameter quantifiers are not supported';
  scxRegExprIllegalIntegerValue = 'Illegal integer value';
  scxRegExprTooBigReferenceNumber = 'Too big reference number';
  scxRegExprCantCreateEmptyEnum = 'Can''t create empty enumeration';
  scxRegExprSubrangeOrder = 'The starting character of the subrange must be less than the finishing one';
  scxRegExprHexNumberExpected0 = 'Hexadecimal number expected';
  scxRegExprHexNumberExpected = 'Hexadecimal number expected but ''%s'' found';
  scxRegExprMissing = 'Missing ''%s''';
  scxRegExprUnnecessary = 'Unnecessary ''%s''';
  scxRegExprIncorrectSpace = 'The space character is not allowed after ''\''';
  scxRegExprNotCompiled = 'Regular expression is not compiled';
  scxRegExprIncorrectParameterQuantifier = 'Incorrect parameter quantifier';
  scxRegExprCantUseParameterQuantifier = 'The parameter quantifier cannot be applied here';

  scxMaskEditRegExprError = 'Regular expression errors:';
  scxMaskEditInvalidEditValue = 'The edit value is invalid';
  scxMaskEditNoMask = 'None';
  scxMaskEditIllegalFileFormat = 'Illegal file format';
  scxMaskEditEmptyMaskCollectionFile = 'The mask collection file is empty';
  scxMaskEditMaskCollectionFiles = 'Mask collection files';
  cxSSpinEditInvalidNumericValue = 'Invalid numeric value';
//------------------------------------------------------------------------------
// End Of Lv, zu de 汉化
//------------------------------------------------------------------------------
implementation

end.
