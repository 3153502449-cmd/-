--苏州NPC
--云雪儿
--珍兽
x001089_g_ScriptId = 001089
--**********************************
--事件交互入口
--**********************************
function x001089_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  我是小丫鬟，不管事。你不要勾引我!")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--远程调用
--**********************************
function x001089_OnEventRequest( sceneId, selfId, targetId, eventId )


end