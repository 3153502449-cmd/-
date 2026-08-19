--慕容NPC
--使者

--**********************************
--事件交互入口
--**********************************
function x002140_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId," #{GUSU_MENPAI_33}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
