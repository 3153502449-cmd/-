--宋辽大战[血战雁门关]
--将帅事件
--逍遥子 QQ857904341
x502012_g_CampName = {
	[156] = "宋",
	[157] = "辽",
}
--**********************************
-- 鼎死亡事件
--**********************************
function x502012_OnDie(sceneId, objId, killerId)
	if objId < 1 or killerId < 1  then
		return
	end
	
    local objType = GetCharacterType( sceneId, killerId )		 	 
	if objType == 3 then --如果杀死他的是其他玩家的宠物
		killerId = GetPetCreator( sceneId, killerId )		
	end
	local nfanhui = LuaFnGetCopySceneData_Param(sceneId, 18)
	if nfanhui ~= 0 then
			AddGlobalCountNews(sceneId,"已经败了，本次击杀失效")
		return
	end
	local nCamp = GetUnitCampID(sceneId, killerId, killerId)
	if nCamp ~= 156 and nCamp ~= 157 then
			AddGlobalCountNews(sceneId,"击杀者阵营有问题")
		return
	end
	LuaFnSetCopySceneData_Param(sceneId, 18,nCamp)
	local nDieName = GetName( sceneId, objId )
	local nKillerName = GetName(sceneId,killerId)
	local Xpos,Zpos = GetWorldPos(sceneId,objId)
	local nScore = 500 --积分
	local nShowInfo = "#H"..nDieName.."#H被击杀，"..x502012_g_CampName[nCamp].."#H获得胜利"
	x502012_Tips(sceneId,killerId,"#{SLDZ_100805_203}") --你获得宋辽大战的胜利，将获得额外的经验奖励
	AddGlobalCountNews(sceneId,nShowInfo)
	AddExp(sceneId,killerId,70000) --加经验哦
	CallScriptFunction(502011, "SongLiaoScoreAdd",sceneId,nCamp,nScore) --通知积分变动
	CallScriptFunction(502011, "EndSLDZ",sceneId) --通知宋辽大战结束
end
--**********************************
--中心通知
--**********************************
function x502012_Tips(sceneId,selfId,Str)
	BeginEvent(sceneId)
		AddText(sceneId, Str)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId, selfId)
end
--**********************************
--提示所有副本内玩家
--**********************************
function x502012_TipAllHuman( sceneId, Str )
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	-- 没有人的场景，什么都不做
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

