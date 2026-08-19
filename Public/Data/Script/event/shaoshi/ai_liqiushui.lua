--飘渺峰 不平道人AI

--F	【暗雷】对自己用一个空技能....再给玩家加个结束后会回调脚本的buff....回调时让BOSS给其周围人加伤寒buff并喊话....
--G 【精算】给自己用一个加buff的技能....
--H 【烟花】对自己用一个空技能....再给玩家加个结束后会回调脚本的buff....回调时喊话....
--I	【朋友】卓不凡死时给自己用一个加buff的技能....


--全程都带有免疫制定技能的buff....
--每隔30秒对随机玩家随机使用FH....
--每隔45秒对自己使用G....
--死亡或脱离战斗时给所有玩家清除FH的buff....
--死亡时寻找不平道人....设置其需要使用狂暴技能....
--死亡时发现不平道人已经死了....则创建另一个BOSS....


--脚本号
x890069_g_ScriptId	= 890069

--副本逻辑脚本号....
x890069_g_FuBenScriptId = 890063

--免疫Buff....
x890069_Buff_MianYi1	= 10472	--免疫一些负面效果....
x890069_Buff_MianYi2	= 10471	--免疫普通隐身....

--技能....
x890069_SkillID_F		= 860
x890069_BuffID_F1		= 19639
x890069_BuffID_F2		= 19640

x890069_SkillID_G		= 868

x890069_SkillID_H		= 861
x890069_BuffID_H		= 19741
x890069_BuffID_H2		= 19742
x890069_BuffID_H3		= 19743
x890069_BuffID_H4		= 19744
x890069_BuffID_H5		= 19745
x890069_BuffID_H6		= 19746

x890069_SkillID_I		= 1036
x890069_BuffID_I1		= 10253
x890069_BuffID_I2		= 10254

x890069_SkillID_J		= 862
x890069_BuffID_J		= 22405

x890069_SkillCD_FH	=	15000
x890069_SkillCD_G		=	10000
x890069_SkillCD_J	=	12000


x890069_MyName			= "丁春秋"	--自己的名字....

--AI Index....
x890069_IDX_KuangBaoMode	= 1	--狂暴模式....0未狂暴 1需要进入狂暴 2已经进入狂暴
x890069_IDX_CD_SkillFH		= 2	--FH技能的CD....
x890069_IDX_CD_SkillG			= 3	--G技能的CD....
x890069_IDX_CD_Talk				= 4	--FH技能喊话的CD....
x890069_IDX_CD_SkillJ			= 5	--G技能的CD....

x890069_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....

x890069_LootItem_1 = {
30505167, 30505168, 39900000, 39900001, }

x890069_LootItem_2 = {50713001, 50713002, 50713003, 50713004, 50703001, 50704002}
--**********************************
--初始化....
--**********************************
function x890069_OnInit(sceneId, selfId)
	--重置AI....
	x890069_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x890069_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890069_IDX_CombatFlag ) then
		return
	end

	--FH技能心跳....
	if 1 == x890069_TickSkillFH( sceneId, selfId, nTick ) then
		return
	end

	--G技能心跳....
	if 1 == x890069_TickSkillG( sceneId, selfId, nTick ) then
		return
	end

	--I技能心跳....
	if 1 == x890069_TickSkillI( sceneId, selfId, nTick ) then
		return
	end

	--J技能心跳....
	if 1 == x890069_TickSkillJ( sceneId, selfId, nTick ) then
		return
	end

	local x,z = GetWorldPos(sceneId,selfId)
	local MonsterId
	local DogX=0
	local DogZ=0
	local nMonsterNum = GetMonsterCount( sceneId )
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId, i)
		if GetName(sceneId, MonsterId) == "血咒巫蛊" then
			DogX, DogZ = GetWorldPos( sceneId, MonsterId )
		end
	end
	if (x - DogX) * (x - DogX) + (z - DogZ) * (z - DogZ) < 6*6 then
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 19650, 0 )
	end

end


--**********************************
--进入战斗....
--**********************************
function x890069_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890069_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890069_Buff_MianYi2, 0 )

	--重置AI....
	x890069_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890069_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x890069_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x890069_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )
	--创建对话NPC....
	local MstId = CallScriptFunction( x890069_g_FuBenScriptId, "CreateBOSS", sceneId, "LiFan_NPC", -1, -1 )
	SetUnitReputationID( sceneId, MstId, MstId, 0 )
end


--**********************************
--杀死敌人....
--**********************************
function x890069_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x890069_OnDie( sceneId, selfId, killerId )

	--重置AI....
	x890069_ResetMyAI( sceneId, selfId )

	--设置已经挑战过李秋水....
	CallScriptFunction( x890069_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "DingChunQiu", 2 )

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
		str = format("少室山上一阵雷鸣电闪，轰隆隆的雷声从天空传来，#G原来是#{_INFOUSR%s}带领的队伍正和丁春秋激战。#W激战中，丁春秋一不留神，被#{_INFOUSR%s}一下戳中了死穴，一头栽在地上，倒地不起。众人连忙上前抢夺其掉落的财宝！", playerName, playerName); --李秋水
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
			if rand < 60 then
				local WuPin = random( getn(x890069_LootItem_1) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890069_LootItem_1[WuPin] )

			end

			rand = random(100)
			if rand < 50 then
				local WuPin = random( getn(x890069_LootItem_1) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890069_LootItem_1[WuPin] )

			end
			rand = random(100)
			if rand < 50 then
				local WuPin = random( getn(x890069_LootItem_2) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890069_LootItem_2[WuPin]  )
			end

			rand = random(100)
			if rand < 40 then
				local WuPin = random( getn(x890069_LootItem_2) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890069_LootItem_2[WuPin]  )
			end

		end
	end

end


--**********************************
--重置AI....
--**********************************
function x890069_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_KuangBaoMode, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillFH, x890069_SkillCD_FH )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillG, x890069_SkillCD_G )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillJ, x890069_SkillCD_J )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_Talk, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890069_IDX_CombatFlag, 0 )

	--给所有玩家清除FH的buff....
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x890069_BuffID_F1 )
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x890069_BuffID_H )
		end
	end

end


--**********************************
--FH技能心跳....
--**********************************
function x890069_TickSkillFH( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillFH )
	if cd > nTick then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillFH, cd-nTick )
		return 0

	else

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillFH, x890069_SkillCD_FH-(nTick-cd) )

		--随机使用FH....
		if random(100) < 50 then
			return x890069_UseSkillF( sceneId, selfId )
		else
			return x890069_UseSkillH( sceneId, selfId )
		end

	end

end


--**********************************
--G技能心跳....
--**********************************
function x890069_TickSkillG( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillG )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillG, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillG, x890069_SkillCD_G-(nTick-cd) )
		return x890069_UseSkillG( sceneId, selfId )
	end

end

--**********************************
--J技能心跳....
--**********************************
function x890069_TickSkillJ( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.4666 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillJ )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillJ, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_CD_SkillJ, x890069_SkillCD_J-(nTick-cd) )
		return x890069_UseSkillJ( sceneId, selfId )
	end

end

--**********************************
--I技能心跳....
--**********************************
function x890069_TickSkillI( sceneId, selfId, nTick )

	--获得当前狂暴mode....
	local CurMode = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890069_IDX_KuangBaoMode )

	if CurMode == 0 or CurMode == 2 then

		--如果不需要狂暴或者已经狂暴了则返回....
		return 0

	elseif CurMode == 1 then

		--如果需要狂暴则使用狂暴技能....
		local ret =  x890069_UseSkillI( sceneId, selfId )
		if ret == 1 then
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890069_IDX_KuangBaoMode, 2 )
			return 1
		else
			return 0
		end

	end

end


--**********************************
--使用F技能....
--**********************************
function x890069_UseSkillF( sceneId, selfId )

	if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, x890069_BuffID_F1) == 1 then
		return 0
	end
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, x890069_BuffID_H) == 1 then
		return 0
	end

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

	--对自己使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x890069_SkillID_F, selfId, x, z, 0, 1 )

	--给玩家加结束后回调脚本的buff....
	LuaFnSendSpecificImpactToUnit( sceneId, PlayerId, PlayerId, PlayerId, x890069_BuffID_F1, 0 )
	--LuaFnSendSpecificImpactToUnit( sceneId, PlayerId, PlayerId, PlayerId, x890069_BuffID_F3, 0 )
	x890069_MsgBox( sceneId, PlayerId, "你将在10秒钟后产生爆炸，请远离人群！" )

	return 1

end


--**********************************
--使用G技能....
--**********************************
function x890069_UseSkillG( sceneId, selfId )


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

	--对其使用技能....
	local x,z = GetWorldPos( sceneId, PlayerId )
	LuaFnUnitUseSkill( sceneId, selfId, x890069_SkillID_G, PlayerId, x, z, 0, 1 )

	return 1

end


--**********************************
--使用H技能....
--**********************************
function x890069_UseSkillH( sceneId, selfId )

	if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, x890069_BuffID_F1) == 1 then
		return 0
	end
	if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, x890069_BuffID_H) == 1 then
		return 0
	end

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

	--对自己使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x890069_SkillID_H, selfId, x, z, 0, 1 )

	--给玩家加结束后回调脚本的buff....
	LuaFnSendSpecificImpactToUnit( sceneId, PlayerId, PlayerId, PlayerId, x890069_BuffID_H, 0 )
	x890069_MsgBox( sceneId, PlayerId, "你将在10秒钟后产生爆炸，可以寻找队友为你分担伤害！" )

	return 1

end

--**********************************
--使用J技能....
--**********************************
function x890069_UseSkillJ( sceneId, selfId )

	--对自己使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x890069_SkillID_J, selfId, x, z, 0, 1 )

	local x,z = GetWorldPos( sceneId, selfId )
	local MstId = CallScriptFunction( x890069_g_FuBenScriptId, "CreateBOSS", sceneId, "WuDing_BOSS", x, z )
	LuaFnSendSpecificImpactToUnit( sceneId, MstId, MstId, MstId, 10246, 0 )
	CreateSpecialObjByDataIndex(sceneId, selfId, 1023, x, z, 0)
	CallScriptFunction((200060), "Paopao",sceneId, "丁春秋", "少室山", "丁春秋： 这些巫蛊在我身边将会为我治疗，若你们进来，那就等死吧！" )
	MonsterTalk( sceneId, -1, "", "注意，请迅速将丁春秋引出血咒巫蛊的施法范围，否则将被血咒巫蛊恢复一定的生命值！" )

	return 1

end


--**********************************
--使用I技能....
--**********************************
function x890069_UseSkillI( sceneId, selfId )

	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890069_BuffID_I1, 5000 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890069_BuffID_I2, 5000 )

	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x890069_SkillID_I, selfId, x, z, 0, 1 )

	MonsterTalk( sceneId, -1, "", "#{PMF_20080530_02}" )

	return 1

end


--**********************************
--暗雷和烟花的buff结束的时候回调本接口....
--**********************************
function x890069_OnImpactFadeOut( sceneId, selfId, impactId )

	--寻找BOSS....
	local bossId = -1
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x890069_MyName == GetName( sceneId, MonsterId ) then
			bossId = MonsterId
		end
	end

	--没找到则返回....
	if bossId == -1 then
		return
	end

	--如果是烟花的buff则让BOSS喊话....
	if impactId == x890069_BuffID_F1 then

		CallScriptFunction((200060), "Paopao",sceneId, "丁春秋", "少室山", "丁春秋：#c2ebeff"..GetName( sceneId, selfId ).."#W你已被老夫施下腐蚀毒，你的四周将会与你共赴黄泉！" )

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
				if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 12*12 then
					LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, PlayerId, x890069_BuffID_F2, 0 )
					LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 19652, 0 )
				end
			end
		end

		return
	end

	--如果是暗雷的buff....则让BOSS给附近的玩家加一个伤害的buff并喊话....
	if impactId == x890069_BuffID_H then

		CallScriptFunction((200060), "Paopao",sceneId, "丁春秋", "少室山", "丁春秋：老夫倒要看看，有谁愿意替#c2ebeff"..GetName( sceneId, selfId ).."#W分担伤害！" )

		local x = 0
		local z = 0
		local xx = 0
		local zz = 0
		local count = 0

		x,z = GetWorldPos( sceneId,selfId )
		local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanNum-1  do
			local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId, PlayerId) == 1 and PlayerId ~= selfId then
				xx,zz = GetWorldPos(sceneId,PlayerId)
				if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 8*8 then
					count = count + 1
				end
			end
		end

		if count == 0 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, x890069_BuffID_F2, 0 )
		    --LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, x890069_BuffID_H2, 0 )
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 19652, 0 )

		elseif count == 1 then
			x,z = GetWorldPos( sceneId,selfId )
			local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanNum-1  do
				local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId, PlayerId) == 1 then
					xx,zz = GetWorldPos(sceneId,PlayerId)
					if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 12*12 then
						LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, PlayerId, x890069_BuffID_H2, 0 )
					       LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 19652, 0 )
					end
				end
			end
		elseif count == 2 then
			x,z = GetWorldPos( sceneId,selfId )
			local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanNum-1  do
				local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId, PlayerId) == 1 then
					xx,zz = GetWorldPos(sceneId,PlayerId)
					if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 12*12 then
						LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, PlayerId, x890069_BuffID_H3, 0 )
					       LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 19652, 0 )
					end
				end
			end
		elseif count == 3 then
			x,z = GetWorldPos( sceneId,selfId )
			local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanNum-1  do
				local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId, PlayerId) == 1 then
					xx,zz = GetWorldPos(sceneId,PlayerId)
					if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 12*12 then
						LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, PlayerId, x890069_BuffID_H4, 0 )
					       LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 19652, 0 )
					end
				end
			end
		elseif count == 4 then
			x,z = GetWorldPos( sceneId,selfId )
			local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanNum-1  do
				local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId, PlayerId) == 1 then
					xx,zz = GetWorldPos(sceneId,PlayerId)
					if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 12*12 then
						LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, PlayerId, x890069_BuffID_H5, 0 )
					       LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 19652, 0 )
					end
				end
			end
		elseif count == 5 then
			x,z = GetWorldPos( sceneId,selfId )
			local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
			for i=0, nHumanNum-1  do
				local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 and LuaFnIsCharacterLiving(sceneId, PlayerId) == 1 then
					xx,zz = GetWorldPos(sceneId,PlayerId)
					if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 12*12 then
						LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, PlayerId, x890069_BuffID_H6, 0 )
					       LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 19652, 0 )
					end
				end
			end
		end

		return

	end

end

--**********************************
--消息提示
--**********************************
function x890069_MsgBox( sceneId, selfId, str )	
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end