--格物技能学习
--2019-11-30 22:31:01 逍遥子

--脚本号
x000544_g_ScriptId = 000544

--学习界面要说的话
x000544_g_MessageStudy = "如果你达到%d级并且肯花费#{_EXCHG%d}就可以学会格物技能。你决定学习么？"

--技能编号
x000544_g_AbilityID = ABILITY_GEWU

--技能名称
x000544_g_AbilityName = "格物"

--学习本技能的等级限制
x000544_g_LimitLevel = 10

--要让玩家学会的配方列表
x000544_g_PeiFangID = { 399, 400, 401, 402, 403, 404, 405, 406, 407 }


--**********************************
--任务入口函数
--**********************************
function x000544_OnDefaultEvent( sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId )
	--玩家技能的等级
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x000544_g_AbilityID)

	--任务判断

	--判断是否已经学会了格物,如果学会了,则提示已经学会了
	if AbilityLevel >= 1 then
		BeginEvent(sceneId)
        	AddText(sceneId,"你已经学会"..x000544_g_AbilityName.."技能了");
        	EndEvent(sceneId)
        DispatchMissionTips(sceneId,selfId)
		return
	end

	
	--如果点击的是“学习技能”（即参数=0）
	if ButtomNum == 0 then
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(x000544_g_AbilityID, 1);
		if ret and ret == 1 then
			BeginEvent(sceneId)
			local addText = format(x000544_g_MessageStudy, x000544_g_LimitLevel, demandMoney);
			AddText(sceneId, addText)
			--确定学习按钮
					AddNumText(sceneId,x000544_g_ScriptId,"我确定要学习", 6, 2)
			--取消学习按钮
					AddNumText(sceneId,x000544_g_ScriptId,"我只是来看看", 8, 3)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	elseif ButtomNum == 2 then			--如果点击的是“我确定要学习”
	--检查玩家是否有足够的现金
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(x000544_g_AbilityID, 1);
		if ret and ret == 1 then
			if GetMoney(sceneId,selfId)+GetMoneyJZ(sceneId,selfId) < demandMoney then			
				BeginEvent(sceneId)
					local addText2 = format( "对不起！您携带的金钱不够，请携带#{_EXCHG%d}前来学习。", demandMoney )
					AddText( sceneId, addText2 );
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--检查玩家等级是否达到要求
			if GetLevel(sceneId,selfId) < x000544_g_LimitLevel then
				BeginEvent(sceneId)
					AddText(sceneId,"你的等级不够");
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--删除金钱
			LuaFnCostMoneyWithPriority(sceneId, selfId, demandMoney)
			--技能提升到1
			SetHumanAbilityLevel(sceneId,selfId,x000544_g_AbilityID,1)
			--让玩家学会所有9个配方
			x000544_AddAllPeiFang( sceneId, selfId )
			--在npc聊天窗口通知玩家已经学会了
			BeginEvent(sceneId)
				AddText(sceneId,"你学会了"..x000544_g_AbilityName.."技能")
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
function x000544_OnEnumerate( sceneId, selfId, targetId )

	local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(x000544_g_AbilityID, 1);
	if ret and ret == 1 then
		AddNumText(sceneId,x000544_g_ScriptId,"学习"..x000544_g_AbilityName.."技能", 12, 0)
	end
	return

end

--**********************************
--检测接受条件
--**********************************
function x000544_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x000544_OnAccept( sceneId, selfId, x000544_g_AbilityID )
end


function x000544_AddAllPeiFang( sceneId, selfId )

	for i, pfID in x000544_g_PeiFangID do
	
		if IsPrescrLearned( sceneId, selfId, pfID ) == 0 then
			SetPrescription( sceneId, selfId, pfID, 1 )
		end

	end

end
