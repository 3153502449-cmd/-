--大理NPC
--告示牌
--普通

--**********************************
--事件交互入口
--**********************************
function x002925_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"    本告示牌由大理兵器店蒲老板出资设立，专供各路江湖人士在此发布或接取悬赏之用。现已天下太平，夜不闭户，无人发布悬赏，此告示牌就此闲置在此。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
