--大理NPC
--崔逢九
--普通

x080010_g_ScriptId	= 080010

--**********************************
--事件交互入口
--**********************************
function x080010_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		if GetLevel( sceneId, selfId ) >= 1 then
			AddText( sceneId, "#{ZLSCS_160825_01}" )
			AddNumText( sceneId, x080010_g_ScriptId, "#{ZLSCS_160825_02}", 9, 1001 )
			AddNumText( sceneId, x080010_g_ScriptId, "#{ZLSCS_160825_03}", 9, 1002 )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x080010_OnEventRequest( sceneId, selfId, targetId, eventId )
	local arg = GetNumText()
	if arg == 1001 then		--传送至阵灵石·天
		BeginEvent( sceneId )
			AddText( sceneId, "#{ZLSCS_160825_09}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 197, 36, 43, 10 )
		return
	end
	if arg == 1002 then		--传送至阵灵石·地
		BeginEvent( sceneId )
			AddText( sceneId, "#{ZLSCS_160825_10}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 197, 95,144, 10 )
		return
	end
end
