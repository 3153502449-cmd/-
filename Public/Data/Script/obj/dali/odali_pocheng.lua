-- 大理NPC
-- 破尘

x002933_g_scriptId = 002933

--**********************************
--事件交互入口
--**********************************
function x002933_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{SXRW_090119_068}" )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
