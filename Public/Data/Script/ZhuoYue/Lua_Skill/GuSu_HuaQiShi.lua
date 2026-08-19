--姑苏-化气式
--2019-10-3 11:42:27 逍遥子
x808239_g_ScriptId = 808239
x808239_g_Other65 = {
	[0]=947,
	[1]=948,
	[2]=949,
	[3]=950,
	[4]=951,
	[5]=952,
	[6]=953,
	[7]=954,
	[8]=955,
	[9]=0,
	[10]=0,
	[11]=956,
	[12]=957,
	[13]=958,
}
--**********************************
--事件交互入口
--**********************************
function x808239_OnImpactFadeOut( sceneId, selfId, impactId )
	local targetId = LuaFnGetTargetObjID(sceneId, selfId);
	local objType = GetCharacterType( sceneId, targetId);
	local nMenPaiId = GetMenPai( sceneId, selfId );
	if LuaFnIsObjValid(sceneId, targetId) ~= 1 then
	   return
	end
	if nMenPaiId ~= 10 then
	   return
	end
	--特殊情况
	if GetHp( sceneId, selfId ) == 0  or GetHp( sceneId, targetId ) == 0 or selfId == targetId or (LuaFnUnitIsEnemy(sceneId, selfId, targetId) ~= 1 )  then
	   x808239_NotifyTip( sceneId, selfId, "不能攻击此目标")
	   return
	end
	local nTargetMenPaiId = -1
	if objType == 1 then
		nTargetMenPaiId = GetMenPai(sceneId, targetId)
		if nTargetMenPaiId == 9 or nTargetMenPaiId == 10 then
			nTargetMenPaiId = random(8)
		end
	else
		nTargetMenPaiId = random(12)
		if nTargetMenPaiId == 9 or nTargetMenPaiId == 10 then
			nTargetMenPaiId = random(8)
		end
	end
--	  int nSkillID = lua_tonumber(L, 3);
--    int nTargetID = lua_tonumber(L, 4);
--    int nPos_X = lua_tonumber(L, 5);
--    int nPos_Y = lua_tonumber(L, 6);
--    int nDir = lua_tonumber(L, 7);
	x808239_NotifyTip( sceneId, selfId, "nSkillID "..x808239_g_Other65[nTargetMenPaiId] )
	x808239_NotifyTip( sceneId, selfId, "targetId "..targetId )
	LuaFnHumanUseSkill(sceneId,selfId,x808239_g_Other65[nTargetMenPaiId],targetId,-1,-1,-1)
end
--**********************************
--醒目提示
--**********************************
function x808239_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end


