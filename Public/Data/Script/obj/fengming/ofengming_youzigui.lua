--凤鸣NPC
--普通弟子
--普通

--**********************************
--事件交互入口
--**********************************
function x760109_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"     #G林海溪谷#W？不、不，我们美丽富饶的天荒胜景，在曾经的一场大阴谋中消失殆尽。少侠一探便知，天降劫火，紫火燃烧，林海溪谷早已只剩下一片荒芜的陨坑。#r    #Y刚玉矿石#W、#Y七彩玄晶#W也随之消散无踪，仅剩于世的也再无价值了！少侠若是再有所得，不妨直接售于#G商贾#W，换些零用的钱币吧。 ");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
