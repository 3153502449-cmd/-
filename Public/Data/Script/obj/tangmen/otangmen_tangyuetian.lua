--唐岳天

--脚本号
x017500_g_scriptId = 017500

--所拥有的事件ID列表
--x017500_g_eventList={228908}
x017500_g_eventList={228907,228908,229009,229012}
--x017500_g_eventList={}--201012,201111,201411,201412,201611,201612	,808004	

--**********************************
--事件列表
--**********************************
function x017500_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
	AddText(sceneId,"#{XMPTM_130123_109}")
	for i, eventId in x017500_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x017500_OnDefaultEvent( sceneId, selfId,targetId )
	x017500_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x017500_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x017500_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x017500_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x017500_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x017500_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x017500_g_eventList do
		if missionScriptId == findId then
			x017500_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x017500_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x017500_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x017500_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x017500_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x017500_OnDie( sceneId, selfId, killerId )
end
