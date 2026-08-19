--桃花岛NPC-聂先生
--2019-11-15 20:48:16 逍遥子
--脚本号
x000565_g_scriptId = 000565

--**********************************
--事件列表
--**********************************
function x000565_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{THD_190613_153}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000565_OnDefaultEvent( sceneId, selfId,targetId )
	x000565_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000565_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	
	return
end