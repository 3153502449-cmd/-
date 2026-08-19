--9星神器特殊技能-诛仙万象
--2019-9-21 14:27:31 逍遥子
x808242_g_scriptId = 808242
x808242_g_DiHunWei = {
	{25390,25391,25392,25393,25394,25395,25396,25397,25398,25399},
	{25400,25401,25402,25403,25404,25405,25406,25407,25408,25409},
	{25410,25411,25412,25413,25414,25415,25416,25417,25418,25419},
	{25420,25421,25422,25423,25424,25425,25426,25427,25428,25429},
}
x808242_g_TianHunWei = {
	{25430,25431,25432,25433,25434,25435,25436,25437,25438,25439},
	{25440,25441,25442,25443,25444,25445,25446,25447,25448,25449},
	{25450,25451,25452,25453,25454,25455,25456,25457,25458,25459},
	{25460,25461,25462,25463,25464,25465,25466,25467,25468,25469},
}
--**********************************
--技能触发
--**********************************
function x808242_OnActiveSuperWeapon9Skill( sceneId, selfId ,targetId)
	if LuaFnIsObjValid(sceneId, targetId) ~= 1 then
	   return
	end
    --特殊情况
	if GetHp( sceneId, selfId ) == 0  or GetHp( sceneId, targetId ) == 0 or selfId == targetId or (LuaFnUnitIsEnemy(sceneId, selfId, targetId) ~= 1 )  then
	   x808242_NotifyTip( sceneId, selfId, "#{GMDP_Struct_Skill_Info_Target_Not_Enough_Reputation}")
	   return
	end
	if LuaFnIsUnbreakable(sceneId,targetId) >= 1 then
	   x808242_NotifyTip( sceneId, selfId, "目标处于无敌状态")
	   return
	end
	local _,nEquipData = LuaFnGetItemCreator( sceneId, selfId,100)
	if nEquipData == nil then
		return
	end
	local nPos_1,nPos_2,nType_1,nLevel_1,nType_2,nLevel_2,nType_3,nLevel_3 = strfind(nEquipData,"&ZX(%w)(%w%w)(%w)(%w%w)(%w)(%w%w)")
	if nPos_1 == nil or nPos_2 == nil then
		x808242_NotifyTip( sceneId, selfId, "#{JXSQ_170804_111}")
		return
	end
	--命魂伤害赋予
	LuaFnSetSuperWeaponDiySkillDmage(sceneId,selfId,targetId,tonumber(nType_1),tonumber(nLevel_1));
	--地魂减抗赋予
	if x808242_g_DiHunWei[tonumber(nType_2)] ~= nil and x808242_g_DiHunWei[tonumber(nType_2)][tonumber(nLevel_2)] ~= nil then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,x808242_g_DiHunWei[tonumber(nType_2)][tonumber(nLevel_2)], 0 )
	end
	--天魂减抗下限赋予
	if x808242_g_TianHunWei[tonumber(nType_2)] ~= nil and x808242_g_TianHunWei[tonumber(nType_2)][tonumber(nLevel_2)] ~= nil then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,x808242_g_TianHunWei[tonumber(nType_2)][tonumber(nLevel_2)], 0 );
		LuaFnRefreshEngine(sceneId,selfId);
	end
end
--**********************************
--醒目提示
--**********************************
function x808242_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
