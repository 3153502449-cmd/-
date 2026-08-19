--技能
x899039_g_scriptId = 899039
--**********************************************************************************
function x899039_OnImpactFadeOut( sceneId, selfId, impactId )   
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	local objType = GetCharacterType( sceneId, targetId )
	local menpai = GetMenPai( sceneId, selfId )
	
	if LuaFnIsObjValid(sceneId, targetId) ~= 1 then
		return
	end

	if GetHp( sceneId, selfId ) == 0  or GetHp( sceneId, targetId ) == 0 or selfId == targetId or (LuaFnUnitIsEnemy(sceneId, selfId, targetId) ~= 1 )  then
		return
	end
	
	if GetHp( sceneId, selfId ) == 0  or GetHp( sceneId, targetId ) == 0 or selfId == targetId or (LuaFnUnitIsEnemy(sceneId, selfId, targetId) ~= 1 )  then
		return
	end	
	---下限特殊处理
	local JieKou = {SYS_ICE_SUB_LIMIT,SYS_FIRE_SUB_LIMIT,SYS_LIGHT_SUB_LIMIT,SYS_POSION_SUB_LIMIT}
	local NewSanHai = 0--减少目标抗性
	for i = 1,4 do
	   NewSanHai = NewSanHai + GetMissionData( sceneId, selfId, JieKou[i] )
	end
	   sanhai = NewSanHai * 10  -- 这里100 = 500
	--下限特殊处理
	if sanhai <=0  then
		return
	end   	
	if LuaFnIsUnbreakable(sceneId,targetId) >= 1 then--目标处于无敌状态
		x899039_NotifyTip( sceneId, selfId, "目标处于无敌状态" )
		return
	end	
	if objType == 1 then --objType等于1是人，objType等于2是怪，objType等于3是宠
		LuaFnSetDamage(sceneId, selfId, targetId,sanhai)		
	elseif objType == 3 then
		LuaFnSetDamage(sceneId, selfId, targetId,sanhai)		
	elseif objType == 2  then
		LuaFnSetDamage(sceneId, selfId, targetId,sanhai)
	end	
end

--**********************************
--醒目提示
--**********************************
function x899039_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
	AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--PDJZVMRU作式了中以我些开

--代上了要发我些展58158148