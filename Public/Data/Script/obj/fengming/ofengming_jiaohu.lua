--凤鸣NPC
--焦虎
--装备升灵
x760104_g_ScriptId = 760104
--**********************************
--事件交互入口
--**********************************
function x760104_OnDefaultEvent( sceneId, selfId,targetId )
   local myLevel = GetLevel(sceneId, selfId)
   if myLevel < 85 then
        BeginEvent(sceneId)
			AddText(sceneId, "    你的等级低于85级，不能使用装备升灵功能.")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
        return
   end
	BeginEvent(sceneId)
		AddText(sceneId,"#{ZZZB_150811_109}")
		AddNumText( sceneId, x760104_g_ScriptId, "王权升灵",6,1)
		AddNumText( sceneId, x760104_g_ScriptId, "天道升灵",6,2)
		AddNumText( sceneId, x760104_g_ScriptId, "装备进阶",6,3)
		AddNumText( sceneId, x760104_g_ScriptId, "升灵转移",6,4)
		AddNumText( sceneId, x760102_g_scriptId, "关于手工装备升灵", 11, 5)	
		AddNumText( sceneId, x760102_g_scriptId, "关于手工装备进阶", 11, 6)	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x760104_OnEventRequest( sceneId, selfId, targetId, eventId)
	
	if GetNumText() == 5 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZZZB_150811_294}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if GetNumText() == 6 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{ZZZB_150811_295}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end


	if GetNumText() == 1 then
	   BeginUICommand(sceneId)
	      UICommand_AddInt(sceneId,targetId);
	      EndUICommand(sceneId )
	   DispatchUICommand(sceneId,selfId, 201708093)
           return
	end

	if GetNumText() == 2 then
	   BeginUICommand(sceneId)
	      UICommand_AddInt(sceneId,targetId);
	      EndUICommand(sceneId )
	   DispatchUICommand(sceneId,selfId, 201708097)
           return
	end

	if GetNumText() == 3 then
	   BeginUICommand(sceneId)
	      UICommand_AddInt(sceneId,targetId);
	      EndUICommand(sceneId )
	   DispatchUICommand(sceneId,selfId, 20170526)
           return
	end

	if GetNumText() == 4 then
	   BeginUICommand(sceneId)
	      UICommand_AddInt(sceneId,targetId);
              UICommand_AddInt( sceneId,8)
	      EndUICommand(sceneId )
	   DispatchUICommand(sceneId,selfId, 20090721  )
           return
	end
end
