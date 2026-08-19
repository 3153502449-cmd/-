--武意·沉锋
--2019-11-2 11:39:29 逍遥子
--暴击在底层限制，识别BUFF 25474-25483
x808241_g_scriptId = 808241
--**********************************
--第三次命中效果
--**********************************
function x808241_OnImpactFadeOut( sceneId, selfId, impactId )
	for i = 25474,25483 do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, i) == 1 then
			LuaFnCancelSpecificImpact(sceneId,selfId,i)
		end
	end
end
--**********************************
--技能释放效果
--**********************************
function x808241_StartWuYiChenFeng(sceneId,selfId)
	if GetMissionData(sceneId,selfId,WUYI_SKILL_ITEM) > LuaFnGetCurrentTime() then
		return
	end
	local nWuYiLevel = floor(mod(GetMissionData(sceneId,selfId,WUYI_SKILL_DE),10^6)/10^4)
	if nWuYiLevel == 0 then
		nWuYiLevel = 1;
	end
	local nImpact = 25473 + nWuYiLevel
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, nImpact) ~= 1 then
		--命中记录
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,25470,0)
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,nImpact,0)
		--时间记录
		SetMissionData(sceneId,selfId,WUYI_SKILL_ITEM,LuaFnGetCurrentTime()+300)
	end
end
--**********************************
--醒目提示
--**********************************
function x808241_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
