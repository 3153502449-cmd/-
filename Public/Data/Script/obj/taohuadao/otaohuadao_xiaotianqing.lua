--桃花岛NPC-小天青and小雨歇
--2019-11-15 20:27:34 逍遥子
--脚本号
x000559_g_scriptId = 000559

--**********************************
--事件列表
--**********************************
function x000559_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		if GetName(sceneId,targetId) == "小雨歇" then
			AddText(sceneId,"#{THD_190613_149}#r#{THD_190613_150}");
		else
			AddText(sceneId,"#{THD_190613_151}#r#{THD_190613_152}");
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000559_OnDefaultEvent( sceneId, selfId,targetId )
	x000559_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000559_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	if sign == 0 then
		
	end
	return
end