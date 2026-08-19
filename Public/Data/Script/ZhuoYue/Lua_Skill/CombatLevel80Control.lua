--80技能强力控制控制脚本
--2019-12-2 21:58:03 逍遥子
--此处参照底层/Publuc.c Combat_MenPaiXinFa8Control(int Obj_Human, int Obj_Target, int nSkillId)代码
x808285_g_scriptId = 808285
x808285_g_ControlImpactID = 1369
--//////这里添加下门派区分不同的属性buff，不然不堆成 显示完美点
x808285_g_MinBuff = {[0] = 1370,[1] = 17000,[2] = 17030,[3] = 17060,[4] = 17090,[5] = 17120,[6] = 17150,[7] = 17180,[8] = 17210,[10] = 17240,[11] = 17270,[12] = 17300,[13] = 17330}
x808285_g_MaxBuff = {[0] = 1399,[1] = 17029,[2] = 17059,[3] = 17089,[4] = 17119,[5] = 17149,[6] = 17179,[7] = 17209,[8] = 17239,[10] = 17269,[11] = 17299,[12] = 17329,[13] = 17359}
--**********************************
--BUFF回调
--**********************************
function x808285_OnImpactFadeOut( sceneId, selfId, impactId )
	if impactId ~= x808285_g_ControlImpactID then
		LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_SKILL);
		return
	end
	local targetId = LuaFnGetTargetObjID(sceneId, selfId);
	local objType = GetCharacterType(sceneId,targetId);
	if LuaFnIsObjValid(sceneId, targetId) ~= 1 then
		LuaFnSendOResultToPlayer(sceneId, selfId, OR_TARGET_DIE);
        return
    end
	if GetHp( sceneId, selfId ) == 0 or GetHp( sceneId, targetId ) == 0 or selfId == targetId or (LuaFnUnitIsEnemy(sceneId, selfId, targetId) ~= 1 )  then
		LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET);
		return
	end
	if LuaFnIsUnbreakable(sceneId,targetId) >= 1 then
		LuaFnSendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET);
		return
	end
	--控制开始
--	int nSelfScore = pHuman->GetMissionData(XIULIAN_SCORE);
--	int nTarScore = pTarget->GetMissionData(XIULIAN_SCORE);
--	int nDetScore = nSelfScore - nTarScore;
--	if (nDetScore < 0)
--	{
--		nDetScore = 0;
--	}
	--修炼评分对比
	local nSelfScore = GetMissionData(sceneId,selfId,XIULIAN_SCORE);
	
--	//心法对比 max 4375
--	int nSelfXinfaScore = pHuman->GetMissionData(Obj_Human, XINFA_SCORE);
--	int nTarXinfaScore = pTarget->GetMissionData(Obj_Target, XINFA_SCORE);
--	int nDetXinfaScore = nSelfXinfaScore - nTarXinfaScore;
--	if (nDetXinfaScore < 0)
--	{
--		nDetXinfaScore = 0;
--	}
--	//宝石评分记入 2019-11-27 20:22:31 逍遥子
--	int nSelfGemTime = pHuman->DataPoolGetGemScore();
--	int nTarGemTime = pTarget->DataPoolGetGemScore(Obj_Target);
--	int nDetGemTime = nSelfGemTime - nTarGemTime;//这里是整秒数
	local nSelfXinfaScore = GetMissionData(sceneId,selfId,XINFA_SCORE);
	
	local nSelfGemTime = DataPoolGetGemScore(sceneId,selfId);
	
	--对方是人类
	if objType == 1 then
		local nTarScore = GetMissionData(sceneId,targetId,XIULIAN_SCORE);
		local nDetScore = nSelfScore - nTarScore;
		if nDetScore < 0 then
			nDetScore = 0;
		end
		local nTarXinfaScore = GetMissionData(sceneId,targetId,XINFA_SCORE);
		local nDetXinfaScore = nSelfXinfaScore - nTarXinfaScore;
		if nDetXinfaScore < 0 then
			nDetXinfaScore = 0;
		end
		local nTarGemTime = DataPoolGetGemScore(sceneId,targetId);
		local nDetGemTime = nSelfGemTime - nTarGemTime;
		if nDetGemTime < 0 then
			nDetGemTime = 0;
		end
--		double nAllTime = 5 * (nDetScore/(double)nXiuLianMaxScore) + 15 * (nDetXinfaScore/(double)nXinFaMaxScore) + nDetGemTime + 3;
--		if (nAllTime > 15.0)
--		{
--			nAllTime = 15.0;
--		}	
		local nAllTime = 5 * (nDetScore/4375) + 15 * (nDetXinfaScore/33750) + nDetGemTime + 3;
		if nAllTime > 15 then
			nAllTime = 15;
		end
--		int nImpactIndex = nBuffStart + (int)((nBuffMax - nBuffStart) * (nAllTime/15.0));
--		if (nImpactIndex > nBuffMax)
--		{
--			nImpactIndex = nBuffMax;
--		}
--		if (nImpactIndex < nBuffStart)
--		{
--			nImpactIndex = nBuffStart;
--		}
		local nImpactIndex = x808285_g_MinBuff[GetMenPai(sceneId,selfId)] + (x808285_g_MaxBuff[GetMenPai(sceneId,selfId)] - x808285_g_MinBuff[GetMenPai(sceneId,selfId)]) * (nAllTime/15);
		if nImpactIndex > x808285_g_MaxBuff[GetMenPai(sceneId,selfId)] then
			nImpactIndex = x808285_g_MaxBuff[GetMenPai(sceneId,selfId)];
		end
		if nImpactIndex < x808285_g_MinBuff[GetMenPai(sceneId,selfId)] then
			nImpactIndex = x808285_g_MinBuff[GetMenPai(sceneId,selfId)];
		end
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, targetId, floor(nImpactIndex), 0 );		
	else
		--对方非人哉
		local nAllTime = 15 * ((nSelfScore + nSelfXinfaScore) / (4375 + 33750)) + nSelfGemTime + 3;
		if nAllTime > 15 then
			nAllTime = 15;
		end
		local nImpactIndex = x808285_g_MinBuff[GetMenPai(sceneId,selfId)] + (x808285_g_MaxBuff[GetMenPai(sceneId,selfId)] - x808285_g_MinBuff[GetMenPai(sceneId,selfId)]) * (nAllTime/15);
		if nImpactIndex > x808285_g_MaxBuff[GetMenPai(sceneId,selfId)] then
			nImpactIndex = x808285_g_MaxBuff[GetMenPai(sceneId,selfId)];
		end
		if nImpactIndex < x808285_g_MinBuff[GetMenPai(sceneId,selfId)] then
			nImpactIndex = x808285_g_MinBuff[GetMenPai(sceneId,selfId)];
		end
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, targetId, floor(nImpactIndex), 0 );
		--AddGlobalCountNews(sceneId,nImpactIndex)
	end
end
--//宝石评分影响时间
--int DataPoolGetGemScore(int pHuman)
--{
--	int nGemScore = pHuman->GetMissionData(298);
--	int nGemEffect = 0;
--	if (nGemScore >= 960 && nGemScore < 1280)
--	{
--		nGemEffect = 2;
--	}
--	else if (nGemScore >= 1280 && nGemScore < 1920)
--	{
--		nGemEffect = 4;
--	}
--	else if (nGemScore >= 1920 && nGemScore < 3200)
--	{
--		nGemEffect = 7;
--	}
--	else if (nGemScore >= 3200)
--	{
--		nGemEffect = 10;
--	}
--	return nGemEffect;
--}
function DataPoolGetGemScore(sceneId,selfId)
	local nGemScore = GetMissionData(sceneId,selfId,298);
	local nGemEffect = 0;
	if nGemScore >= 960 and nGemScore < 1280 then
		nGemEffect = 2;
	elseif nGemScore >= 1280 and nGemScore < 1920 then
		nGemEffect = 4;
	elseif nGemScore >= 1920 and nGemScore < 3200 then
		nGemEffect = 7;
	elseif nGemScore >= 3200 then
		nGemEffect = 10;
	end
	return nGemEffect
end