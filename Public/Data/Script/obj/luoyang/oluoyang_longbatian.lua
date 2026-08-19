--洛阳NPC
--神医
--普通

--脚本号
x000129_g_scriptId = 000129

--所拥有的事件ID列表
x000129_g_eventList={701603}				-- “珍兽治疗”脚本

--游医脚本编号
x000129_g_healScriptId = 000064



--治疗设定 参见脚本000064
x000129_XinFaList = {{1,2,3,4,5,6,55,72},{7,8,9,10,11,12,56,73},{13,14,15,16,17,18,57,74},
{19,20,21,22,23,24,58,75},{25,26,27,28,29,30,59,76},{31,32,33,34,35,36,60,77},
{37,38,39,40,41,42,61,78},{43,44,45,46,47,48,62,79},{49,50,51,52,53,54,63,80},{0,0,0,0,0,0,0,0},
{64,65,66,67,68,69,70,71},{81,82,83,84,85,86,87,88},{89,90,91,92,93,94,95,96},}

x000129_MyXinFa = {}
x000129_g_healtargetId = 189
--**********************************
--事件列表
--**********************************
function x000129_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		 if LuaFnGetName( sceneId, targetId ) == "龙霸天" then
		AddText(sceneId,"#{OBJ_luoyang_BaTian}")
		AddNumText(sceneId,x000129_g_scriptId,"满怒治疗",6,0)
		end
		if LuaFnGetName( sceneId, targetId ) == "侠客行欢迎您" then
		RestoreHp( sceneId, selfId ) ------满血
	    RestoreMp( sceneId, selfId ) ------满气
	    RestoreRage( sceneId, selfId ) ------满怒	
		AddText(sceneId,"#H亲爱的玩家#G$N#H！你好！")
		AddText(sceneId,"#r    #W欢迎来到《侠客行·怀旧服》#W")
	    AddText(sceneId,"#r#G  如有任何问题或建议请给我们提出")
		AddNumText(sceneId,x000129_g_scriptId,"     加入 转换 门派",6,888)
		AddNumText(sceneId,x000129_g_scriptId,"     我要出去闯世界",6,999)
		--Msg2Player(  sceneId, selfId,"@*;npcpaopao;"..selfId..";596",MSG2PLAYER_PARA )
		end
	EndEvent(sceneId)
	if LuaFnGetName( sceneId, targetId ) == "龙霸天" then
	for i, eventId in x000129_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	Msg2Player(  sceneId, selfId,"@*;npcpaopao;209;651",MSG2PLAYER_PARA )
end

--**********************************
--事件交互入口
--**********************************
function x000129_OnDefaultEvent( sceneId, selfId,targetId )
	x000129_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000129_OnEventRequest( sceneId, selfId, targetId, eventId )
	-- 调用“江湖游医”脚本中计算金钱的函数
	local	gld = CallScriptFunction( x000129_g_healScriptId, "CalcMoney_hpmp",sceneId, selfId, targetId )* 0.1

	local	key	= GetNumText()
    if key == 888 then
	    if GetMenPai(sceneId, selfId) == 9 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId,targetId)
			UICommand_AddInt( sceneId, 1 )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 20150630 )	
		else
			local to=0
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) >= 1 then
				to=LuaFnGetAvailableItemCount(sceneId, selfId, 30008104)	
			end	
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId,targetId)
			UICommand_AddInt( sceneId, to )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 20150630 )	
		end
	    return
	end
    if  key == 999 then
        DispatchUICommand(sceneId,selfId, 20170503)  
        return
    end
	if key == 1000 then	--不愿再治疗
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
	if key == 1001 then	--确认要治疗
		-- 调用“江湖游医”脚本中计算金钱的函数
		gld = CallScriptFunction( x000129_g_healScriptId, "CalcMoney_hpmp",sceneId, selfId, targetId )* 0.1

		-- 得到交子和金钱数目
		local nMoneyJZ = GetMoneyJZ ( sceneId, selfId )
		local nMoney = GetMoney ( sceneId, selfId )
		
		--检查玩家是否有足够的现金
		if (nMoneyJZ + nMoney >= gld) then
			--扣钱
			LuaFnCostMoneyWithPriority (sceneId, selfId, gld)
			-- 调用“江湖游医”脚本
			CallScriptFunction( x000129_g_healScriptId, "Restore_hpmp",sceneId, selfId, targetId )
			RestoreStrikePoint( sceneId, selfId )			
			return
		
		else
			BeginEvent( sceneId )
				AddText( sceneId, "  你的金钱不足！" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
		end
	end
	
	--加血
	if key == 0 then
		if GetHp( sceneId, selfId ) == GetMaxHp( sceneId, selfId ) and
			 GetRage( sceneId, selfId ) == GetMaxRage( sceneId, selfId ) and
			 GetMp( sceneId, selfId ) == GetMaxMp( sceneId, selfId ) and
			 IsStrikePointFull( sceneId, selfId ) == 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "  你现在很健康，不需要治疗！" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			
			--取消指定玩家身上的所有敌对可驱散驻留效果
			LuaFnDispelAllHostileImpacts( sceneId, selfId )
			return
		end
	
		if gld <= 0 then
			-- 调用“江湖游医”脚本
			CallScriptFunction( x000129_g_healScriptId, "Restore_hpmp",sceneId, selfId, targetId )
			RestoreStrikePoint( sceneId, selfId )
			--x000129_Restore_hpmp( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId )
				AddText( sceneId, "  你可以花费#G#{_EXCHG"..gld.."}#W，来恢复气血和怒气，确定要治疗吗？" )
				AddNumText( sceneId, x000129_g_scriptId, "是", -1, 1001 )
				AddNumText( sceneId, x000129_g_scriptId, "否", -1, 1000 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	else
		for i, findId in x000129_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText() )	--GetNumText()是addnumtext中最后的变量
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000129_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000129_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000129_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000129_g_eventList do
		if missionScriptId == findId then
			x000129_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000129_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000129_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000129_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000129_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000129_OnDie( sceneId, selfId, killerId )
end


function x000129_MP_MenPaiCall(sceneId,selfId,idxx,idxxx)

local MenPaiJS = {"#Y外家功夫天下第一，面对威胁时往往舍生取义，掩护同伴",
                  "#Y带有圣火的灼伤效果，武功先发制人，复活能力也常使他们反败为胜",
				  "#Y腾挪闪避之术天下无双，连击越多，攻击力越大，后发制人",
				  "#Y攻敌于百步之外，同时可以移形换位，几乎能做到敌不沾身",
				  "#Y拥有治疗和攻击力，一定时间内甚至能刀枪不入，无敌于阵。",
				  "#Y使敌容易被扰乱心智恐惧不已，更需忍受持续的剧毒伤害",
				  "#Y天龙弟子内、外兼修，同时拥有数种攻击属性，以指为剑，命中极高",
				  "#Y身形飘忽，可以瞬间隐没自己，待合适时机爆发，实行一击必。",
				  "#Y奇门遁甲控敌之术无敌天下，让敌人防不胜防，群战中更是令人胆寒",}				  
	  if idxx<1 or idxx >11 then
		return
	  end
	  local OldMenPai = GetMenPai(sceneId,selfId)
	  if idxxx == 1 then
	  x000129_MP_zhhy( sceneId, selfId,idxx )
	  else
	local a = GetHumanAttr(sceneId, selfId, 3)
    local b = GetHumanAttr(sceneId, selfId, 4)
    local c = GetHumanAttr(sceneId, selfId, 5)
    local d = GetHumanAttr(sceneId, selfId, 6)
	BeginUICommand( sceneId )
	UICommand_AddString(sceneId,"#Y更换需要提供一个#G移骨丹#Y，更换后心法保持不变，部分宝石可进行属性转换#G大理#{_INFOAIM154,156,2,彭怀玉}")
	UICommand_AddString(sceneId,MenPaiJS[idxx])
	UICommand_AddInt( sceneId,77)
	UICommand_AddInt( sceneId, x000129_g_healtargetId )
    UICommand_AddInt( sceneId, OldMenPai+1 )
	UICommand_AddInt( sceneId, idxx  )
	UICommand_AddInt( sceneId, a )
	UICommand_AddInt( sceneId, b )
	UICommand_AddInt( sceneId, c )
	UICommand_AddInt( sceneId, d )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 20181212 )	
	end

return
end
function x000129_MP_zhhy( sceneId, selfId,idxx )

	  if idxx<1 or idxx >11 then
		return
	  end	
if GetMenPai(sceneId, selfId) == 9 then
		if idxx == 6 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 5)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到星宿。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
          return
	   end
	if idxx == 9 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 8)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到逍遥。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
      return
	end
	if idxx == 1 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 0)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到少林。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
        return
	end
	
	if idxx == 8 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 7)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到天山。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
       return
	end
	if idxx == 7 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 6)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到天龙。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		return
	end
	if idxx == 5 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 4)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到峨眉。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		return
	end
	
	if idxx == 4 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 3)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到武当。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
        return
	end
	if idxx == 2 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 1)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到明教。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		return
	end
	if idxx == 3 then
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 2)
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
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功加入到丐帮。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
       return
	end
  end

end


function x000129_MP_ZHHx(sceneId,selfId,idxx)
      for i = 1,8 do
        if HaveXinFa(sceneId,selfId,x000129_XinFaList[GetMenPai(sceneId,selfId)+1][i]) > 0 then
           x000129_MyXinFa[i] = HaveXinFa(sceneId,selfId,x000129_XinFaList[GetMenPai(sceneId,selfId)+1][i])
        end
      end
	  
	  if idxx<1 or idxx >11 then
		return
	  end	
if GetMenPai ~= 9 then
	-------------------------------		if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) >= 1 then
	if idxx == 6 then
		if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
			BeginEvent(sceneId)
	        AddText(sceneId,"对不起,你你没转换资格");
	        EndEvent(sceneId)
	        DispatchMissionTips(sceneId,selfId)	
		  return
	    end
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 5)
		LuaFnSetXinFaLevel(sceneId,selfId,31,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,32,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,33,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,34,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,35,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,36,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,60,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,77,x000129_MyXinFa[8])	
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到星宿。", 4 )
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
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 8)
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		
		LuaFnSetXinFaLevel(sceneId,selfId,49,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,50,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,51,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,52,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,53,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,54,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,63,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,80,x000129_MyXinFa[8])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到逍遥。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		return
	end
	if idxx == 1 then
			if LuaFnGetAvailableItemCount(sceneId, selfId, 30008104) <1 then
			BeginEvent(sceneId)
	        AddText(sceneId,"对不起,你你没转换资格");
	        EndEvent(sceneId)
	        DispatchMissionTips(sceneId,selfId)	
		  return
	    end
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 0)
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		
		LuaFnSetXinFaLevel(sceneId,selfId,1,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,2,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,3,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,4,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,5,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,6,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,55,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,72,x000129_MyXinFa[8])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到少林。", 4 )
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
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 7)
		LuaFnSetXinFaLevel(sceneId,selfId,43,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,44,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,45,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,46,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,47,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,48,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,62,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,79,x000129_MyXinFa[8])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到天山。", 4 )
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
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 6)
		
		LuaFnSetXinFaLevel(sceneId,selfId,37,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,38,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,39,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,40,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,41,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,42,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,61,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,78,x000129_MyXinFa[8])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到天龙。", 4 )
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
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 4)
		
		LuaFnSetXinFaLevel(sceneId,selfId,25,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,26,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,27,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,28,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,29,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,30,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,59,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,76,x000129_MyXinFa[8])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到峨眉。", 4 )
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
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 3)
		
		LuaFnSetXinFaLevel(sceneId,selfId,19,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,20,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,21,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,22,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,23,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,24,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,58,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,75,x000129_MyXinFa[8])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到武当。", 4 )
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
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 1)
		LuaFnSetXinFaLevel(sceneId,selfId,7,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,8,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,9,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,10,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,11,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,12,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,56,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,73,x000129_MyXinFa[8])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到明教。", 4 )
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
		LuaFnDelAvailableItem(sceneId,selfId,30008104,1)
		LuaFnJoinMenpai(sceneId, selfId, x000129_g_healtargetId, 2)
		
		LuaFnSetXinFaLevel(sceneId,selfId,13,x000129_MyXinFa[1])
		LuaFnSetXinFaLevel(sceneId,selfId,14,x000129_MyXinFa[2])
		LuaFnSetXinFaLevel(sceneId,selfId,15,x000129_MyXinFa[3])
		LuaFnSetXinFaLevel(sceneId,selfId,16,x000129_MyXinFa[4])
		LuaFnSetXinFaLevel(sceneId,selfId,17,x000129_MyXinFa[5])
		LuaFnSetXinFaLevel(sceneId,selfId,18,x000129_MyXinFa[6])
		LuaFnSetXinFaLevel(sceneId,selfId,57,x000129_MyXinFa[7])
		--LuaFnSetXinFaLevel(sceneId,selfId,74,x000129_MyXinFa[8])
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
		local	nam	= LuaFnGetName( sceneId, selfId )
		BroadMsgByChatPipe( sceneId, selfId, "#Y恭喜玩家 "..nam.." 成功更换到丐帮。", 4 )
		CallScriptFunction( 888903, "PlayerJoinMenPai",sceneId, selfId, -1 )
		return
	end
	end
end


