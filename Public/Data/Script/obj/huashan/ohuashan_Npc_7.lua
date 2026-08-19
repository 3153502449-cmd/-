x124502_TBL = 
{
IDX_TimerPrepare = 1,
IDX_TimerInterval = 2,
IDX_FlagCombat = 1,
BossSkill = 1002,
PrepareTime = 60000,
SkillInterval = 60000,
BossBuff = 9999
}

function x124502_OnDie( sceneId, selfId, killerId )
	LuaFnNpcChat(sceneId, selfId, 0, "厉害！在下甘拜下风。")
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124502_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124502_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124502_TBL.IDX_FlagCombat, 0)

	if LuaFnGetCopySceneData_Param(sceneId, 8) == 5  then
		LuaFnSetCopySceneData_Param(sceneId, 8, 6)
	end

end

function x124502_OnHeartBeat(sceneId, selfId, nTick)
end

function x124502_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124502_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124502_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124502_TBL.IDX_FlagCombat, 0)
end

function x124502_OnKillCharacter(sceneId, selfId, targetId)
end

function x124502_OnEnterCombat(sceneId, selfId, enmeyId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124502_TBL.IDX_TimerPrepare, x124502_TBL.PrepareTime)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124502_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124502_TBL.IDX_FlagCombat, 1)
end

function x124502_OnLeaveCombat(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124502_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124502_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124502_TBL.IDX_FlagCombat, 0)
end

