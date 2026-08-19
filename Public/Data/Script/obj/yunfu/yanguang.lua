--云浮NPC
--普通

--**********************************
--事件交互入口
--**********************************
function x761000_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"     一瓢春酝，三尺斩妖邪！哈哈哈哈哈，如能戎马征战斩尽宵小，岂不快哉！ ");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
