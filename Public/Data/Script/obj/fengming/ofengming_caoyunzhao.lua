--凤鸣NPC
--普通弟子
--普通

x760101_g_ScriptId = 760101
--**********************************
--事件交互入口
--**********************************
function x760101_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"待添加文案");
		AddNumText(sceneId, x760101_g_ScriptId, "寒冰海域",6,1)
		AddNumText(sceneId, x760101_g_ScriptId, "灭世火窟",6,2)
		AddNumText(sceneId, x760101_g_ScriptId, "蛊惑灵谷",6,3)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x760101_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText()==1 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 505, 70,100, 85 )
		return
	end

	if GetNumText()==2 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 506, 70,100, 85 )
		return
	end

	if GetNumText()==3 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 507, 70,100, 85 )
		return
	end

end
