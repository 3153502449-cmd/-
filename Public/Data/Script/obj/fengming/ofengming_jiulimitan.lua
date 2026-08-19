--凤鸣NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x760111_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"     有巢氏的走狗，不要妄想从吾这里问出什么！！#r    想吾九黎一族个个英雄了得，如何会向尔等蝼蚁投降。#r    #G小提示：九黎俘虏冥顽不灵，或许用些特殊物品，能够让他开口。 ");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
