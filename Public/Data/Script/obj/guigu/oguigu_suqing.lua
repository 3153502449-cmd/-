--鬼谷NPC
--坐骑管理员
--普通
--**********************************
--事件交互入口
--**********************************
function x080014_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{XMPGG_160823_59}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
