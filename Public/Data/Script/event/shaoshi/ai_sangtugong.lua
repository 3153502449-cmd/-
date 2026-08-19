--飘渺峰 桑土公AI

--A 【土遁】BOSS的HP每损失20%则会消失20秒....同时创建小怪依次为1122只..死亡or脱离战斗消失....
--B 【牛毛毒针】非土遁状态时每隔20一次大范围攻击....土遁状态下CD正常走只是不使用....土遁结束时清CD....
--C 【出土文物】进入土遁时随机获得2个buff....同时清除上次的2个buff....
--D 【疯狂】战斗5分钟后给自己和所有僵尸加一击致命buff....不再使用AB(C)....

--全程都带有免疫制定技能的buff....
--脱离战斗或死亡时删除僵尸....


--脚本号
x890065_g_ScriptId	= 890065

--副本逻辑脚本号....
x890065_g_FuBenScriptId = 890063

x890065_MyName			= "庄聚贤"	--自己的名字....


--免疫特定技能buff....
x890065_Buff_MianYi1	= 10472	--免疫一些负面效果....
x890065_Buff_MianYi2	= 10471	--免疫普通隐身....

--A土遁....
x890065_SkillID_H				= 1635
x890065_SkillA_TuDun				= 1028
x890065_SkillA_AChildName		= "冰蚕"
x890065_SkillA_BChildName		= "火墨虎"
x890065_SkillA_CChildName		= "毒墨虎"
x890065_SkillA_DChildName		= "玄墨虎"


x890065_SkillA_ChildTime		= 5000		--土遁多长时间后开始刷小怪....
x890065_SkillA_Time					= 20000		--土遁持续的时间....


--F蚕丝....
x890065_SkillB_NiuMaoDuZhen		= 864
x890065_SkillB_SpecObjTbl = { 1018, 1020 }

--冷却时间....
x890065_SkillB_CD						= 10000


--C出土文物技能的buff列表....
x890065_SkillC_ChutuBuff1 = { 19628, 19628 }


--D疯狂....
x890065_SkillD_Buff1	= 10234
x890065_SkillD_Buff2	= 10235
--开始进入狂暴状态的时间....
x890065_EnterKuangBaoTime	= 10*60*1000


--AI Index....
x890065_IDX_HPStep							= 1	--血量级别....
x890065_IDX_SkillB_CD						= 2	--B技能的CD时间....
x890065_IDX_KuangBaoTimer				= 3	--狂暴的计时器....
x890065_IDX_TuDunTimer					= 4	--土遁的计时器....用于计算何时土遁结束....
x890065_IDX_NeedCreateChildNum	= 5	--需要创建的小怪的数量....

x890065_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x890065_IDX_IsTudunMode			= 2	--是否处于土遁模式的标志....
x890065_IDX_IsKuangBaoMode	= 3	--是否处于狂暴模式的标志....

x890065_LootItem_1 = {50101001, 50101002, 50201001, 50201002,}

x890065_LootItem_2 = {50713001, 50713002, 50713003, 50713004, 50703001, 50704002}
--**********************************
--初始化....
--**********************************
function x890065_OnInit(sceneId, selfId)
	--重置AI....
	x890065_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x890065_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890065_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890065_IDX_IsKuangBaoMode ) then
		return
	end

	--执行狂暴逻辑....
	if 1 == x890065_DoSkillD_KuangBao( sceneId, selfId, nTick ) then
		return
	end

	--执行土遁逻辑....
	if 1 == x890065_SkillLogicA_TunDun( sceneId, selfId, nTick ) then
		return
	end

	--执行牛毛毒针逻辑....
	if 1 == x890065_SkillLogicB_NiuMaoDuZhen( sceneId, selfId, nTick ) then
		return
	end

end


--**********************************
--进入战斗....
--**********************************
function x890065_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890065_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890065_Buff_MianYi2, 0 )

	--重置AI....
	x890065_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890065_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x890065_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x890065_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )

	--创建对话NPC....
	local MstId = CallScriptFunction( x890065_g_FuBenScriptId, "CreateBOSS", sceneId, "ZhangJuXian_NPC", -1, -1 )
	SetUnitReputationID( sceneId, MstId, MstId, 0 )

end


--**********************************
--杀死敌人....
--**********************************
function x890065_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x890065_OnDie( sceneId, selfId, killerId )

	--重置AI....
	x890065_ResetMyAI( sceneId, selfId )

	--设置已经挑战过桑土公....
	CallScriptFunction( x890065_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "ZhangJuXian", 2 )

	--如果还没有挑战过乌老大则可以挑战乌老大....
	if 2 ~= CallScriptFunction( x890065_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "MuRongFu" )	then
		CallScriptFunction( x890065_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "MuRongFu", 1 )
	end
	
	-- zchw 全球公告
	local	playerName	= GetName( sceneId, killerId )
	
	--杀死怪物的是宠物则获取其主人的名字....
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
		playerName = GetName( sceneId, playerID )
	end
	
	--如果玩家组队了则获取队长的名字....
	local leaderID = GetTeamLeader( sceneId, playerID )
	if leaderID ~= -1 then
		playerName = GetName( sceneId, leaderID )
	end
	
	if playerName ~= nil then
		str = format("#Y庄聚贤#W也抵挡不住#cFF0000#{_INFOUSR%s}#W攻击。被打得落花流水，只逃而去，金银财宝散落一地！", playerName); --桑土公
		AddGlobalCountNews( sceneId, str )
	end
	--取得当前场景里的人数
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
	local mems = {}
	
	for i = 0, num - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId( sceneId, i )
	end

	for i = 0, num - 1 do
		if LuaFnIsObjValid( sceneId, mems[i] ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, mems[i] ) == 1 then					-- 不在场景的不做此操作

			rand = random(100)
			if rand < 40 then
				local WuPin = random( getn(x890065_LootItem_1) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890065_LootItem_1[WuPin] )

			end

			rand = random(100)
			if rand < 40 then
				local WuPin = random( getn(x890065_LootItem_1) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890065_LootItem_1[WuPin] )

			end

			rand = random(100)
			if rand < 10 then
				local WuPin = random( getn(x890065_LootItem_2) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890065_LootItem_2[WuPin]  )
			end

			rand = random(100)
			if rand < 10 then
				local WuPin = random( getn(x890065_LootItem_2) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890065_LootItem_2[WuPin]  )
			end

		end
	end
	
end


--**********************************
--重置AI....
--**********************************
function x890065_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_HPStep, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_SkillB_CD, x890065_SkillB_CD )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_KuangBaoTimer, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_TuDunTimer, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_NeedCreateChildNum, 0 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890065_IDX_CombatFlag, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890065_IDX_IsTudunMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890065_IDX_IsKuangBaoMode, 0 )

	--清除buff....
	for i, buffId in x890065_SkillC_ChutuBuff1 do
		LuaFnCancelSpecificImpact( sceneId, selfId, buffId )
	end



	LuaFnCancelSpecificImpact( sceneId, selfId, x890065_SkillD_Buff1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x890065_SkillD_Buff2 )

	--清除小怪....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, MonsterId) == x890065_SkillA_AChildName or GetName(sceneId, MonsterId) == x890065_SkillA_BChildName or GetName(sceneId, MonsterId) == x890065_SkillA_CChildName or GetName(sceneId, MonsterId) == x890065_SkillA_DChildName then
			LuaFnDeleteMonster(sceneId, MonsterId)
		end
	end

end


--**********************************
--狂暴技能....
--**********************************
function x890065_DoSkillD_KuangBao( sceneId, selfId )

	--加狂暴buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890065_SkillD_Buff1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890065_SkillD_Buff2, 0 )

	--给所有小怪加狂暴....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, MonsterId) == x890065_SkillA_ChildName then
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x890065_SkillD_Buff1, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x890065_SkillD_Buff2, 0 )
		end
	end

end


--**********************************
--土遁逻辑....
--**********************************
function x890065_SkillLogicA_TunDun( sceneId, selfId, nTick )


	--土遁模式则更新土遁的计时器....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890065_IDX_IsTudunMode ) then

		local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890065_IDX_TuDunTimer )
		if cd > nTick then

			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_TuDunTimer, cd-nTick )
			--如果到了刷小怪的时间并且本次土遁还没刷过小怪....
			if cd < (x890065_SkillA_Time-x890065_SkillA_ChildTime) then
				local needCreateNum = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890065_IDX_NeedCreateChildNum )
				if needCreateNum > 0 then
					--创建小怪....
					MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_NeedCreateChildNum, 0 )
					local x,z = GetWorldPos( sceneId, selfId )
					if needCreateNum == 1 then
						CallScriptFunction((200060), "Paopao",sceneId, "庄聚贤", "少室山", "看来不动点真格的还真是不行了，让你尝尝我冰蚕的厉害。" )
						local MstId = CallScriptFunction( x890065_g_FuBenScriptId, "CreateBOSS", sceneId, "JiangShi_BOSS", x, z )
						SetCharacterName( sceneId, MstId, x890065_SkillA_AChildName )
					end
				end
			end

		else

			--土遁结束....设置离开土遁状态....
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_TuDunTimer, 0 )
			MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890065_IDX_IsTudunMode, 0 )
			--重置牛毛毒针CD....
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_SkillB_CD, x890065_SkillB_CD )

		end


	--非土遁模式则检测是否可以进入土遁模式....
	else

		--每减少20%血时进入土遁模式....
		local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
		local LastStep = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890065_IDX_HPStep )
		local CurStep = -1
		if CurPercent <= 0.8 then
			CurStep = 1
		end

		--进行土遁....
		if CurStep > LastStep then
			--给自己设置隐身and不能攻击....
			local x,z = GetWorldPos( sceneId, selfId )
			LuaFnUnitUseSkill( sceneId, selfId, x890065_SkillA_TuDun, selfId, x, z, 0, 1 )

			--随机获得2个buff(出土文物)....
			local idx1 = random( getn(x890065_SkillC_ChutuBuff1) )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890065_SkillC_ChutuBuff1[idx1], 0 )

			local NeedCreateNum = 0
			if CurStep == 1 then
				NeedCreateNum = 1
			end

			MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890065_IDX_IsTudunMode, 1 )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_NeedCreateChildNum, NeedCreateNum )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_HPStep, CurStep )
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_TuDunTimer, x890065_SkillA_Time )
			return 1
		end


	end

	return 0

end


--**********************************
--牛毛毒针逻辑....
--**********************************
function x890065_SkillLogicB_NiuMaoDuZhen( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890065_IDX_SkillB_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_SkillB_CD, cd-nTick )
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_SkillB_CD, x890065_SkillB_CD-(nTick-cd) )
		--非土遁状态才可以用....
		if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890065_IDX_IsTudunMode ) then
			local x,z = GetWorldPos( sceneId, selfId )
			CallScriptFunction((200060), "Paopao",sceneId, "庄聚贤", "少室山", "看看我冰蚕丝的厉害！" )
			LuaFnUnitUseSkill( sceneId, selfId, x890065_SkillB_NiuMaoDuZhen, selfId, x, z, 0, 0 )

			local SpecObj = random( getn(x890065_SkillB_SpecObjTbl) )
			local x,z = GetWorldPos( sceneId, selfId )
			CreateSpecialObjByDataIndex(sceneId, selfId, x890065_SkillB_SpecObjTbl[SpecObj],  x, z, 0)

			return 1
		end
	end

	return 0

end


--**********************************
--狂暴逻辑....
--**********************************
function x890065_DoSkillD_KuangBao( sceneId, selfId, nTick )

	--检测是否到了狂暴的时候....
	local kbTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890065_IDX_KuangBaoTimer )
	if kbTime < x890065_EnterKuangBaoTime then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890065_IDX_KuangBaoTimer, kbTime+nTick )

	else

		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890065_IDX_IsKuangBaoMode, 1 )
		--加狂暴buff....
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890065_SkillD_Buff1, 0 )
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890065_SkillD_Buff2, 0 )
		--给所有小怪加狂暴buff....
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			if GetName(sceneId, MonsterId) == x890065_SkillA_AChildName or GetName(sceneId, MonsterId) == x890065_SkillA_BChildName or GetName(sceneId, MonsterId) == x890065_SkillA_CChildName or GetName(sceneId, MonsterId) == x890065_SkillA_DChildName then
				LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x890065_SkillD_Buff1, 0 )
				LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, x890065_SkillD_Buff2, 0 )
			end
		end
		return 1

	end


	return 0

end

--**********************************
--暗雷和烟花的buff结束的时候回调本接口....
--**********************************
function x890065_OnImpactFadeOut( sceneId, selfId, impactId )

	--寻找BOSS....
	local bossId = -1
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x890065_MyName == GetName( sceneId, MonsterId ) then
			bossId = MonsterId
		end
	end

	--没找到则返回....
	if bossId == -1 then
		return
	end

	--如果是烟花的buff则让BOSS喊话....
	if impactId == 19767 then
		local x = 0
		local z = 0
		local xx = 0
		local zz = 0
		x,z = GetWorldPos( sceneId,selfId )
		local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanNum-1  do
			local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId, PlayerId) == 1 and PlayerId ~= selfId then
				xx,zz = GetWorldPos(sceneId,PlayerId)
				if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 16*16 then
					LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, PlayerId, 19768, 0 )
				end
			end
		end

		return
	end

end

