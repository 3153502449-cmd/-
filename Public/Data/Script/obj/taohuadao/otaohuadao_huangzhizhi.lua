--桃花岛NPC-黄志之
--2019-11-7 22:24:00 逍遥子
--脚本号
x000509_g_scriptId = 000509

--**********************************
--事件列表
--**********************************
function x000509_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local nMenPaiID = GetMenPai(sceneId,selfId);
	if nMenPaiID == 13 then
		AddText(sceneId,"#{THD_190613_05}");
	else
		AddText(sceneId,"#{THD_190613_06}");
	end
	AddNumText(sceneId, x000509_g_scriptId, "#{THD_190613_40}",6,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000509_OnDefaultEvent( sceneId, selfId,targetId )
	x000509_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000509_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	if sign == 0 then
		DispatchShopItem( sceneId, selfId,targetId, 269 )
	end
end