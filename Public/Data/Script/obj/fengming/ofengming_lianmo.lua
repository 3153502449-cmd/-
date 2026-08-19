--凤鸣NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x760372_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{WHOATN_12103118_01}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
