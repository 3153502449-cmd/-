x124503_TBL = 
{
IDX_TimerPrepare = 1,
IDX_TimerInterval = 2,
IDX_FlagCombat = 1,
BossSkill = 1002,
PrepareTime = 60000,
SkillInterval = 60000,
BossBuff = 9999
}

function x124503_OnDie( sceneId, selfId, killerId )
	LuaFnNpcChat(sceneId, selfId, 0, "疼死了，下手轻点啊，你个魂淡。")
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124503_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124503_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124503_TBL.IDX_FlagCombat, 0)

	LuaFnSetCopySceneData_Param(sceneId, 8, 9)

end

function x124503_OnHeartBeat(sceneId, selfId, nTick)
end

function x124503_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124503_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124503_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124503_TBL.IDX_FlagCombat, 0)
end

function x124503_OnKillCharacter(sceneId, selfId, targetId)
end

function x124503_OnEnterCombat(sceneId, selfId, enmeyId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124503_TBL.IDX_TimerPrepare, x124503_TBL.PrepareTime)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124503_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124503_TBL.IDX_FlagCombat, 1)
end

function x124503_OnLeaveCombat(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124503_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124503_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124503_TBL.IDX_FlagCombat, 0)
end

