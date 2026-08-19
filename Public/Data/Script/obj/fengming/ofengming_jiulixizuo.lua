--凤鸣NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x760112_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"     滚开，蝼蚁！！待我九黎一族的战士踏入这凤鸣镇，便是尔等死期！#r    #G小提示：九黎俘虏冥顽不灵，或许用些特殊物品，能够让他开口。 ");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
