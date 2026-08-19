--洛阳NPC
--苏焕焕
--普通
x000157_g_shoptableindex=155
x000110_g_scriptId = 000157
--**********************************
--事件交互入口
--**********************************
function x000157_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{GXHDZ_141121_100}" )
		AddNumText( sceneId, x000110_g_scriptId, "关于易容阁", 11, 0 )
		AddNumText( sceneId, x000110_g_scriptId, "打开易容阁", 6, 1 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x000157_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 0 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{GXHDZ_141121_103}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 1 then
		CallScriptFunction(900028, "OpenShopDresser",sceneId,selfId,targetId)
	end
end