--桃花岛-劝君酒
--2019-12-7 12:55:41 逍遥子
x808288_g_scriptId = 808288
--**********************************
--劝君酒激发
function x808288_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
function x808288_OnImpactFadeOut( sceneId, selfId, impactId )
    
    x808288_StartQuanJunJiu( sceneId, selfId )
end
function x808288_StartQuanJunJiu( sceneId, selfId )
	local nObjID = GetMissionData(sceneId,selfId,MD_TAOHUADAO_KUILEI_OBJID);
	local nPosX,nPosY = LuaFnGetUnitPosition(sceneId, selfId);
	local nKPosX,nKPosY = LuaFnGetUnitPosition(sceneId, nObjID);
	local nDistance = floor(sqrt((nKPosX-nPosX)*(nKPosX-nPosX)+(nKPosY-nPosY)*(nKPosY-nPosY)))
	if nDistance > 12 then
		x808288_Tips( sceneId, selfId, "#{MHCJ_181128_71}" )
		return
	end
	--共情消耗
	local nRage = GetRage(sceneId,selfId);
	SetRage(sceneId,selfId,nRage - 120);
	--枚举角色ID
	local PlayerList = {};
	local numPlayer = 0;
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId);
	for i = 0, nHumanCount - 1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i);
		if IsInDist( sceneId, nHumanId, selfId, 11 ) == 1 and selfId ~= nHumanId and 1 == LuaFnUnitIsEnemy(sceneId, nHumanId, selfId) and LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			nPosX,nPosY = LuaFnGetUnitPosition(sceneId, nHumanId);
			nDistance = floor(sqrt((nKPosX-nPosX)*(nKPosX-nPosX)+(nKPosY-nPosY)*(nKPosY-nPosY)))
			if nDistance <= 5 then
				numPlayer = numPlayer + 1;
				PlayerList[numPlayer] = nHumanId;
			end
		end
	end
	if numPlayer < 1 then
		return
	end
	local nRandMax = numPlayer
	if nRandMax > 5 then
		nRandMax = 5;
	end
	
	for i = 1,nRandMax do
		--拉至附近
		local nRandIndex = random(1,numPlayer);
		local nRandX = random(-2,2) + nKPosX
		local nRandZ = random(-2,2) + nKPosY
		SetPos(sceneId,PlayerList[nRandIndex],nRandX,nRandZ)
		--给予impact-暗伤标记10s
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, PlayerList[nRandIndex], 13714, 0);
		--底层增加代码 LuaFnXYZIsCharacterImpactOfSubMoveSpeed(sceneId,objId);
--		if LuaFnXYZIsCharacterImpactOfSubMoveSpeed(sceneId,PlayerList[nRandIndex]) == 1 then
--			--带减速效果
--			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, PlayerList[nRandIndex], 13719, 0);
--			return
--		end
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, PlayerList[nRandIndex], 13720, 0);
	end
end