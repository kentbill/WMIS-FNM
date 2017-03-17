Modified Delphi Vcl Source
DelphiVer：6.0 Build 6.240
WindowsVer：Windows2000 Build 2195 Sp4
Internet Explorer：6.0.2800.1106 Sp1
(行号均表示修改前的行号)
valedit.pas
valedit001	修改：Line：792
                修改判断条件为：
                if (goEditing in Options) and Assigned(FOnValidate) and Assigned(InplaceEditor) and InplaceEditor.Modified then 防止AV
		增加行InplaceEditor.Modified:=False;防止修改一次后以后在选中别的单元格时,没有必要的触发OnValidate事件。

StdCtrls.pas
                该文件编译后的DCU文件和原Delphi安装包中的DCU文件不同.
                原DCU文件造成:TComboBox控件的下拉列表弹出不正常,无法在OnDropDown和OnEnter事件中加载Items.若该事件中加载Items会造成下拉列表立即被收起.复制此文件到工程的搜索路径重新编译工程即可解决此BUG.