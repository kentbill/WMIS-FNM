Modified DevExpress Control Pack
ControlVer：4.5.2
(行号均表示修改前的行号)
cxGridFooterPopupMenuItems.pas
cxGrid001	修改：Line：236
		增加一个判断语句块:
  if not Assigned(AValueTypeClass) then
  begin
    result := False;
    exit;
  end;
  修正cxGrid在数据集合未打开,右击标题栏或脚注可能会出现AV的BUG

cxCustomData.pas
cxCust001       修改：Line：7197
                注释掉7197-7201共4行语句,解决了分组脚注浮点型数据合计时自动默认为货币数据的BUG.
  该BUG由Delphi的函数VarType的BUG引起的,其源代码有地方注意到了这个问题,只是这个地方忽略了,证据见:
  cxFilter文件中Line：2592

cxGridCustomTableView
cxGrid001       修改5492行 
		添加如下语句:
  ord('c'), ord('C'):
    begin
      if ssCtrl in Shift then
        Clipboard.AsText:=GetDisplayText(Controller.GetFocusedItemIndex);
    end;
  使表格在只读模式下可以复制选定单元格的数据.
cxGridDetailsSite
cxGrDet001       修改154行
	将154行提到163行，放出protected属性：Level到public
cxGridPopupMenu
cxGrPop001       修改428行
	添加下面的语句
  if Grid.FocusedView = nil then
    exit;
解决在cxGrid没有任何GridView的情况下,右键弹出上下文菜单出错的BUG
cxLike001	修改211/214行
	加入UpperCase函数解决用户过滤时必须区别大小写的问题。
cxVari001       修改222行
	将函数体改为：
  if VarIsArray(V1) or VarIsArray(V2) then
    Result := VarArrayCompare(V1, V2)
  else
  try
    {$IFNDEF DELPHI6}
    if VarIsEmpty(V1) or VarIsEmpty(V2) then
    begin
      Result := -1
      exit;
    end;
    {$ENDIF}

    if V1 = V2 then
    begin
      Result := 0;
      exit;
    end;

    if VarIsStr(V1) and VarIsStr(V2) then
    begin
      if UpperCase(V1) = UpperCase(V2) then
      begin
        Result := 0;
        Exit;
      end;
    end;

    {$IFDEF DELPHI6}
    if VarIsNull(V1) then
      Result := -1
    else
      if VarIsNull(V2) then
        Result := 1
      else
    {$ENDIF}
        if V1 < V2 then
          Result := -1
        else
          Result := 1;
  except
    on EVariantError do
      Result := -1;
  end;
	解决了比较相等时大小写敏感的问题。

cxXLSExport
cxXLS001 修改997/1010行。
  解决到出xls文件负数导成字符的问题，增加下面的代码。
    tmpext: Extended;
    ivalue, E: Integer;
  begin
    if not VarIsNull(AValue) then
    begin
      Val(AValue, ivalue, E);
      if E = 0 then
      begin
        SetCellDataInteger(ACol, ARow, AValue);
        Exit;
      end else if TextToFloat(Pchar(String(AValue)), tmpext, fvExtended) then
      begin
        SetCellDataDouble(ACol, ARow, AValue);
        Exit;
      end;
    end;
