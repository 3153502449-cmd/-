--===========================
--宋辽大战[血战雁门关]
--六博棋子
--逍遥子 QQ857904341
--===========================
--脚本号
x502017_g_scriptId = 502017

x502017_g_ChessTable = {
	[40004571] = {"宋棋：兵",1,MD_CHESS_SONG},
	[40004572] = {"宋棋：馬",10,MD_CHESS_SONG},
	[40004573] = {"宋棋：砲",100,MD_CHESS_SONG},
	[40004574] = {"宋棋：車",1000,MD_CHESS_SONG},
	[40004575] = {"宋棋：相",10000,MD_CHESS_SONG},
	[40004576] = {"宋棋：仕",100000,MD_CHESS_SONG},
	[40004577] = {"宋棋：帥",1000000,MD_CHESS_SONG},
	--辽棋
	[40004578] = {"辽棋：卒",1,MD_CHESS_LIAO},
	[40004579] = {"辽棋：馬",10,MD_CHESS_LIAO},
	[40004580] = {"辽棋：炮",100,MD_CHESS_LIAO},
	[40004581] = {"辽棋：車",1000,MD_CHESS_LIAO},
	[40004582] = {"辽棋：象",10000,MD_CHESS_LIAO},
	[40004583] = {"辽棋：士",100000,MD_CHESS_LIAO},
	[40004584] = {"辽棋：将",1000000,MD_CHESS_LIAO},
}
--**********************************
--事件交互入口
--**********************************
function x502017_OnDefaultEvent( sceneId, selfId )

end
--**********************************
--只会执行一次入口：
--返回1：处理成功；返回0：处理失败。
--**********************************
function x502017_OnActivateOnce( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId )
	local LiuBoQiHe = LuaFnGetAvailableItemCount(sceneId,selfId,40004570)
    if LiuBoQiHe < 1 then
		x502017_NotifyFailBox( sceneId, selfId, -1, "#{SLDZ_100805_19}" ) --你的任务栏没有#Y六博棋盒#W，或者你的棋盒还有棋子#G没有收集满#W，无法兑换。#r    请到#G任务栏#W查看详细情况。
		return 0
	end
	if x502017_g_ChessTable[itemTblIndex] ~= nil then
		local ChessName = x502017_g_ChessTable[itemTblIndex][1]
		local Add = x502017_g_ChessTable[itemTblIndex][2]
		local TeamData = GetMissionDataEx(sceneId,selfId,x502017_g_ChessTable[itemTblIndex][3])
		if floor(mod(TeamData,Add*10)/Add) >= 1 then
			x502017_Tips( sceneId, selfId, "此枚棋子已收集完成，请尽快收集其他棋子！" )
			DelItem( sceneId, selfId, itemTblIndex, 1 )
			return
        else
            SetMissionDataEx(sceneId,selfId,x502017_g_ChessTable[itemTblIndex][3],TeamData+Add)
			x502017_Tips( sceneId, selfId,"恭喜您成功注入了  "..(ChessName).."。" )
			DelItem( sceneId, selfId, itemTblIndex, 1 )
	        CallScriptFunction( 502018, "OnDefaultEvent", sceneId,selfId,targetId)
			return
        end
	else
		x502017_Tips( sceneId, selfId, "棋子数据异常，无法完成注入！" )
		return 0
	end
end
--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x502017_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x502017_OnDeplete( sceneId, selfId )
	return 1
end


--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x502017_OnConditionCheck( sceneId, selfId )
	return 1
end
--**********************************
-- 
--**********************************
function x502017_IsSkillLikeScript( sceneId, selfId)
	return 1
end
function x502017_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x502017_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
-- 屏幕中心信息提示
--**********************************
function x502017_Tips( sceneId, selfId,msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
