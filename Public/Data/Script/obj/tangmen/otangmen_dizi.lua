--唐门NPC
--唐门姥姥
--普通

--**********************************
--事件交互入口
--**********************************
function x017503_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{XMPTM_130813_14}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
