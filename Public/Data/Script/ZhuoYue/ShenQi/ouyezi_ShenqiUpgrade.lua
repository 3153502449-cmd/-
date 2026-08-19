--神器进阶
x500505_g_scriptId = 500505
x500505_UpgradeMoney = 50000 --神器进阶所需金币
--神兵符
x500505_ShenBingFu_Need = 20 --炼魂所需神兵符
function x500505_GetHumunBagPos(sceneId,selfId)
      	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 5 then
		     x500505_NotifysTip( sceneId, selfId, "道具栏空间不足，至少需要5格" )
		   return 0
	    end
	    if LuaFnGetMaterialBagSpace(sceneId,selfId) < 5 then
		     x500505_NotifysTip( sceneId, selfId, "材料栏空间不足，至少需要5格" )
		   return 0
	    end
   return 1
end
--**********************************
--手工装备重洗
--**********************************
function x500505_DoRefreshSuperAttr(sceneId,selfId,nEquipPos)
         if nEquipPos == nil then
		    return
		 end
		 local Material = 38000956
		 local Need = 0
		 ---检测是否是手工
		 local _,nData = LuaFnGetItemCreator(sceneId, selfId, nEquipPos)
		 if nData == nil then
		    x500505_NotifysTip( sceneId, selfId, "#{ZBCZ_140618_28}")
		    return
		 end
		 local OneStr = strsub(nData,1,2)		 
		 if strbyte(OneStr) < 49 then
		    x500505_NotifysTip( sceneId, selfId, "#{ZBCZ_140618_28}")
		    return
		 end
		 local EquipLevle = GetBagItemLevel(sceneId,selfId,nEquipPos)
		 if EquipLevle < 80 then
		    x500505_NotifysTip( sceneId, selfId, "#{ZBCZ_140618_28}33")
		    return
		 end
		 local Qula = LuaFnGetItmQual(sceneId,selfId,nEquipPos)
		 if Qula < 8 then
		    x500505_NotifysTip( sceneId, selfId, "#{ZBCZ_140618_28}44")
		    return
		 end
		 if Qula == 8 then
		    Need = Material
		 end
		 if Qula >= 9 then
		    Need = Material
		 end

    local nDelJZ, nDelMoney = LuaFnCostMoneyWithPriority(sceneId, selfId, 1000000);
	if nDelJZ == -1 then
		x500505_NotifysTip( sceneId, selfId,"#{THD_190613_116}")
		return
	end
		 local Have = LuaFnGetAvailableItemCount(sceneId,selfId,Need)
		 if Have < 1 then
		    x500505_NotifysTip( sceneId, selfId, "所需"..GetItemName(sceneId,Need).."不足1个。")
		    return
		 end
		 if LuaFnDelAvailableItem(sceneId,selfId,Need,1) ~= 1 then
		    return
		 end
		 LuaFnRewashEquipAttr(sceneId,selfId,nEquipPos)
		 LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效
		 local str = format("#{_INFOUSR%s}#P看着手里属性一般的手工，于是到#G苏州（266，146）#Y欧治于#P处通过手工重洗的功能得到了#{_INFOMSG%s}#P", GetName(sceneId,selfId),GetBagItemTransfer(sceneId,selfId,nEquipPos))
		 BroadMsgByChatPipe( sceneId, selfId, str, 4 )
end
--**********************************
--神器炼魂请求-属性
--**********************************
function x500505_ShenQiConfirm(sceneId,selfId,nEquipPos,nTargetID)

	if nEquipPos == nil or nTargetID == nil then
		return
	end
	
	if x500505_GetHumunBagPos(sceneId,selfId) == 0 then
	    return
	end
	local nMenPaiID = LuaFnGetMenPai(sceneId,selfId)
	--这种情况应该不会出现，但是还是要检测下
	if nMenPaiID == -1 or nMenPaiID == 9 then
		x500505_NotifysTip( sceneId, selfId, "门派数据异常，请检查您的角色状态！")
		return
	end
	local nOldWeaponID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nEquipPos )
	local nWeaponLevel = GetBagItemLevel(sceneId,selfId,nEquipPos)
	--武器等级判断
	local nNewItemID,nNeedMoney,nMaterial_1 = x500505_GetShenqiUpgradeInfo(sceneId,selfId,nOldWeaponID)
	if nNewItemID == nil or nMaterial_1 == -1 then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_37}1")
		return
	end
	if nNewItemID[nTargetID] == nil then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_37}2")
	return
	end
	
	--判断金币
	local nDelJZ, nDelMoney = LuaFnCostMoneyWithPriority(sceneId, selfId, 50000);
	if nDelJZ == -1 then
		x500505_NotifysTip( sceneId, selfId,"#{CXYH_140813_40}")
		return
	end

	--20190609 add
	local nCostMaterial = 0
	if nMaterial_1 ~= -1 then
		nCostMaterial = nMaterial_1
	end
	local nMaterialNum = LuaFnGetAvailableItemCount(sceneId,selfId,nCostMaterial)--Mtl_GetCostNum(sceneId, selfId,nCostMaterial)
	if nMaterialNum < x500505_ShenBingFu_Need then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_39}")
		return
	end
    
    LuaFnDelAvailableItem(sceneId,selfId,nCostMaterial,x500505_ShenBingFu_Need)
     CostMoney(sceneId,selfId, 50000) 
    LuaFnEquipTransToNew(sceneId,selfId,nEquipPos,nNewItemID[nTargetID])
	if LuaFnGetItmQual(sceneId,selfId,nEquipPos) ~=8 then
		LuaFnSetItemQual(sceneId,selfId,nEquipPos, 8)
	end
	LuaFnRewashEquipAttr(sceneId,selfId,nEquipPos)	
	local transfer = GetBagItemTransfer(sceneId,selfId,nEquipPos)	
    x500505_NotifysTip( sceneId, selfId, "恭喜你神器炼魂成功")
	local str = format("#{_INFOUSR%s}#P总是用着一个神器，于是在#G大理（150，155）#Y欧治于#P处通过神器炼魂的功能得到了#{_INFOMSG%s}#P", GetName(sceneId,selfId),transfer)
	BroadMsgByChatPipe( sceneId, selfId, str, 4 )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效
end
--**********************************
--神器重洗
--**********************************
function x500505_OnShenqiUpgrade(sceneId,selfId,nEquipPos)
    local WeaponID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, nEquipPos )
	local nWeaponLevel = GetBagItemLevel(sceneId,selfId,nEquipPos)
	local Material = {30505816,30505817,30505908}
	local nEEd = 0
	if x500505_GetHumunBagPos(sceneId,selfId) == 0 then
	    return
	end
	if nEquipPos ==nil  then
	   return
	end
	if WeaponID < 10300000 or WeaponID > 10308051 then
	    x500505_NotifysTip( sceneId, selfId, "该装备不能重洗")
	   return
	end

    if nWeaponLevel == 86 then
	   nEEd = Material[1]
	end
    if nWeaponLevel == 96 then
	   nEEd = Material[2]
	end
    if nWeaponLevel == 102 then
	   nEEd = Material[3]
	end
	if nEEd == 0 then
	   return
	end	
	--判断金币
	local nMoneyJZ = 0
	local nMoneyJB = GetMoney(sceneId,selfId)
	local nMoneySelf = nMoneyJZ + nMoneyJB
	if nMoneySelf < 5000000 then
		x500505_NotifysTip( sceneId, selfId, "#{CXYH_140813_40}" )
	    return
	end	
	if AddMoney(sceneId,selfId, -5000000) ~= 1 then
		x500505_NotifysTip( sceneId, selfId,"金钱不足。")
		return
	end	
	print(nEEd)
	if LuaFnGetAvailableItemCount(sceneId,selfId,nEEd) < 5 then
	   x500505_NotifysTip( sceneId, selfId, "所需"..GetItemName(sceneId,nEEd).."不足5个。")
	   return
	end
	if LuaFnDelAvailableItem(sceneId,selfId,nEEd,5) ~= 1 then
	     x500505_NotifysTip( sceneId, selfId, "所需"..GetItemName(sceneId,nEEd).."不足5个。")
	   return
	end
    LuaFnRewashEquipAttr(sceneId,selfId,nEquipPos) 
	local transfer = GetBagItemTransfer(sceneId,selfId,nEquipPos)
    local transfera = GetBagItemTransfer(sceneId,selfId,nMateriaPos)	
	x500505_NotifysTip( sceneId, selfId, "恭喜你神器重洗成功")
	local str = format("#{_INFOUSR%s}#P拿着%s，在#G苏州（266，146）#Y欧治于#P处将#{_INFOMSG%s}重洗成功#P。", GetName(sceneId,selfId),GetItemName(sceneId,nEEd),transfer)
	BroadMsgByChatPipe( sceneId, selfId, str, 4 )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效	
	return
end
--**********************************
--醒目提示
--**********************************
function x500505_NotifysTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--获取神器炼化信息
--**********************************
function x500505_GetShenqiUpgradeInfo(sceneId,selfId,nItemID)
	local nSuperWeaponUp = {
	[0] = {
{10311007,"大唐昆岳",10310007},
{10311008,"大唐昆岳",10310007},
{10311009,"大唐昆岳",10310007},

},	
	[1] = {
{10311001,"大夏龙雀",10310007},
{10311002,"大夏龙雀",10310007},
{10311003,"大夏龙雀",10310007},
 },
	[2] = {
{10311004,"大秦锋镝",10310007},
{10311005,"大秦锋镝",10310007},
{10311006,"大秦锋镝",10310007},	
},
	[3] = {
{10311010,"大商尘影",10310017},
{10311011,"大商尘影",10310017},
{10311012,"大商尘影",10310017},
},			 
	[4] = {
{10311016,"大周岚夜",10310017},
{10311017,"大周岚夜",10310017},
{10311018,"大周岚夜",10310017},
},				 
	[5] = {
{10311019,"大晋星痕",10310017},
{10311020,"大晋星痕",10310017},
{10311021,"大晋星痕",10310017},
},
	[6] = {
{10311025,"大汉弘纲",10310037},
{10311026,"大汉弘纲",10310037},
{10311027,"大汉弘纲",10310037},
},		 
	[7] = {
{10311028,"大隋凝霜",10310037},
{10311029,"大隋凝霜",10310037},
{10311030,"大隋凝霜",10310037},
},				 
	[8] = {
{10311022,"大宋君岑",10310027},
{10311023,"大宋君岑",10310027},
{10311024,"大宋君岑",10310027},
},				 
    }
	
	
	local mpID = LuaFnGetMenPai(sceneId, selfId )
	local g_NewId, g_NeedMoney = {},50000
	local nMaterial_1 = -1

    if nSuperWeaponUp[mpID] ~= nil then
	if nSuperWeaponUp[mpID][1][3] == nItemID then
	    for j =1,getn(nSuperWeaponUp[mpID]) do
	       g_NewId[j] = nSuperWeaponUp[mpID][j][1]
	    end
	end
	end


	
	
	

	     nMaterial_1 = 30505806
 
	return g_NewId, g_NeedMoney,nMaterial_1
end