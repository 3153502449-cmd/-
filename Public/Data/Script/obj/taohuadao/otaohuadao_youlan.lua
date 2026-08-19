--桃花岛NPC-幽澜
--2019-11-15 20:27:34 逍遥子
--脚本号
x000524_g_scriptId = 000524

--**********************************
--事件列表
--**********************************
function x000524_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{THD_190613_53}");
		AddNumText(sceneId, x000524_g_scriptId, "#{THD_190613_54}",6,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000524_OnDefaultEvent( sceneId, selfId,targetId )
	x000524_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000524_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	if sign == 0 then
		
	end
	return
end