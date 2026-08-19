--**********************************
-- 修炼系统
-- 逍遥子 FOR XYJ
-- NPC
-- QQ 857904341
--**********************************
--脚本号
x900008_g_ScriptId = 900008
--**********************************
--事件列表
--**********************************
function x900008_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{XL_090707_01}" )
		AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_35}", 6, 0 ) --修炼
		AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_36}", 6, 1 )
		--AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_37}", 6, 2 )
		--help
		--AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_38}", 11,3 )
		local PlayerName=GetName(sceneId,selfId)
		if 	PlayerName == "丁春秋" then
			--SetMissionData(sceneId, selfId, XIULIAN_GONGLI, 5000)
			--AddExpMore(sceneId,selfId,100000000)
			--AddMoney(sceneId,selfId,10000000)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x900008_OnEventRequest( sceneId, selfId, targetId, eventId )
    local Operation = GetNumText()

	if Operation == 0 then
		if GetLevel(sceneId,selfId) < 70 then
			x900008_NotifyTip( sceneId, selfId,"#{XL_090707_61}")
			return
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,1)--1修炼2提升修炼境界
			UICommand_AddInt(sceneId,0)--g_IsSpecialState
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 171717)
		return
	end
	if Operation == 1 then
		if GetLevel(sceneId,selfId) < 70 then
			x900008_NotifyTip( sceneId, selfId,"#{XL_090707_61}")
			return
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			UICommand_AddInt(sceneId,2)--1修炼2提升修炼境界
			UICommand_AddInt(sceneId,0)--g_IsSpecialState
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 171717)
		return
	end
	if Operation == 2 then
		--暂未开放
	end
	if Operation == 3 then
		BeginEvent(sceneId)
			AddText( sceneId, "#{XL_090707_46}" )
			AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_60}", 11, 100 )
			AddNumText( sceneId, x900008_g_ScriptId, "#{XLZY_120330_19}", 11, 101 )
			AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_69}", 11, 102 )
			AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_61}", 11, 103 )
			AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_63}", 11, 104 )
			AddNumText( sceneId, x900008_g_ScriptId, "#{XL_XML_64}", 11, 105 )
			AddNumText( sceneId, x900008_g_ScriptId, "#{XLPF_110520_01}", 11, 106 )
			AddNumText( sceneId, x900008_g_ScriptId, "返回上一页", 0, 107 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)	
		return
	end
	--/////////////////////////////////////////////
	if Operation == 100 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_48}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 101 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XLZY_120330_20}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 102 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_52}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 103 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_53}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 104 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_55}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 105 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XL_090707_56}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 106 then
		BeginEvent( sceneId )
		AddText( sceneId, "#{XLPF_110520_02}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if Operation == 107 then
		x900008_UpdateEventList( sceneId, selfId,targetId )
		return
	end
end

--**********************************
--事件交互入口
--**********************************
function x900008_OnDefaultEvent( sceneId, selfId,targetId )
	x900008_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x900008_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
	AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end