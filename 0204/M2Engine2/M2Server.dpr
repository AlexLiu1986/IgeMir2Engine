program M2Server;

uses
  Forms,
  Windows,
  svMain in 'svMain.pas' {FrmMain},
  LocalDB in 'LocalDB.pas' {FrmDB},
  InterServerMsg in 'InterServerMsg.pas' {FrmSrvMsg},
  InterMsgClient in 'InterMsgClient.pas' {FrmMsgClient},
  IdSrvClient in 'IdSrvClient.pas' {FrmIDSoc},
  FSrvValue in 'FSrvValue.pas' {FrmServerValue},
  UsrEngn in 'UsrEngn.pas',
  ObjNpc in 'ObjNpc.pas',
  ObjMon2 in 'ObjMon2.pas',
  ObjMon in 'ObjMon.pas',
  ObjGuard in 'ObjGuard.pas',
  ObjBase in 'ObjBase.pas',
  ObjAxeMon in 'ObjAxeMon.pas',
  NoticeM in 'NoticeM.pas',
  Magic in 'Magic.pas',
  M2Share in 'M2Share.pas',
  ItmUnit in 'ItmUnit.pas',
  FrnEngn in 'FrnEngn.pas',
  Event in 'Event.pas',
  Envir in 'Envir.pas',
  Castle in 'Castle.pas',
  RunDB in 'RunDB.pas',
  RunSock in 'RunSock.pas',
  HUtil32 in '..\Common\HUtil32.pas',
  Mudutil in '..\Common\Mudutil.pas',
  PlugIn in 'PlugIn.pas',
  GeneralConfig in 'GeneralConfig.pas' {frmGeneralConfig},
  GameConfig in 'GameConfig.pas' {frmGameConfig},
  FunctionConfig in 'FunctionConfig.pas' {frmFunctionConfig},
  ObjRobot in 'ObjRobot.pas',
  ViewSession in 'ViewSession.pas' {frmViewSession},
  ViewOnlineHuman in 'ViewOnlineHuman.pas' {frmViewOnlineHuman},
  ViewLevel in 'ViewLevel.pas' {frmViewLevel},
  ViewList in 'ViewList.pas' {frmViewList},
  OnlineMsg in 'OnlineMsg.pas' {frmOnlineMsg},
  HumanInfo in 'HumanInfo.pas' {frmHumanInfo},
  ViewKernelInfo in 'ViewKernelInfo.pas' {frmViewKernelInfo},
  ConfigMerchant in 'ConfigMerchant.pas' {frmConfigMerchant},
  ItemSet in 'ItemSet.pas' {frmItemSet},
  ConfigMonGen in 'ConfigMonGen.pas' {frmConfigMonGen},
  PlugInManage in 'PlugInManage.pas' {ftmPlugInManage},
  GameCommand in 'GameCommand.pas' {frmGameCmd},
  MonsterConfig in 'MonsterConfig.pas' {frmMonsterConfig},
  ActionSpeedConfig in 'ActionSpeedConfig.pas' {frmActionSpeed},
  EDcode in '..\Common\EDcode.pas',
  CastleManage in 'CastleManage.pas' {frmCastleManage},
  Common in '..\Common\Common.pas',
  AttackSabukWallConfig in 'AttackSabukWallConfig.pas' {FrmAttackSabukWall},
  AboutUnit in 'AboutUnit.pas' {FrmAbout},
  ObjPlayMon in 'ObjPlayMon.pas',
  EDcodeUnit in '..\Common\EDcodeUnit.pas',
  Guild in 'Guild.pas',
  Grobal2 in '..\Common\Grobal2.pas',
  DESTR in '..\Common\DESTR.pas',
  ObjPlayRobot in 'ObjPlayRobot.pas',
  ObjHero in 'ObjHero.pas',
  SDK in '..\Common\SDK.pas',
  HeroConfig in 'HeroConfig.pas' {frmHeroConfig},
  PlugOfEngine in 'PlugOfEngine.pas',
  DESCrypt in 'DESCrypt.pas',
  ViewList2 in 'ViewList2.pas' {frmViewList2},
  GuildManage in 'GuildManage.pas' {frmGuildManage};

//------------------------------------------------------------------------------
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                {PlugOfEngine}//引擎输出函数
exports
(*  //TList_Create Name 'TList_Create',
  //TList_Free Name 'TList_Free',
  TList_Count Name 'TList_Count',
  TList_Add Name 'TList_Add',
  TList_Insert Name 'TList_Insert',
  TList_Get Name 'TList_Get',
  //TList_Put Name 'TList_Put',
  TList_Delete Name 'TList_Delete',
  TList_Clear Name 'TList_Clear',
  TList_Exchange Name 'TList_Exchange', 

  TStringList_Create Name 'TStringList_Create',
  TStringList_Free Name 'TStringList_Free',
  TStringList_Count Name 'TStringList_Count',
  TStringList_Add Name 'TStringList_Add',
  TStringList_AddObject Name 'TStringList_AddObject',
  TStringList_Insert Name 'TStringList_Insert',
  TStringList_Get Name 'TStringList_Get',
  TStringList_GetObject Name 'TStringList_GetObject',
  //TStringList_Put Name 'TStringList_Put',
  //TStringList_PutObject Name 'TStringList_PutObject',
  TStringList_Delete Name 'TStringList_Delete',
  TStringList_Clear Name 'TStringList_Clear',
  TStringList_Exchange Name 'TStringList_Exchange',
  TStringList_LoadFormFile Name 'TStringList_LoadFormFile',
  TStringList_SaveToFile Name 'TStringList_SaveToFile', *)

  MainOutMessageAPI Name 'MainOutMessageAPI',
  //AddGameDataLogAPI Name 'AddGameDataLogAPI',
  //GetGameGoldName Name 'GetGameGoldName',

  //EDcode_Decode6BitBuf Name 'EDcode_Decode6BitBuf',
  //EDcode_Encode6BitBuf Name 'EDcode_Encode6BitBuf',
  //EDcode_SetDecode Name 'EDcode_SetDecode',
  //EDcode_SetEncode Name 'EDcode_SetEncode',

  {EDcode_DeCodeString Name 'EDcode_DeCodeString',
  EDcode_EncodeString Name 'EDcode_EncodeString',
  EDcode_EncodeBuffer Name 'EDcode_EncodeBuffer',
  EDcode_DecodeBuffer Name 'EDcode_DecodeBuffer',}

  {TConfig_AmyOunsulPoint Name 'TConfig_AmyOunsulPoint',
  TConfig_sEnvirDir Name 'TConfig_sEnvirDir', 

  TBaseObject_Create Name 'TBaseObject_Create',
  TBaseObject_Free Name 'TBaseObject_Free',
  TBaseObject_sMapFileName Name 'TBaseObject_sMapFileName',}
  //TBaseObject_sMapByName Name 'TBaseObject_sMapByName',//20080415 人物所在地图名称
  //TBaseObject_sMapName Name 'TBaseObject_sMapName',
  //TBaseObject_sMapNameA Name 'TBaseObject_sMapNameA',
  //TBaseObject_sCharName Name 'TBaseObject_sCharName',
  //TBaseObject_sCharNameA Name 'TBaseObject_sCharNameA',
  //TBaseObject_nCurrX Name 'TBaseObject_nCurrX',
  //TBaseObject_nCurrY Name 'TBaseObject_nCurrY',
  //TBaseObject_btDirection Name 'TBaseObject_btDirection',
  //TBaseObject_btGender Name 'TBaseObject_btGender',
  //TBaseObject_btHair Name 'TBaseObject_btHair',
  //TBaseObject_btJob Name 'TBaseObject_btJob',
  //TBaseObject_nGold Name 'TBaseObject_nGold',
  //TPlayObject_nGameGird Name 'TPlayObject_nGameGird',  //20080302 灵符接口
  //TBaseObject_Ability Name 'TBaseObject_Ability',
  TBaseObject_WAbility Name 'TBaseObject_WAbility',
  //TBaseObject_nCharStatus Name 'TBaseObject_nCharStatus',
  //TBaseObject_sHomeMap Name 'TBaseObject_sHomeMap',
  //TBaseObject_nHomeX Name 'TBaseObject_nHomeX',
  //TBaseObject_nHomeY Name 'TBaseObject_nHomeY',
  //TBaseObject_boOnHorse Name 'TBaseObject_boOnHorse',
  //TBaseObject_btHorseType Name 'TBaseObject_btHorseType',
  //TBaseObject_btDressEffType Name 'TBaseObject_btDressEffType',
  //TBaseObject_nPkPoint Name 'TBaseObject_nPkPoint',
  //TBaseObject_boAllowGroup Name 'TBaseObject_boAllowGroup',
  //TBaseObject_boAllowGuild Name 'TBaseObject_boAllowGuild',  
  //TBaseObject_nFightZoneDieCount Name 'TBaseObject_nFightZoneDieCount',
  //TBaseObject_nBonusPoint Name 'TBaseObject_nBonusPoint',
  //TBaseObject_nHungerStatus Name 'TBaseObject_nHungerStatus',
  //TBaseObject_boAllowGuildReCall Name 'TBaseObject_boAllowGuildReCall',
  //TBaseObject_duBodyLuck Name 'TBaseObject_duBodyLuck',
  //TBaseObject_nBodyLuckLevel Name 'TBaseObject_nBodyLuckLevel',
  //TBaseObject_wGroupRcallTime Name 'TBaseObject_wGroupRcallTime',
  //TBaseObject_boAllowGroupReCall Name 'TBaseObject_boAllowGroupReCall',
  //TBaseObject_nCharStatusEx Name 'TBaseObject_nCharStatusEx',
  //TBaseObject_dwFightExp Name 'TBaseObject_dwFightExp',
  //TBaseObject_dwRockAddHPTick Name 'TBaseObject_dwRockAddHPTick',//气石加HP间隔 20080524
  //TBaseObject_dwRockAddMPTick Name 'TBaseObject_dwRockAddMPTick',//气石加MP间隔 20080524
  //TBaseObject_nViewRange Name 'TBaseObject_nViewRange',
  //TBaseObject_wAppr Name 'TBaseObject_wAppr',
  //TBaseObject_btRaceServer Name 'TBaseObject_btRaceServer',
  //TBaseObject_btRaceImg Name 'TBaseObject_btRaceImg',
  //TBaseObject_btHitPoint Name 'TBaseObject_btHitPoint',
  //TBaseObject_nHitPlus Name 'TBaseObject_nHitPlus',
  //TBaseObject_nHitDouble Name 'TBaseObject_nHitDouble',
  //TBaseObject_boRecallSuite Name 'TBaseObject_boRecallSuite',
  //TBaseObject_nHealthRecover Name 'TBaseObject_nHealthRecover',
  //TBaseObject_nSpellRecover Name 'TBaseObject_nSpellRecover',
  //TBaseObject_btAntiPoison Name 'TBaseObject_btAntiPoison',
  //TBaseObject_nPoisonRecover Name 'TBaseObject_nPoisonRecover',
  //TBaseObject_nAntiMagic Name 'TBaseObject_nAntiMagic',
  //TBaseObject_nLuck Name 'TBaseObject_nLuck',
  //TBaseObject_nPerHealth Name 'TBaseObject_nPerHealth',
  //TBaseObject_nPerHealing Name 'TBaseObject_nPerHealing',
  //TBaseObject_nPerSpell Name 'TBaseObject_nPerSpell',
  //TBaseObject_btGreenPoisoningPoint Name 'TBaseObject_btGreenPoisoningPoint',
  //TBaseObject_nGoldMax Name 'TBaseObject_nGoldMax',
  //TBaseObject_btSpeedPoint Name 'TBaseObject_btSpeedPoint',
  //TBaseObject_btPermission Name 'TBaseObject_btPermission',
  //TBaseObject_nHitSpeed Name 'TBaseObject_nHitSpeed',
  //TBaseObject_TargetCret Name 'TBaseObject_TargetCret',
  //TBaseObject_LastHiter Name 'TBaseObject_LastHiter',
  //TBaseObject_ExpHiter Name 'TBaseObject_ExpHitter',
  //TBaseObject_btLifeAttrib Name 'TBaseObject_btLifeAttrib',
  //TBaseObject_GroupOwner Name 'TBaseObject_GroupOwner',
  //TBaseObject_GroupMembersList Name 'TBaseObject_GroupMembersList',
  //TBaseObject_boHearWhisper Name 'TBaseObject_boHearWhisper',
  //TBaseObject_boBanShout Name 'TBaseObject_boBanShout',
  //TBaseObject_boBanGmMsg  Name 'TBaseObject_boBanGmMsg',//20080211 禁止接收喊话信息
  //TBaseObject_boBanGuildChat Name 'TBaseObject_boBanGuildChat',
  //TBaseObject_boAllowDeal Name 'TBaseObject_boAllowDeal',
  //TBaseObject_nSlaveType Name 'TBaseObject_nSlaveType',//未使用 20080329
  //TBaseObject_Master Name 'TBaseObject_Master',
  {TBaseObject_btAttatckMode Name 'TBaseObject_btAttatckMode',
  TBaseObject_btNameColor Name 'TBaseObject_btNameColor',
  TBaseObject_nLight Name 'TBaseObject_nLight',
  TBaseObject_ItemList Name 'TBaseObject_ItemList',
  TBaseObject_MagicList Name 'TBaseObject_MagicList',
  TBaseObject_MyGuild Name 'TBaseObject_MyGuild',
  TBaseObject_UseItems Name 'TBaseObject_UseItems',
  TBaseObject_btMonsterWeapon Name 'TBaseObject_btMonsterWeapon',
  TBaseObject_PEnvir Name 'TBaseObject_PEnvir',}
  //TBaseObject_boGhost Name 'TBaseObject_boGhost',
  TBaseObject_boDeath Name 'TBaseObject_boDeath',
  //TBaseObject_DeleteBagItem Name 'TBaseObject_DeleteBagItem',
  //TBaseObject_AddCustomData Name 'TBaseObject_AddCustomData', //20080329
  //TBaseObject_GetCustomData Name 'TBaseObject_GetCustomData',//未使用 20080329
  //TBaseObject_SendMsg Name 'TBaseObject_SendMsg',
  TBaseObject_SendRefMsg Name 'TBaseObject_SendRefMsg',
  //TBaseObject_SendDelayMsg Name 'TBaseObject_SendDelayMsg',
  //TBaseObject_SysMsg Name 'TBaseObject_SysMsg',
  //TBaseObject_SendBroadCastMsgExt Name 'TBaseObject_SendBroadCastMsgExt',//向每个人物发送消息 20080227
  {TBaseObject_GetFrontPosition Name 'TBaseObject_GetFrontPosition',
  TBaseObject_GetRecallXY Name 'TBaseObject_GetRecallXY',
  TBaseObject_SpaceMove Name 'TBaseObject_SpaceMove',
  TBaseObject_FeatureChanged Name 'TBaseObject_FeatureChanged',
  TBaseObject_StatusChanged Name 'TBaseObject_StatusChanged',
  TBaseObject_GetFeatureToLong Name 'TBaseObject_GetFeatureToLong',
  TBaseObject_GetFeature Name 'TBaseObject_GetFeature',
  TBaseObject_GetCharColor Name 'TBaseObject_GetCharColor',
  TBaseObject_GetNamecolor Name 'TBaseObject_GetNamecolor',
  TBaseObject_GoldChanged Name 'TBaseObject_GoldChanged',}
  //TBaseObject_GameGoldChanged Name 'TBaseObject_GameGoldChanged',
  {TBaseObject_MagCanHitTarget Name 'TBaseObject_MagCanHitTarget',
  TBaseObject_SetTargetCreat Name 'TBaseObject_SetTargetCreat',
  TBaseObject_IsProtectTarget Name 'TBaseObject_IsProtectTarget',
  TBaseObject_IsAttackTarget Name 'TBaseObject_IsAttackTarget',}
  TBaseObject_IsProperTarget Name 'TBaseObject_IsProperTarget',
  //TBaseObject_IsProperFriend Name 'TBaseObject_IsProperFriend',
  //TBaseObject_TrainSkillPoint Name 'TBaseObject_TrainSkillPoint',
  TBaseObject_GetAttackPower Name 'TBaseObject_GetAttackPower',
  //TBaseObject_MakeSlave Name 'TBaseObject_MakeSlave',
  //TBaseObject_MakeGhost Name 'TBaseObject_MakeGhost',
  //TBaseObject_RefNameColor Name 'TBaseObject_RefNameColor',
  //AddItem 占用内存由自己处理，API内部会自动申请内存
  //TBaseObject_AddItemToBag Name 'TBaseObject_AddItemToBag',
  //TBaseObject_AddItemToStorage Name 'TBaseObject_AddItemToStorage',
  //TBaseObject_ClearBagItem Name 'TBaseObject_ClearBagItem',
  //TBaseObject_ClearStorageItem Name 'TBaseObject_ClearStorageItem',
  {TBaseObject_SetHookGetFeature Name 'TBaseObject_SetHookGetFeature',
  TBaseObject_SetHookEnterAnotherMap Name 'TBaseObject_SetHookEnterAnotherMap',
  TBaseObject_SetHookObjectDie Name 'TBaseObject_SetHookObjectDie',
  TBaseObject_SetHookChangeCurrMap Name 'TBaseObject_SetHookChangeCurrMap',
  TBaseObject_GetPoseCreate Name 'TBaseObject_GetPoseCreate',}
  TBaseObject_MagMakeDefenceArea Name 'TBaseObject_MagMakeDefenceArea',
  TBaseObject_MagBubbleDefenceUp Name 'TBaseObject_MagBubbleDefenceUp',
  //TBaseObject_MagProtectionDefenceUp Name 'TBaseObject_MagProtectionDefenceUp', //护体神盾 20080107
(* TBaseObject_GetBaseObjectTick Name 'TBaseObject_GetBaseObjectTick', {*******}
  TPlayObject_AddItemToStorage Name 'TPlayObject_AddItemToStorage',  {*******}
  TPlayObject_ClearStorageItem Name 'TPlayObject_ClearStorageItem',  {*******}
  TPlayObject_GroupOwner Name 'TPlayObject_GroupOwner',              {*******}
  TPlayObject_GroupMembersList Name 'TPlayObject_GroupMembersList',  {*******}
  TPlayObject_boHearWhisper Name 'TPlayObject_boHearWhisper',        {*******}
  TPlayObject_boBanShout Name 'TPlayObject_boBanShout',              {*******}
  TPlayObject_boBanGuildChat Name 'TPlayObject_boBanGuildChat',      {*******}
  TPlayObject_boAllowDeal Name 'TPlayObject_boAllowDeal',            {*******}
  TPlayObject_boAllowGroup Name 'TPlayObject_boAllowGroup',          {*******}
  TPlayObject_boAllowGuild Name 'TPlayObject_boAllowGuild',          {*******}
  TPlayObject_nHungerStatus Name 'TPlayObject_nHungerStatus',        {*******}
  TPlayObject_boAllowGuildReCall Name 'TPlayObject_boAllowGuildReCall', {*******}
  TPlayObject_wGroupRcallTime Name 'TPlayObject_wGroupRcallTime',       {*******}
  TPlayObject_boAllowGroupReCall Name 'TPlayObject_boAllowGroupReCall', {*******}  *)

  TPlayObject_IsEnoughBag Name 'TPlayObject_IsEnoughBag',
  {TPlayObject_nSoftVersionDate Name 'TPlayObject_nSoftVersionDate',
  TPlayObject_nSoftVersionDateEx Name 'TPlayObject_nSoftVersionDateEx',
  TPlayObject_dLogonTime Name 'TPlayObject_dLogonTime',
  TPlayObject_dwLogonTick Name 'TPlayObject_dwLogonTick',
  TPlayObject_nMemberType Name 'TPlayObject_nMemberType',
  TPlayObject_nMemberLevel Name 'TPlayObject_nMemberLevel',}
  //TPlayObject_nGameGold Name 'TPlayObject_nGameGold',
  {TPlayObject_nGamePoint Name 'TPlayObject_nGamePoint',
  TPlayObject_nPayMentPoint Name 'TPlayObject_nPayMentPoint',
  TPlayObject_nClientFlag Name 'TPlayObject_nClientFlag',
  TPlayObject_nSelectID Name 'TPlayObject_nSelectID',
  TPlayObject_nClientFlagMode Name 'TPlayObject_nClientFlagMode',
  TPlayObject_dwClientTick Name 'TPlayObject_dwClientTick',}
  //TPlayObject_wClientType Name 'TPlayObject_wClientType',//未使用 20080329
  //TPlayObject_sBankPassword Name 'TPlayObject_sBankPassword',
  //TPlayObject_nBankGold Name 'TPlayObject_nBankGold',//未使用 20080329
  //TPlayObject_Create Name 'TPlayObject_Create',
  //TPlayObject_Free Name 'TPlayObject_Free',
  TPlayObject_SendSocket Name 'TPlayObject_SendSocket',
  //TPlayObject_SendDefMessage Name 'TPlayObject_SendDefMessage',
  TPlayObject_SendAddItem Name 'TPlayObject_SendAddItem',
  TPlayObject_SendDelItem Name 'TPlayObject_SendDelItem',
  THeroObject_SendDelItem Name 'THeroObject_SendDelItem', //20080309
  //TPlayObject_TargetInNearXY Name 'TPlayObject_TargetInNearXY',
  //TPlayObject_SetBankPassword Name 'TPlayObject_SetBankPassword',
  TPlayObject_GetPlayObjectTick Name 'TPlayObject_GetPlayObjectTick',
  TPlayObject_SetPlayObjectTick Name 'TPlayObject_SetPlayObjectTick',
  {TPlayObject_SetHookCreate Name 'TPlayObject_SetHookCreate',
  TPlayObject_GetHookCreate Name 'TPlayObject_GetHookCreate',
  TPlayObject_SetHookDestroy Name 'TPlayObject_SetHookDestroy',
  TPlayObject_GetHookDestroy Name 'TPlayObject_GetHookDestroy',
  TPlayObject_SetHookUserLogin1 Name 'TPlayObject_SetHookUserLogin1',
  TPlayObject_SetHookUserLogin2 Name 'TPlayObject_SetHookUserLogin2',
  TPlayObject_SetHookUserLogin3 Name 'TPlayObject_SetHookUserLogin3',
  TPlayObject_SetHookUserLogin4 Name 'TPlayObject_SetHookUserLogin4',}
  //TPlayObject_SetHookUserCmd Name 'TPlayObject_SetHookUserCmd',
  //TPlayObject_GetHookUserCmd Name 'TPlayObject_GetHookUserCmd',
  //TPlayObject_SetHookPlayOperateMessage Name 'TPlayObject_SetHookPlayOperateMessage',
  //TPlayObject_GetHookPlayOperateMessage Name 'TPlayObject_GetHookPlayOperateMessage',
  {TPlayObject_SetHookClientQueryBagItems Name 'TPlayObject_SetHookClientQueryBagItems',
  TPlayObject_SetHookClientQueryUserState Name 'TPlayObject_SetHookClientQueryUserState',
  TPlayObject_SetHookSendActionGood Name 'TPlayObject_SetHookSendActionGood',
  TPlayObject_SetHookSendActionFail Name 'TPlayObject_SetHookSendActionFail',
  TPlayObject_SetHookSendWalkMsg Name 'TPlayObject_SetHookSendWalkMsg',
  TPlayObject_SetHookSendHorseRunMsg Name 'TPlayObject_SetHookSendHorseRunMsg',
  TPlayObject_SetHookSendRunMsg Name 'TPlayObject_SetHookSendRunMsg',
  TPlayObject_SetHookSendDeathMsg Name 'TPlayObject_SetHookSendDeathMsg',
  TPlayObject_SetHookSendSkeletonMsg Name 'TPlayObject_SetHookSendSkeletonMsg',
  TPlayObject_SetHookSendAliveMsg Name 'TPlayObject_SetHookSendAliveMsg',
  TPlayObject_SetHookSendSpaceMoveMsg Name 'TPlayObject_SetHookSendSpaceMoveMsg',
  TPlayObject_SetHookSendChangeFaceMsg Name 'TPlayObject_SetHookSendChangeFaceMsg',
  TPlayObject_SetHookSendUseitemsMsg Name 'TPlayObject_SetHookSendUseitemsMsg',
  TPlayObject_SetHookSendUserLevelUpMsg Name 'TPlayObject_SetHookSendUserLevelUpMsg',
  TPlayObject_SetHookSendUserAbilieyMsg Name 'TPlayObject_SetHookSendUserAbilieyMsg',
  //TPlayObject_SetHookSendUserStatusMsg Name 'TPlayObject_SetHookSendUserStatusMsg',
  TPlayObject_SetHookSendUserStruckMsg Name 'TPlayObject_SetHookSendUserStruckMsg',
  TPlayObject_SetHookSendUseMagicMsg Name 'TPlayObject_SetHookSendUseMagicMsg',
  TPlayObject_SetHookSendSocket Name 'TPlayObject_SetHookSendSocket',
  TPlayObject_SetHookSendGoodsList Name 'TPlayObject_SetHookSendGoodsList',}
  {TPlayObject_SetCheckClientDropItem Name 'TPlayObject_SetCheckClientDropItem',
  TPlayObject_SetCheckClientDealItem Name 'TPlayObject_SetCheckClientDealItem',
  TPlayObject_SetCheckClientStorageItem Name 'TPlayObject_SetCheckClientStorageItem',
  TPlayObject_SetCheckClientRepairItem Name 'TPlayObject_SetCheckClientRepairItem',
  TPlayObject_SetCheckClientDropHint Name 'TPlayObject_SetCheckClientDropHint', //物品掉落提示规则  20080226
  TPlayObject_SetCheckClientOpenBoxsHint Name 'TPlayObject_SetCheckClientOpenBoxsHint', //开启宝箱提示规则  20080226
  TPlayObject_SetCheckClientNoDropItem Name 'TPlayObject_SetCheckClientNoDropItem', //物品永不暴出规则  20080226
  TPlayObject_SetCheckClientButchHint Name 'TPlayObject_SetCheckClientButchHint',//物品规则里的 挖取提示规则  20080226
  TPlayObject_SetCheckClientHeroUseItem Name 'TPlayObject_SetCheckClientHeroUseItem',//物品规则里的 禁止英雄使用规则 20080419
  TPlayObject_SetCheckClientPickUpItem Name 'TPlayObject_SetCheckClientPickUpItem',//物品规则 禁止捡起(除GM外) 20080611
  TPlayObject_SetCheckClientDieDropItems Name 'TPlayObject_SetCheckClientDieDropItems',}//物品规则 死亡掉落 20080614

  //TPlayObject_SetHookCheckUserItems Name 'TPlayObject_SetHookCheckUserItems',
  //TPlayObject_SetHookRun Name 'TPlayObject_SetHookRun',
  //TPlayObject_SetHookFilterMsg Name 'TPlayObject_SetHookFilterMsg',
  //TPlayObject_SetHookUserRunMsg Name 'TPlayObject_SetHookUserRunMsg',//20080813 注释
  //TPlayObject_SetUserInPutInteger Name 'TPlayObject_SetUserInPutInteger',
  //TPlayObject_SetUserInPutString Name 'TPlayObject_SetUserInPutString',
  //TPlayObject_IncGold Name 'TPlayObject_IncGold',
  //TPlayObject_IncGameGold Name 'TPlayObject_IncGameGold',
  //TPlayObject_IncGameGird Name 'TPlayObject_IncGameGird', //增加灵符 20080302
  //TPlayObject_IncGamePoint Name 'TPlayObject_IncGamePoint',
  //TPlayObject_DecGold Name 'TPlayObject_DecGold',
  //TPlayObject_DecGameGold Name 'TPlayObject_DecGameGold',
  //TPlayObject_DecGamePoint Name 'TPlayObject_DecGamePoint',
  TPlayObject_PlayUseItems Name 'TPlayObject_PlayUseItems',

  //TNormNpc_sFilePath Name 'TNormNpc_sFilePath',
  //TNormNpc_sPath Name 'TNormNpc_sPath',
  //TNormNpc_GetLineVariableText Name 'TNormNpc_GetLineVariableText',
  //TNormNpc_SetScriptActionCmd Name 'TNormNpc_SetScriptActionCmd',
  //TNormNpc_GetScriptActionCmd Name 'TNormNpc_GetScriptActionCmd',
  //TNormNpc_GetScriptConditionCmd Name 'TNormNpc_GetScriptConditionCmd',
  {TNormNpc_GetManageNpc Name 'TNormNpc_GetManageNpc',
  TNormNpc_GetFunctionNpc Name 'TNormNpc_GetFunctionNpc',
  TNormNpc_GotoLable Name 'TNormNpc_GotoLable',}
  //TNormNpc_SetScriptAction Name 'TNormNpc_SetScriptAction',
  //TNormNpc_GetScriptAction Name 'TNormNpc_GetScriptAction',
  //TNormNpc_SetScriptCondition Name 'TNormNpc_SetScriptCondition',
  //TNormNpc_GetScriptCondition Name 'TNormNpc_GetScriptCondition',

  //TMerchant_GoodsList Name 'TMerchant_GoodsList',
  //TMerchant_GetItemPrice Name 'TMerchant_GetItemPrice',
  //TMerchant_GetUserPrice Name 'TMerchant_GetUserPrice',
  //TMerchant_GetUserItemPrice Name 'TMerchant_GetUserItemPrice',
  //TMerchant_SetHookClientGetDetailGoodsList Name 'TMerchant_SetHookClientGetDetailGoodsList',
  //TMerchant_SetCheckUserSelect Name 'TMerchant_SetCheckUserSelect',
  //TMerchant_GetCheckUserSelect Name 'TMerchant_GetCheckUserSelect',

  //TUserEngine_Create Name 'TUserEngine_Create',
  //TUserEngine_Free Name 'TUserEngine_Free',
  //TUserEngine_GetUserEngine Name 'TUserEngine_GetUserEngine',
  TUserEngine_GetPlayObject Name 'TUserEngine_GetPlayObject',
  //TUserEngine_GetLoadPlayList Name 'TUserEngine_GetLoadPlayList',
  //TUserEngine_GetPlayObjectList Name 'TUserEngine_GetPlayObjectList',
  //TUserEngine_GetLoadPlayCount Name 'TUserEngine_GetLoadPlayCount',
  TUserEngine_GetPlayObjectCount Name 'TUserEngine_GetPlayObjectCount',
  TUserEngine_GetStdItemByName Name 'TUserEngine_GetStdItemByName',
  TUserEngine_GetStdItemByIndex Name 'TUserEngine_GetStdItemByIndex',
  TUserEngine_CopyToUserItemFromName Name 'TUserEngine_CopyToUserItemFromName',
  TUserEngine_GetStdItemList Name 'TUserEngine_GetStdItemList',
  TUserEngine_GetMagicList Name 'TUserEngine_GetMagicList',
  //TUserEngine_FindMagic Name 'TUserEngine_FindMagic',
  TUserEngine_AddMagic Name 'TUserEngine_AddMagic',
  TUserEngine_DelMagic Name 'TUserEngine_DelMagic',
  //TUserEngine_SetHookRun Name 'TUserEngine_SetHookRun',
  //TUserEngine_GetHookRun Name 'TUserEngine_GetHookRun',
  //TUserEngine_SetHookClientUserMessage Name 'TUserEngine_SetHookClientUserMessage',

  //TMapManager_FindMap Name 'TMapManager_FindMap',
  //TEnvirnoment_GetRangeBaseObject Name 'TEnvirnoment_GetRangeBaseObject',
  //TEnvirnoment_boCANRIDE Name 'TEnvirnoment_boCANRIDE',//未使用 20080329
  //TEnvirnoment_boCANBAT Name 'TEnvirnoment_boCANBAT',//未使用 20080329

  //TGuild_RankList Name 'TGuild_RankList',

  //TItemUnit_GetItemAddValue Name 'TItemUnit_GetItemAddValue',

  //TMagicManager_MPow Name 'TMagicManager_MPow',
  //TMagicManager_GetPower Name 'TMagicManager_GetPower',
  //TMagicManager_GetPower13 Name 'TMagicManager_GetPower13',
  //TMagicManager_GetRPow Name 'TMagicManager_GetRPow',
  //TMagicManager_IsWarrSkill Name 'TMagicManager_IsWarrSkill',
  TMagicManager_MagBigHealing Name 'TMagicManager_MagBigHealing',
  TMagicManager_MagPushArround Name 'TMagicManager_MagPushArround',
  //TMagicManager_MagPushArroundTaos Name 'TMagicManager_MagPushArroundTaos',
  TMagicManager_MagTurnUndead Name 'TMagicManager_MagTurnUndead',
  TMagicManager_MagMakeHolyCurtain Name 'TMagicManager_MagMakeHolyCurtain',
  TMagicManager_MagMakeGroupTransparent Name 'TMagicManager_MagMakeGroupTransparent',
  TMagicManager_MagTamming Name 'TMagicManager_MagTamming',
  TMagicManager_MagSaceMove Name 'TMagicManager_MagSaceMove',
  TMagicManager_MagMakeFireCross Name 'TMagicManager_MagMakeFireCross',
  TMagicManager_MagBigExplosion Name 'TMagicManager_MagBigExplosion',
  TMagicManager_MagElecBlizzard Name 'TMagicManager_MagElecBlizzard',
  TMagicManager_MabMabe Name 'TMagicManager_MabMabe',
  TMagicManager_MagMakeSlave Name 'TMagicManager_MagMakeSlave',
  TMagicManager_MagMakeSinSuSlave Name 'TMagicManager_MagMakeSinSuSlave',
  TMagicManager_MagWindTebo Name 'TMagicManager_MagWindTebo',
  TMagicManager_MagGroupLightening Name 'TMagicManager_MagGroupLightening',
  TMagicManager_MagGroupAmyounsul Name 'TMagicManager_MagGroupAmyounsul',
  TMagicManager_MagGroupDeDing Name 'TMagicManager_MagGroupDeDing',
  TMagicManager_MagGroupMb Name 'TMagicManager_MagGroupMb',
  TMagicManager_MagHbFireBall Name 'TMagicManager_MagHbFireBall',
  TMagicManager_MagLightening Name 'TMagicManager_MagLightening',
  TMagicManager_MagMakeSlave_ Name 'TMagicManager_MagMakeSlave_',
  TMagicManager_CheckAmulet Name 'TMagicManager_CheckAmulet',
  TMagicManager_UseAmulet Name 'TMagicManager_UseAmulet',
  TMagicManager_MagMakeSuperFireCross Name 'TMagicManager_MagMakeSuperFireCross',

  TMagicManager_MagMakeFireball Name 'TMagicManager_MagMakeFireball',
  TMagicManager_MagTreatment Name 'TMagicManager_MagTreatment',
  TMagicManager_MagMakeHellFire Name 'TMagicManager_MagMakeHellFire',
  TMagicManager_MagMakeQuickLighting Name 'TMagicManager_MagMakeQuickLighting',
  TMagicManager_MagMakeLighting Name 'TMagicManager_MagMakeLighting',
  TMagicManager_MagMakeFireCharm Name 'TMagicManager_MagMakeFireCharm',
  TMagicManager_MagMakeUnTreatment Name 'TMagicManager_MagMakeUnTreatment',
  TMagicManager_MagMakePrivateTransparent Name 'TMagicManager_MagMakePrivateTransparent',

  TMagicManager_MagMakeLivePlayObject Name 'TMagicManager_MagMakeLivePlayObject',
  TMagicManager_MagMakeArrestObject Name 'TMagicManager_MagMakeArrestObject',
  TMagicManager_MagChangePosition Name 'TMagicManager_MagChangePosition',
  TMagicManager_MagMakeFireDay Name 'TMagicManager_MagMakeFireDay',

  //TMagicManager_GetMagicManager Name 'TMagicManager_GetMagicManager',
  TMagicManager_SetHookDoSpell Name 'TMagicManager_SetHookDoSpell',
  //TMagicManager_DoSpell Name 'TMagicManager_DoSpell',
  //TRunSocket_CloseUser Name 'TRunSocket_CloseUser',
  //TRunSocket_SetHookExecGateMsgOpen Name 'TRunSocket_SetHookExecGateMsgOpen',
  //TRunSocket_SetHookExecGateMsgClose Name 'TRunSocket_SetHookExecGateMsgClose',
  //TRunSocket_SetHookExecGateMsgEeceive_OK Name 'TRunSocket_SetHookExecGateMsgEeceive_OK',
  //TRunSocket_SetHookExecGateMsgData Name 'TRunSocket_SetHookExecGateMsgData',
  TPlugOfEngine_GetUserVersion Name 'TPlugOfEngine_GetUserVersion',
  TPlugOfEngine_GetProductVersion Name 'TPlugOfEngine_GetProductVersion',
  TPlugOfEngine_HealthSpellChanged Name 'TPlugOfEngine_HealthSpellChanged', //20080416
  TPlugOfEngine_GetUserName Name 'TPlugOfEngine_GetUserName';//20081203
//------------------------------------------------------------------------------
{$R *.res}

procedure Start();
begin
  g_Config.nServerFile_CRCA := CalcFileCRC(Application.ExeName);
  Application.Initialize;
  Application.HintPause := 100;
  Application.HintShortPause := 100;
  Application.HintHidePause := 5000;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmSrvMsg, FrmSrvMsg);
  asm
    jz @@Start
    jnz @@Start
    db 0EBh
    @@Start:
  end;
  Application.CreateForm(TFrmMsgClient, FrmMsgClient);
  Application.CreateForm(TFrmIDSoc, FrmIDSoc);
 // Application.CreateForm(TFrmServerValue, FrmServerValue);//性能参数配置   20080119
 // Application.CreateForm(TftmPlugInManage, ftmPlugInManage);//插件窗口   20080119
 // Application.CreateForm(TfrmGameCmd, frmGameCmd);//游戏命令设置         20080119
 // Application.CreateForm(TfrmMonsterConfig, frmMonsterConfig);//怪物设置  20080119
  Application.Run;
end;

asm
  jz @@Start
  jnz @@Start
  db 0E8h
@@Start:
  lea eax,Start
  call eax
  jz @@end
  jnz @@end
  db 0F4h
  db 0FFh
@@end:
end.

