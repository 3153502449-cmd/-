--宋辽大战[血战雁门关]
--鼎事件
--逍遥子 QQ857904341
x502013_g_MosterDing = {	
	{PosX=108,  PosY=225},
	{PosX=160,  PosY=215},
	{PosX=212,  PosY=225},
	{PosX=108,  PosY=160},
	{PosX=160,  PosY=160},
	{PosX=212,  PosY=160},
	{PosX=108,  PosY=95},
	{PosX=160,  PosY=105},
	{PosX=212,  PosY=95},
}
x502013_g_CampName = {
	[156] = "宋",
	[157] = "辽",
}
--**********************************
-- 鼎死亡事件
--**********************************
function x502013_OnDie(sceneId, objId, killerId)
	if objId < 1 or killerId < 1  then
		return
	end
    local objType = GetCharacterType( sceneId, killerId )		 	 
	if objType == 3 then --如果杀死他的是其他玩家的宠物
		killerId = GetPetCreator( sceneId, killerId )		
	end
	local Xpos,Zpos = GetWorldPos(sceneId,objId)
	local nCamp = GetUnitCampID(sceneId, killerId, killerId)
	local nScore = 0 --积分
	local nDingID = 0 --N号鼎
	for i = 1,9 do
        if abs(x502013_g_MosterDing[i].PosX - Xpos) < 50 and abs(x502013_g_MosterDing[i].PosY - Zpos) < 50 then                 
	        local nMonsterID = 0
            if nCamp == 156 then
				nMonsterID = 14680      
            elseif nCamp == 157 then
				nMonsterID = 14681       
            end  
			local MonsterID = LuaFnCreateMonster(sceneId, nMonsterID,x502013_g_MosterDing[i].PosX,x502013_g_MosterDing[i].PosY,0,-1,502013)
			SetUnitCampID(sceneId,MonsterID,MonsterID,nCamp)	    
			LuaFnSetCopySceneData_Param(sceneId,(i+20),nMonsterID)   	  
			nScore = 50
			nDingID = i
        end	
    end
	local nShowInfo = ""
	if nDingID >= 1 and nDingID <= 3 then
		nShowInfo = "#Y"..x502013_g_CampName[nCamp].."#Y方#P夺取了#Y"..nDingID.."#Y号鼎#P，获得阵营积分"..nScore.."#P分。"
	end
--	if nDingID >= 4 and nDingID <= 6 then --中央鼎
--		nShowInfo = "#H中央三鼎已经被"..x502013_g_CampName[nCamp].."#H全部占领，"..x502013_g_CampName[nCamp].."#H将获得更多援军！"
--	end
	if nDingID >= 7 and nDingID <= 9 then
		nDingID = nDingID - 6
		nShowInfo = "#Y"..x502013_g_CampName[nCamp].."#Y方#P夺取了#Y"..nDingID.."#Y号鼎#P，获得阵营积分"..nScore.."#P分。"
	end
	AddGlobalCountNews(sceneId,nShowInfo)
	CallScriptFunction(502011, "SongLiaoScoreAdd",sceneId,nCamp,nScore) --通知积分变动
end
--**********************************
--提示所有副本内玩家
--**********************************
function x502013_TipAllHuman( sceneId, Str )
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

