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
x890066_g_ScriptId	= 890066

--副本逻辑脚本号....
x890066_g_FuBenScriptId = 890063

--免疫Buff....
x890066_Buff_MianYi1	= 10472	--免疫一些负面效果....
x890066_Buff_MianYi2	= 10471	--免疫普通隐身....

--技能....
x890066_SkillID_F		= 854
x890066_BuffID_F1		= 19636

x890066_SkillID_G		= 853
x890066_SkillID_G_SpecObj		= 1022

x890066_SkillID_H		= 855
x890066_SkillID_J		= 859
x890066_BuffID_H		= 19629

x890066_SkillID_I		= 1036
x890066_BuffID_I1		= 10253
x890066_BuffID_I2		= 10254

x890066_SkillCD_FH	=	10000
x890066_SkillCD_G		=	6000
x890066_SkillCD_H	=	20000


x890066_MyName			= "慕容复"	--自己的名字....

--AI Index....
x890066_IDX_KuangBaoMode	= 1	--狂暴模式....0未狂暴 1需要进入狂暴 2已经进入狂暴
x890066_IDX_CD_SkillFH		= 2	--FH技能的CD....
x890066_IDX_CD_SkillG			= 3	--G技能的CD....
x890066_IDX_CD_Talk				= 4	--FH技能喊话的CD....
x890066_IDX_CD_SkillH			= 5	--G技能的CD....

x890066_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....

x890066_LootItem_1 = {
50712001, 50712002, 50712003, 50712004, 
}

x890066_LootItem_2 = {50101001, 50101002, 50201001, 50201002,}
--**********************************
--初始化....
--**********************************
function x890066_OnInit(sceneId, selfId)
	--重置AI....
	x890066_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x890066_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x890066_IDX_CombatFlag ) then
		return
	end

	--FH技能心跳....
	if 1 == x890066_TickSkillFH( sceneId, selfId, nTick ) then
		return
	end

	--G技能心跳....
	if 1 == x890066_TickSkillG( sceneId, selfId, nTick ) then
		return
	end

	--H技能心跳....
	if 1 == x890066_TickSkillH( sceneId, selfId, nTick ) then
		return
	end

	--I技能心跳....
	if 1 == x890066_TickSkillI( sceneId, selfId, nTick ) then
		return
	end

end


--**********************************
--进入战斗....
--**********************************
function x890066_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890066_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890066_Buff_MianYi2, 0 )

	--重置AI....
	x890066_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890066_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x890066_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x890066_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )

	--创建对话NPC....
	local MstId = CallScriptFunction( x890066_g_FuBenScriptId, "CreateBOSS", sceneId, "MuRongFu_NPC", -1, -1 )
	SetUnitReputationID( sceneId, MstId, MstId, 0 )
end


--**********************************
--杀死敌人....
--**********************************
function x890066_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x890066_OnDie( sceneId, selfId, killerId )

	--重置AI....
	x890066_ResetMyAI( sceneId, selfId )

	--删除自己....
	SetCharacterDieTime( sceneId, selfId, 3000 )

	--开启乌老大死亡的计时器....
	--local x,z = GetWorldPos( sceneId, selfId )
	--CallScriptFunction( x890066_g_FuBenScriptId, "OpenMuRongFuDieTimer", sceneId, 4, x890066_g_ScriptId, x, z )

	--设置已经挑战过乌老大....
	CallScriptFunction( x890066_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "MuRongFu", 2 )

	--如果还没有挑战过双子则可以挑战双子....
	if 2 ~= CallScriptFunction( x890066_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "DingChunQiu" )	then
		CallScriptFunction( x890066_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "DingChunQiu", 1 )
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
		str = format("少室山#Y慕容复#W：咳、咳、咳，虽然我大燕兴复无望，#cFF0000但是#cFF0000#{_INFOUSR%s}#W你也不要得意，其他的兄弟会为我报仇的！", playerName); --乌老大
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
			if rand < 50 then
				local WuPin = random( getn(x890066_LootItem_1) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890066_LootItem_1[WuPin] )

			end

			rand = random(100)
			if rand < 50 then
				local WuPin = random( getn(x890066_LootItem_1) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890066_LootItem_1[WuPin] )

			end

			rand = random(100)
			if rand < 50 then
				local WuPin = random( getn(x890066_LootItem_2) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890066_LootItem_2[WuPin]  )
			end			rand = random(100)
			if rand < 10 then
				local WuPin = random( getn(x890066_LootItem_2) )
				AddMonsterDropItem( sceneId, selfId, mems[i], x890066_LootItem_2[WuPin]  )
			end

		end
	end

end


--**********************************
--重置AI....
--**********************************
function x890066_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_KuangBaoMode, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillFH, x890066_SkillCD_FH )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillG, x890066_SkillCD_G )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillH, x890066_SkillCD_H )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_Talk, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x890066_IDX_CombatFlag, 0 )

	--给所有玩家清除FH的buff....
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x890066_BuffID_F1 )
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x890066_BuffID_H )
		end
	end

end


--**********************************
--FH技能心跳....
--**********************************
function x890066_TickSkillFH( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent <= 0.3333 or CurPercent > 0.6333 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillFH )
	if cd > nTick then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillFH, cd-nTick )
		return 0

	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillFH, x890066_SkillCD_FH-(nTick-cd) )
		return x890066_UseSkillF( sceneId, selfId )
	end

end


--**********************************
--G技能心跳....
--**********************************
function x890066_TickSkillG( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent <= 0.6666 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillG )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillG, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillG, x890066_SkillCD_G-(nTick-cd) )
		return x890066_UseSkillG( sceneId, selfId )
	end

end

--**********************************
--H技能心跳....
--**********************************
function x890066_TickSkillH( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.3333 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillH )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillH, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_CD_SkillH, x890066_SkillCD_H-(nTick-cd) )
		return x890066_UseSkillH( sceneId, selfId )
	end

end

--**********************************
--I技能心跳....
--**********************************
function x890066_TickSkillI( sceneId, selfId, nTick )

	--获得当前狂暴mode....
	local CurMode = MonsterAI_GetIntParamByIndex( sceneId, selfId, x890066_IDX_KuangBaoMode )

	if CurMode == 0 or CurMode == 2 then

		--如果不需要狂暴或者已经狂暴了则返回....
		return 0

	elseif CurMode == 1 then

		--如果需要狂暴则使用狂暴技能....
		local ret =  x890066_UseSkillI( sceneId, selfId )
		if ret == 1 then
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x890066_IDX_KuangBaoMode, 2 )
			return 1
		else
			return 0
		end

	end

end


--**********************************
--使用F技能....
--**********************************
function x890066_UseSkillF( sceneId, selfId )

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
	LuaFnUnitUseSkill( sceneId, selfId, x890066_SkillID_F, PlayerId, x, z, 0, 1 )
	CallScriptFunction((200060), "Paopao",sceneId, "慕容复", "少室山", "慕容复：哼，不想你们同伴死的很惨就尽情放马过来吧，本人绝不还手！此后莫说本公子恃强凌弱！" )
	MonsterTalk( sceneId, -1, "", "请注意攻击强度，慕容复会将所有伤害转嫁给"..GetName( sceneId, PlayerId ).."，所有人的攻击都会伤害他！" )

	--给玩家加结束后回调脚本的buff....
	LuaFnSendSpecificImpactToUnit( sceneId, PlayerId, PlayerId, PlayerId, x890066_BuffID_F1, 0 )

	return 1

end


--**********************************
--使用G技能....
--**********************************
function x890066_UseSkillG( sceneId, selfId )


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
	LuaFnUnitUseSkill( sceneId, selfId, x890066_SkillID_G, selfId, x, z, 0, 1 )

	--在该玩家脚底下放陷阱....
	x,z = GetWorldPos( sceneId, PlayerId )
	CreateSpecialObjByDataIndex(sceneId, selfId, x890066_SkillID_G_SpecObj, x, z, 0)

	CallScriptFunction((200060), "Paopao",sceneId, "慕容复", "少室山", "慕容复：我慕容世家武学渊源，打你们根本无需我动用自家绝技！" )
	return 1

end


--**********************************
--使用H技能....
--**********************************
function x890066_UseSkillH( sceneId, selfId )

	--使用空技能....
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x890066_SkillID_H, selfId, x, z, 0, 1 )
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x890066_SkillID_J, selfId, x, z, 0, 1 )

		MonsterTalk( sceneId, -1, "", "请注意攻击强度，慕容复会将所有人的伤害反弹！！" )
		CallScriptFunction((200060), "Paopao",sceneId, "慕容复", "少室山", "看来我还有些低估你们了，让你们看下慕容家的绝技以彼之道还施彼身！！" )

		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
				x,z = GetWorldPos( sceneId, nHumanId )
				LuaFnSendSpecificImpactToUnit( sceneId, nHumanId, nHumanId, nHumanId, x890066_BuffID_H, 0 )
			end
		end

	return 1

end


--**********************************
--使用I技能....
--**********************************
function x890066_UseSkillI( sceneId, selfId )

	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890066_BuffID_I1, 5000 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x890066_BuffID_I2, 5000 )

	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x890066_SkillID_I, selfId, x, z, 0, 1 )

	MonsterTalk( sceneId, -1, "", "#{PMF_20080530_02}" )

	return 1

end


--**********************************
--暗雷和烟花的buff结束的时候回调本接口....
--**********************************
function x890066_OnImpactFadeOut( sceneId, selfId, impactId )

	--寻找BOSS....
	local bossId = -1
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x890066_MyName == GetName( sceneId, MonsterId ) then
			bossId = MonsterId
		end
	end

	--没找到则返回....
	if bossId == -1 then
		return
	end

	--如果是烟花的buff则让BOSS喊话....
	if impactId == 19629 then
		local PlayNowHp = GetHp( sceneId, selfId )
		local LastHp = CallScriptFunction( x890066_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PlayHp" )
		if LastHp > PlayNowHp then
			local nMonsterNum = GetMonsterCount( sceneId )
			for i=0, nMonsterNum-1 do
				local MonsterId = GetMonsterObjID(sceneId, i)
				if GetName(sceneId, MonsterId) == "慕容复" and LuaFnIsCharacterLiving(sceneId, MonsterId) == 1 then
				   LuaFnSendSpecificImpactToUnit(sceneId, MonsterId, MonsterId, MonsterId, 19630, 0)
		              end
	              end
              end

		CallScriptFunction( x890066_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "PlayHp", PlayNowHp )

		return
	end

end
