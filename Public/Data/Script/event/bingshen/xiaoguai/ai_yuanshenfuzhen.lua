--兵圣奇阵 元神符阵
--2019-10-27 14:14:53 逍遥子
--脚本号
x894095_g_ScriptId	= 894095

--副本逻辑脚本号....
x894095_g_FuBenScriptId = 894063

x894095_MyName			= "元神符阵"	--自己的名字....
x894095_BrotherName			= "耶律连城·元神"	--自己的名字....


--**********************************
--初始化....
--**********************************
function x894095_OnInit(sceneId, selfId)


end


--**********************************
--心跳....
--**********************************
function x894095_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x894095_IDX_CombatFlag ) then
		return
	end

	--靠近给BUFF....
	local x,z = GetWorldPos(sceneId,selfId)
	local MonsterId, DogX, DogZ
	local nMonsterNum = GetMonsterCount( sceneId )
	for i=0, nMonsterNum-1 do
		local MonsterId = GetMonsterObjID(sceneId, i)
		if GetName(sceneId, MonsterId) == x894095_BrotherName then
		local	DogX, DogZ = GetWorldPos( sceneId, MonsterId )
		end
	end
	if (x - DogX) * (x - DogX) + (z - DogZ) * (z - DogZ) < 10*10 then
		LuaFnSendSpecificImpactToUnit( sceneId, MonsterId, MonsterId, MonsterId, 8864, 0 )
	end

end


--**********************************
--进入战斗....
--**********************************
function x894095_OnEnterCombat(sceneId, selfId, enmeyId)

end


--**********************************
--离开战斗....
--**********************************
function x894095_OnLeaveCombat(sceneId, selfId)

end


--**********************************
--杀死敌人....
--**********************************
function x894095_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x894095_OnDie( sceneId, selfId, killerId )

	--重置AI....
	x894095_ResetMyAI( sceneId, selfId )

end


--**********************************
--重置AI....
--**********************************
function x894095_ResetMyAI( sceneId, selfId )

end
