--飘渺峰 桑土公AI

--A 【土遁】BOSS的HP每损失20%则会消失20秒....同时创建小怪依次为1122只..死亡or脱离战斗消失....
--B 【牛毛毒针】非土遁状态时每隔20一次大范围攻击....土遁状态下CD正常走只是不使用....土遁结束时清CD....
--C 【出土文物】进入土遁时随机获得2个buff....同时清除上次的2个buff....
--D 【疯狂】战斗5分钟后给自己和所有僵尸加一击致命buff....不再使用AB(C)....

--全程都带有免疫制定技能的buff....
--脱离战斗或死亡时删除僵尸....


--脚本号
x890068_g_ScriptId	= 890068

--副本逻辑脚本号....
x890068_g_FuBenScriptId = 890063


--免疫特定技能buff....
x890068_Buff_MianYi1	= 10472	--免疫一些负面效果....
x890068_Buff_MianYi2	= 10471	--免疫普通隐身....

--A土遁....
x890068_SkillID_H				= 1635
x890068_SkillA_TuDun				= 1028

x890068_SkillA_AChildName		= "冰蚕"
x890068_SkillA_BChildName		= "冰蚕1"
x890068_SkillA_CChildName		= "冰蚕2"
x890068_SkillA_DChildName		= "冰蚕3"


x890068_SkillA_ChildTime		= 5000		--土遁多长时间后开始刷小怪....
x890068_SkillA_Time					= 20000		--土遁持续的时间....


--B牛毛毒针....
x890068_SkillB_NiuMaoDuZhen = 868
--冷却时间....
x890068_SkillB_CD						= 5000


--C出土文物技能的buff列表....
x890068_SkillC_ChutuBuff1 = { 19624, 19624 }
x890068_SkillC_ChutuBuff2 = { 19624, 19624, 19624, 19624 }

x890068_BrotherName = "庄聚贤"		--兄弟的名字....

--D疯狂....
x890068_SkillD_Buff1	= 10234
x890068_SkillD_Buff2	= 10235
--开始进入狂暴状态的时间....
x890068_EnterKuangBaoTime	= 20*60*1000


--AI Index....
x890068_IDX_HPStep							= 1	--血量级别....
x890068_IDX_SkillB_CD						= 2	--B技能的CD时间....
x890068_IDX_KuangBaoTimer				= 3	--狂暴的计时器....
x890068_IDX_TuDunTimer					= 4	--土遁的计时器....用于计算何时土遁结束....
x890068_IDX_NeedCreateChildNum	= 5	--需要创建的小怪的数量....

x890068_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x890068_IDX_IsTudunMode			= 2	--是否处于土遁模式的标志....
x890068_IDX_IsKuangBaoMode	= 3	--是否处于狂暴模式的标志....


--**********************************
--初始化....
--**********************************
function x890068_OnInit(sceneId, selfId)
	--重置AI....
	x890068_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x890068_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890068_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890068_IDX_IsKuangBaoMode ) then
		return
	end

	--执行狂暴逻辑....
	if 1 == x890068_DoSkillD_KuangBao( sceneId, selfId, nTick ) then
		return
	end

	--执行土遁逻辑....
	if 1 == x890068_SkillLogicA_TunDun( sceneId, selfId, nTick ) then
		return
	end

	--执行牛毛毒针逻辑....
	if 1 == x890068_SkillLogicB_NiuMaoDuZhen( sceneId, selfId, nTick ) then
		return
	end

end


--**********************************
--进入战斗....
--**********************************
function x890068_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890068_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890068_Buff_MianYi2, 0 )

	--重置AI....
	x890068_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890068_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x890068_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x890068_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )

	--创建对话NPC....
	--local MstId = CallScriptFunction( x890068_g_FuBenScriptId, "CreateBOSS", sceneId, "ZhangJuXian_NPC", -1, -1 )
	--SetUnitReputationID( sceneId, MstId, MstId, 0 )

end


--**********************************
--杀死敌人....
--**********************************
function x890068_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x890068_OnDie( sceneId, selfId, killerId )

	--遍历场景里所有的怪....寻找兄弟....给其设置需要使用狂暴技能....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x890068_BrotherName == GetName( sceneId, MonsterId ) and LuaFnIsCharacterLiving(sceneId, MonsterId) == 1 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, MonsterId, 19626, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, MonsterId, 19627, 0 )
		end
	end
	
end


--**********************************
--重置AI....
--**********************************
function x890068_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_HPStep, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_SkillB_CD, x890068_SkillB_CD )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_KuangBaoTimer, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_TuDunTimer, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_NeedCreateChildNum, 0 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890068_IDX_CombatFlag, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890068_IDX_IsTudunMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890068_IDX_IsKuangBaoMode, 0 )

	--清除buff....
	for i, buffId in x890068_SkillC_ChutuBuff1 do
		LuaFnCancelSpecificImpact( sceneId, selfId, buffId )
	end

	for i, buffId in x890068_SkillC_ChutuBuff2 do
		LuaFnCancelSpecificImpact( sceneId, selfId, buffId )
	end

	LuaFnCancelSpecificImpact( sceneId, selfId, x890068_SkillD_Buff1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x890068_SkillD_Buff2 )

	--清除小怪....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, MonsterId) == x890068_SkillA_AChildName or GetName(sceneId, MonsterId) == x890068_SkillA_BChildName or GetName(sceneId, MonsterId) == x890068_SkillA_CChildName or GetName(sceneId, MonsterId) == x890068_SkillA_DChildName then
			LuaFnDeleteMonster(sceneId, MonsterId)
		end
	end

end


--**********************************
--狂暴技能....
--**********************************
function x890068_DoSkillD_KuangBao( sceneId, selfId )

	--加狂暴buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890068_SkillD_Buff1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890068_SkillD_Buff2, 0 )

	--给所有小怪加狂暴....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, MonsterId) == x890068_SkillA_ChildName then
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x890068_SkillD_Buff1, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x890068_SkillD_Buff2, 0 )
		end
	end

end


--**********************************
--土遁逻辑....
--**********************************
function x890068_SkillLogicA_TunDun( sceneId, selfId, nTick )


	--土遁模式则更新土遁的计时器....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890068_IDX_IsTudunMode ) then

		local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890068_IDX_TuDunTimer )
		if cd > nTick then

			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_TuDunTimer, cd-nTick )
			--如果到了刷小怪的时间并且本次土遁还没刷过小怪....
			if cd < (x890068_SkillA_Time-x890068_SkillA_ChildTime) then
				local needCreateNum = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890068_IDX_NeedCreateChildNum )
				if needCreateNum > 0 then
					--创建小怪....
					MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_NeedCreateChildNum, 0 )
					local x,z = GetWorldPos( sceneId, selfId )
					if needCreateNum == 1 then
						local MstId = CallScriptFunction( x890068_g_FuBenScriptId, "CreateBOSS", sceneId, "JiangShi_BOSS", x, z )
						SetCharacterName( sceneId, MstId, x890068_SkillA_AChildName )
					end
				end
			end

		else

			--土遁结束....设置离开土遁状态....
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_TuDunTimer, 0 )
			MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890068_IDX_IsTudunMode, 0 )
			--重置牛毛毒针CD....
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_SkillB_CD, x890068_SkillB_CD )

		end


	--非土遁模式则检测是否可以进入土遁模式....
	else

		--每减少20%血时进入土遁模式....
		local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
		local LastStep = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890068_IDX_HPStep )
		local CurStep = -1
		if CurPercent <= 0.6333 then
			CurStep = 1
		end

		--进行土遁....
		if CurStep > LastStep then
			--给自己设置蚕茧....
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 19623, 0 )

			--随机获得2个buff(出土文物)....
			local idx1 = random( getn(x890068_SkillC_ChutuBuff1) )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890068_SkillC_ChutuBuff1[idx1], 0 )
			local idx2 = random( getn(x890068_SkillC_ChutuBuff2) )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890068_SkillC_ChutuBuff2[idx2], 0 )

			--local NeedCreateNum = 0
			--if CurStep == 1 then
				--NeedCreateNum = 1
			--end

			MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890068_IDX_IsTudunMode, 1 )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_NeedCreateChildNum, NeedCreateNum )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_HPStep, CurStep )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_TuDunTimer, x890068_SkillA_Time )
			return 1
		end


	end

	return 0

end


--**********************************
--牛毛毒针逻辑....
--**********************************
function x890068_SkillLogicB_NiuMaoDuZhen( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890068_IDX_SkillB_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_SkillB_CD, cd-nTick )
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_SkillB_CD, x890068_SkillB_CD-(nTick-cd) )
		--非土遁状态才可以用....
		if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890068_IDX_IsTudunMode ) then
			local x,z = GetWorldPos( sceneId, selfId )
			CallScriptFunction((200060), "Paopao",sceneId, "冰蚕", "少室山", "尝尝我的冰蚕毒掌！" )
			MonsterTalk( sceneId, -1, "", "冰蚕毒掌拥有毒爆状态效果，爆炸后对队友造成大量伤害！！" )
			LuaFnUnitUseSkill( sceneId, selfId, x890068_SkillB_NiuMaoDuZhen, selfId, x, z, 0, 0 )
			return 1
		end
	end

	return 0

end


--**********************************
--狂暴逻辑....
--**********************************
function x890068_DoSkillD_KuangBao( sceneId, selfId, nTick )

	--检测是否到了狂暴的时候....
	local kbTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890068_IDX_KuangBaoTimer )
	if kbTime < x890068_EnterKuangBaoTime then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890068_IDX_KuangBaoTimer, kbTime+nTick )

	else

		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890068_IDX_IsKuangBaoMode, 1 )
		--加狂暴buff....
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890068_SkillD_Buff1, 0 )
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890068_SkillD_Buff2, 0 )
		--给所有小怪加狂暴buff....
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			if GetName(sceneId, MonsterId) == x890068_SkillA_AChildName or GetName(sceneId, MonsterId) == x890068_SkillA_BChildName or GetName(sceneId, MonsterId) == x890068_SkillA_CChildName or GetName(sceneId, MonsterId) == x890068_SkillA_DChildName then
				LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x890068_SkillD_Buff1, 0 )
				LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x890068_SkillD_Buff2, 0 )
			end
		end
		return 1

	end


	return 0

end

