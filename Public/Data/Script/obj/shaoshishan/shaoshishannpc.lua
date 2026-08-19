--楼兰NPC....
--缥缈峰接引使....

--脚本号
x002096_g_ScriptId = 002096


--所拥有的事件ID列表
x002096_g_eventList={890063}

--**********************************
--事件列表
--**********************************
function x002096_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
			AddText(sceneId,"#{CJG_101231_381}")
		for i, eventId in x002096_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002096_OnDefaultEvent( sceneId, selfId,targetId )
	x002096_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002096_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002096_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x002096_g_ScriptId )
		return
		end
	end
end

