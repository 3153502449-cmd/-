--琅嬛福地NPC

--脚本号
x002109_g_ScriptId = 002109


--所拥有的事件ID列表
x002109_g_eventList={893083,893084}
--**********************************
--事件列表
--**********************************
function x002109_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{LHFD_160203_145}")
		AddNumText( sceneId, x002109_g_ScriptId, "关于琅嬛福地",0 ,2  )
		for i, eventId in x002109_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002109_OnDefaultEvent( sceneId, selfId,targetId )
	x002109_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002109_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 2 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{LHFD_160203_07}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	for i, findId in x002109_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnEventRequest",sceneId, selfId, targetId, GetNumText(),x002109_g_ScriptId )
		return
		end
	end
end

