--===========================
--六博棋盒
--===========================
--脚本ID
x502018_g_scriptId = 502018

--**********************************
-- 事件交互入口
--**********************************
function x502018_OnDefaultEvent( sceneId, selfId, targetId )
    local songQi = GetMissionDataEx(sceneId,selfId,MD_CHESS_SONG)
    local liaoQi = GetMissionDataEx(sceneId,selfId,MD_CHESS_LIAO)
	BeginUICommand(sceneId)
	   UICommand_AddInt( sceneId, songQi )      
	   UICommand_AddInt( sceneId, liaoQi )      
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 502018)
end
--**********************************
--玩家屏幕中间提示
--**********************************
function x502018_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--对话窗口信息提示
--**********************************
function x502018_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end
--**********************************
-- 
--**********************************
function x502018_IsSkillLikeScript( sceneId, selfId)
	return 0
end

