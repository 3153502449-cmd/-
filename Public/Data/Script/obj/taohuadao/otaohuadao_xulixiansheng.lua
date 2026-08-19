--桃花岛NPC-徐鲤先生
--2019-11-15 20:48:16 逍遥子
--脚本号
x000564_g_scriptId = 000564

--**********************************
--事件列表
--**********************************
function x000564_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{THD_190613_141}");
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000564_OnDefaultEvent( sceneId, selfId,targetId )
	x000564_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000564_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	
	return
end