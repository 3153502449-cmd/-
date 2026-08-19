--脚本号
x391001_g_scriptId = 391001
--**********************************
--事件交互入口
--**********************************
function x391001_OnDefaultEvent( sceneId, selfId, targetId)
    -- local _,nDWstr = LuaFnGetItemCreator(sceneId,selfId,0)--装备上雕纹的信息。
	-- LuaFnSetEquipItemCreatorEx(sceneId,selfId,0,"&DWD010000")
	BeginEvent(sceneId)  
		AddText(sceneId, "#{ZBDW_091105_1}")
		-- AddText(sceneId, nDWstr)
        AddNumText(sceneId, x391001_g_scriptId,"雕纹合成", 6, 1)
		AddNumText(sceneId, x391001_g_scriptId,"雕纹蚀刻", 6, 2)
		-- AddNumText(sceneId, x391001_g_scriptId,"#G雕纹融合", 6, 3)
		AddNumText(sceneId, x391001_g_scriptId,"雕纹强化", 6, 4)
		--AddNumText(sceneId, x391001_g_scriptId,"雕纹转移", 6, 5)
		AddNumText(sceneId, x391001_g_scriptId,"雕纹拆除", 6, 6)
		AddNumText(sceneId, x391001_g_scriptId,"#G雕纹拆解", 6, 7)
		AddNumText(sceneId, x391001_g_scriptId,"关于装备雕纹", 11, 8)
		-- AddNumText(sceneId, x391001_g_scriptId,"关于双极雕纹", 11, 9)
		-- SetMissionData(sceneId,selfId,MD_WeekAdnMonth,0)
		EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x391001_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key=GetNumText()
	-- TryRecieveItem(sceneId,selfId,10155003,1)
	if key==9999 then
		x391001_CloseMe(sceneId, selfId)
	elseif key==1 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000156)
	elseif key==2 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 2000156)
	elseif key==3 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 20140820)
	elseif key==4 then --雕纹强化
		local nMaterialNum = LuaFnGetAvailableItemCount(sceneId, selfId, 20310166)
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,nMaterialNum)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 3000156)--3000156 此处更正，直接快捷强化
	elseif key==5 then --雕纹转移
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 20141216)--3770156
	elseif key==6 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 4000156)
	elseif key==7 then
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 20140612)
	elseif key==8 then
		BeginEvent(sceneId)     
			AddText(sceneId, "#{ZBDW_091105_21}")
		AddText(sceneId, "    #G小提示：右键点击装备、材料进行操作，只有特定高级装备才可以雕纹。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif key==9 then
		BeginEvent(sceneId)     
			AddText(sceneId, "#{SSXDW_140819_32}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end
--**********************************
--对话窗口信息提示
--**********************************
function x391001_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x391001_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--关闭对话框
--**********************************
function x391001_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end