Modified DevExpress Control Pack
ControlVer��4.5.2
(�кž���ʾ�޸�ǰ���к�)
cxGridFooterPopupMenuItems.pas
cxGrid001	�޸ģ�Line��236
		����һ���ж�����:
  if not Assigned(AValueTypeClass) then
  begin
    result := False;
    exit;
  end;
  ����cxGrid�����ݼ���δ��,�һ����������ע���ܻ����AV��BUG

cxCustomData.pas
cxCust001       �޸ģ�Line��7197
                ע�͵�7197-7201��4�����,����˷����ע���������ݺϼ�ʱ�Զ�Ĭ��Ϊ�������ݵ�BUG.
  ��BUG��Delphi�ĺ���VarType��BUG�����,��Դ�����еط�ע�⵽���������,ֻ������ط�������,֤�ݼ�:
  cxFilter�ļ���Line��2592

cxGridCustomTableView
cxGrid001       �޸�5492�� 
		����������:
  ord('c'), ord('C'):
    begin
      if ssCtrl in Shift then
        Clipboard.AsText:=GetDisplayText(Controller.GetFocusedItemIndex);
    end;
  ʹ�����ֻ��ģʽ�¿��Ը���ѡ����Ԫ�������.
cxGridDetailsSite
cxGrDet001       �޸�154��
	��154���ᵽ163�У��ų�protected���ԣ�Level��public
cxGridPopupMenu
cxGrPop001       �޸�428��
	�����������
  if Grid.FocusedView = nil then
    exit;
�����cxGridû���κ�GridView�������,�Ҽ����������Ĳ˵������BUG
cxLike001	�޸�211/214��
	����UpperCase��������û�����ʱ���������Сд�����⡣
cxVari001       �޸�222��
	���������Ϊ��
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
	����˱Ƚ����ʱ��Сд���е����⡣

cxXLSExport
cxXLS001 �޸�997/1010�С�
  �������xls�ļ����������ַ������⣬��������Ĵ��롣
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
