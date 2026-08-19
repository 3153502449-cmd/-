x124505_TBL = 
{
IDX_TimerPrepare = 1,
IDX_TimerInterval = 2,
IDX_FlagCombat = 1,
BossSkill = 1002,
PrepareTime = 60000,
SkillInterval = 60000,
BossBuff = 9999
}

function x124505_OnDie( sceneId, selfId, killerId )
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124505_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124505_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124505_TBL.IDX_FlagCombat, 0)

	local szNpcName = GetName(sceneId, selfId)

	if szNpcName == "探花"  then
		LuaFnNpcChat(sceneId, selfId, 0, "长江后浪推前浪，俺败了！")
		x124505_ClearMonsterByName(sceneId, "无")
		x124505_TipAllHuman( sceneId, "已战胜  探花  1/1" )
		
	elseif szNpcName == "榜眼"  then
		LuaFnNpcChat(sceneId, selfId, 0, "万般皆是命，半点不由人！")
		x124505_ClearMonsterByName(sceneId, "无")
		x124505_TipAllHuman( sceneId, "已战胜  榜眼  1/1" )
		
	elseif szNpcName == "比武状元"  then
		LuaFnNpcChat(sceneId, selfId, 0, "#G中原武林人才辈出，卧虎藏龙，在下认输！")
		x124505_ClearMonsterByName(sceneId, "无")
		x124505_ClearMonsterByName(sceneId, "无")
		x124505_TipAllHuman( sceneId, "已战胜  比武状元  1/1" )
		
		if LuaFnGetCopySceneData_Param(sceneId, 8) == 12  then
			LuaFnSetCopySceneData_Param(sceneId, 8, 14)
		end
	end
end

function x124505_OnHeartBeat(sceneId, selfId, nTick)
end

function x124505_OnInit(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124505_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124505_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124505_TBL.IDX_FlagCombat, 0)
end

function x124505_OnKillCharacter(sceneId, selfId, targetId)
end

function x124505_OnEnterCombat(sceneId, selfId, enmeyId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124505_TBL.IDX_TimerPrepare, x124505_TBL.PrepareTime)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124505_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124505_TBL.IDX_FlagCombat, 1)
end

function x124505_OnLeaveCombat(sceneId, selfId)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124505_TBL.IDX_TimerPrepare, 0)
	MonsterAI_SetIntParamByIndex(sceneId, selfId, x124505_TBL.IDX_TimerInterval, 0)
	MonsterAI_SetBoolParamByIndex(sceneId, selfId, x124505_TBL.IDX_FlagCombat, 0)
end


function x124505_ClearMonsterByName(sceneId, szName)
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum-1 do
		local nMonsterId = GetMonsterObjID(sceneId,i)
		if GetName(sceneId, nMonsterId)== szName  then
			LuaFnDeleteMonster(sceneId, nMonsterId)
		end
	end
end

function x124505_TipAllHuman( sceneId, Str )
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanNum < 1 then
		return
	end
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		BeginEvent(sceneId)
			AddText(sceneId, Str)
		EndEvent(sceneId)
		DispatchMissionTips(sceneId, PlayerId)
	end
end
