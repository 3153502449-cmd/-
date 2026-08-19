--兵圣奇阵 耶律彦
--2019-10-27 13:42:27 逍遥子二开

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
x894066_g_ScriptId	= 894066

--副本逻辑脚本号....
x894066_g_FuBenScriptId = 894063

--免疫Buff....
x894066_Buff_MianYi1	= 10472	--免疫一些负面效果....
x894066_Buff_MianYi2	= 10471	--免疫普通隐身....

--技能....
x894066_SkillID_F		= 1809
x894066_SkillID_F2		= 1810
x894066_BuffID_F1		= 8833

x894066_SkillID_G		= 1811
x894066_SkillID_G_SpecObj		= 188

x894066_SkillID_H		= 1813
x894066_SkillD_SpecObj = 190

x894066_SkillID_I		= 1814

x894066_SkillID_J		= 1817
x894066_SkillID_J2		= 1818
x894066_BuffID_J2		= 8835

x894066_SkillCD_FH	=	6000
x894066_SkillCD_G		=	45000
x894066_SkillCD_H	=	25000
x894066_SkillCD_I	=	50000
x894066_SkillCD_J	=	30000

x894066_MyName			= "耶律焱"	--自己的名字....

--AI Index....
x894066_IDX_KuangBaoMode	= 1	--狂暴模式....0未狂暴 1需要进入狂暴 2已经进入狂暴
x894066_IDX_CD_SkillFH		= 2	--FH技能的CD....
x894066_IDX_CD_SkillG			= 3	--G技能的CD....
x894066_IDX_CD_Talk				= 4	--FH技能喊话的CD....
x894066_IDX_CD_SkillI			= 5	--G技能的CD....
x894066_IDX_CD_SkillJ			= 6	--G技能的CD....
x894066_IDX_CD_SkillH			= 7	--H技能的CD....
x894066_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....

--**********************************
--初始化....
--**********************************
function x894066_OnInit(sceneId, selfId)
	--重置AI....
	x894066_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x894066_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x894066_IDX_CombatFlag ) then
		return
	end

	--FH技能心跳....
	if 1 == x894066_TickSkillFH( sceneId, selfId, nTick ) then
		return
	end

	--G技能心跳....
	if 1 == x894066_TickSkillG( sceneId, selfId, nTick ) then
		return
	end

	--H技能心跳....
	if 1 == x894066_TickSkillH( sceneId, selfId, nTick ) then
		return
	end

	--I技能心跳....
	if 1 == x894066_TickSkillI( sceneId, selfId, nTick ) then
		return
	end

	--I技能心跳....
	if 1 == x894066_TickSkillJ( sceneId, selfId, nTick ) then
		return
	end

end


--**********************************
--进入战斗....
--**********************************
function x894066_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x894066_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x894066_Buff_MianYi2, 0 )

	--重置AI....
	x894066_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x894066_IDX_CombatFlag, 1 )

	--公告
	CallScriptFunction((200060), "Paopao",sceneId, "耶律焱", "兵圣奇阵", "#{BSQZ_101223_172}" )
	CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_173}" )
end


--**********************************
--离开战斗....
--**********************************
function x894066_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x894066_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )

	--创建对话NPC....
	local MstId = CallScriptFunction( x894066_g_FuBenScriptId, "CreateBOSS", sceneId, "YeLvYan_NPC", -1, -1 )
	SetUnitReputationID( sceneId, MstId, MstId, 0 )

end


--**********************************
--杀死敌人....
--**********************************
function x894066_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x894066_OnDie( sceneId, selfId, killerId )

	--重置AI....
	x894066_ResetMyAI( sceneId, selfId )

	--删除自己....
	SetCharacterDieTime( sceneId, selfId, 3000 )

	--设置已经挑战过耶律彦....
	CallScriptFunction( x894066_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "YeLvYan", 2 )

	--如果还没有挑战过双子则可以挑战双子....
	if 2 ~= CallScriptFunction( x894066_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "YeLvLian" )	then
		CallScriptFunction( x894066_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "YeLvLian", 1 )
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
	
	CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_171}" )
	
	if playerName ~= nil then
		str = format("#P扑灭周身焚火之后，#{_INFOUSR%s}#P在包裹之中翻找伤药：“虽说这#{_BOSS142}#P是个辽国女子，但武功招数还真不少，侵略如火、地火焚天.....#P……这是什么招数？这东西什么时候跑到我包里的？！”", playerName); --耶律彦
		AddGlobalCountNews( sceneId, str )
	end
end


--**********************************
--重置AI....
--**********************************
function x894066_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_KuangBaoMode, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillFH, x894066_SkillCD_FH )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillG, x894066_SkillCD_G )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillH, x894066_SkillCD_H )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillI, x894066_SkillCD_I )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillJ, x894066_SkillCD_J )

	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_Talk, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x894066_IDX_CombatFlag, 0 )

	--给所有玩家清除FH的buff....
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x894066_BuffID_F1 )
		end
	end

	--遍历场景里所有的怪....寻找兄弟并将其删除....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if "地府牛妖" == GetName( sceneId, MonsterId ) then
			LuaFnDeleteMonster( sceneId, MonsterId )
		end
	end

end


--**********************************
--FH技能心跳....
--**********************************
function x894066_TickSkillFH( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillFH )
	if cd > nTick then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillFH, cd-nTick )
		return 0

	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillFH, x894066_SkillCD_FH-(nTick-cd) )
		return x894066_UseSkillF( sceneId, selfId )
	end

end


--**********************************
--G技能心跳....
--**********************************
function x894066_TickSkillG( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.8333 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillG )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillG, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillG, x894066_SkillCD_G-(nTick-cd) )
		return x894066_UseSkillG( sceneId, selfId )
	end

end

--**********************************
--H技能心跳....
--**********************************
function x894066_TickSkillH( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.6333 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillH )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillH, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillH, x894066_SkillCD_H-(nTick-cd) )
		return x894066_UseSkillH( sceneId, selfId )
	end

end

--**********************************
--I技能心跳....
--**********************************
function x894066_TickSkillI( sceneId, selfId, nTick )
	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.5333 then
		return 0
	end
	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillI )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillI, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillI, x894066_SkillCD_I-(nTick-cd) )
		return x894066_UseSkillI( sceneId, selfId )
	end

end

--**********************************
--I技能心跳....
--**********************************
function x894066_TickSkillJ( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.3333 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillJ )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillJ, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894066_IDX_CD_SkillJ, x894066_SkillCD_J-(nTick-cd) )
		return x894066_UseSkillJ( sceneId, selfId )
	end

end

--**********************************
--使用F技能....
--**********************************
function x894066_UseSkillF( sceneId, selfId )

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
	LuaFnUnitUseSkill( sceneId, selfId, x894066_SkillID_F, PlayerId, x, z, 0, 1 )

	--给玩家加结束后回调脚本的buff....
	LuaFnSendSpecificImpactToUnit( sceneId, PlayerId, PlayerId, PlayerId, x894066_BuffID_F1, 0 )
	LuaFnUnitUseSkill( sceneId, selfId, x894066_SkillID_F2, selfId, x, z, 0, 1 )

	return 1

end


--**********************************
--使用G技能....
--**********************************
function x894066_UseSkillG( sceneId, selfId )


	CallScriptFunction((200060), "Paopao",sceneId, "耶律焱", "兵圣奇阵", "#{BSQZ_101223_93}" )
	CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_94}" )

	--使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894066_SkillID_G, selfId, x, z, 0, 1 )
	CreateSpecialObjByDataIndex(sceneId, selfId, 189, 200, 184, 0)
	CallScriptFunction( x894066_g_FuBenScriptId, "OpenBQZTimer", sceneId, 15, x894066_g_ScriptId, -1 ,-1 )

	return 1

end


--**********************************
--使用H技能....
--**********************************
function x894066_UseSkillH( sceneId, selfId )

	--使用空技能....
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, x894066_SkillID_H, selfId, x, z, 0, 1 )

		CallScriptFunction((200060), "Paopao",sceneId, "耶律焱", "兵圣奇阵", "#{BSQZ_101223_95}" )
		CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_96}" )

		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			local  	x,z = GetWorldPos( sceneId, nHumanId )
				CreateSpecialObjByDataIndex(sceneId, selfId, x894066_SkillD_SpecObj, x, z, 0)
			end
		end

	return 1

end


--**********************************
--使用I技能....
--**********************************
function x894066_UseSkillI( sceneId, selfId )

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
	local PlayerIdA = PlayerList[ random(numPlayer) ]
	local PlayerIdB = PlayerList[ random(numPlayer) ]

	--对自己使用一个空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894066_SkillID_I, selfId, x, z, 0, 1 )

         local	x,z = GetWorldPos( sceneId,selfId )
	local MstIdA = CallScriptFunction( x894066_g_FuBenScriptId, "CreateBOSS", sceneId, "HuoNiu_BOSS", x, z )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdA, PlayerIdA, MstIdA, 8843, 0 )

	local x,z = GetWorldPos( sceneId, selfId )
	local MstIdC = CallScriptFunction( x894066_g_FuBenScriptId, "CreateBOSS", sceneId, "HuoNiu_BOSS", x, z )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdC, PlayerIdA, MstIdC, 8843, 0 )

	local x,z = GetWorldPos( sceneId, selfId )
	local MstIdB = CallScriptFunction( x894066_g_FuBenScriptId, "CreateBOSS", sceneId, "HuoNiu_BOSS", x, z )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdB, PlayerIdB, MstIdB, 8843, 0 )

	local x,z = GetWorldPos( sceneId, selfId )
	local MstIdD = CallScriptFunction( x894066_g_FuBenScriptId, "CreateBOSS", sceneId, "HuoNiu_BOSS", x, z )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdD, PlayerIdB, MstIdD, 8843, 0 )

	CallScriptFunction((200060), "Paopao",sceneId, "耶律焱", "兵圣奇阵", "#{BSQZ_101223_97}#c2ebeff"..GetName( sceneId, PlayerIdA )..","..GetName( sceneId, PlayerIdB ).."#{BSQZ_101223_98}" )
	CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_99}" )

	return 1

end

--**********************************
--使用J技能....
--**********************************
function x894066_UseSkillJ( sceneId, selfId )

	CallScriptFunction((200060), "Paopao",sceneId, "耶律焱", "兵圣奇阵", "#{BSQZ_101223_100}" )
	CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_101}" )

	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
		         local	x,z = GetWorldPos( sceneId, selfId )
			LuaFnUnitUseSkill( sceneId, selfId, x894066_SkillID_J, nHumanId, x, z, 0, 1 )
		end
	end

	--对其使用技能....
	local x,z = GetWorldPos( sceneId, PlayerId )
	LuaFnUnitUseSkill( sceneId, selfId, x894066_SkillID_J2, selfId, x, z, 0, 1 )

	CallScriptFunction((200060), "Paopao",sceneId, "耶律焱", "兵圣奇阵", "八脉通玄，飞火流星，天火降世，杀伐众生，看汝如何逃生！" )
	CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_103}" )

	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			--给玩家加结束后回调脚本的buff....
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, nHumanId, x894066_BuffID_J2, 0 )
		end
	end

	return 1

end

--**********************************
--暗雷和烟花的buff结束的时候回调本接口....
--**********************************
function x894066_OnImpactFadeOut( sceneId, selfId, impactId )

	--寻找BOSS....
	local bossId = -1
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x894066_MyName == GetName( sceneId, MonsterId ) then
			bossId = MonsterId
		end
	end

	--没找到则返回....
	if bossId == -1 then
		return
	end

	--如果是暗雷的buff....则让BOSS给附近的玩家加一个伤害的buff并喊话....
	if impactId == x894066_BuffID_J2 then

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
				if (x-xx)*(x-xx) + (z-zz)*(z-zz) < 10*10 then
					count = count + 1
				end
			end
		end

		if count == 0 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8834, 0 )
		elseif count == 1 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8792, 0 )
		elseif count == 2 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8793, 0 )
		elseif count == 3 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8794, 0 )
		elseif count == 4 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8795, 0 )
		elseif count == 5 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8796, 0 )
		elseif count == 6 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8797, 0 )
		elseif count == 7 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8798, 0 )
		elseif count == 8 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8799, 0 )
		elseif count == 9 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8800, 0 )
		elseif count == 10 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8801, 0 )
		elseif count == 11 then
		    LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, selfId, 8802, 0 )
		end

		return

	end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x894066_OnBQZTimer( sceneId, step, data1, data2 )

	--寻找BOSS....
	local bossId = -1
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName( sceneId, MonsterId ) == "耶律焱" then
			bossId = MonsterId
		end
	end

	--没找到则返回....
	if bossId == -1 then
		return
	end

	if 15 == step then
		CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_94}" )
		return
	end

	if 7 == step then
		CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_94}" )		
		return
	end


	if 4 == step then
		CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_94}" )
		return
	end

	if 3 == step then
		CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_94}" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x894066_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_94}" )
		return
	end

	if 1 == step then
		--伤害....
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
				LuaFnSendSpecificImpactToUnit( sceneId, bossId, bossId, nHumanId, 8834, 0 )
			end
		end
		return
	end

end
