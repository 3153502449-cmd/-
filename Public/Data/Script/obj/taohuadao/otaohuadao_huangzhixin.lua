--桃花岛NPC-黄志心
--2019-11-7 22:24:00 逍遥子
--脚本号
x000508_g_scriptId = 000508

--**********************************
--事件列表
--**********************************
function x000508_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nMenPaiID = GetMenPai(sceneId,selfId);
		if nMenPaiID == 13 then
			AddText(sceneId,"#{THD_190613_27}");
		else
			AddText(sceneId,"#{THD_190613_28}");
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
--	for i = 97,102 do
--		LuaFnSetXinFaLevel(sceneId,selfId,i,15)
--	end
--	AddExp(sceneId,selfId,10000)
--	YuanBao(sceneId,selfId,selfId,1,200000)
--	AddMoney(sceneId,selfId,10000000)
end

--**********************************
--事件交互入口
--**********************************
function x000508_OnDefaultEvent( sceneId, selfId,targetId )
	x000508_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000508_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	
	return
end