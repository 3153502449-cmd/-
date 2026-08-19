--宋辽大战[血战雁门关]
--核心逻辑
--黄忠补写
--==========全局动态信息
--PG_SONGLIAO_JIFEN = 10
--==========全局动态信息

--MD_SONGLIAO_JIFEN = 406	     
--MD_SONGLIAO_LIANZHAN = 407
--MD_SONGLIAO_MYKILL = 408
--MD_SONGLIAO_PAIMING = 409
--MD_SONGLIAO_LASTPLAY = 410
--MD_SONGLIAO_TEMP_DATA = 411

x502011_g_scriptId = 502011
x502011_g_SceneHumanMax = 60 --副本人数上限
x502011_g_BaoHuBUFF = 95 --宋辽保护BUFF
x502011_g_Relivepos = {{298,242},{20,83}} --宋辽传送点,复活点位置
x502011_g_nEndTimes = 4 * 60 --副本的持续时间
x502011_g_BingTime = 120 ---士兵的时间控制（秒）
x502011_g_CloseTick = 20	 	--副本关闭前倒计时（单位：次数）
x502011_g_TickTime=5	   		--回调脚本的时钟时间（单位：秒/次）
x502011_g_NoUserTime = 5000  		--副本中没有人后可以继续保存的时间（单位：秒）
x502011_g_Score = {}			--每个玩家积分
x502011_g_HumanID = {}		--每个玩家ID
x502011_g_CampName = {
	[156] = "宋",
	[157] = "辽",
}
--鼎
x502011_g_MosterDing = {	
	{ nSign=21,ID=14680, PosX=108,  PosY=225, BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=4,GsongID=3 },---宋左下  21    3 
	{ nSign=22,ID=14680, PosX=160,  PosY=215, BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=5,GsongID=3 },---宋中间  22    4
	{ nSign=23,ID=14680, PosX=212,  PosY=225, BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=6,GsongID=3 },---宋右下  23    5
	{ nSign=24,ID=14679, PosX=108,  PosY=160, BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=4,GsongID=0 },---中间左  24 
	{ nSign=25,ID=14679, PosX=160,  PosY=160, BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=5,GsongID=1 },---中间中  25
	{ nSign=26,ID=14679, PosX=212,  PosY=160, BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=6,GsongID=2 },---中间右  26
	{ nSign=27,ID=14681, PosX=108,  PosY=95,  BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=7,GsongID=0 },---辽鼎左上  27   0
	{ nSign=28,ID=14681, PosX=160,  PosY=105, BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=7,GsongID=1 },---辽鼎中间 28   1
	{ nSign=29,ID=14681, PosX=212,  PosY=95,  BaseAI=0, ExtAIScript=-1, ScriptID=502013,GliaoID=7,GsongID=2 },---辽鼎右上  29   2
}
--宋方四塔和将士
x502011_g_MosterToCamp_Song = {
	{ ID=14687, PosX=148,  PosY=284, BaseAI=25, ExtAIScript=324, ScriptID=502011 },--青龙
	{ ID=14688, PosX=168,  PosY=284, BaseAI=25, ExtAIScript=322, ScriptID=502011 },--白虎
	{ ID=14689, PosX=148,  PosY=299, BaseAI=25, ExtAIScript=323, ScriptID=502011 },--朱雀
	{ ID=14690, PosX=170,  PosY=298, BaseAI=25, ExtAIScript=325, ScriptID=502011 },--玄武
	{ ID=14694, PosX=159,  PosY=302, BaseAI=25, ExtAIScript=326, ScriptID=502012 },--将
	{ ID=14714, PosX=110,  PosY=227, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--宋塔A
	{ ID=14714, PosX=106,  PosY=227, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--宋塔A
	{ ID=14714, PosX=158,  PosY=217, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--宋塔B
	{ ID=14714, PosX=162,  PosY=217, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--宋塔B	
	{ ID=14714, PosX=214,  PosY=227, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--宋塔C
	{ ID=14714, PosX=210,  PosY=227, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--宋塔C
	{ ID=14714, PosX=231,  PosY=269, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--宋塔门
	{ ID=14714, PosX=231,  PosY=276, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--宋塔门
}
--辽方四塔和将士
x502011_g_MosterToCamp_Liao = {
	{ ID=14700, PosX=169,  PosY=35, BaseAI=25, ExtAIScript=324, ScriptID=502011 },--青龙
	{ ID=14701, PosX=149,  PosY=35, BaseAI=25, ExtAIScript=322, ScriptID=502011 },--白虎
    { ID=14703, PosX=150,  PosY=21, BaseAI=25, ExtAIScript=325, ScriptID=502011 },--玄武
	{ ID=14702, PosX=170,  PosY=21, BaseAI=25, ExtAIScript=323, ScriptID=502011 },--朱雀	
	{ ID=14707, PosX=158,  PosY=27, BaseAI=25, ExtAIScript=326, ScriptID=502012 },---帅
	{ ID=14715, PosX=110,  PosY=93, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--辽塔A
	{ ID=14715, PosX=106,  PosY=93, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--辽塔A	
	{ ID=14715, PosX=158,  PosY=103,BaseAI=25, ExtAIScript=321, ScriptID=502011 },--辽塔B
	{ ID=14715, PosX=162,  PosY=103,BaseAI=25, ExtAIScript=321, ScriptID=502011 },--辽塔B	
	{ ID=14715, PosX=210,  PosY=93, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--辽塔C
	{ ID=14715, PosX=214,  PosY=93, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--辽塔C
	{ ID=14715, PosX=88,   PosY=51, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--辽塔门
	{ ID=14715, PosX=87,   PosY=41, BaseAI=25, ExtAIScript=321, ScriptID=502011 },--辽塔门
}
--宋方士兵
x502011_SongBing = {
	{ ChildID=14693, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --车
	{ ChildID=14685, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --马
	{ ChildID=14686, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --炮
	{ ChildID=14691, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --士
	{ ChildID=14692, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --士
	{ ChildID=14684, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --兵
	{ ChildID=14684, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 },	--兵
	{ ChildID=14684, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 },	--兵
	{ ChildID=14684, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 },	--兵
	{ ChildID=14684, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 },	--兵	
}
--辽方士兵
x502011_LiaoBing = {	
 	{ ChildID=14706, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --车
	{ ChildID=14698, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --马
	{ ChildID=14699, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --炮
	{ ChildID=14704, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --士
	{ ChildID=14705, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --士
	{ ChildID=14697, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --兵
	{ ChildID=14697, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 }, --兵
	{ ChildID=14697, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 },	--兵
	{ ChildID=14697, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 },	--兵
	{ ChildID=14697, BaseAI=0, ExtAIScript=-1, ScriptID = 502016 },	--兵			

}
--**********************************
--创建副本
--**********************************
function x502011_MakeCopyScene( sceneId, selfId )

	local nLeaderGuid = LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "Songliao_War.nav"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, nLeaderGuid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x502011_g_NoUserTime);
	LuaFnSetCopySceneData_PvpRuler( sceneId, 3 )  -- 竞技规则
	LuaFnSetCopySceneData_Timer(sceneId, x502011_g_TickTime * 1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, FUBEN_SONGLIAO);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, 502011);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6, 0); --保存
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;--杀死
	LuaFnSetCopySceneData_Param(sceneId, 16, 0); --保存宋的总分
	LuaFnSetCopySceneData_Param(sceneId, 17, 0) ;--保存辽的总分	
	LuaFnSetCopySceneData_Param(sceneId, 18, 0);--胜利方
	for i= 1,9 do
		LuaFnSetCopySceneData_Param(sceneId, x502011_g_MosterDing[i].nSign, x502011_g_MosterDing[i].ID) ;--初始化鼎
	end
	--设置场景中的各种Npc和区域
	LuaFnSetSceneLoad_Area( sceneId, "Songliao_War_area.ini" )
	LuaFnSetSceneLoad_Monster( sceneId, "Songliao_War_monster.ini" )
	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
	BeginEvent(sceneId)
	if bRetSceneID >0 then
		AddText(sceneId,"#{SLDZ_100805_40}"); --H宋辽战场副本创建成功！
	else
		AddText(sceneId,"副本创建失败");
	end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end
--**********************************
--副本事件--副本装载完毕
--**********************************
function x502011_OnCopySceneReady( sceneId, destsceneId )
	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId) --设置副本入口场景号
	local nLeaderGuid  = LuaFnGetCopySceneData_TeamLeader(destsceneId)
	local nLeaderObjId = LuaFnGuid2ObjId(sceneId,nLeaderGuid)
	if LuaFnIsCanDoScriptLogic( sceneId, nLeaderObjId ) ~= 1 then	-- 处于无法执行逻辑的状态
		return
	end
	if nLeaderObjId == -1 then	 -- 找不到该玩家
		return
	end
	--开始进行玩家分配
	local HumanHP = {}
	local HumanID = {}
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=1, nHumanCount  do   
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		local Humanhp = GetMaxHp(sceneId, nHumanId)    
		HumanID[i] = nHumanId  	     
		HumanHP[i] = Humanhp
	if i > x502011_g_SceneHumanMax then
		nHumanCount = i
		break
	end
	end
	--对大数进行一次排序
	for i = 1,nHumanCount do
        for j = 1,i do             
			if HumanHP[i] > HumanHP[j]  then
				local temp = HumanHP[i]
				local tempID = HumanID[i]
				HumanHP[i] = HumanHP[j]
				HumanID[i] = HumanID[j]
				HumanHP[j] = temp
				HumanID[j] = tempID
			end
	end
	end  
	--玩家数据初始化以及位置初始化
	for i = 1,nHumanCount do
	if HumanID[i] <1 then
           	break
	end
        SetMissionDataEx( sceneId, HumanID[i], MD_SONGLIAO_JIFEN,0)     --积分                                    
        SetMissionDataEx( sceneId, HumanID[i], MD_SONGLIAO_LIANZHAN,0)	--连杀
        SetMissionDataEx( sceneId, HumanID[i], MD_SONGLIAO_MYKILL,0)    --杀人数
        SetMissionDataEx( sceneId, HumanID[i], MD_SONGLIAO_PAIMING,0)   --排名
		local nlszhi = mod(i,2)
		if nlszhi == 0 then    
			NewWorld( sceneId,  HumanID[i], destsceneId, x502011_g_Relivepos[1][1] , x502011_g_Relivepos[1][2] )
		else  
			NewWorld( sceneId,  HumanID[i], destsceneId, x502011_g_Relivepos[2][1] , x502011_g_Relivepos[2][2] )
		end
	end
end
--**********************************
--玩家进入副本
--**********************************
function x502011_OnPlayerEnter( sceneId, playerId )
	RestoreHp( sceneId, playerId )
	RestoreMp( sceneId, playerId )
	RestoreRage( sceneId, playerId)	 
	local x,z = GetWorldPos(sceneId, playerId)
	local nTempCampID = GetMissionDataEx(sceneId, playerId, MD_SONGLIAO_TEMP_DATA)
	if nTempCampID == 157 then --掉线位置修正
		x = 10
	elseif nTempCampID == 156 then
		x = 200
	end
--	local nCampName = "大辽"
	local nRelivePos = 2
	if x <100  then
		SetUnitCampID(sceneId,playerId ,playerId, 157)
		SetMissionDataEx(sceneId, playerId, MD_SONGLIAO_TEMP_DATA,157)
		x502011_MsgBox( sceneId, playerId,"你所在团队阵营已经被分配为辽；你的对手为宋营团队。")	
		x502011_MsgBox( sceneId, playerId,"#{SLDZ_100805_48}")--你需要击杀尽可能多的宋营对手或击杀宋营主帅以获得胜利。
		x502011_MsgBox( sceneId, playerId,"#{SLDZ_100805_46}")--详细的战场规则请咨询卫兵。
	else
		SetUnitCampID(sceneId,playerId ,playerId, 156) 
		SetMissionDataEx(sceneId, playerId, MD_SONGLIAO_TEMP_DATA,156) 
--		nCampName = "大宋"
		x502011_MsgBox( sceneId, playerId,"你所在团队阵营已经被分配为宋；你的对手为辽营团队。")
		x502011_MsgBox( sceneId, playerId,"#{SLDZ_100805_45}")--你需要击杀尽可能多的辽营对手或击杀辽营大将以获得胜利。
		x502011_MsgBox( sceneId, playerId,"#{SLDZ_100805_46}")--详细的战场规则请咨询卫兵。
		nRelivePos = 1
	end
	LuaFnCancelSpecificImpact(sceneId,playerId,x502011_g_BaoHuBUFF) --取消保护BUFF
	SetPvpAuthorizationFlagByID(sceneId, playerId, 2, 1) 		                             
	SetPlayerDefaultReliveInfo( sceneId, playerId, "%50", "%50", "0",sceneId ,x502011_g_Relivepos[nRelivePos][1] , x502011_g_Relivepos[nRelivePos][2] )      
	--x502011_MsgBox( sceneId, playerId,"#{SLDZ_100805_43}")--H你已进入宋辽战场！
end
--*********************************
--刷新每位玩家的个人积分
--*********************************
function x502011_RefreshPlayerRank(sceneId)
	local nfanhui = LuaFnGetCopySceneData_Param(sceneId, 18)
	if nfanhui ~= 156 and nfanhui ~= 157 then
		AddGlobalCountNews(sceneId,"胜利方阵营有问题")
		return
	end
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local j = 0
	for i=1, nHumanCount do   
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		local nCamp = GetUnitCampID(sceneId, nHumanId, nHumanId)
		if nCamp == nfanhui then
			local HumanJifen = GetMissionDataEx( sceneId, nHumanId, MD_SONGLIAO_JIFEN)
			j = j + 1
			x502011_g_HumanID[j] = nHumanId  	     
			x502011_g_Score[j] = HumanJifen
			--胜利次数记录 2019-9-1 13:23:54 逍遥子
			SetMissionDataEx(sceneId,nHumanId,MD_SONGLIAO_WINNUM,GetMissionDataEx(sceneId,nHumanId,MD_SONGLIAO_WINNUM) + 1)
		end
	end
	nHumanCount = j
	AddGlobalCountNews(sceneId,"胜利方人数"..j)

	--开始进行排序
	for i = 1,nHumanCount do
		if x502011_g_Score[i] == nil then
			break
		end
        for j = 1,i do             
			if x502011_g_Score[i] > x502011_g_Score[j]  then
				local temp = x502011_g_Score[i]
				local tempID = x502011_g_HumanID[i]
				x502011_g_Score[i] = x502011_g_Score[j]
				x502011_g_HumanID[i] = x502011_g_HumanID[j]
				x502011_g_Score[j] = temp
				x502011_g_HumanID[j] = tempID
			end
		end
	end

	--进行排名存档
	for i= 1  ,nHumanCount do  
		if x502011_g_Score[i] < 1 then
			SetMissionDataEx( sceneId, x502011_g_HumanID[i], MD_SONGLIAO_PAIMING,60) 
			AddGlobalCountNews(sceneId,LuaFnGetName( sceneId, x502011_g_HumanID[i]).."垃圾60")
		else
			SetMissionDataEx( sceneId, x502011_g_HumanID[i], MD_SONGLIAO_PAIMING,i) 
			AddGlobalCountNews(sceneId,LuaFnGetName( sceneId, x502011_g_HumanID[i]).."成功"..x502011_g_Score[i])
		end 
	end
end
--**********************************
--对象死亡事件
--**********************************
function x502011_OnDie(sceneId, objId, killerId)
	if objId < 1 or killerId < 1  then
		return
	end
    local objType = GetCharacterType( sceneId, killerId )		 	 
	if objType == 3 then --如果杀死他的是其他玩家的宠物
		killerId = GetPetCreator( sceneId, killerId )		
	end
	local nScore = 0 --积分
	local MosDataID = GetMonsterDataID( sceneId, objId)
	local monstername = LuaFnGetName( sceneId, objId)
	if MosDataID >= 14700 and MosDataID <= 14703 then
			nScore = 80
	end
	if MosDataID >= 14687 and MosDataID <= 14690 then
			nScore = 80
	end	
	if MosDataID >= 14714 and MosDataID <= 14715 then
			nScore = 10
	end
	local nCamp = GetUnitCampID(sceneId, killerId, killerId)
	local nShowInfo = "#Y"..x502011_g_CampName[nCamp].."#Y方#P破坏了#Y"..monstername.."#P，获得阵营积分"..nScore.."#P分。"
	AddGlobalCountNews(sceneId,nShowInfo)
	CallScriptFunction(502011, "SongLiaoScoreAdd",sceneId,nCamp,nScore) --通知积分变动	
end
--**********************************
--杀死怪物或玩家
--**********************************
function x502011_OnKillObject( sceneId, selfId, objdataId, objId )
	
end
--**********************************
----人物死亡事件
--**********************************
function x502011_OnHumanDie(sceneId, dieId, nHumanId)
	-- 如果这个杀手是个宠物，需要现找到主人
	local nObjType = GetCharacterType(sceneId, nHumanId);
	local killerId = -1;
	if nObjType then
		if nObjType == 1 then	
			killerId = nHumanId
		elseif nObjType == 3 then
			killerId = GetPetCreator(sceneId, nHumanId);
		else
			local nCampID = GetUnitCampID(sceneId, killerId, killerId)	
			x502011_SongLiaoScoreAdd(sceneId,nCampID,3) --所属阵营总分增加
			return
		end
	end
	if killerId == -1 then
		--死的莫名其妙
		--x502011_MsgBox( sceneId, selfId, str )
		--return
	end
	if IsSameMAC(sceneId,dieId,killerId) > 0 then
		--相同的MAC，是小号，不记录
		--return
	end
	local nCampID = GetUnitCampID(sceneId, killerId, killerId)	
	if nCampID == GetUnitCampID(sceneId, dieId, dieId) then
		--同一个阵营就不能行
		return
	end
	local nKillerLevel = GetLevel(sceneId, killerId)
  	local nDiedLevel = GetLevel(sceneId, dieId)
	local nScore = 0 --增加的积分记录
	if (nKillerLevel - nDiedLevel) > 10 then --击杀低于自己10级以外的玩家，每次积1分；
		nScore = 1
	end
	if (nKillerLevel - nDiedLevel) <= 10 then --击杀低于自己10级以内的玩家，每次积2分；
		nScore = 2
	end
	if (nDiedLevel - nKillerLevel) <= 10 then --击杀高于自己10级以内的玩家，每次积3分；
		nScore = 3
	end
	if (nDiedLevel - nKillerLevel) > 10 then --击杀高于自己10级以外的玩家，每次积5分；
		nScore = 5
	end
	--连杀数据计算
	local nKillerLianSha = GetMissionDataEx( sceneId, killerId, MD_SONGLIAO_LIANZHAN)
	local nKillerNum = GetMissionDataEx( sceneId, killerId, MD_SONGLIAO_MYKILL)
	local nKillerScore = GetMissionDataEx( sceneId, killerId, MD_SONGLIAO_JIFEN) 
	local nKillerName = LuaFnGetName( sceneId, killerId )
	--
	local nDiedLianSha = GetMissionDataEx( sceneId, dieId, MD_SONGLIAO_LIANZHAN)
	local nDiedNum = GetMissionDataEx( sceneId, dieId, MD_SONGLIAO_MYKILL)
	local nDiedScore = GetMissionDataEx( sceneId, dieId, MD_SONGLIAO_JIFEN) 
	local nDiedName = LuaFnGetName( sceneId, dieId )
	--连杀积分处理
	local nKillerLianShaScore = nKillerLianSha * 3
	local nDiedLianShaScore = nDiedLianSha * 3
	--公告处理
	--连杀公告
	if nDiedLianSha >= 3 then
		BroadMsgByChatPipe(sceneId, killerId,"#{_INFOUSR"..nDiedName.."}#P达到了辉煌的"..nDiedLianSha.."#P连杀，现在这个记录终于被#{_INFOUSR"..nKillerName.."}#P终结了！", 4);
	end
	if nKillerLianSha > 1 then
		BroadMsgByChatPipe(sceneId, killerId,"#{_INFOUSR"..nKillerName.."}#P连战连捷，已经达到"..nKillerLianSha.."#P连杀！", 4);
	end
	x502011_MsgBox( sceneId, killerId,"#H你击杀了"..nDiedName.."#H，得到基础积分"..nScore.."#H，连胜积分"..nKillerLianShaScore.."#H，对方连胜积分"..nDiedLianShaScore.."#H" )	
	--数据刷新
	SetMissionDataEx( sceneId, killerId, MD_SONGLIAO_LIANZHAN,nKillerLianSha + 1)
	SetMissionDataEx( sceneId, killerId, MD_SONGLIAO_MYKILL,nKillerNum + 1)
	SetMissionDataEx( sceneId, killerId, MD_SONGLIAO_JIFEN,nKillerScore + nScore + nKillerLianShaScore) 
	--
	SetMissionDataEx( sceneId, dieId, MD_SONGLIAO_LIANZHAN,0)
	--数据刷新
	x502011_SongLiaoScoreAdd(sceneId,nCampID,nScore + nKillerLianShaScore) --所属阵营总分增加
	x502011_DropChess(sceneId,dieId) --被杀对象掉点东西吧

end

--*********************************
--胜负决定，结束战斗
--*********************************
function x502011_EndSLDZ(sceneId)
	local nfanhui = LuaFnGetCopySceneData_Param(sceneId, 18)
	local nScore_L = LuaFnGetCopySceneData_Param( sceneId,17)	
	local nScore_S = LuaFnGetCopySceneData_Param( sceneId,16)		
	local nScore_axL = 0
	local nScore_axS = 0
	local njisha = 0
	if nfanhui == 0 then
		nScore_axL = nScore_L
		nScore_axS = nScore_S
	else
		if nfanhui == 156 then
			nScore_S = 300
		end
		if nfanhui == 157 then
			nScore_L = 300
		end
		njisha = 1		
	end
	local nShowInfo = ""
	if nScore_axL >= 200 or nScore_axS >= 200 then
		if nScore_L ~= nScore_S then
			local nWinerName = ""
			if nScore_axL > nScore_axS then
				nWinerName = "辽方"
				if njisha == 0 then
					LuaFnSetCopySceneData_Param(sceneId, 18,157)
				end
			else
				nWinerName = "宋方"
				if njisha == 0 then
					LuaFnSetCopySceneData_Param(sceneId, 18,156)
				end
			end
			if njisha == 1 then
				nWinerName = nWinerName.."成功击杀敌方主将，"
			end
			nShowInfo = "#H活动结束，辽方积分"..nScore_L.."#H，宋方积分"..nScore_S.."#H，"..nWinerName.."#H获得胜利。"
		else
			nShowInfo = "#H活动结束，辽方积分"..nScore_L.."#H，宋方积分"..nScore_S.."#H，辽方、宋方均获得胜利！"
		end
	else
		if nScore_L < 100 and nScore_S < 100 then
			nShowInfo = "#{SLDZ_100805_58}"
		elseif nScore_L < 200 and nScore_S < 200 then
			nShowInfo = "#{SLDZ_100805_59}"
		end
	end
	AddGlobalCountNews(sceneId,nShowInfo)
	x502011_TipAllHuman( sceneId, nShowInfo ) --msg通知
	LuaFnSetCopySceneData_Param(sceneId,4,1) --设置副本结束
	x502011_RefreshPlayerRank(sceneId) --排名信息最后一次刷新

end
--*********************************
--宋辽双方积分变动事件
--*********************************
function x502011_SongLiaoScoreAdd(sceneId,nCampID,nScore)
	local nSign = 0
	if nCampID == 156 then
		nSign = 16
	else
		nSign = 17
	end
	local nScore_Now = LuaFnGetCopySceneData_Param( sceneId,nSign )	
	LuaFnSetCopySceneData_Param(sceneId,nSign,nScore_Now+nScore)
end
--**********************************
--副本时钟
--**********************************
function x502011_OnCopySceneTimer( sceneId, nowTime )
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanNum < 1 then
		return
	end
	--查询副本时钟
	local TickCount = LuaFnGetCopySceneData_Param( sceneId, 2 )	-- 取得已经执行的定时次数
	TickCount = TickCount + 1
	LuaFnSetCopySceneData_Param(sceneId,2,TickCount)	--关闭副本
	if x502011_g_nEndTimes - TickCount == 10 then
		x502011_EndSLDZ(sceneId) --时间到了，结束战斗
	end
	local nCopySceneFlag = LuaFnGetCopySceneData_Param( sceneId, 4 ) --获取当前副本状态
	if nCopySceneFlag == 0 then --副本正常运作
		--宋辽大战即将在%s#H秒后正式开始！
		if TickCount < 20 then
			--0秒不显示
			local nTimeAll = 20
			nTimeAll = nTimeAll - TickCount
			x502011_TipAllHuman( sceneId, "宋辽大战即将在"..nTimeAll.."#H秒后正式开始！" )
		end
		if TickCount == 20 then
			local message = "宋辽大战正式开始"
			BroadMsgByChatPipe(sceneId, selfId, message, 4);
			--释放鼎
			x502011_UpdateDing(sceneId) --刷新鼎
			--释放双方小兵
			if mod(TickCount,x502011_g_BingTime) ==0 then
				x502011_UpdateArmySongAndLiao(sceneId)
			end
			--释放双方塔防
			x502011_UpdateTaSongAndLiao(sceneId)
			--刷新排名信息
			--ToClientUI
		end
	elseif nCopySceneFlag == 1 then --副本关闭，宋辽大战结束
		--离开倒计时间的读取和设置
		local leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, 5)
		if leaveTickCount == x502011_g_CloseTick then --倒计时间到，大家都出去吧
			x502011_ClearMonster(sceneId) --清除副本内的Monster
			x502011_GoAwayAllPeople(sceneId)
		elseif leaveTickCount < x502011_g_CloseTick then
			--通知当前副本场景里的所有人，场景关闭倒计时间
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
			local mems = {}
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				if LuaFnIsObjValid(sceneId, mems[i]) == 1 and LuaFnIsCanDoScriptLogic(sceneId, mems[i]) == 1 then
					BeginEvent(sceneId)
						strText = format("副本将在%s#H秒后关闭", (x502011_g_CloseTick-leaveTickCount)*x502011_g_TickTime )
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,mems[i])
				end
			end
		end
		leaveTickCount = leaveTickCount+1 ;
		LuaFnSetCopySceneData_Param(sceneId, 5, leaveTickCount) ;
	end
-------------------------------------------------------------------------------------------------------------------	
local nlszhi = mod(TickCount,10)
if nlszhi == 7 then
	
	local suiji = random(5)
	if suiji <= 3 then
	
	for _ ,BossData in x502011_SongBing do 
		local suijizb = random(25)
        local MonsterID = LuaFnCreateMonster(sceneId, BossData.ChildID, 159, 275+suijizb, 17, 0, BossData.ScriptID )        
        if MonsterID > 0 then
				local suiji5 = random(3)
				SetUnitCampID(sceneId, MonsterID, MonsterID,156)          
 				SetPatrolId( sceneId, MonsterID, suiji5-1 )
				SetMonsterFightWithNpcFlag(sceneId, MonsterID, 1)
       end
    end
	end
	--辽军
	suiji = random(5)
	if suiji <= 3 then
	
	for _ ,BossData in x502011_LiaoBing do 
		local suijizb = random(25)
        local MonsterID = LuaFnCreateMonster(sceneId, BossData.ChildID, 159, 40-suijizb, 17, 0, BossData.ScriptID )        
        if MonsterID > 0 then
				local suiji5 = random(3)
				SetUnitCampID(sceneId, MonsterID, MonsterID,157)          
 				SetPatrolId( sceneId, MonsterID, suiji5+2 )
				SetMonsterFightWithNpcFlag(sceneId, MonsterID, 1)
       end
    end
	end
end
------------------------------------------------------------------------------------------------------
end
--*********************************
--宋辽双方普通士兵刷新事件
--*********************************
function x502011_UpdateArmySongAndLiao(sceneId)
	for i=1 ,9 do		 	     	
		local nCamp = LuaFnGetCopySceneData_Param(sceneId,(i+20)) 
		if nCamp == 14680  then     
			x502011_FnUpdateArmySongAndLiao (sceneId,nCamp,x502011_g_MosterDing[i].PosX, x502011_g_MosterDing[i].PosY, x502011_g_MosterDing[i].GliaoID)	 
		elseif nCamp==14681 then  
			x502011_FnUpdateArmySongAndLiao (sceneId,nCamp,x502011_g_MosterDing[i].PosX, x502011_g_MosterDing[i].PosY, x502011_g_MosterDing[i].GsongID)	 
		end      	   
	end		
end
function x502011_FnUpdateArmySongAndLiao(sceneId,MonsterID,Xpos,Zpos,PatrolId)
	if MonsterID == 14680 then --辽
	 	for _,Data in x502011_LiaoBing  do
			local nMonsterID = LuaFnCreateMonster(sceneId, Data.ChildID, Xpos, Zpos, Data.BaseAI, Data.ExtAIScript , 502011 )
			if nMonsterID < 1 then
				break
			end 
			SetCharacterDieTime(sceneId, nMonsterID, 10*60*1000);
			SetMonsterFightWithNpcFlag(sceneId, nMonsterID, 1)
			SetUnitCampID(sceneId, nMonsterID, nMonsterID,156)
			SetPatrolId(sceneId, nMonsterID, PatrolId)
		end
	elseif  MonsterID == 14681 then
		for _,Data in x502011_SongBing  do
			local nMonsterID = LuaFnCreateMonster(sceneId, Data.ChildID, Xpos, Zpos, Data.BaseAI, Data.ExtAIScript , 502011 )
			if nMonsterID < 1 then
				break
			end 
			SetCharacterDieTime(sceneId, nMonsterID, 10*60*1000);
			SetMonsterFightWithNpcFlag(sceneId, nMonsterID, 1)
			SetUnitCampID(sceneId, nMonsterID, nMonsterID,157)
			SetPatrolId(sceneId, nMonsterID, PatrolId)
		end
	end
end
--*********************************
--宋辽双方塔、将刷新事件
--*********************************
function x502011_UpdateTaSongAndLiao(sceneId)
	for _ ,BossData in x502011_g_MosterToCamp_Song do           
        local MonsterID = LuaFnCreateMonster(sceneId, BossData.ID, BossData.PosX, BossData.PosY, BossData.BaseAI, BossData.ExtAIScript, BossData.ScriptID )
        if MonsterID > 0 then
			SetUnitCampID(sceneId, MonsterID, MonsterID,156)         
        end
    end
	for _ ,BossData in x502011_g_MosterToCamp_Liao do 
        local MonsterID = LuaFnCreateMonster(sceneId, BossData.ID, BossData.PosX, BossData.PosY, BossData.BaseAI, BossData.ExtAIScript, BossData.ScriptID )        
        if MonsterID > 0 then
			SetUnitCampID(sceneId, MonsterID, MonsterID,157)          
        end
    end
end
--*********************************
--棋子事件
--*********************************
function x502011_DropChess(sceneId,objId)
	local x,y = GetWorldPos(sceneId,objId)
	local nCampID = GetUnitCampID(sceneId, objId, objId)  --得到死者的阵营
	local nChessID = -1
	local BoxId = -1	 
	local nRandID = random (1000)
    if nCampID == 156 then
		if nRandID < 100 then
			nChessID = 40004577 --帅
		elseif nRandID < 250 then
			nChessID = 40004576 --相
		elseif nRandID < 350 then
			nChessID = 40004575 --士
		elseif nRandID < 450 then
			nChessID = 40004574 --车
		elseif nRandID < 550 then
			nChessID = 40004573 --炮
		elseif nRandID < 650 then
			nChessID = 40004572 --马
		elseif nRandID < 750 then
			nChessID = 40004571 --兵			
		end
   else 
		if nRandID < 100 then
			nChessID = 40004584 --将
		elseif nRandID < 250 then
			nChessID = 40004583 --士
		elseif nRandID < 350 then
			nChessID = 40004582 --相
		elseif nRandID < 450 then
			nChessID = 40004581 --车
		elseif nRandID < 550 then
			nChessID = 40004580 --炮
		elseif nRandID < 650 then
			nChessID = 40004579 --马
		elseif nRandID < 750 then
			nChessID = 40004578 --兵
		end
   end   
	if nChessID > 0 then
		BoxId = DropBoxEnterScene( x, y, sceneId )
		if BoxId > -1 then
			AddItemToBox(sceneId,BoxId,QUALITY_CREATE_BY_BOSS,1,nChessID)
		end
	end 
end
--*********************************
--鼎事件
--*********************************
function x502011_UpdateDing(sceneId)
	for _ ,BossData in x502011_g_MosterDing  do           
        local MonsterID = LuaFnCreateMonster(sceneId, BossData.ID, BossData.PosX, BossData.PosY, BossData.BaseAI, BossData.ExtAIScript, BossData.ScriptID )
		if BossData.ID == 14679 then --中心鼎
			SetUnitCampID(sceneId, MonsterID, MonsterID,160) 
		elseif BossData.ID == 14680 then --宋鼎
			SetUnitCampID(sceneId, MonsterID, MonsterID,156) 
		elseif BossData.ID == 14681 then --辽鼎
			SetUnitCampID(sceneId, MonsterID, MonsterID,157)         
		end           
    end
end
---**********************************
--场景内怪物清除
---**********************************
function x502011_ClearMonster(sceneId)
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=1, nMonsterNum do
		local nMonsterId = GetMonsterObjID(sceneId,i-1)	
		LuaFnDeleteMonster(sceneId, nMonsterId)		 
	end		
end
--*********************************
--副本人员清空
--*********************************
function x502011_GoAwayAllPeople(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
    for i = 1,nHumanCount do   
        local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
		SetPvpAuthorizationFlagByID(sceneId,nHumanId, 2, 0)--设定PVP状态
		SetUnitCampID(sceneId,nHumanId,nHumanId, -1) --重新设定阵营
        NewWorld( sceneId, nHumanId,1,random(292,296),random(239,243)) 
    end
end
--**********************************
--消息提示
--**********************************
function x502011_MsgBox( sceneId, selfId, str )	
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x502011_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--提示所有副本内玩家
--**********************************
function x502011_TipAllHuman( sceneId, Str )
	-- 获得场景里头的所有人
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	-- 没有人的场景，什么都不做
	if nHumanNum < 1 then
		return
	end
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, PlayerId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, PlayerId) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId, Str)
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, PlayerId)
		end
	end
end


