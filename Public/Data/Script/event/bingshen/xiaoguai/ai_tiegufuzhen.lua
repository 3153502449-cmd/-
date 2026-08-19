--脚本号
x894094_g_ScriptId	= 894094

--副本逻辑脚本号....
x894094_g_FuBenScriptId = 894063

x894094_MyName			= "铁骨符阵"	--自己的名字....
x894094_BrotherName			= "耶律连城·铁骨"	--自己的名字....


--**********************************
--初始化....
--**********************************
function x894094_OnInit(sceneId, selfId)

end


--**********************************
--心跳....
--**********************************
function x894094_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x894094_IDX_CombatFlag ) then
		return
	end

	--靠近给BUFF....
	local x,z = GetWorldPos(sceneId,selfId)
	local MonsterId, DogX, DogZ
	local nMonsterNum = GetMonsterCount( sceneId )
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId, i)
		if GetName(sceneId, MonsterId) == x894094_BrotherName then
			DogX, DogZ = GetWorldPos( sceneId, MonsterId )
		end
	end
	if (x - DogX) * (x - DogX) + (z - DogZ) * (z - DogZ) < 10*10 then
		LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, 8862, 0 )
	end

end


--**********************************
--进入战斗....
--**********************************
function x894094_OnEnterCombat(sceneId, selfId, enmeyId)


end


--**********************************
--离开战斗....
--**********************************
function x894094_OnLeaveCombat(sceneId, selfId)

	--删除自己....
	LuaFnDeleteMonster( sceneId, selfId )

end


--**********************************
--杀死敌人....
--**********************************
function x894094_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x894094_OnDie( sceneId, selfId, killerId )


end


--**********************************
--重置AI....
--**********************************
function x894094_ResetMyAI( sceneId, selfId )


end
