<<<<<<< .minesdfs
���ñ��뻷��
=======
���ñ��뻷�� test 3333a afs
>>>>>>> .r13468

��Project Options -> Directories/COnditionals -> Search path ����������·��;
  ..\Client\Class;..\Server;..\UserRight;..\Client\ThirdpartyCode\ModifyVcl\;..\Client\ThirdpartyCode\HanExpress

ע��: �ڰ�װCXGrid �ؼ�ʱ��ѡ�� Add Source To Local,����ϵͳ�༭��������FNMQueryģ���޸��˲���CXGrid��Դ����
 

�м����ð���

0 �������
    var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
1 ��ѯ������SQL�����
   SELECT * FROM FNMDB.dbo.fnSQLList

2 ��ѯ���ݣ��ɷ�������������
    sCondition := ''''','+ ''''''+','+ QuotedStr(edtCPBColor.Text);
    FNMServerObj.GetQueryData(vData,'CPBGetColor',sCondition,sErrorMsg);

  �ͻ��˵��ã�
     ���ص������ݼ�  ClientDataSet.Data := vData;
     ���ض�����ݼ�  ClientDataSet1.Data := vData[0];
                     ClientDataSet2.Data := vData[1];
                     ClientDataSet2.Data := vData[2];
  
3 ��������
    sCondition := QuotedStr(sNote_NO)+ ','+ QuotedStr(Login.LoginName)+','+QuotedStr('R');
    FNMServerObj.SaveDataBySQL('CancelFabricInfo',sCondition,sErrorMsg);
4 �������ݲ����ص�ֵ
    sCondition := QuotedStr(sFNCardList)+',' + QuotedStr(sDestination)+','+ QuotedStr(Login.CurrentDepartment)
                  +',' + QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQLEx('SaveSendInfo',sCondition,sNote_NO,sErrorMsg);
