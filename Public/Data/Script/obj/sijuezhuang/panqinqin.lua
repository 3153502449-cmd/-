-- 领奖NPC

x893080_g_scriptId = 893080
x893080_g_FuBenScriptId = 893063

--**********************************
--事件交互入口
--**********************************
function x893080_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{SJZ_100129_32}")
		AddNumText( sceneId, x893080_g_scriptId, "#c00ff00我要隐身", 6, 200)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x893080_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 200 then

		if GetMenPai(sceneId,selfId) ~= MP_SHAOLIN and GetMenPai(sceneId,selfId) ~= MP_MINGJIAO and GetMenPai(sceneId,selfId) ~= MP_GAIBANG and GetMenPai(sceneId,selfId) ~= MP_TIANSHAN and GetMenPai(sceneId,selfId) ~= MP_GUSU then
			BeginEvent(sceneId)
	   			AddText( sceneId,"#{SJZ_100129_35}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else 
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 2850, 0 )
			BeginEvent(sceneId)
	   			AddText( sceneId, "我已经成功给你使用隐身粉末，注意要将珍兽收起来，否则没有隐身效果！" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end

	end
end

