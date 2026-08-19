--洛阳NPC
--燕青
--普通

--脚本号
x002099_g_ScriptId = 002099

--所拥有的事件ID列表
x002099_g_eventList={}
--**********************************
--事件列表
--**********************************
function x002099_UpdateEventList( sceneId, selfId,targetId )
    -- local _,nImpact = LuaFnGetEquipVisualAndImpactInTable(sceneId,10301200)
	BeginEvent(sceneId)
		AddText(sceneId,"#{WH_090729_03}")
		for i, eventId in x002099_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end	
		AddNumText(sceneId,x002099_g_ScriptId,"提升武魂合成等级",6,1)  ---
		AddNumText(sceneId,x002099_g_ScriptId,"武魂开辟属性栏",6,2)
		AddNumText(sceneId,x002099_g_ScriptId,"武魂扩展属性学习",6,3)
		AddNumText(sceneId,x002099_g_ScriptId,"武魂扩展属性升级",6,4)
		AddNumText(sceneId,x002099_g_ScriptId,"武魂领悟技能",6,5)
		AddNumText(sceneId,x002099_g_ScriptId,"重洗武魂技能",6,6)
		AddNumText(sceneId,x002099_g_ScriptId,"武魂技能升级",6,7)
		AddNumText(sceneId,x002099_g_ScriptId,"武魂说明",11,8)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002099_OnDefaultEvent( sceneId, selfId,targetId )
	x002099_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x002099_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x002099_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
	if GetNumText() == 1 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt( sceneId,2)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 20090721)
	elseif GetNumText() == 2 then 
	    BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt( sceneId,4)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 20090721)
	elseif GetNumText() == 3 then 
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt( sceneId,1)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 20090721)
	elseif GetNumText() == 4 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId);
			UICommand_AddInt( sceneId,1)
		EndUICommand(sceneId )
		DispatchUICommand(sceneId,selfId, 20090720 )
	elseif GetNumText() == 5 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
	        UICommand_AddInt(sceneId,1)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090722)
	elseif GetNumText() == 6 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
	        UICommand_AddInt(sceneId,2)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090722)
	elseif GetNumText() == 7 then
		BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId,20090723)
	elseif GetNumText() == 8 then
		BeginEvent(sceneId)
			AddNumText(sceneId,x002099_g_ScriptId,"武魂背景介绍",11,9)
			AddNumText(sceneId,x002099_g_ScriptId,"怎样获得武魂及相关道具",11,10)
			AddNumText(sceneId,x002099_g_ScriptId,"武魂升级介绍",11,11)
			AddNumText(sceneId,x002099_g_ScriptId,"武魂合成等级介绍",11,12)
			AddNumText(sceneId,x002099_g_ScriptId,"武魂拓展属性介绍",11,13)
			AddNumText(sceneId,x002099_g_ScriptId,"武魂技能介绍",11,14)
			AddNumText(sceneId,x002099_g_ScriptId,"武魂属相介绍",11,15)
			AddNumText(sceneId,x002099_g_ScriptId,"武魂的寿命",11,16)
			AddNumText(sceneId,x002099_g_ScriptId,"返回上一页",8,17)
	    EndEvent(sceneId)
	    DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 9 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090820_01}" )
		--AddNumText(sceneId,x002099_g_ScriptId,"返回上一页",8,18)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 10 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_59}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 11 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_45}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 12 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_46}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 13 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_47}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 14 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_48}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 15 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090729_49}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 16 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{WH_090820_02}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 17 then
		x002099_UpdateEventList( sceneId, selfId,targetId )
	elseif GetNumText() == 18 then
		
	end
	
end

--**********************************
-- --对话窗口信息提示
--**********************************
function x002099_NotifyFailBox( sceneId, selfId,  msg )
	BeginEvent(sceneId)
	AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)

end