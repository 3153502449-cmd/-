--非法冷却池重置检查
x999992_g_scriptId = 999992
--**********************************
--BUFF回调
--**********************************
function x999992_OnImpactFadeOut( sceneId, selfId, impactId )
	if GetMissionFlag(sceneId,selfId,MF_ILLIGAL_COOLDOWNCHECK) ~= 1 then
		x999992_Nopardonforkilling( sceneId, selfId ) --休怪我手下无情
	else
		SetMissionFlag(sceneId,selfId,MF_ILLIGAL_COOLDOWNCHECK,0)
	end
end

function x999992_Nopardonforkilling( sceneId, selfId )
	--惩罚措施
	--SetLevel( sceneId, selfId, 0)
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 42, 0 )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 37, 0 )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 38, 0 )
    NewWorld(sceneId,selfId,77,17,56)
	--惩罚措施
	local ErrorMsg = "安全系统检测到游戏数据异常！你的账号已经被纳入安全系统的惩罚范围！如有异议，请联系运营团队！0x00"
	local Code = tostring(random(1000,9999))
	x999992_Msg( sceneId, selfId, ErrorMsg..Code)   
end
function x999992_Msg(sceneId,selfId,Msg)
		BeginEvent(sceneId)     
		AddText(sceneId, Msg)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,selfId)
end