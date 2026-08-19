--武意·背水
--2019-11-2 15:30:07 逍遥子原创
--伤害记录于底层，识别BUFF 25484-25493，记录位 52
x808246_g_scriptId = 808246
--**********************************
--背水技能结束
--**********************************
function x808246_OnImpactFadeOut(sceneId,selfId,nImpact)
	local nDamage = GetMissionData(sceneId,selfId,MD_WUYIBEISHUI_SKILL_DAMAGE);
	local nHp = GetHp(sceneId,selfId)
	if nDamage >= nHp then
		LuaFnGmKillObj(sceneId,selfId,selfId)
	else
		LuaFnSetDamage(sceneId, selfId, selfId,nDamage)
	end
	--伤害记录清空
	SetMissionData(sceneId,selfId,MD_WUYIBEISHUI_SKILL_DAMAGE,0);
end
--**********************************
--技能释放效果
--**********************************
function x808246_StartWuYiBeiShui(sceneId,selfId)
	if LuaFnIsObjValid(sceneId, selfId) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId,selfId) ~= 1 then
		return
	end
	if GetMissionData(sceneId,selfId,WUYI_SKILL_ITEM) > LuaFnGetCurrentTime() then
		return
	end
	--BUFF赋予
	local nWuYiLevel = floor(mod(GetMissionData(sceneId,selfId,WUYI_SKILL_DE),10^6)/10^4)
	if nWuYiLevel == 0 then
		nWuYiLevel = 1;
	end
	local nImpact = 25493 + nWuYiLevel
	--背水BUFF
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, nImpact,0)
	--时间记录
	SetMissionData(sceneId,selfId,WUYI_SKILL_ITEM,LuaFnGetCurrentTime()+300)
end
--**********************************
--醒目提示
--**********************************
function x808246_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
