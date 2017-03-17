program FNM;

{$I Terminal.inc}

{$IFDEF TERMINAL}
  {$MESSAGE ERROR '请修改Terminal.inc注释行:$DEFINE TERMINAL'}

{$ENDIF}

{$Message ' 中间层调用帮助'}
{
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
    sCondition := QuotedStr(sFNCardList)+',' + QuotedStr(sDestination)+','+ QuotedStr(Login.CurrentDepartment)+',' +
                  QuotedStr(Login.LoginName);
    FNMServerObj.SaveDataBySQLEx('SaveSendInfo',sCondition,sNote_NO,sErrorMsg);
    
5 报表预览及打印(Ctrl)
  if (HiWord(GetKeyState(VK_CONTROL)) <> 0)then
    rptWeigh.Preview
  else
    rptWeigh.Print;
}
uses
  Forms,
  Windows,
  Messages,
  ServerDllPub in 'Common\ServerDllPub.pas',
  uAppOption in 'Class\uAppOption.pas',
  uDictionary in 'Class\uDictionary.pas',
  uFNMArtInfo in 'Class\uFNMArtInfo.pas',
  uFNMResource in 'Common\uFNMResource.pas',
  uGlobal in 'Common\uGlobal.pas',
  uGridDecorator in 'Class\uGridDecorator.pas',
  uLogin in 'Class\uLogin.pas',
  UExportActions in 'Common\uExportActions.pas',
  uQueryControl in 'Class\uQueryControl.pas',
  uQueryDictionary in 'Class\uQueryDictionary.pas',
  uOutLookMail in 'Common\uOutLookMail.pas',
  uShowMessage in 'Class\uShowMessage.pas',
  uVersionInfo in 'Class\uVersionInfo.pas',
  frmAccident in 'Form\frmAccident.pas' {AccidentForm},
  frmAnalysisQuality in 'Form\frmAnalysisQuality.pas' {AnalysisQualityForm},
  frmArtReview in 'Form\frmArtReview.pas' {ArtReviewForm},
  frmBase in 'Form\frmBase.pas' {BaseForm},
  frmCreateSample in 'Form\frmCreateSample.pas' {CreateSampleForm},
  frmDictionary in 'Form\frmDictionary.pas' {WebQueryForm},
  frmDisposeAccident in 'Form\frmDisposeAccident.pas' {DisposeAccidentForm},
  frmDistributeTerminal in 'Form\frmDistributeTerminal.pas' {DistributeTerminalForm},
  frmFactArtInfo in 'Form\frmFactArtInfo.pas' {FactArtInfoForm},
  frmFNCardProperty in 'Form\frmFNCardProperty.pas' {FNCardPropertyForm},
  frmHLManage in 'Form\frmHLManage.pas' {HLManageForm},
  frmMachineSample in 'Form\frmMachineSample.pas' {MachineSampleForm},
  frmMachineTerminal in 'Form\frmMachineTerminal.pas' {MachineTerminalForm},
  frmMain in 'Form\frmMain.pas' {FNMMainForm},
  frmOption in 'Form\frmOption.pas' {OptionForm},
  frmPlan in 'Form\frmPlan.pas' {PlanForm},
  frmPrintFNCard in 'Form\frmPrintFNCard.pas' {PrintFNCardForm},
  frmReceiveInfo in 'Form\frmReceiveInfo.pas' {ReceiveInfoForm},
  frmHandRecipe in 'Form\frmHandRecipe.pas' {HandRecipeForm},
  frmRecipePlan in 'Form\frmRecipePlan.pas' {RecipePlanForm},
  frmRecipeTerminal in 'Form\frmRecipeTerminal.pas' {RecipeTerminalForm},
  frmSupplyRecipe in 'Form\frmSupplyRecipe.pas' {SupplyRecipeForm},
  rptRecipe in 'Report\rptRecipe.pas' {RecipeReport},
  frmRepairArtInfo in 'Form\frmRepairArtInfo.pas' {RepairArtInfoForm},
  frmRePrintNoteNO in 'Form\frmRePrintNoteNO.pas' {RePrintNoteNOForm},
  frmSendInfo in 'Form\frmSendInfo.pas' {SendInfoForm},
  frmStdArtInfo in 'Form\frmStdArtInfo.pas' {StdArtInfoForm},
  frmWorker in 'Form\frmWorker.pas' {WorkerForm},
  frmWorkerStation in 'Form\frmWorkerStation.pas' {WorkerStationForm},
  rptSendInfo in 'Report\rptSendInfo.pas' {SendInfoReport},
  frmCancelSendInfo in 'Form\frmCancelSendInfo.pas' {CancelSendInfoForm},
  frmOTD in 'Form\frmOTD.pas' {OTDForm},
  frmEditOTD in 'Form\frmEditOTD.pas' {EditOTDForm},
  frmWorkerPrize in 'Form\frmWorkerPrize.pas' {WorkerPrizeForm},
  uCADInfo in 'Class\uCADInfo.pas',
  rptFNCard in 'Report\rptFNCard.pas' {FNCardReport},
  frmWIPQuery in 'Form\frmWIPQuery.pas' {WIPQueryForm},
  frmHLArtInfo in 'Form\frmHLArtInfo.pas' {HLArtForm},
  frmFabricReport in 'Form\frmFabricReport.pas' {FabricReportForm},
  rptHLCard in 'Report\rptHLCard.pas' {HLCardReport},
  frmWelcome in 'Form\frmWelcome.pas' {FNMWelcome},
  frmCancelPrintFNCard in 'Form\frmCancelPrintFNCard.pas' {CancePrintFNCardForm},
  frmHold in 'Form\frmHold.pas' {HoldForm},
  frmFabricCard in 'Form\frmFabricCard.pas' {FabricCardForm},
  frmCreateStdPrescription in 'Form\frmCreateStdPrescription.pas' {CreateStdPrescriptionForm},
  frmCutCloth in 'Form\frmCutCloth.pas' {CutClothForm},
  frmQualityRemark in 'Form\frmQualityRemark.pas' {QualityRemarkForm},
  frmOperationAddr in 'Form\frmOperationAddr.pas' {OperationAddrForm},
  frmJobTrace in 'Form\frmJobTrace.pas' {JobTraceForm},
  frmChangeGFNO in 'Form\frmChangeGFNO.pas' {ChangeGFNOForm},
  frmSuspend in 'Form\frmSuspend.pas' {SuspendForm},
  frmViewArtDtl in 'Form\frmViewArtDtl.pas' {ViewArtDtlForm},
  frmFNMQuery in 'Form\frmFNMQuery.pas' {FNMQueryForm},
  frmAdjustJobTraceDtl in 'Form\frmAdjustJobTraceDtl.pas' {AdjustJobTraceDtlForm},
  frmPlanControl in 'Form\frmPlanControl.pas' {PlanControlForm},
  frmArtControl in 'Form\frmArtControl.pas' {ArtControlForm},
  frmChangeDepartment in 'Form\frmChangeDepartment.pas' {ChangeDepartmentForm},
  frmChangeMaterialType in 'Form\frmChangeMaterialType.pas' {ChangeMaterialTypeForm},
  frmModifyCarNO in 'Form\frmModifyCarNO.pas' {ModifyCarNOForm},
  frmReceiveFromGI in 'Form\frmReceiveFromGI.pas' {ReceiveFromGIForm},
  frmReceiveGIRepairInfo in 'Form\frmReceiveGIRepairInfo.pas' {ReceiveGIRepairInfoForm},
  frmManageSample in 'Form\frmManageSample.pas' {ManageSampleForm},
  frmShrinkageAnalysis in 'Form\frmShrinkageAnalysis.pas' {ShrinkageAnalysiForm},
  frmCreateRecipe in 'Form\frmCreateRecipe.pas' {CreateRecipeForm},
  frmCancelFI in 'Form\frmCancelFI.pas' {CancelFIForm},
  frmMachineEfficiency in 'Form\frmMachineEfficiency.pas' {MachineEfficiencyForm},
  frmChemical in 'Form\frmChemical.pas' {ChemicalForm},
  frmChemicalQuery in 'Form\frmChemicalQuery.pas' {ChemicalQueryForm},
  frmArtAnalysis in 'Form\frmArtAnalysis.pas' {ArtAnalysisForm},
  frmRepairReason in 'Form\frmRepairReason.pas' {Form1},
  frmOTDReason in 'Form\frmOTDReason.pas' {OTDReasonForm},
  frmReceiveBenchMark in 'Form\frmReceiveBenchMark.pas' {ReceiveBenchMarkForm},
  frmMutexChemical in 'Form\frmMutexChemical.pas' {MutexChemicalkForm},
  frmInnerRepairCheck in 'Form\frmInnerRepairCheck.pas' {InnerRepairCheckForm},
  frmMachineSelect in 'Form\frmMachineSelect.pas' {MachineSelectForm},
  frmInput in 'Form\frmInput.pas' {InputForm},
  frmFIDuty in 'Form\frmFIDuty.pas' {FIDutyForm},
  frmCSState in 'Form\frmCSState.pas' {CSStateForm},
  frmSDTrace in 'Form\frmSDTrace.pas' {SDTraceForm},
  frmRSTrace in 'Form\frmRSTrace.pas' {RSTraceForm},
  frmDisposeAccidentTrace in 'Form\frmDisposeAccidentTrace.pas' {DisposeAccidentTraceForm},
  frmChemicalRatio in 'Form\frmChemicalRatio.pas' {ChemicalRatioForm},
  frmManageSC in 'Form\frmManageSC.pas' {ManageSCForm},
  frmWorkerStationTurn in 'Form\frmWorkerStationTurn.pas' {WorkerStationTurnForm},
  frmRecipe in 'Form\frmRecipe.pas' {RecipeForm},
  frmCPBDirect in 'Form\frmCPBDirect.pas' {CPBDirectForm},
  frmCPBRecipe in 'Form\frmCPBRecipe.pas' {CPBRecipeForm},
  frmCPBSign in 'Form\frmCPBSign.pas' {CPBSignForm},
  frmCPBManage in 'Form\frmCPBManage.pas' {CPBManageForm},
  frmCPBCheck in 'Form\frmCPBCheck.pas' {CPBCheckForm},
  frmCPBStock in 'Form\frmCPBStock.pas' {CPBStockForm},
  frmCPBColor in 'Form\frmCPBColor.pas' {CPBColorForm},
  frmCPBFormat in 'Form\frmCPBFormat.pas' {CPBFormatForm},
  frmCPBQuery in 'Form\frmCPBQuery.pas' {CPBQueryForm},
  frmCPBWIP in 'Form\frmCPBWIP.pas' {CPBWIPForm},
  rptCPB in 'Report\rptCPB.pas' {CPBReport},
  frmAutoPlanShift in 'Form\frmAutoPlanShift.pas' {AutoPlanShiftForm},
  frmSubRecipe in 'Form\frmSubRecipe.pas' {SubRecipeForm},
  frmTraceRepair in 'Form\frmTraceRepair.pas' {TraceRepairForm},
  frmAnalysisOTD in 'Form\frmAnalysisOTD.pas' {AnalysisOTDForm},
  frmCPBChemicalGroup in 'Form\frmCPBChemicalGroup.pas' {CPBChemicalGroupForm},
  frmCPBCustomerGroup in 'Form\frmCPBCustomerGroup.pas' {CPBCustomerGroupForm},
  frmSelectFNColorCode in 'Form\frmSelectFNColorCode.pas' {SelectFNColorCodeForm},
  frmSOPDefect in 'Form\frmSOPDefect.pas' {SOPDefectForm},
  frmAffirmCardOperationMap in 'Form\frmAffirmCardOperationMap.pas' {AffirmCardOperationMapForm},
  frmOperationMapMachineModel in 'Form\frmOperationMapMachineModel.pas' {OperationMapMachineModelForm},
  frmAffirmCard in 'Form\frmAffirmCard.pas' {AffirmCardForm},
  frmAccidentRecord in 'Form\frmAccidentRecord.pas' {AccidentRecordForm},
  frmLocateCar in 'Form\frmLocateCar.pas' {LocateCarForm},
  uFNMPrescriptionInfo in 'Class\uFNMPrescriptionInfo.pas',
  rptAccidentRecord in 'Report\rptAccidentRecord.pas' {AccidentRecordReport},
  frmBaseData in 'Form\frmBaseData.pas' {BaseDataForm},
  frmCheckArt in 'Form\frmCheckArt.pas' {CheckArtForm},
  frmCPBChangeGFNO in 'Form\frmCPBChangeGFNO.pas' {CPBChangeGFNOForm},
  frmColorInfo in 'Form\frmColorInfo.pas' {ColorInfoForm},
  frmWeighSelect in 'Form\frmWeighSelect.pas' {WeighSelectForm},
  frmWeigh in 'Form\frmWeigh.pas' {WeighForm},
  frmSendInfoManage in 'Form\frmSendInfoManage.pas' {SendInfoManageForm},
  frmSaveScrapInfo in 'Form\frmSaveScrapInfo.pas' {SaveScrapInfoForm},
  frmScrapInfo in 'Form\frmScrapInfo.pas' {ScrapInfoForm},
  frmLessStatistic in 'Form\frmLessStatistic.pas' {LessStatisticForm},
  frmAlertInfo in 'Form\frmAlertInfo.pas' {AlertInfoForm},
  frmMachineRules in 'Form\frmMachineRules.pas' {MachineRulesForm},
  frmSuspendApproval in 'Form\frmSuspendApproval.pas' {SuspendApprovalForm},
  frmEnergyQuery in 'Form\frmEnergyQuery.pas' {EnergyQueryForm},
  frmAffirmBox in 'Form\frmAffirmBox.pas' {AffirmBoxForm},
  frmCreateAffirmHand in 'Form\frmCreateAffirmHand.pas' {CreateAffirmHandForm},
  frmAccidentTimeSelect in 'Form\frmAccidentTimeSelect.pas' {AccidentTimeSelectFrom},
  frmDownInfo in 'Form\frmDownInfo.pas' {DownInfoForm},
  frmScanInventory in 'Form\frmScanInventory.pas' {ScanInventoryForm},
  frmMCSystem in 'Form\frmMCSystem.pas' {frmMC},
  uConditionEditor in 'Class\uConditionEditor.pas',
  frmTrackOnline in 'Form\frmTrackOnline.pas' {TrackOnlineForm},
  frmPlanAnalysis in 'Form\frmPlanAnalysis.pas' {PlanAnalysisForm},
  frmOTDTrace in 'Form\frmOTDTrace.pas' {OTDTraceForm},
  frmColorInfoEdit in 'Form\frmColorInfoEdit.pas' {ColorInfoEditFrom},
  frmAddPrice in 'Form\frmAddPrice.pas' {AddPriceForm},
  frmAddTask in 'Form\frmAddTask.pas' {AddTaskForm},
  frmDisposePrice in 'Form\frmDisposePrice.pas' {DisposePriceForm},
  frmPriceQuery in 'Form\frmPriceQuery.pas' {PriceQueryForm},
  frmMFQuery in 'Form\frmMFQuery.pas' {MFQueryForm},
  frmCheckSCParam in 'Form\frmCheckSCParam.pas' {CheckSCParamForm},
  frmProductionParameter in 'Form\frmProductionParameter.pas' {ProductionParameterForm},
  frmProductionList in 'Form\frmProductionList.pas' {ProductionListForm},
  frmReceiveGreyCloth in 'Form\frmReceiveGreyCloth.pas' {ReceiveGreyClothForm},
  frmPrintFNCardGreyCloth in 'Form\frmPrintFNCardGreyCloth.pas' {PrintFNCardGreyClothForm},
  rptFNCardGreyCloth in 'Report\rptFNCardGreyCloth.pas' {FNCardGreyClothReport},
  frmReturnGreyCloth in 'Form\frmReturnGreyCloth.pas' {ReturnGreyClothForm},
  frmPrintFNCardAndLabel in 'Form\frmPrintFNCardAndLabel.pas' {PrintFNCardAndLabelFrom},
  rptGIReportLabel in 'Report\rptGIReportLabel.pas' {GIReportLabelForm},
  frmGIWorkerOption in 'Form\frmGIWorkerOption.pas' {WorkerOptionForm},
  frmOutGoFabric in 'Form\frmOutGoFabric.pas' {OutGoFabricForm},
  frmFNEditCarNo in 'Form\frmFNEditCarNo.pas' {FNEditCarNoForm},
  frmOutGoFabricRules in 'Form\frmOutGoFabricRules.pas' {OutGoFabricRulesForm},
  uPrinterOption in 'Class\uPrinterOption.pas',
  frmPrepareFabric in 'Form\frmPrepareFabric.pas' {PrepareFabricForm},
  frmEditCarNoByFNCard in 'Form\frmEditCarNoByFNCard.pas' {EditCarNoByFNCardForm},
  frmOutRework in 'Form\frmOutRework.pas' {OutReworkFrom},
  frmSelectWorker in 'Form\frmSelectWorker.pas' {SelectWorkerForm},
  frmSectionFabric in 'Form\frmSectionFabric.pas' {SectionFabricForm},
  frmPerformanceSop in 'Form\frmPerformanceSop.pas' {PerformanceSopForm},
  rptSectionFabricLabel in 'Report\rptSectionFabricLabel.pas' {SectionFabricReportForm},
  frmReceiveCPBBulkFabric in 'Form\frmReceiveCPBBulkFabric.pas' {ReceiveCPBBulkFabricForm},
  frmCPBHLRpt in 'Form\frmCPBHLRpt.pas' {CPBHLRptForm},
  frmCPBDyeDetail in 'Form\frmCPBDyeDetail.pas' {CPBDyeDetailForm},

  frmStdChemicalGroup in 'Form\frmStdChemicalGroup.pas' {StdChemicalGroupForm},
  frmFactoryRate in 'Form\frmFactoryRate.pas' {FactoryRateForm},
  frmModifyFactory in 'Form\frmModifyFactory.pas' {ModifyFactoryForm},
  frmCheckModifyFactory in 'Form\frmCheckModifyFactory.pas' {CheckModifyFactoryForm},
  frmSetCapacity in 'Form\frmSetCapacity.pas' {SetCapacityForm};

{$R *.res}
{$R FNMAuto.res}
//应用程序图标资源文件
{$R FNMBitMap.RES}

var
  ExisFormHandle: THandle;
  AFlashWinfo: FLASHWINFO;
begin
  Application.Initialize;
  Application.OnException:=TGlobal.OnException;
  ExisFormHandle:=FindWindow('TAppBuilder', nil);
  if ExisFormHandle = 0 then
  begin
    ExisFormHandle:=FindWindow('TFNMWelcome', nil);
    if ExisFormHandle = 0 then
      ExisFormHandle:= FindWindow('TFNMMainForm', nil);

    if ExisFormHandle <> 0 then
    begin
      AFlashWinfo.cbSize:=Sizeof(AFlashWinfo);
      AFlashWinfo.hwnd:=ExisFormHandle;
      AFlashWinfo.dwFlags:=FLASHW_ALL;
      AFlashWinfo.dwTimeout:=0;
      AFlashWinfo.uCount:=4;

      //存在BUG，窗体被置前后无法最小化，只能现在任务栏上使用右击菜单恢复后才能最小化。
      FlashWindowEx(AFlashWinfo);
      SetForegroundWindow(ExisFormHandle);
      PostMessage(ExisFormHandle, WM_SHOWWINDOW, 1, SW_PARENTOPENING);
      exit;
    end;
  end;

  //让用户选择中间服务器,此举避免用户在选则取消的时候,主界面闪现的弊病.
  if GetComServerName then
    Application.CreateForm(TFNMMainForm, FNMMainForm);
 
  Application.Run;
end.
