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
x893069_g_ScriptId	= 893069

--副本逻辑脚本号....
x893069_g_FuBenScriptId = 893063


--免疫特定技能buff....
x893069_Buff_MianYi1	= 10472	--免疫一些负面效果....
x893069_Buff_MianYi2	= 10471	--免疫普通隐身....

--A小无相功....
x893069_SkillA_ID			= 1640
x893069_SkillA_BID			= 1638
x893069_SkillA_Buff		=	2866
x893069_SkillA_CD			= 60000

--B剑舞....
x893069_SkillB_SkillIDTbl = { 1043, 1044, 1045, 1046, 1047 }
x893069_SkillB_WeatherTbl = { 11, 12, 13, 14, 15 }
x893069_SkillB_SelfBuff = { 2872, 2873, 2874, 2875, 2876 }
x893069_SkillB_LongZhuTbl = { "Mu_BOSS", "Tu_BOSS", "Huo_BOSS", "Jin_BOSS", "Shui_BOSS" }
x893069_SkillB_TalkTbl =
{
	"我要召唤龙柱啦--大家小心了",
	"我要召唤龙柱啦--大家小心了",
	"我要召唤龙柱啦--大家小心了",
	"我要召唤龙柱啦--大家小心了",
	"我要召唤龙柱啦--大家小心了"
}

x893069_SkillB_Text =
{
	"潘菁菁：庞企激活了木龙柱，尽快将庞企引到克制木的金龙柱旁边，否则大家有难了！",
	"潘菁菁：庞企激活了土龙柱，尽快将庞企引到克制土的木龙柱旁边，否则大家有难了！",
	"潘菁菁：庞企激活了火龙柱，尽快将庞企引到克制火的水龙柱旁边，否则大家有难了！",
	"潘菁菁：庞企激活了金龙柱，尽快将庞企引到克制金的火龙柱旁边，否则大家有难了！",
	"潘菁菁：庞企激活了水龙柱，尽快将庞企引到克制水的土龙柱旁边，否则大家有难了！"
}

x893069_SkillB_BuffIDTbl =
{
	[1] = {2872,2872},
	[2] = {2873,2873},
	[3] = {2874,2874},
	[4] = {2875,2875},
	[5] = {2876,2876}
}

--C洒脱....
x893069_SkillC_ID		= 1639
x893069_SkillC_CD		= 5000

--D冰爆....
x893069_SkillD_ID		= 1639
x893069_SkillD_CD		= 20000
x893069_SkillD_SpecObj = 59

--E狂暴....
x893069_SkillE_Buff1	= 10234
x893069_SkillE_Buff2	= 10235
--开始进入狂暴状态的时间....
x893069_EnterKuangBaoTime	= 50*60*1000

--F十步一杀....
x893069_SkillF_ID		= 1643
x893069_SkillF_SpecObjTbl = { 162, 163, 164, 165, 166, 167 }

--G弃車保帅....
x893069_SkillG_ID		= 1642

--小怪跑
x893069_g_DogfacePos = {
	{ 41, 24, 0, 14146 }, { 41, 24, 0, 14146 }, { 41, 24, 0, 14146 }, 
       { 38, 36, 1, 14146 }, { 38, 36, 1, 14146 }, { 38, 36, 1, 14146 }, 
       { 20, 37, 2, 14146 }, { 20, 37, 2, 14146 }, { 20, 37, 2, 14146 },
       { 18, 25, 3, 14146 }, { 18, 25, 3, 14146 }, { 18, 25, 3, 14146 },
       { 29, 18, 4, 14146 }, { 29, 18, 4, 14146 }, { 29, 18, 4, 14146 }
}

x893069_g_DogfaceGroup = 0					-- 逃跑小兵的 Group ID

--AI Index....
x893069_IDX_StopWatch						= 1	--秒表....
x893069_IDX_SkillA_CD						= 2	--A技能的CD时间....
x893069_IDX_SkillB_HPStep				= 3	--血量级别....
x893069_IDX_SkillB_Step					= 4	--B技能的Step....0=未发动 15=buff1 14=buff2 …… 1=buff15
x893069_IDX_SkillB_Type					= 5	--当前正在使用哪种类型的剑舞....
x893069_IDX_SkillC_CD						= 6	--C技能的CD时间....
x893069_IDX_SkillD_CD						= 7	--C技能的CD时间....
x893069_IDX_KuangBaoTimer				= 8	--狂暴的计时器....


x893069_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x893069_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--初始化....
--**********************************
function x893069_OnInit(sceneId, selfId)
	--重置AI....
	x893069_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x893069_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x893069_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x893069_IDX_IsKuangBaoMode ) then
		return
	end

	--A技能心跳....
	if 1 == x893069_TickSkillA( sceneId, selfId, nTick ) then
		return
	end

	--B技能心跳....
	if 1 == x893069_TickSkillB( sceneId, selfId, nTick ) then
		return
	end

	--C技能心跳....
	if 1 == x893069_TickSkillC( sceneId, selfId, nTick ) then
		return
	end

	--D技能心跳....
	if 1 == x893069_TickSkillD( sceneId, selfId, nTick ) then
		return
	end

	--E技能心跳....
	if 1 == x893069_TickSkillE( sceneId, selfId, nTick ) then
		return
	end

	--秒表心跳....
	x893069_TickStopWatch( sceneId, selfId, nTick )

		local monstercount = GetMonsterCount( sceneId )
		local monsterId, GroupID, DogX, DogZ
		local x, z = GetLastPatrolPoint( sceneId, 0 )

		for i = 0, monstercount - 1 do
			monsterId = GetMonsterObjID( sceneId, i )
			GroupID = GetMonsterGroupID( sceneId, monsterId )

			if GroupID == x893069_g_DogfaceGroup
			 and LuaFnIsCharacterLiving( sceneId, monsterId ) == 1 then			-- 判断活着的小兵是否逃跑成功
				DogX, DogZ = GetWorldPos( sceneId, monsterId )

				if (x - DogX) * (x - DogX) + (z - DogZ) * (z - DogZ) < 2 then	-- 离终点不到 5 米
					LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 2882, 0 )  --加血
					LuaFnDeleteMonster( sceneId, monsterId )
				end
			end
		end
end


--**********************************
--进入战斗....
--**********************************
function x893069_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x893069_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x893069_Buff_MianYi2, 0 )

	--重置AI....
	x893069_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893069_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x893069_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x893069_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )
	--创建对话NPC....
	local MstId = CallScriptFunction( x893069_g_FuBenScriptId, "CreateBOSS", sceneId, "LiFan_NPC", -1, -1 )
	SetUnitReputationID( sceneId, MstId, MstId, 0 )
end


--**********************************
--杀死敌人....
--**********************************
function x893069_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x893069_OnDie( sceneId, selfId, killerId )
local x,z = GetWorldPos( sceneId, selfId )
	--取得当前场景里的人数
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
	local mems = {}
	for i = 0, num - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId( sceneId, i )
                local aa = random(1,5)
                for j = 1,aa do
		   AddMonsterDropItem( sceneId, selfId, mems[i], 20800032 )
                end
	end

	--重置AI....
	x893069_ResetMyAI( sceneId, selfId )

	--设置已经挑战过李秋水....
	CallScriptFunction( x893069_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "PangQi", 2 )

	--增加扫荡点【注意，此处自带遍历，不需要再次遍历】2019-8-21 11:58:28 逍遥子
	LuaFnAddSweepPointByID(sceneId, selfId,2,10)
	--取得当前场景里的人数
	local RenNum = LuaFnGetCopyScene_HumanCount( sceneId )
	for i=0, RenNum-1 do
	local EveryBodyID = LuaFnGetCopyScene_HumanObjId( sceneId, i )	  --取得当前场景里人的objId
	    --====================================
		--SUNYAN ADD ACTIVITY SYSTEM 20181228
		CallScriptFunction(990012, "AddActivePoint",sceneId,EveryBodyID,12,89)
		--====================================
		--======================================================
		--SALARY SYSTEM 20181230 ADD
		CallScriptFunction( 002102, "AddSalary", sceneId, EveryBodyID,8,15)
		--======================================================
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
	LuaFnCreateMonster(sceneId, 14156, 29, 29, 3, 0, 893082)
	local nsuiji = random(3)
	if playerName ~= nil and nsuiji == 1 then
		LuaFnCreateMonster(sceneId, 14157, x, z, 0, 0, -1)
		str = format("#Y庞企#cffcc88独占四绝庄秘宝的野心不但被#{_INFOUSR%s}率队破坏了，甚至自己珍藏的黄金棋子都被打飞了", playerName);
		AddGlobalCountNews( sceneId, str )
	else
		str = format("#Y庞企#cffcc88独占四绝庄秘宝的野心被#{_INFOUSR%s}率队破坏了", playerName);
		AddGlobalCountNews( sceneId, str )	
	end
end


--**********************************
--重置AI....
--**********************************
function x893069_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_StopWatch, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillA_CD, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_HPStep, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Step, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Type, 1 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillC_CD, x893069_SkillC_CD )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillD_CD, x893069_SkillD_CD )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_KuangBaoTimer, 0 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893069_IDX_CombatFlag, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893069_IDX_IsKuangBaoMode, 0 )

end

--**********************************
--A技能心跳....
--**********************************
function x893069_TickSkillA( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillA_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillA_CD, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillA_CD, x893069_SkillA_CD-(nTick-cd) )
		return x893069_UseSkillA( sceneId, selfId )
	end

end

--**********************************
--B技能心跳....
--**********************************
function x893069_TickSkillB( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	local LastStep = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_HPStep )
	local CurStep = 0
	if CurPercent <= 0.1333 then
		CurStep = 5
	elseif CurPercent <= 0.3666 then
		CurStep = 4
	elseif CurPercent <= 0.6666 then
		CurStep = 3
	elseif CurPercent <= 0.8333 then
		CurStep = 2
	elseif CurPercent <= 0.9333 then
		CurStep = 1
	end

	if CurStep > LastStep and CurStep < 3 then

		--设置参数....
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_HPStep, CurStep )
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Step, 2 )
		local JianWuType = random( getn(x893069_SkillB_SkillIDTbl) )
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Type, JianWuType )

		--喊话....
		MonsterTalk(sceneId, -1, "", x893069_SkillB_TalkTbl[JianWuType] )

		CallScriptFunction((200060), "Paopao",sceneId, "潘菁菁", "四绝庄", x893069_SkillB_Text[JianWuType] )
		
		MonsterTalk(sceneId, -1, "", x893069_SkillB_Text[JianWuType] )
		--放全场景烟花....
		LuaFnSetSceneWeather(sceneId, x893069_SkillB_WeatherTbl[JianWuType], 30000 )
                --怪物给自己加强化
                LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, x893069_SkillB_SelfBuff[JianWuType], 0)

		--创建龙住....
		--local x,z = GetWorldPos( sceneId, selfId )
                for j = 1,5 do
		    MstId = CallScriptFunction( x893066_g_FuBenScriptId, "CreateBOSS", sceneId, x893069_SkillB_LongZhuTbl[j], -1, -1 )
		    SetCharacterDieTime( sceneId, MstId, 30000 )
                end

		return 1

	elseif CurStep > LastStep and CurStep < 4 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_HPStep, CurStep )

		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x893069_SkillG_ID, selfId, x, z, 0, 1 )
		CallScriptFunction((200060), "Paopao",sceneId, "潘菁菁", "四绝庄",  "潘菁菁：速度击杀所有星罗小卒，否则庞企将会恢复体力！")

		local dogfaceId = -1
		for i = 1, getn( x893069_g_DogfacePos ) do
			if x893069_g_DogfacePos[i] then
			      local dogfaceId = LuaFnCreateMonster( sceneId, x893069_g_DogfacePos[i][4], x893069_g_DogfacePos[i][1], x893069_g_DogfacePos[i][2], 1, 4, -1 )
				SetMonsterGroupID( sceneId, dogfaceId, x893069_g_DogfaceGroup )
				SetPatrolId( sceneId, dogfaceId, x893069_g_DogfacePos[i][3] )		-- 设置巡逻路径
				SetCharacterDieTime( sceneId, dogfaceId, 8000 )
			end
		end
                --庞企复位
                SetPos(sceneId,selfId,29,29)
		return 1

	elseif CurStep > LastStep then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_HPStep, CurStep )

	--使用空技能....
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x893069_SkillF_ID, selfId, x, z, 0, 1 )
		CallScriptFunction((200060), "Paopao",sceneId, "庞企", "四绝庄",  "十步杀一人，千里不留行。")
		CallScriptFunction((200060), "Paopao",sceneId, "潘菁菁", "四绝庄",  "潘菁菁：庞企要开始连续放十步一杀了，大家小心躲开自己脚下的陷阱！")

		local SpecObj = random( getn(x893069_SkillF_SpecObjTbl) )

		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
				x,z = GetWorldPos( sceneId, nHumanId )
				CreateSpecialObjByDataIndex(sceneId, selfId, x893069_SkillF_SpecObjTbl[SpecObj], x, z, 0)
			end
		end

		return 1

	end

	return 0

end

--**********************************
--C技能心跳....
--**********************************
function x893069_TickSkillC( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillC_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillC_CD, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillC_CD, x893069_SkillC_CD-(nTick-cd) )
		return x893069_UseSkillC( sceneId, selfId )
	end

end

--**********************************
--D技能心跳....
--**********************************
function x893069_TickSkillD( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillD_CD )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillD_CD, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillD_CD, x893069_SkillD_CD-(nTick-cd) )
		return x893069_UseSkillD( sceneId, selfId )
	end

end

--**********************************
--E技能心跳....
--**********************************
function x893069_TickSkillE( sceneId, selfId, nTick )

	--如果正在用B技能则先等待....
	if MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Step ) > 0 then
		return 0
	end

	--检测是否到了狂暴的时候....
	local kbTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_KuangBaoTimer )
	if kbTime < x893069_EnterKuangBaoTime then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_KuangBaoTimer, kbTime+nTick )
		return 0

	else

		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x893069_IDX_IsKuangBaoMode, 1 )
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x893069_SkillE_Buff1, 0 )
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x893069_SkillE_Buff2, 0 )
		return 1

	end

end

--**********************************
--秒表心跳....
--**********************************
function x893069_TickStopWatch( sceneId, selfId, nTick )

	--限制每秒才会执行一次....
	local time = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_StopWatch )
	if (time + nTick) > 1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_StopWatch, time+nTick-1000 )
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_StopWatch, time+nTick )
		return
	end


	-------------------------
	--剑舞技能逻辑....
	-------------------------
	local buffStep = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Step )
	local skillType = MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Type )
	if buffStep >= 1 and buffStep <= 2 then

		--寻找符敏仪....
		--local bossId = CallScriptFunction( x893069_g_FuBenScriptId, "FindBOSS", sceneId, "LiFan_NPC" )
		--if bossId <= 0 then
			--return 0
		--end

		--让符敏仪给玩家加buff....
		local buffTbl = x893069_SkillB_BuffIDTbl[skillType]
		local buffId = buffTbl[2-buffStep]
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, buffId, 0 )
		--local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		--for i=0, nHumanCount-1 do
			--local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			--if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
				--LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, nHumanId, buffId, 0 )
			--end
		--end

	end

	if buffStep > 0 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Step, buffStep-1 )
	end


end

--**********************************
--使用A技能....
--**********************************
function x893069_UseSkillA( sceneId, selfId )

	--如果正在用B技能则跳过....
	if MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Step ) > 0 then
		return 0
	end

	--对自己使用一个空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893069_SkillA_BID, selfId, x, z, 0, 1 )

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
	LuaFnUnitUseSkill( sceneId, selfId, x893069_SkillA_ID, selfId, x, z, 0, 1 )

	--给玩家加失明buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, PlayerId, x893069_SkillA_Buff, 0 )

	return 1

end

--**********************************
--使用C技能....
--**********************************
function x893069_UseSkillC( sceneId, selfId )

	--如果正在用B技能则跳过....
	if MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Step ) > 0 then
		return 0
	end

	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893069_SkillC_ID, selfId, x, z, 0, 1 )
	return 1

end

--**********************************
--使用D技能....
--**********************************
function x893069_UseSkillD( sceneId, selfId )

	--如果正在用B技能则跳过....
	if MonsterAI_GetIntParamByIndex( sceneId, selfId, x893069_IDX_SkillB_Step ) > 0 then
		return 0
	end

	--使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x893069_SkillD_ID, selfId, x, z, 0, 1 )

	return 1

end

