--脚本号
x895093_g_ScriptId	= 895093

--副本逻辑脚本号....
x895093_g_FuBenScriptId = 895063

x895093_MyName			= "耶律连城·元神"	--自己的名字....
x895093_BrotherName			= "耶律连城"	--自己的名字....

--免疫Buff....
x895093_Buff_MianYi1	= 10472	--免疫一些负面效果....
x895093_Buff_MianYi2	= 10471	--免疫普通隐身....

--D技能....
x895093_BuffD				= 19801	--简单版缥缈峰使用伤害降低了的版本....
x895093_SkillD_CD		= 5000

--AI Index....
x895093_IDX_CD_SkillD			= 1	--D技能的CD....

x895093_IDX_CombatFlag 		= 1	--是否处于战斗状态的标志....


--**********************************
--初始化....
--**********************************
function x895093_OnInit(sceneId, selfId)
	--重置AI....
	--x895093_ResetMyAI( sceneId, selfId )

end


--**********************************
--心跳....
--**********************************
function x895093_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x895093_IDX_CombatFlag ) then
		return
	end

	--D技能心跳....
	if 1 == x895093_TickSkillD( sceneId, selfId, nTick ) then
		return
	end

end


--**********************************
--进入战斗....
--**********************************
function x895093_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	--LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x895093_Buff_MianYi1, 0 )
	--LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x895093_Buff_MianYi2, 0 )

	--重置AI....
	--x895093_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	--MonsterAI_SetBoolParamByIndex( sceneId, selfId, x895093_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x895093_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	--x895093_ResetMyAI( sceneId, selfId )

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )

end


--**********************************
--杀死敌人....
--**********************************
function x895093_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x895093_OnDie( sceneId, selfId, killerId )

	--重置AI....
	--x895093_ResetMyAI( sceneId, selfId )

	--删除自己....
	SetCharacterDieTime( sceneId, selfId, 3000 )

	--遍历场景里所有的怪....寻找兄弟....给其设置需要使用狂暴技能....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x895093_BrotherName == GetName( sceneId, MonsterId ) and LuaFnIsCharacterLiving(sceneId, MonsterId) == 1 then
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, 8854, 0 )
		end
	end

	CallScriptFunction((200060), "Paopao",sceneId, "耶律连城", "兵圣奇阵", "耶律连城：元神、铁骨怎会被破，难道是天欲取吾命？！" )
	CallScriptFunction( x895093_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁道： 由于及时将分身铲除，耶律连城已元气大伤，此时不攻更待何时。" )

end


--**********************************
--重置AI....
--**********************************
--function x895093_ResetMyAI( sceneId, selfId )

	--重置参数....
	--MonsterAI_SetIntParamByIndex( sceneId, selfId, x895093_IDX_CD_SkillD, x895093_SkillD_CD )

--end


--**********************************
--ABC技能心跳....
--**********************************
function x895093_TickSkillABC( sceneId, selfId, nTick )

end


--**********************************
--D技能心跳....
--**********************************
function x895093_TickSkillD( sceneId, selfId, nTick )

	--更新技能CD....
	local cd = MonsterAI_GetIntParamByIndex( sceneId, selfId, x895093_IDX_CD_SkillD )
	if cd > nTick then

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x895093_IDX_CD_SkillD, cd-nTick )
		return 0

	else

		MonsterAI_SetIntParamByIndex( sceneId, selfId, x895093_IDX_CD_SkillD, x895093_SkillD_CD-(nTick-cd) )
		return x895093_UseSkillD( sceneId, selfId )

	end

end


--**********************************
--使用D技能....
--**********************************
function x895093_UseSkillD( sceneId, selfId )

	--遍历场景里所有的怪....寻找兄弟....给其设置需要使用狂暴技能....
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if x895093_BrotherName == GetName( sceneId, MonsterId ) and LuaFnIsCharacterLiving(sceneId, MonsterId) == 1 then
			LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, 8853, 0 )
		end
	end

end