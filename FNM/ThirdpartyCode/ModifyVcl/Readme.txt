Modified Delphi Vcl Source
DelphiVer��6.0 Build 6.240
WindowsVer��Windows2000 Build 2195 Sp4
Internet Explorer��6.0.2800.1106 Sp1
(�кž���ʾ�޸�ǰ���к�)
valedit.pas
valedit001	�޸ģ�Line��792
                �޸��ж�����Ϊ��
                if (goEditing in Options) and Assigned(FOnValidate) and Assigned(InplaceEditor) and InplaceEditor.Modified then ��ֹAV
		������InplaceEditor.Modified:=False;��ֹ�޸�һ�κ��Ժ���ѡ�б�ĵ�Ԫ��ʱ,û�б�Ҫ�Ĵ���OnValidate�¼���

StdCtrls.pas
                ���ļ�������DCU�ļ���ԭDelphi��װ���е�DCU�ļ���ͬ.
                ԭDCU�ļ����:TComboBox�ؼ��������б���������,�޷���OnDropDown��OnEnter�¼��м���Items.�����¼��м���Items����������б�����������.���ƴ��ļ������̵�����·�����±��빤�̼��ɽ����BUG.