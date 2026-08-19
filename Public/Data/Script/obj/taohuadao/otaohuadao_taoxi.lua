--桃花岛NPC-桃溪
--2019-11-7 22:24:00 逍遥子
--脚本号
x000517_g_scriptId = 000517

--**********************************
--事件列表
--**********************************
function x000517_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nMenPaiID = GetMenPai(sceneId,selfId);
		if nMenPaiID == 13 then
			AddText(sceneId,"#{THD_190613_07}");
		else
			AddText(sceneId,"#{THD_190613_08}");
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000517_OnDefaultEvent( sceneId, selfId,targetId )
	x000517_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000517_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	
	return
end