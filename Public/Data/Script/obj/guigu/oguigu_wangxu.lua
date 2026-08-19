--鬼谷NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x080013_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{XMPGG_160823_66}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
