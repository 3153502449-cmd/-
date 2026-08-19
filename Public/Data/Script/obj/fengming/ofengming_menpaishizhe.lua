--凤鸣NPC
--门派使者集合
--普通

--**********************************
--事件交互入口
--**********************************
function x760105_OnDefaultEvent( sceneId, selfId,targetId )
	local NPCName = GetName(sceneId,targetId)
	BeginEvent(sceneId)
	    if NPCName == "曹琦" then
			AddText(sceneId,"#{JCZB_161108_1}");
		end
		if NPCName == "苏敬池" then
			AddText(sceneId,"#{KVKNPC_140304_24}");
		end
		if NPCName == "明厉大师" then
			AddText(sceneId,"#{KVKNPC_140304_25}");
		end
		if NPCName == "黎岫锋" then
			AddText(sceneId,"#{KVKNPC_140304_26}");
		end
		if NPCName == "天岩大师" then
			AddText(sceneId,"#{KVKNPC_140304_27}");
		end
		if NPCName == "宋倩秋" then
			AddText(sceneId,"#{KVKNPC_140304_28}");
		end
		if NPCName == "唐千川" then
			AddText(sceneId,"#{KVKNPC_140304_23}");
		end
		if NPCName == "郭大鹏" then
			AddText(sceneId,"#{KVKNPC_140304_22}");
		end
		if NPCName == "朱翎羽" then
			AddText(sceneId,"#{KVKNPC_140304_21}");
		end
		if NPCName == "慕容玖" then
			AddText(sceneId,"#{KVKNPC_140304_20}");
		end
		if NPCName == "叶睿" then
			AddText(sceneId,"#{KVKNPC_140304_19}");
		end
		if NPCName == "宁忆" then
			AddText(sceneId,"#{KVKNPC_140304_18}");
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
