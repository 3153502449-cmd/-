--楼兰神器升级
--冰魄神针锻造 2019-7-16 17:18:52 XYZ
x260001_g_scriptId=260001
x260001_g_ObbpszCost = 2000000;
x260001_g_Mainitem = {10155003,10155005};
x260001_g_Othertem = {30008069,30008070};--20310115,20310116}; 
--**********************************
--锻造冰魄神针请求
--**********************************
function x260001_AnqiConfirm(sceneId,selfId,nPos,nMaterial)
	if nPos ~= nil and nMaterial ~= nil then
		BeginUICommand(sceneId)
			UICommand_AddInt( sceneId,nPos)
			UICommand_AddInt( sceneId,nMaterial)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 260001)
	end
end
--**********************************
--锻造冰魄神针
--**********************************
function x260001_Anqi2Shenzhen(sceneId,selfId,nPos,nMaterial)
	if IsPilferLockFlag(sceneId,selfId) <= 0 then
		x260001_NotifyTip( sceneId, selfId, "#{OR_PILFER_LOCK_FLAG}" )	
		return
	end
	local nAnqiItemID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nPos )
    local nMaterialID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nMaterial)	
    if  not nAnqiItemID or nAnqiItemID == nil or not nMaterialID or nMaterialID == nil then
        return
    end
    if nAnqiItemID ~= 10155003 and nAnqiItemID ~= 10155005 then
        x260001_NotifyTip( sceneId, selfId, "#{AQSJ_090709_23}" )
        return
    end
    if nMaterialID ~= 30008069 and nMaterialID ~= 30008070 then
        x260001_NotifyTip( sceneId, selfId, "#{AQSJ_090709_24}" )
        return
    end
    if LuaFnGetAvailableItemCount(sceneId, selfId, nMaterialID) < 1 then
        x260001_NotifyTip( sceneId, selfId, "#{AQSJ_090709_24}" )	
        return
    end
	local nNewBPSZID = 0
	if nAnqiItemID == 10155003 or nAnqiItemID == 10155005 then
		nNewBPSZID = 10155002
	end	
	if nNewBPSZID ==0 then 
		x260001_NotifyTip( sceneId, selfId, "未知错误" )
		return
	end
	local HumanMoney = LuaFnGetMoney( sceneId, selfId )
	local HumanMoneyJZ = GetMoneyJZ( sceneId, selfId );	
	if HumanMoney + HumanMoneyJZ < x260001_g_ObbpszCost  then
		x260001_NotifyTip( sceneId, selfId, "#{AQSJ_090709_11}" )
		return
	end
	if  LuaFnDelAvailableItem(sceneId,selfId,nMaterialID, 1) ~= 1 then
		x260001_NotifyTip( sceneId, selfId, "物品扣取失败" )
		return
	end
    local nDelJZ, nDelMoney = LuaFnCostMoneyWithPriority(sceneId, selfId, x260001_g_ObbpszCost);
    LuaFnEquipTransToNew(sceneId,selfId,nPos,nNewBPSZID)
	x260001_NotifyTip( sceneId, selfId, "#{AQSJ_090709_12}" )
    LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
end

--**********************************
--醒目提示
--**********************************
function x260001_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end