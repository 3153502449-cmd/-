--桃花岛-高唐云散
--2019-11-24 15:02:05 逍遥子
x808284_g_scriptId = 808284
--**********************************
--BUFF回调
--**********************************
function x808284_OnImpactFadeOut( sceneId, selfId, impactId )
    x808284_StartGaoTangYunSan( sceneId, selfId )
end
function x808284_StartGaoTangYunSan( sceneId, selfId )
    x808284_Tips( sceneId, selfId, "#{MHCJ_181128_71}" )
	if GetHp( sceneId, selfId ) == 0 then
		return
	end
--	x808284_Tips( sceneId, selfId, "Success" )
	local nObjID = GetMissionData(sceneId,selfId,MD_TAOHUADAO_KUILEI_OBJID);
	local nPosX,nPosY = LuaFnGetUnitPosition(sceneId, selfId);
	local nKPosX,nKPosY = LuaFnGetUnitPosition(sceneId, nObjID);
	local nDistance = floor(sqrt((nKPosX-nPosX)*(nKPosX-nPosX)+(nKPosY-nPosY)*(nKPosY-nPosY)))
	if nDistance > 12 then
		x808284_Tips( sceneId, selfId, "#{MHCJ_181128_71}" )
		return
	end
	--共情消耗
	local nRage = GetRage(sceneId,selfId);
	SetRage(sceneId,selfId,nRage - 10)
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
	--枚举怪物ID
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=0, nMonsterNum - 1 do
		local MonsterId = GetMonsterObjID(sceneId,i)
		if IsInDist( sceneId, MonsterId, selfId, 11 ) == 1 and nObjID ~= MonsterId and 1 == LuaFnUnitIsEnemy(sceneId, MonsterId, selfId) and LuaFnIsObjValid(sceneId, MonsterId) == 1 and LuaFnIsCharacterLiving(sceneId, MonsterId) == 1 then
			nPosX,nPosY = LuaFnGetUnitPosition(sceneId, MonsterId);
			nDistance = floor(sqrt((nKPosX-nPosX)*(nKPosX-nPosX)+(nKPosY-nPosY)*(nKPosY-nPosY)))
			if nDistance <= 5 then
				numPlayer = numPlayer+1
				PlayerList[numPlayer] = MonsterId;
			end
		end
	end
	if numPlayer < 1 then
		return
	end
	--随机造成阵法影响
	local nRand = random(1,numPlayer)
	if numPlayer < nRand then
		nRand = numPlayer;
	end
	
	local posX,posZ = LuaFnGetUnitPosition(sceneId, PlayerList[nRand]);
	for i = 1,2 do
		LuaFnUnitUseSkill( sceneId, nObjID, 1849, selfId, posX, posZ, 0, 1 )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, PlayerList[nRand], 13583, 0);
	end
	--暗伤标记
--	LuaFnSendImpactAroundPosition(sceneId, selfId, nKPosX, nKPosY, 5, -1, 1, 1,13583, 6)
end
--**********************************
--玩家屏幕中间提示
--**********************************
function x808284_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end