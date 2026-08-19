--兵圣奇阵 耶律连城
--2019-10-27 13:34:42 逍遥子二开

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
x894069_g_ScriptId	= 894069

--副本逻辑脚本号....
x894069_g_FuBenScriptId = 894063

--免疫Buff....
x894069_Buff_MianYi1	= 10472	--免疫一些负面效果....
x894069_Buff_MianYi2	= 10471	--免疫普通隐身....

--技能....
x894069_SkillID_F		= 1820  --普通攻击
x894069_SkillID_F2		= 1821
x894069_BuffID_F		= 8851

--石堆
x894069_SkillID_G		= 1822

x894069_SkillID_H		= 1823
x894069_BuffID_H		= 19741

x894069_SkillID_I		= 1036
x894069_BuffID_I1		= 10253
x894069_BuffID_I2		= 10254

x894069_SkillID_J		= 1824
x894069_BuffID_J		= 8834

x894069_SkillCD_FH	=	8000
x894069_SkillCD_G		=	45000
x894069_SkillCD_J	=	31000
x894069_SkillCD_H		=	60000
x894069_SkillCD_K	=	5000


x894069_MyName			= "耶律连城"	--自己的名字....

--AI Index....
x894069_IDX_KuangBaoMode	= 1	--狂暴模式....0未狂暴 1需要进入狂暴 2已经进入狂暴
x894069_IDX_CD_SkillFH		= 2	--FH技能的CD....
x894069_IDX_CD_SkillG			= 3	--G技能的CD....
x894069_IDX_CD_Talk				= 4	--FH技能喊话的CD....
x894069_IDX_CD_SkillJ			= 5	--G技能的CD....
x894069_IDX_CD_SkillH			= 6	--G技能的CD....
x894069_IDX_CD_SkillK			= 7	--G技能的CD....

x894069_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....

--**********************************
--初始化....
--**********************************
function x894069_OnInit(sceneId, selfId)
	--重置AI....
	x894069_ResetMyAI( sceneId, selfId )
end


--**********************************
--心跳....
--**********************************
function x894069_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x894069_IDX_CombatFlag ) then
		return
	end

	--FH技能心跳....
	if 1 == x894069_TickSkillFH( sceneId, selfId, nTick ) then
		return
	end

	--G技能心跳....
	if 1 == x894069_TickSkillG( sceneId, selfId, nTick ) then
		return
	end

	--H技能心跳....
	if 1 == x894069_TickSkillH( sceneId, selfId, nTick ) then
		return
	end

	--I技能心跳....
	if 1 == x894069_TickSkillI( sceneId, selfId, nTick ) then
		return
	end

	--J技能心跳....
	if 1 == x894069_TickSkillJ( sceneId, selfId, nTick ) then
		return
	end

	--K技能心跳....
	if 1 == x894069_TickSkillK( sceneId, selfId, nTick ) then
		return
	end
end


--**********************************
--进入战斗....
--**********************************
function x894069_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x894069_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x894069_Buff_MianYi2, 0 )

	--重置AI....
	x894069_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x894069_IDX_CombatFlag, 1 )
	
	--公告
	CallScriptFunction((200060), "Paopao",sceneId, "耶律连城", "兵圣奇阵", "#{BSQZ_101223_177}" )
	CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_178}" )
end


--**********************************
--离开战斗....
--**********************************
function x894069_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x894069_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )

	--创建对话NPC....
	local MstId = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "LiFan_NPC", -1, -1 )
	SetUnitReputationID( sceneId, MstId, MstId, 0 )
end


--**********************************
--杀死敌人....
--**********************************
function x894069_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x894069_OnDie( sceneId, selfId, killerId )

	--重置AI....
	x894069_ResetMyAI( sceneId, selfId )

	--设置已经挑战过耶律连城....
	CallScriptFunction( x894069_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "YeLvLian", 2 )

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
	
	--公告
	CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_176}" )
	
	CallScriptFunction(892921,"GetDBNum",sceneId, killerId,2)
	if playerName ~= nil then
		str = format("#P躲过#G耶律连城P的必杀秘技后，#{_INFOUSR%s}#P心有余悸的坐在一块岩石之上。兀自叹息间，刚受秘技洗礼又遭重力侵袭的岩石便碎裂开来，诸多石屑当中#G宝物#P应声落地。", playerName); --耶律连城
		AddGlobalCountNews( sceneId, str )
	end


end


--**********************************
--重置AI....
--**********************************
function x894069_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_KuangBaoMode, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillFH, x894069_SkillCD_FH )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillG, x894069_SkillCD_G )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillJ, x894069_SkillCD_J )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillH, x894069_SkillCD_H )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillK, x894069_SkillCD_K )

	MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_Talk, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x894069_IDX_CombatFlag, 0 )

	--给所有玩家清除FH的buff....
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 then
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x894069_BuffID_F )
			LuaFnCancelSpecificImpact( sceneId, nHumanId, x894069_BuffID_H )
		end
	end

end


--**********************************
--FH技能心跳....
--**********************************
function x894069_TickSkillFH( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillFH )
	if cd > nTick then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillFH, cd-nTick )
		return 0

	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillFH, x894069_SkillCD_FH-(nTick-cd) )
		return x894069_UseSkillF( sceneId, selfId )
	end

end


--**********************************
--G技能心跳....
--**********************************
function x894069_TickSkillG( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent < 0.6666 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillG )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillG, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillG, x894069_SkillCD_G-(nTick-cd) )
		return x894069_UseSkillG( sceneId, selfId )
	end

end

--**********************************
--H技能心跳....
--**********************************
function x894069_TickSkillH( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.6 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillH )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillH, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillH, x894069_SkillCD_H-(nTick-cd) )
		return x894069_UseSkillH( sceneId, selfId )
	end

end

--**********************************
--J技能心跳....
--**********************************
function x894069_TickSkillJ( sceneId, selfId, nTick )

	local CurPercent = GetHp( sceneId, selfId ) / GetMaxHp( sceneId, selfId )
	if CurPercent > 0.2 then
		return 0
	end

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillJ )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillJ, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillJ, x894069_SkillCD_J-(nTick-cd) )
		return x894069_UseSkillJ( sceneId, selfId )
	end

end

--**********************************
--K技能心跳....
--**********************************
function x894069_TickSkillK( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillK )
	if cd > nTick then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillK, cd-nTick )
		return 0
	else
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_CD_SkillK, x894069_SkillCD_K-(nTick-cd) )
		return x894069_UseSkillK( sceneId, selfId )
	end

end
--**********************************
--I技能心跳....
--**********************************
function x894069_TickSkillI( sceneId, selfId, nTick )

	--获得当前狂暴mode....
	local CurMode = MonsterAI_GetIntParamByIndex( sceneId, selfId, x894069_IDX_KuangBaoMode )

	if CurMode == 0 or CurMode == 2 then

		--如果不需要狂暴或者已经狂暴了则返回....
		return 0

	elseif CurMode == 1 then

		--如果需要狂暴则使用狂暴技能....
		local ret =  x894069_UseSkillI( sceneId, selfId )
		if ret == 1 then
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x894069_IDX_KuangBaoMode, 2 )
			return 1
		else
			return 0
		end

	end

end


--**********************************
--使用F技能....
--**********************************
function x894069_UseSkillF( sceneId, selfId )

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
	LuaFnUnitUseSkill( sceneId, selfId, x894069_SkillID_F, PlayerId, x, z, 0, 1 )

	--给玩家加结束后回调脚本的buff....
	LuaFnSendSpecificImpactToUnit( sceneId, PlayerId, PlayerId, PlayerId, x894069_BuffID_F, 0 )

	--对自己使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894069_SkillID_F2, selfId, x, z, 0, 1 )

	return 1

end


--**********************************
--使用G技能....
--**********************************
function x894069_UseSkillG( sceneId, selfId )

	--对其使用技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894069_SkillID_G, selfId, x, z, 0, 1 )

	CallScriptFunction((200060), "Paopao",sceneId, "耶律连城", "兵圣奇阵", "#{BSQZ_101223_109}" )
	CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_110}" )

	local MstIdA = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "ShiDui_BOSSA", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdA, MstIdA, MstIdA, 8857, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8859, 0 )
	SetCharacterDieTime( sceneId, MstIdA, 30000 )

	local MstIdB = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "ShiDui_BOSSB", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdB, MstIdB, MstIdB, 8857, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8859, 0 )
	SetCharacterDieTime( sceneId, MstIdB, 30000 )

	local MstIdC = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "ShiDui_BOSSC", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdC, MstIdC, MstIdC, 8857, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8859, 0 )
	SetCharacterDieTime( sceneId, MstIdC, 30000 )

	local MstIdD = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "ShiDui_BOSSD", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdD, MstIdD, MstIdD, 8857, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8859, 0 )
	SetCharacterDieTime( sceneId, MstIdD, 30000 )

	local MstIdE = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "ShiDui_BOSSE", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdE, MstIdE, MstIdE, 8858, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8859, 0 )
	SetCharacterDieTime( sceneId, MstIdE, 30000 )

	local MstIdF = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "ShiDui_BOSSF", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdF, MstIdF, MstIdF, 8858, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8859, 0 )
	SetCharacterDieTime( sceneId, MstIdF, 30000 )

	local MstIdG = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "ShiDui_BOSSG", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdG, MstIdG, MstIdG, 8858, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8859, 0 )
	SetCharacterDieTime( sceneId, MstIdG, 30000 )

	local MstIdH = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "ShiDui_BOSSH", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdH, MstIdH, MstIdH, 8858, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8859, 0 )
	SetCharacterDieTime( sceneId, MstIdH, 30000 )

       --自己隐身
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8852, 0 )

	return 1

end


--**********************************
--使用H技能....
--**********************************
function x894069_UseSkillH( sceneId, selfId )

	--对其使用技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894069_SkillID_H, selfId, x, z, 0, 1 )

	CallScriptFunction((200060), "Paopao",sceneId, "耶律连城", "兵圣奇阵", "#{BSQZ_101223_111}" )
	CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_112}" )
	CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_175}" )
	CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_195}" )

	local x,z = GetWorldPos( sceneId, selfId )
	local MstIdI = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "TieGu_BOSS", x, z )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdI, MstIdI, MstIdI, 8857, 0 )

	local x,z = GetWorldPos( sceneId, selfId )
	local MstIdJ = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "YuanShen_BOSS", x, z )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdJ, MstIdJ, MstIdJ, 8858, 0 )

	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8853, 0 )

	local MstIdK = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "TieFuZhen_BOSS", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdK, MstIdK, MstIdK, 8866, 0 )
	SetCharacterDieTime( sceneId, MstIdK, 60000 )

	local MstIdL = CallScriptFunction( x894069_g_FuBenScriptId, "CreateBOSS", sceneId, "YuanFuZhen_BOSS", -1, -1 )
	LuaFnSendSpecificImpactToUnit( sceneId, MstIdL, MstIdL, MstIdL, 8867, 0 )
	SetCharacterDieTime( sceneId, MstIdL, 60000 )

	return 1

end

--**********************************
--使用J技能....
--**********************************
function x894069_UseSkillJ( sceneId, selfId )

	CallScriptFunction((200060), "Paopao",sceneId, "耶律连城", "兵圣奇阵", "#{BSQZ_101223_197}" )
	CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "#{BSQZ_101223_198}" )

	--对自己使用空技能....
	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894069_SkillID_J, selfId, x, z, 0, 1 )

	CallScriptFunction( x894069_g_FuBenScriptId, "OpenBQZTimer", sceneId, 30, x894069_g_ScriptId, -1 ,-1 )

	return 1


end

--**********************************
--使用I技能....
--**********************************
function x894069_UseSkillK( sceneId, selfId )

	local nCount = GetMonsterCount(sceneId)
	for i=0, nCount-1  do
		local nObjId = GetMonsterObjID(sceneId, i)
		local MosDataID = GetMonsterDataID( sceneId, nObjId )
		if MosDataID == 15085 or MosDataID == 15100 then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 8853, 0 )
		end
	end

	return 1

end

--**********************************
--使用I技能....
--**********************************
function x894069_UseSkillI( sceneId, selfId )

	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x894069_BuffID_I1, 5000 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x894069_BuffID_I2, 5000 )

	local x,z = GetWorldPos( sceneId, selfId )
	LuaFnUnitUseSkill( sceneId, selfId, x894069_SkillID_I, selfId, x, z, 0, 1 )

	CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId,  "#{BSQZ_101223_197}" )

	return 1

end


--**********************************
--暗雷和烟花的buff结束的时候回调本接口....
--**********************************
function x894069_OnImpactFadeOut( sceneId, selfId, impactId )

	--寻找BOSS....
	local bossId = -1
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x894069_MyName == GetName( sceneId, MonsterId ) then
			bossId = MonsterId
		end
	end

	--没找到则返回....
	if bossId == -1 then
		return
	end

	--如果是烟花的buff则让BOSS喊话....
	if impactId == 8859 then

		local x,z = GetWorldPos( sceneId,selfId )
		CreateSpecialObjByDataIndex(sceneId, bossId, 192, x, z, 0)

		local bok = 0
		local nMonsterNum = GetMonsterCount( sceneId )
		for i=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId, i)
			if GetName(sceneId, MonsterId) == "石堆" and LuaFnIsCharacterLiving(sceneId, MonsterId) == 1 then
		          bok = 1
			end
		end

	       if bok == 1 then
			local nMonsterNum = GetMonsterCount( sceneId )
			for i=0, nMonsterNum-1 do
				local MonsterId = GetMonsterObjID(sceneId, i)
				if GetName(sceneId, MonsterId) == "耶律连城" and LuaFnIsCharacterLiving(sceneId, MonsterId) == 1 then
				 	 LuaFnSendSpecificImpactToUnit(sceneId, MonsterId, MonsterId, MonsterId, 8861, 0)
				end
			end
		end

		return
	end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x894069_OnBQZTimer( sceneId, step, data1, data2 )
	--寻找BOSS....
	local bossId = -1
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if GetName( sceneId, MonsterId ) == "耶律连城" then
			bossId = MonsterId
		end
	end

	--没找到则返回....
	if bossId == -1 then
		return
	end
	if 30 == step then
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：30秒内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保！" )
		return
	end

	if 20 == step then
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：20秒内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保。" )
		return
	end

	if 15 == step then
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：吞天石已成阵过半，再生五座我等便将命归西天。15秒内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保！" )
		return
	end

	if 10 == step then
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：10秒内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保。" )
		return
	end

	if 6 == step then
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：6秒钟内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保。" )
		return
	end

	if 5 == step then
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：5秒钟内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保。" )
		return
	end

	if 4 == step then
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：4秒钟内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保。" )
		return
	end

	if 3 == step then
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：3秒钟内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保。" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x894069_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁：2秒内未能将耶律连城击杀，十座吞天石便将连体成阵，我等定会性命不保。" )
		return
	end

	if 1 == step then
		CallScriptFunction((200060), "Paopao",sceneId, "耶律连城", "兵圣奇阵", "#{BSQZ_101223_199}" )
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