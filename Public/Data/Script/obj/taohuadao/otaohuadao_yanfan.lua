--桃花岛NPC-燕返
--2019-11-15 19:59:09 逍遥子

x000506_g_scriptId = 000506

--**********************************
--事件交互入口
--**********************************
function x000506_OnDefaultEvent( sceneId, selfId,targetId )
	x000506_g_MenPai = GetMenPai(sceneId, selfId)
	if x000506_g_MenPai == 13 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THD_190613_11}")
			AddNumText(sceneId, x000506_g_scriptId, "学习技能",12,0)
			AddNumText(sceneId, x000506_g_scriptId, "#{MPJJ_XT_110705_01}",11,10)
			AddNumText(sceneId, x000506_g_scriptId, "#{MPJJ_XT_110705_03}",11,11)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
			BeginEvent(sceneId)
			AddText(sceneId,"#{THD_190613_12}")
			AddNumText(sceneId, x000506_g_scriptId, "#{MPJJ_XT_110705_01}",11,10)
			AddNumText(sceneId, x000506_g_scriptId, "#{MPJJ_XT_110705_03}",11,11)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end

--**********************************
--事件列表选中一项
--**********************************
function x000506_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 10 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{MPJJ_XT_110705_02}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 11 then
		BeginEvent(sceneId)					
			AddText( sceneId, "#{MPJJ_XT_110705_08}" )							
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	DispatchXinfaLevelInfo( sceneId, selfId, targetId, 13 );
end
