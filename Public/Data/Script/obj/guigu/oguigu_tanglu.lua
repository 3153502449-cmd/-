--鬼谷NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x080007_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{XMPGG_160823_63}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
