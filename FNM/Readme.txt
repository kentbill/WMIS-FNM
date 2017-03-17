<<<<<<< .minesdfs
配置编译环境
=======
配置编译环境 test 3333a afs
>>>>>>> .r13468

在Project Options -> Directories/COnditionals -> Search path 里增加下面路径;
  ..\Client\Class;..\Server;..\UserRight;..\Client\ThirdpartyCode\ModifyVcl\;..\Client\ThirdpartyCode\HanExpress

注意: 在安装CXGrid 控件时请选择 Add Source To Local,否则系统编辑不过。在FNMQuery模块修改了部分CXGrid的源代码
 

中间层调用帮助

0 定义变量
    var vData: OleVariant;
    sCondition,sErrorMsg: WideString;
1 查询及保存SQL的语句
   SELECT * FROM FNMDB.dbo.fnSQLList

2 查询数据，可返回任意多个数据
    sCondition := ''''','+ ''''''+','+ QuotedStr(edtCPBColor.Text);
    FNMServerObj.GetQueryData(vData,'CPBGetColor',sCondition,sErrorMsg);

  客户端调用：
     返回单个数据集  ClientDataSet.Data := vData;
     返回多个数据集  ClientDataSet1.Data := vData[0];
                     ClientDataSet2.Data := vData[1];
                     ClientDataSet2.Data := vData[2];
  
3 保存数据
    sCondition := QuotedStr(sNote_NO)+ ','+ QuotedStr(Login.LoginName)+','+QuotedStr('R');
    FNMServerObj.SaveDataBySQL('CancelFabricInfo',sCondition,sErrorMsg);
4 保存数据并返回单值
    sCondition := QuotedStr(sFNCardList)+',' + QuotedStr(sDestination)+','+ QuotedStr(Login.CurrentDepartment)
                  +',' + QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQLEx('SaveSendInfo',sCondition,sNote_NO,sErrorMsg);
