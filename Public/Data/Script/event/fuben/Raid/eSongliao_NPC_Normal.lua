--宋辽大战[血战雁门关]
--普通士兵事件
--逍遥子 QQ857904341
--**********************************
-- 鼎死亡事件
--**********************************
function x502016_OnDie(sceneId, objId, killerId)
	if objId < 1 or killerId < 1  then
		return
	end
    local objType = GetCharacterType( sceneId, killerId )		 	 
	if objType == 3 then --如果杀死他的是其他玩家的宠物
		killerId = GetPetCreator( sceneId, killerId )		
	end
	local nCamp = GetUnitCampID(sceneId, killerId, killerId)
	local nScore = 1 --积分
	CallScriptFunction(502011, "SongLiaoScoreAdd",sceneId,nCamp,nScore) --通知积分变动
end
--**********************************
--提示所有副本内玩家
--**********************************
function x502016_TipAllHuman( sceneId, Str )
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

