--培元技能学习
--2019-11-30 22:23:53 桃花岛 逍遥子

--脚本号
x000545_g_ScriptId = 000545

--此npc可以升到的最高等级
x000545_g_nMaxLevel = 100

--学习界面要说的话
x000545_g_MessageStudy = "只要你肯花费#{_EXCHG%d}就可以学会培元技能。你决定学习么？"


--**********************************
--任务入口函数
--**********************************
function x000545_OnDefaultEvent( sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId )
	--玩家技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, ABILITY_TONGGAN)
	--玩家培元技能的熟练度
	ExpPoint = GetAbilityExp(sceneId, selfId, ABILITY_TONGGAN)
	--任务判断

	--判断是否是桃花岛弟子,不是桃花岛弟子不能学习
		if GetMenPai(sceneId,selfId) ~= MP_TAOHUADAO then
			BeginEvent(sceneId)
        		AddText(sceneId,"#{THDSH_190614_04}");
        	EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
	--判断是否已经学会了培元,如果学会了,则提示已经学会了
	if AbilityLevel >= 1 then
		BeginEvent(sceneId)
        	AddText(sceneId,"#{THDSH_190614_18}");
        	EndEvent(sceneId)
        DispatchMissionTips(sceneId,selfId)
		return
	end

	--如果点击的是“学习技能”（即参数=0）
	if ButtomNum == 0 then
		
		local tempAbilityId = ABILITY_TONGGAN;
		local tempAbilityLevel = 1;
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel);
		if ret and ret == 1 then
			BeginEvent(sceneId)
			--AddText(sceneId,x000545_g_MessageStudy)
			local addText = format(x000545_g_MessageStudy, demandMoney);
			AddText(sceneId,addText)
			--确定学习按钮
					AddNumText(sceneId,x000545_g_ScriptId,"#{THDSH_190614_15}", 6, 2)
			--取消学习按钮
					AddNumText(sceneId,x000545_g_ScriptId,"#{THDSH_190614_16}", 8, 3)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	elseif ButtomNum == 2 then			--如果点击的是“我确定要学习”
		local tempAbilityId = ABILITY_TONGGAN;
		local tempAbilityLevel = 1;
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(tempAbilityId, tempAbilityLevel);
		if ret and ret == 1 then
			--检查玩家是否有一个银币的现金
			if GetMoney(sceneId,selfId)+GetMoneyJZ(sceneId,selfId) < demandMoney then			
				BeginEvent(sceneId)
					AddText(sceneId,"你的金钱不足");
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--检查玩家等级是否达到要求
			if GetLevel(sceneId,selfId) < limitLevel then
				BeginEvent(sceneId)
					AddText(sceneId,"你的等级不够");
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--删除金钱
			LuaFnCostMoneyWithPriority(sceneId,selfId,demandMoney)
			--技能提升到1
			SetHumanAbilityLevel(sceneId,selfId,ABILITY_TONGGAN,1)
			--在npc聊天窗口通知玩家已经学会了
			BeginEvent(sceneId)
				AddText(sceneId,"#{THDSH_190614_17}")
			EndEvent( )
			DispatchEventList(sceneId,selfId,targetId)
		end
	else --如果点击“我只是来看看”
		CallScriptFunction( g_Npc_ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
end

--**********************************
--列举事件
--**********************************
function x000545_OnEnumerate( sceneId, selfId, targetId )
	--如果不到等级则不显示选项
	--if GetLevel(sceneId,selfId) >= 10 then
		AddNumText(sceneId,x000545_g_ScriptId,"#{THDSH_190614_12}", 12, 0)
	--end
	return
end

--**********************************
--检测接受条件
--**********************************
function x000545_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x000545_OnAccept( sceneId, selfId, ABILITY_LIUYIFENGGU )
end
