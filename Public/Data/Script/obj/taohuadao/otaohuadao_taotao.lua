--桃花岛NPC-桃陶
--2019-11-7 22:24:00 逍遥子
--脚本号
x000512_g_scriptId = 000512

--**********************************
--事件列表
--**********************************
function x000512_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nMenPaiID = GetMenPai(sceneId,selfId);
		if nMenPaiID == 13 then
			AddText(sceneId,"#{THD_190613_01}");
		else
			AddText(sceneId,"#{THD_190613_02}");
		end
		AddNumText(sceneId, x000512_g_scriptId, "A", -1, i)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000512_OnDefaultEvent( sceneId, selfId,targetId )
	x000512_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000512_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	
	return
end