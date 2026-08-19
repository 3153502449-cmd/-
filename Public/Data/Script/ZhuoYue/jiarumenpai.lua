-- 卓越制作加入门派npc比较重要 请注意不要乱修改
--************************************************************************
--脚本号
x990010_g_ScriptId	= 990010

x990010_XinFaList = {{1,2,3,4,5,6,55,72},{7,8,9,10,11,12,56,73},{13,14,15,16,17,18,57,74},
{19,20,21,22,23,24,58,75},{25,26,27,28,29,30,59,76},{31,32,33,34,35,36,60,77},
{37,38,39,40,41,42,61,78},{43,44,45,46,47,48,62,79},{49,50,51,52,53,54,63,80},{0,0,0,0,0,0,0,0},
{64,65,66,67,68,69,70,71},{81,82,83,84,85,86,87,88},{89,90,91,92,93,94,95,96},}

x990010_MyXinFa = {}
x990010_g_healtargetId = 189
--**********************************
--任务入口函数
--**********************************
function x990010_OnDefaultEvent( sceneId, selfId, targetId )
	if GetMenPai(sceneId, selfId) == 9 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,x990010_g_healtargetId)
		UICommand_AddInt( sceneId, 1 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20150630 )	
	else
		local to=0
		if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) >= 1 then
			to=LuaFnGetAvailableItemCount(sceneId, selfId, 30008104)	
		end	
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,x990010_g_healtargetId)
		UICommand_AddInt( sceneId, to )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20150630 )	
	end
end
--**********************************
--事件列表选中一项
--**********************************
function x990010_MP_zhhy( sceneId, selfId,idxx ) 	
	
	if idxx<1 or idxx >11 then
		return
	end	
	
	if GetMenPai(sceneId, selfId) == 9 then
		
		if idxx == 1 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 5)
			LuaFnSetXinFaLevel(sceneId,selfId,31,60)
			LuaFnSetXinFaLevel(sceneId,selfId,32,60)
			LuaFnSetXinFaLevel(sceneId,selfId,33,60)
			LuaFnSetXinFaLevel(sceneId,selfId,34,60)
			LuaFnSetXinFaLevel(sceneId,selfId,35,60)
			LuaFnSetXinFaLevel(sceneId,selfId,36,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,60,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,77,60)	
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功拜入到星宿。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		if idxx == 2 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 8)
			LuaFnSetXinFaLevel(sceneId,selfId,49,60)
			LuaFnSetXinFaLevel(sceneId,selfId,50,60)
			LuaFnSetXinFaLevel(sceneId,selfId,51,60)
			LuaFnSetXinFaLevel(sceneId,selfId,52,60)
			LuaFnSetXinFaLevel(sceneId,selfId,53,60)
			LuaFnSetXinFaLevel(sceneId,selfId,54,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,63,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,80,60)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功拜入到逍遥。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		if idxx == 3 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 0)
			LuaFnSetXinFaLevel(sceneId,selfId,1,60)
			LuaFnSetXinFaLevel(sceneId,selfId,2,60)
			LuaFnSetXinFaLevel(sceneId,selfId,3,60)
			LuaFnSetXinFaLevel(sceneId,selfId,4,60)
			LuaFnSetXinFaLevel(sceneId,selfId,5,60)
			LuaFnSetXinFaLevel(sceneId,selfId,6,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,55,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,72,60)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功拜入到少林。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		if idxx == 4 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 7)
			LuaFnSetXinFaLevel(sceneId,selfId,43,60)
			LuaFnSetXinFaLevel(sceneId,selfId,44,60)
			LuaFnSetXinFaLevel(sceneId,selfId,45,60)
			LuaFnSetXinFaLevel(sceneId,selfId,46,60)
			LuaFnSetXinFaLevel(sceneId,selfId,47,60)
			LuaFnSetXinFaLevel(sceneId,selfId,48,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,62,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,79,60)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功拜入到天山。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		if idxx == 5 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 6)
			LuaFnSetXinFaLevel(sceneId,selfId,37,60)
			LuaFnSetXinFaLevel(sceneId,selfId,38,60)
			LuaFnSetXinFaLevel(sceneId,selfId,39,60)
			LuaFnSetXinFaLevel(sceneId,selfId,40,60)
			LuaFnSetXinFaLevel(sceneId,selfId,41,60)
			LuaFnSetXinFaLevel(sceneId,selfId,42,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,61,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,78,60)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功拜入到天龙。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		if idxx == 6 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 4)
			LuaFnSetXinFaLevel(sceneId,selfId,25,60)
			LuaFnSetXinFaLevel(sceneId,selfId,26,60)
			LuaFnSetXinFaLevel(sceneId,selfId,27,60)
			LuaFnSetXinFaLevel(sceneId,selfId,28,60)
			LuaFnSetXinFaLevel(sceneId,selfId,29,60)
			LuaFnSetXinFaLevel(sceneId,selfId,30,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,59,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,76,60)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功拜入到峨眉。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		if idxx == 7 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 3)
			LuaFnSetXinFaLevel(sceneId,selfId,19,60)
			LuaFnSetXinFaLevel(sceneId,selfId,20,60)
			LuaFnSetXinFaLevel(sceneId,selfId,21,60)
			LuaFnSetXinFaLevel(sceneId,selfId,22,60)
			LuaFnSetXinFaLevel(sceneId,selfId,23,60)
			LuaFnSetXinFaLevel(sceneId,selfId,24,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,58,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,75,60)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到武当。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		if idxx == 8 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 1)
			LuaFnSetXinFaLevel(sceneId,selfId,7,60)
			LuaFnSetXinFaLevel(sceneId,selfId,8,60)
			LuaFnSetXinFaLevel(sceneId,selfId,9,60)
			LuaFnSetXinFaLevel(sceneId,selfId,10,60)
			LuaFnSetXinFaLevel(sceneId,selfId,11,60)
			LuaFnSetXinFaLevel(sceneId,selfId,12,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,56,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,73,60)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功拜入到明教。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		if idxx == 9 then
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 2)
			LuaFnSetXinFaLevel(sceneId,selfId,13,60)
			LuaFnSetXinFaLevel(sceneId,selfId,14,60)
			LuaFnSetXinFaLevel(sceneId,selfId,15,60)
			LuaFnSetXinFaLevel(sceneId,selfId,16,60)
			LuaFnSetXinFaLevel(sceneId,selfId,17,60)
			LuaFnSetXinFaLevel(sceneId,selfId,18,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,57,60)
			--LuaFnSetXinFaLevel(sceneId,selfId,74,60)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
			BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功拜入到丐帮。", 4 )
			CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		end
		
		
	else
		
		----------------------------------------以下是转换门派
		for i = 1,8 do
			if HaveXinFa(sceneId,selfId,x990010_XinFaList[GetMenPai(sceneId,selfId)+1][i]) > 0 then
				x990010_MyXinFa[i] = HaveXinFa(sceneId,selfId,x990010_XinFaList[GetMenPai(sceneId,selfId)+1][i])
			end
		end
		
		if idxx == 1 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 5)
			LuaFnSetXinFaLevel(sceneId,selfId,31,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,32,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,33,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,34,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,35,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,36,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,60,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,77,x990010_MyXinFa[8])	
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到星宿。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return
		end
		
		if idxx == 2 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 8)
			LuaFnSetXinFaLevel(sceneId,selfId,49,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,50,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,51,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,52,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,53,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,54,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,63,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,80,x990010_MyXinFa[8])	
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到逍遥。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return
		end
		
		if idxx == 3 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 0)
			LuaFnSetXinFaLevel(sceneId,selfId,1,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,2,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,3,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,4,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,5,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,6,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,55,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,72,x990010_MyXinFa[8])
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到少林。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return	
		end
		
		if idxx == 4 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 7)
			LuaFnSetXinFaLevel(sceneId,selfId,43,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,44,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,45,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,46,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,47,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,48,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,62,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,79,x990010_MyXinFa[8])
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到天山。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return	
		end
		
		if idxx == 5 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 6)
			LuaFnSetXinFaLevel(sceneId,selfId,37,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,38,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,39,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,40,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,41,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,42,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,61,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,78,x990010_MyXinFa[8])
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到天龙。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return	
		end
		
		if idxx == 6 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 4)
			LuaFnSetXinFaLevel(sceneId,selfId,25,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,26,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,27,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,28,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,29,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,30,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,59,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,76,x990010_MyXinFa[8])
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到峨眉。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return	
		end
		
		if idxx == 7 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 3)
			LuaFnSetXinFaLevel(sceneId,selfId,19,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,20,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,21,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,22,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,23,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,24,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,58,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,75,x990010_MyXinFa[8])
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到武当。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return
		end
		
		if idxx == 8 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 1)
			LuaFnSetXinFaLevel(sceneId,selfId,7,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,8,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,9,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,10,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,11,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,12,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,56,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,73,x990010_MyXinFa[8])
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到明教。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return	
		end
		
		if idxx == 9 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
				BeginEvent(sceneId)
				AddText(sceneId,"对不起,你你没转换资格");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)	
				return
			end
			if GetLevel(sceneId,selfId) < 102 then
				x990010_NotifyTip( sceneId, selfId,"请升级到102级，并且神器进阶到102级以后再来转换门派！否则，神器将无法进阶！")
				return
			end
			LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
			
			LuaFnJoinMenpai(sceneId, selfId, x990010_g_healtargetId, 2)
			LuaFnSetXinFaLevel(sceneId,selfId,13,x990010_MyXinFa[1])
			LuaFnSetXinFaLevel(sceneId,selfId,14,x990010_MyXinFa[2])
			LuaFnSetXinFaLevel(sceneId,selfId,15,x990010_MyXinFa[3])
			LuaFnSetXinFaLevel(sceneId,selfId,16,x990010_MyXinFa[4])
			LuaFnSetXinFaLevel(sceneId,selfId,17,x990010_MyXinFa[5])
			LuaFnSetXinFaLevel(sceneId,selfId,18,x990010_MyXinFa[6])
			LuaFnSetXinFaLevel(sceneId,selfId,57,x990010_MyXinFa[7])
			--LuaFnSetXinFaLevel(sceneId,selfId,74,x990010_MyXinFa[8])
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			local	nam	= LuaFnGetName( sceneId, selfId )
				BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到丐帮。", 4 )
				CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
			return
		end
		
	end
end
