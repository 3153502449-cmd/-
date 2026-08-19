--**********************************
-- 事件交互入口
--**********************************

x080009_g_ScriptId	= 080009

--**********************************
--事件交互入口
--**********************************
function x080009_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		if GetLevel( sceneId, selfId ) >= 10 then
			AddText( sceneId, "#{ZLSCS_160825_01}" )
			AddNumText( sceneId, x080009_g_ScriptId, "#{ZLSCS_160825_03}", 6, 1220 )
			AddNumText( sceneId, x080009_g_ScriptId, "#{ZLSCS_160825_04}", 6, 1001 )						
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x080009_OnEventRequest( sceneId, selfId, targetId, eventId )
	local arg = GetNumText()
	if arg == 1001 then		--传送至阵灵石·人
		BeginEvent( sceneId )
			AddText( sceneId, "#{ZLSCS_160825_11}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 197, 159, 46, 10 )
		return
	end

	if arg == 1220 then		--传送至阵灵石·地
		BeginEvent( sceneId )
			AddText( sceneId, "#{ZLSCS_160825_10}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 197, 95,144, 10 )
		return
	end
	
end