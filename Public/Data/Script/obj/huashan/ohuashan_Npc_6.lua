x124501_TBL = 
{
IDX_TimerPrepare = 1,
IDX_TimerInterval = 2,
IDX_FlagCombat = 1,
BossSkill = 1002,
PrepareTime = 60000,
SkillInterval = 60000,
BossBuff = 9999
}

function x124501_OnDie( sceneId, selfId, killerId )
	
	LuaFnNpcChat(sceneId, selfId, 0, "自古武功出少林，没想到我竟然败于你，阿尼陀佛。")
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124501_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124501_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124501_TBL.IDX_FlagCombat, 0)
	
	LuaFnSetCopySceneData_Param(sceneId, 8, 4)
end

function x124501_OnHeartBeat(sceneId, selfId, nTick)
end

function x124501_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124501_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124501_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124501_TBL.IDX_FlagCombat, 0)
end

function x124501_OnKillCharacter(sceneId, selfId, targetId)
end

function x124501_OnEnterCombat(sceneId, selfId, enmeyId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124501_TBL.IDX_TimerPrepare, x124501_TBL.PrepareTime)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124501_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124501_TBL.IDX_FlagCombat, 1)
end

function x124501_OnLeaveCombat(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124501_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124501_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124501_TBL.IDX_FlagCombat, 0)
end

