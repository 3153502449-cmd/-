function x893083_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
	AddNumText( sceneId, x893083_g_ScriptId, "#{LHFD_160203_28}",6 ,7  )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
function x893083_OnEnumerate( sceneId, selfId, targetId )
end