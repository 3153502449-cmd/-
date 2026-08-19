--凤鸣NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x760110_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"     东方青木，生命之力已然在荒野废墟中重新萌动。所有的苦难、哀恸都如土壤之中沉积的养分，终会成为建木之树破后而立的绵绵生息。#r    你看，那些带来灾厄的九黎之人已经退去。而信仰者澎湃生命之力的#G不归城#W之人也涌现了出来。他们就如同我们#G罗浮遗脉#W一样善良纯真，是热爱自然的隐士。");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
