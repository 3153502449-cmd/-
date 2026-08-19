--**********************************
--事件交互入口
--**********************************
function x001094_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  功能待定。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

