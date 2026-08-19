--飘渺峰 李秋水AI

--A 【小无相功】给自己用个空技能....再给随机给一个玩家失明....
--B 【剑舞】给自己用一个空技能....接下来15s内依次给全副本玩家加伤害值逐渐加大的伤害buff....
--C 【洒脱】给自己用一个清buff的技能....
--D 【冰爆】给自己用个空技能....再给随机给玩家脚下放个陷阱....
--E 【狂暴】给自己加疯狂的buff....不再使用其他技能....

--全程都带有免疫制定技能的buff....
--战斗开始同时每隔10秒用A技能....
--当HP降为66%和33%时分别使用B技能....B技能的持续时间内....其它技能CD到了不使用....
--每隔20秒用C技能....
--每隔20秒用D技能....


--脚本号
x900015_g_ScriptId	= 900015

--副本逻辑脚本号....
x900015_g_FuBenScriptId = 893063


--免疫特定技能buff....
x900015_Buff_MianYi1	= 10472	--免疫一些负面效果....
x900015_Buff_MianYi2	= 10471	--免疫普通隐身....

--A神来之笔....
x900015_SkillA_ID			= 1628
x900015_SkillA_Buff		=	2853
x900015_SkillA_CD			= 10000

--C笔走龙蛇....
x900015_SkillC_ID		= 1625
x900015_SkillC_CD		= 20000

--D将进酒....
x900015_SkillD_ID		= 1627
x900015_SkillD_CD		= 20000
x900015_SkillD_SpecObj = 156

--E墨洒八方....
x900015_SkillE_ID			= 1626
x900015_SkillE_Buff		=	2853
x900015_SkillE_CD			= 10000

--开始进入狂暴状态的时间....
x900015_EnterKuangBaoTime	= 500*60*1000

--AI Index....
x900015_IDX_StopWatch						= 1	--秒表....
x900015_IDX_SkillA_CD						= 2	--A技能的CD时间....
x900015_IDX_SkillC_CD						= 3	--C技能的CD时间....
x900015_IDX_SkillD_CD						= 4	--C技能的CD时间....
x900015_IDX_SkillE_CD						= 5	--E技能的CD时间....
x900015_IDX_KuangBaoTimer				= 6	--狂暴的计时器....

x900015_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x900015_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--初始化....
--**********************************
function x900015_OnInit(sceneId, selfId)
	--重置AI....
	x900015_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x900015_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x900015_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x900015_IDX_IsKuangBaoMode ) then
		return
	end

	--A技能心跳....
	if 1 == x900015_TickSkillA( sceneId, selfId, nTick ) then
		return
	end

	--C技能心跳....
	if 1 == x900015_TickSkillC( sceneId, selfId, nTick ) then
		return
	end

	--D技能心跳....
	if 1 == x900015_TickSkillD( sceneId, selfId, nTick ) then
		return
	end

	--E技能心跳....
	if 1 == x900015_TickSkillE( sceneId, selfId, nTick ) then
		return
	end

	--秒表心跳....
	x900015_TickStopWatch( sceneId, selfId, nTick )

end


--**********************************
--进入战斗....
--**********************************
function x900015_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x900015_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x900015_Buff_MianYi2, 0 )

	--重置AI....
	x900015_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x900015_IDX_CombatFlag, 1 )

end

--**********************************
--离开战斗....
--**********************************
function x900015_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x900015_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )
	--创建对话NPC....
	local MstId = CallScriptFunction( x900015_g_FuBenScriptId, "CreateBOSS", sceneId, "MinMo_NPC", -1, -1 )
	SetUnitReputationID( sceneId, MstId, MstId, 0 )
end


--**********************************
--杀死敌人....
--**********************************
function x900015_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x900015_OnDie( sceneId, selfId, killerId )

	--取得当前场景里的人数
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
	local mems = {}
	for i = 0, num - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId( sceneId, i )
                local aa = random(1,5)
                for j = 1,aa do
		   -- AddMonsterDropItem( sceneId, selfId, mems[i], 20800032 )
                end
	end

	--重置AI....
	x900015_ResetMyAI( sceneId, selfId )		
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
		str = format("#cffcc88#{_INFOUSR%s}带领队伍终于将天帝击杀！", playerName); --乌老大
		AddGlobalCountNews( sceneId, str )
	end
	--CallScriptFunction( 898992, "MonsterOnDie", sceneId, selfId, killerId,19 )
end



--**********************************
--重置AI....
--**********************************
function x900015_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_StopWatch, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillA_CD, 0 )

	MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillC_CD, x900015_SkillC_CD )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillD_CD, x900015_SkillD_CD )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillE_CD, x900015_SkillE_CD )

	MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_KuangBaoTimer, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x900015_IDX_CombatFlag, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x900015_IDX_IsKuangBaoMode, 0 )

end

--**********************************
--A技能心跳....
--**********************************
function x900015_TickSkillA( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillA_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillA_CD, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillA_CD, x900015_SkillA_CD-(nTick-cd) )
		return x900015_UseSkillA( sceneId, selfId )
	end

end

--**********************************
--C技能心跳....
--**********************************
function x900015_TickSkillC( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillC_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillC_CD, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillC_CD, x900015_SkillC_CD-(nTick-cd) )
		return x900015_UseSkillC( sceneId, selfId )
	end

end

--**********************************
--D技能心跳....
--**********************************
function x900015_TickSkillD( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillD_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillD_CD, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_SkillD_CD, x900015_SkillD_CD-(nTick-cd) )
		return x900015_UseSkillD( sceneId, selfId )
	end

end

--**********************************
--E技能心跳....
--**********************************
function x900015_TickSkillE( sceneId, selfId, nTick )



	--检测是否到了狂暴的时候....
	-- local kbTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x900015_IDX_KuangBaoTimer )
	-- if kbTime < x900015_EnterKuangBaoTime then

		-- MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_KuangBaoTimer, kbTime+nTick )
		-- return 0

	-- else

	--副本中有效的玩家的列表....
	local PlayerList = {}

	--将有效的人加入列表....
	local numPlayer = 0
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			PlayerList[numPlayer+1] = nHumanId
			numPlayer = numPlayer + 1
		end
	end

	--随机挑选一个玩家....
	if numPlayer <= 0 then
		return 0
	end
	local PlayerId = PlayerList[ random(numPlayer) ]

	--对自己使用一个空技能....
	-- local x,z = GetWorldPos( sceneId, selfId )
	-- LuaFnUnitUseSkill( sceneId, selfId, x900015_SkillE_ID, selfId, x, z, 0, 1 )

	--给玩家加失明buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, PlayerId, 10052, 0 )
	--给自己增加一个免疫控制技能....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 10472, 0 )

	return 1

	-- end
end

--**********************************
--秒表心跳....
--**********************************
function x900015_TickStopWatch( sceneId, selfId, nTick )

	--限制每秒才会执行一次....
	local time = MonsterAI_GetIntParamByIndex( sceneId, selfId, x900015_IDX_StopWatch )
	if (time + nTick) > 1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_StopWatch, time+nTick-1000 )
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x900015_IDX_StopWatch, time+nTick )
		return
	end
end

--**********************************
--使用A技能....
--**********************************
function x900015_UseSkillA( sceneId, selfId )



	--副本中有效的玩家的列表....
	local PlayerList = {}

	--将有效的人加入列表....
	local numPlayer = 0
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			PlayerList[numPlayer+1] = nHumanId
			numPlayer = numPlayer + 1
		end
	end

	--随机挑选一个玩家....
	if numPlayer <= 0 then
		return 0
	end
	local PlayerId = PlayerList[ random(numPlayer) ]

	--对自己使用一个空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, 765, selfId, x, z, 0, 1 )

	--给玩家加失明buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, PlayerId, x900015_SkillA_Buff, 0 )

	return 1

end

--**********************************
--使用C技能....
--**********************************
function x900015_UseSkillC( sceneId, selfId )



	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, 1004, selfId, x, z, 0, 1 )
	return 1

end

--**********************************
--使用D技能....
--**********************************
function x900015_UseSkillD( sceneId, selfId )



	CallScriptFunction((200060), "Paopao",sceneId, "潘菁菁", "四绝庄","潘菁菁：闵墨要放绝技了，大家远离他释放的陷阱！" )

	--副本中有效的玩家的列表....
	local PlayerList = {}

	--将有效的人加入列表....
	local numPlayer = 0
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			PlayerList[numPlayer+1] = nHumanId
			numPlayer = numPlayer + 1
		end
	end

	--随机挑选一个玩家....
	if numPlayer <= 0 then
		return 0
	end
	local PlayerId = PlayerList[ random(numPlayer) ]

	--使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, 340, selfId, x, z, 0, 1 )

	--在该玩家脚底下放陷阱....
	x,z = GetWorldPos( sceneId, PlayerId )
	CreateSpecialObjByDataIndex(sceneId, selfId, 921, x, z, 0)

	return 1

end

