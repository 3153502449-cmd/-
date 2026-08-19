--桃花岛NPC-兰宴
--2019-11-7 22:24:00 逍遥子
--脚本号
x000516_g_scriptId = 000516

--**********************************
--事件列表
--**********************************
function x000516_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nMenPaiID = GetMenPai(sceneId,selfId);
		if nMenPaiID == 13 then
			AddText(sceneId,"#{THD_190613_05}");
		else
			AddText(sceneId,"#{THD_190613_06}");
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000516_OnDefaultEvent( sceneId, selfId,targetId )
	x000516_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000516_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	
	return
end