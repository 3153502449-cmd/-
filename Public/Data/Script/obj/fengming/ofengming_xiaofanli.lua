--凤鸣NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x760108_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"     跑啊跑，跳啊跳，粒粒有个好姥姥……可姥姥为何不见了？#r    娘亲说她变成了天上的星星呢。星星，又在哪儿，好远好远啊！#r    姥姥什么时候才能回来？给小粒粒带糖糖吃……");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
