--桃花岛NPC-韩晗
--2019-11-7 22:24:00 逍遥子
--脚本号
x000558_g_scriptId = 000558

--**********************************
--事件列表
--**********************************
function x000558_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{THD_190613_148}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000558_OnDefaultEvent( sceneId, selfId,targetId )
	x000558_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000558_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	
	return
end