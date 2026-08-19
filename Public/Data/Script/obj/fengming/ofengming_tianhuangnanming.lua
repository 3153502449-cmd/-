--凤鸣NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x760107_OnDefaultEvent( sceneId, selfId,targetId )
	local StrMsg = {"#{KVKNPC_140304_41}","#{KVKNPC_140304_42}","#{KVKNPC_140304_17}","#{KVKNPC_140304_16}","#{KVKNPC_140304_15}"}
	local Str = random(1,getn(StrMsg))
	BeginEvent(sceneId)
		AddText(sceneId,StrMsg[Str]);
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
