--洛阳NPC
--普通

--脚本号
x760432_g_ScriptId = 760432


--**********************************
--事件列表
--**********************************
function x760432_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"某沿着葬潮江畔一路至此，白日参习武意，夜晚观测星象，于青山隐隐、大河滔滔之中了悟浮生奥秘，却也悠哉！")
	AddNumText( sceneId, x760432_g_ScriptId, "关于武意", 11, 100 )
	AddNumText( sceneId, x760432_g_ScriptId, "关于武意属性", 11, 200 )	
	AddNumText( sceneId, x760432_g_ScriptId, "关于武意秘传", 11, 300 )		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x760432_OnDefaultEvent( sceneId, selfId,targetId )
	x760432_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x760432_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{WYXT_20170803_06}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if GetNumText() == 200 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{WYXT_20170803_07}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end	
	if GetNumText() == 300 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{WYXT_20170803_08}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end	

	for i, findId in x760432_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x760432_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x760432_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x760432_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x760432_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x760432_g_eventList do
		if missionScriptId == findId then
			x760432_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x760432_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x760432_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x760432_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x760432_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x760432_OnDie( sceneId, selfId, killerId )
end
