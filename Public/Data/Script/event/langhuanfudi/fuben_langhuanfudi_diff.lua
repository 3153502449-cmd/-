--缥缈峰副本....   ____、呵呵  修复
--脚本号
x893084_g_ScriptId = 893084
x893084_g_CopySceneType = FUBEN_LANGHUAN
x893084_g_TickTime		= 1				--回调脚本的时钟时间（单位：秒/次）
x893084_g_NoUserTime	= 10			--副本中没有人后可以继续保存的时间（单位：秒）
x893084_g_Fuben_X			= 66			--进入副本的位置X
x893084_g_Fuben_Z			= 57			--进入副本的位置Z
x893084_g_FuBenTime		= 1*60*60	--副本关闭时间....

x893084_g_IDX_FuBenLifeStep		= 7	--副本生命期的step....(包括建立NPC....关闭倒计时提示....)
--**********************************
--任务入口函数....
--**********************************
function x893084_OnDefaultEvent( sceneId, selfId, targetId )
end
function x893084_OnEventRequest( sceneId, selfId, targetId, eventId )
	--检测是否可以进入副本....
	local NumText = GetNumText();
	local ret, msg = x893084_CheckCanEnter( sceneId, selfId, targetId )

	if 1 ~= ret then
		BeginEvent(sceneId)
		AddText(sceneId,msg)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--关闭NPC对话窗口....
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)

	x893084_MakeCopyScene( sceneId, selfId,NumText)
	
	
end	

--**********************************
--列举事件
--**********************************
function x893084_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x893084_g_ScriptId, "#G琅嬛福地简单模式", 10, 1 )
	AddNumText( sceneId, x893084_g_ScriptId, "#H琅嬛福地困难模式", 10, 2 )
end

--**********************************
--检测是否可以进入此副本....
--**********************************
function x893084_CheckCanEnter( sceneId, selfId, targetId )

	--是否有队伍....
	if LuaFnHasTeam(sceneId,selfId) ~= 1 then
		return 0, "#{PMF_20080521_02}"
	end

	--是不是队长....
	if GetTeamLeader(sceneId,selfId) ~= selfId then
		return 0, "#{PMF_20080521_03}"
	end	
	--人数是否够....
	if GetTeamSize(sceneId,selfId) < 1 then
		return 0, "#{PMF_20080521_04}"
	end

	--是否都在附近....
	local NearTeamSize = GetNearTeamCount(sceneId,selfId)
	if GetTeamSize(sceneId,selfId) ~= NearTeamSize then
		return 0, "#{PMF_20080521_05}"
	end

	local Humanlist = {}
	local nHumanNum = 0

	--是否有人不够90级....
	for i=0, NearTeamSize-1 do
		local PlayerId = GetNearTeamMember( sceneId, selfId, i )
		if GetLevel( sceneId, PlayerId ) < 90 then
			Humanlist[nHumanNum] = GetName( sceneId, PlayerId )
			nHumanNum = nHumanNum + 1
		end
	end

	if nHumanNum > 0 then

		local msg = "    队伍当中的"
		for i=0, nHumanNum-2 do
			msg = msg .. Humanlist[i] .. "，"
		end
		msg = msg .. Humanlist[nHumanNum-1] .. "小于100级"
		return 0, msg

	end


	--是否有人今天做过3次了....
	nHumanNum = 0
	local CurDayTime = GetDayTime()
	for i=0, NearTeamSize-1 do

		local PlayerId = GetNearTeamMember( sceneId, selfId, i )
		local lastTime = GetMissionDataEx( sceneId, PlayerId, MD_LANGHUANFUDI )
		local lastDayTime = floor( lastTime / 100 )
		local lastDayCount = mod( lastTime, 100 )
	
		if CurDayTime > lastDayTime then
			lastDayTime = CurDayTime
			lastDayCount = 0
		end

		if lastDayCount >= 3 then
			Humanlist[nHumanNum] = GetName( sceneId, PlayerId )
			nHumanNum = nHumanNum + 1
		end

	end

	if nHumanNum > 0 then

		local msg = "    "
		for i=0, nHumanNum-2 do
			msg = msg .. Humanlist[i] .. "，"
		end
		msg = msg .. Humanlist[nHumanNum-1] .. "本日已经挑战过2次琅嬛副本了。"
		return 0, msg

	end
	return 1,msg

end

--**********************************
--创建副本....
--**********************************
function x893084_MakeCopyScene( sceneId, selfId, key)
	local x = 0
	local z = 0
	x,z = LuaFnGetWorldPos(sceneId,selfId)
	leaderguid=LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "langhuanfudi.nav")
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid)
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x893084_g_NoUserTime*1000)
	LuaFnSetCopySceneData_Timer(sceneId, x893084_g_TickTime*1000)
	LuaFnSetCopySceneData_Param(sceneId, 0, x893084_g_CopySceneType)  --副本类型
	LuaFnSetCopySceneData_Param(sceneId, 1, x893084_g_ScriptId)  --脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0)
	LuaFnSetCopySceneData_Param(sceneId, 3, sceneId)    --进入的场景
	LuaFnSetCopySceneData_Param(sceneId, 4, x)       --进入的x坐标
	LuaFnSetCopySceneData_Param(sceneId, 5, z)      --进入的y坐标
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId))  --队伍id

	LuaFnSetCopySceneData_Param(sceneId, 7, 0)      --副本周期
	LuaFnSetCopySceneData_Param(sceneId, 8, key)      --副本级别


	for i=9, 31 do
		LuaFnSetCopySceneData_Param(sceneId, i, 0)
	end


	LuaFnSetSceneLoad_Area( sceneId, "langhuanfudi_area.ini" )
	LuaFnSetSceneLoad_Monster( sceneId, "langhuanfudi_monster.ini" )

	local bRetSceneID = LuaFnCreateCopyScene(sceneId)
	BeginEvent(sceneId)
		if bRetSceneID>0 then
			AddText(sceneId,"副本创建成功！");
		else
			AddText(sceneId,"副本数量已达上限，请稍候再试！");
		end
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)

end

--**********************************
--副本事件....
--**********************************
function x893084_OnCopySceneReady( sceneId, destsceneId )
	--进入副本的规则
	-- 1，如果这个玩家没有组队，就传送这个玩家自己进入副本
	-- 2, 如果玩家有队伍，但是玩家不是队长，就传送自己进入副本
	-- 3，如果玩家有队伍，并且这个玩家是队长，就传送自己和附近队友一起进去
	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId) --设置副本入口场景号
	leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId)
	leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid)
	if LuaFnIsCanDoScriptLogic( sceneId, leaderObjId ) ~= 1 then
		return
	end

	--统计创建副本次数....
	--AuditPMFCreateFuben( sceneId, leaderObjId )

	if LuaFnHasTeam( sceneId, leaderObjId ) == 0  then
		NewWorld( sceneId, leaderObjId, destsceneId, x893084_g_Fuben_X, x893084_g_Fuben_Z) ;
	else
		if IsCaptain(sceneId, leaderObjId) == 0  then
			NewWorld( sceneId, leaderObjId, destsceneId, x893084_g_Fuben_X, x893084_g_Fuben_Z) ;
		else
			local	nearteammembercount = GetNearTeamCount( sceneId, leaderObjId) 
			local mems = {}
			for	i=0,nearteammembercount-1 do
				mems[i] = GetNearTeamMember(sceneId, leaderObjId, i)
				NewWorld( sceneId, mems[i], destsceneId, x893084_g_Fuben_X, x893084_g_Fuben_Z)
			end
		end		
	end

end

--**********************************
--副本场景定时器事件....
--**********************************
function x893084_OnCopySceneTimer( sceneId, nowTime )
	local lifeStep = LuaFnGetCopySceneData_Param( sceneId, x893084_g_IDX_FuBenLifeStep )
	if lifeStep == 9 then
		local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
		local oldSceneId = LuaFnGetCopySceneData_Param( sceneId, 3 )
		local oldX = LuaFnGetCopySceneData_Param( sceneId, 4 )
		local oldZ = LuaFnGetCopySceneData_Param( sceneId, 5 )
		for i=0, nHumanNum-1  do
			local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnIsObjValid( sceneId, PlayerId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, PlayerId ) == 1 then
				NewWorld( sceneId, PlayerId, oldSceneId, oldX, oldZ )
			end
		end
		return
	end


	if lifeStep >= 2 and lifeStep <= 5 then
		local ngwid = LuaFnGetCopySceneData_Param( sceneId, lifeStep + 7)
		local nxintiao = LuaFnGetCopySceneData_Param( sceneId, 13) + 1
		if nxintiao > 20 then
			nxintiao = 0
		end
		LuaFnSetCopySceneData_Param( sceneId, 13, nxintiao)
		CallScriptFunction(391709+lifeStep, "axiaoTimer",sceneId, ngwid, nxintiao)
	elseif lifeStep == 1 then
		LuaFnSetCopySceneData_Param( sceneId, x893084_g_IDX_FuBenLifeStep, 85 )
	elseif lifeStep == 85 then
		LuaFnSetCopySceneData_Param( sceneId, x893084_g_IDX_FuBenLifeStep, 84 )
	elseif lifeStep == 84 then
		LuaFnSetCopySceneData_Param( sceneId, x893084_g_IDX_FuBenLifeStep, 83 )
	elseif lifeStep == 83 then
		LuaFnSetCopySceneData_Param( sceneId, x893084_g_IDX_FuBenLifeStep, 82 )
	elseif lifeStep == 82 then
		LuaFnSetCopySceneData_Param( sceneId, x893084_g_IDX_FuBenLifeStep, 81 )
	elseif lifeStep == 81 then
		LuaFnSetCopySceneData_Param( sceneId, x893084_g_IDX_FuBenLifeStep, 2 )
	end
	--初始化副本内的NPC....
	if lifeStep == 0 then
		LuaFnSetCopySceneData_Param( sceneId, x893084_g_IDX_FuBenLifeStep, 1 )
		local nnandu = LuaFnGetCopySceneData_Param( sceneId, 8)
	if nnandu == 2 then
		local MstId= LuaFnCreateMonster(sceneId, 44170, 140, 63, 17, 351, 391711 )
		LuaFnSetCopySceneData_Param( sceneId, 9, MstId)		
		SetUnitCampID(sceneId, MstId, MstId, 0)
		SetUnitReputationID(sceneId, MstId, MstId, 29)

		MstId= LuaFnCreateMonster(sceneId, 44171, 212, 119, 17, 352, 391712 )
		SetUnitCampID(sceneId, MstId, MstId, 0)
		SetUnitReputationID(sceneId, MstId, MstId, 8)
		LuaFnSetCopySceneData_Param( sceneId, 10, MstId)		

		MstId= LuaFnCreateMonster(sceneId, 44173, 182, 206, 17, 353, 391713 )
		SetUnitCampID(sceneId, MstId, MstId, 0)
		SetUnitReputationID(sceneId, MstId, MstId, 8)
		LuaFnSetCopySceneData_Param( sceneId, 11, MstId)		

		MstId= LuaFnCreateMonster(sceneId, 44174, 82, 180, 17, 354, 391714 )
		SetUnitCampID(sceneId, MstId, MstId, 0)
		SetUnitReputationID(sceneId, MstId, MstId, 8)
		LuaFnSetCopySceneData_Param( sceneId, 12, MstId)
	else
		local MstId= LuaFnCreateMonster(sceneId, 44270, 140, 63, 17, 351, 391711 )
		LuaFnSetCopySceneData_Param( sceneId, 9, MstId)		
		SetUnitReputationID(sceneId, MstId, MstId, 29)

		MstId= LuaFnCreateMonster(sceneId, 44271, 212, 119, 17, 352, 391712 )
		SetUnitCampID(sceneId, MstId, MstId, 0)
		SetUnitReputationID(sceneId, MstId, MstId, 8)
		LuaFnSetCopySceneData_Param( sceneId, 10, MstId)		

		MstId= LuaFnCreateMonster(sceneId, 44273, 182, 206, 17, 353, 391713 )
		SetUnitCampID(sceneId, MstId, MstId, 0)
		SetUnitReputationID(sceneId, MstId, MstId, 8)
		LuaFnSetCopySceneData_Param( sceneId, 11, MstId)		

		MstId= LuaFnCreateMonster(sceneId, 44274, 82, 180, 17, 354, 391714 )
		SetUnitCampID(sceneId, MstId, MstId, 0)
		SetUnitReputationID(sceneId, MstId, MstId, 8)
		LuaFnSetCopySceneData_Param( sceneId, 12, MstId)
	end
	end
end

--**********************************
--有玩家进入副本事件....
--**********************************
function x893084_OnPlayerEnter( sceneId, selfId )

	--设置死亡事件....
	SetPlayerDefaultReliveInfo( sceneId, selfId, "%20", -1, "0", sceneId, x893084_g_Fuben_X, x893084_g_Fuben_Z )

	--设置挑战过一次缥缈峰....
	local lastTime = GetMissionDataEx( sceneId, selfId, MD_LANGHUANFUDI )
	local lastDayTime = floor( lastTime / 100 )
	local lastDayCount = mod( lastTime, 100 )
	local CurDayTime = GetDayTime()

	if CurDayTime > lastDayTime then
		lastDayTime = CurDayTime
		lastDayCount = 0
	end

	lastDayCount = lastDayCount + 1
	lastTime = lastDayTime * 100 + lastDayCount
	SetMissionDataEx( sceneId, selfId, MD_LANGHUANFUDI, lastTime )


end

--**********************************
--有玩家在副本中死亡事件....
--**********************************
function x893084_OnHumanDie( sceneId, selfId, killerId )
	
end

--**********************************
--提示所有副本内玩家....
--**********************************
function x893084_TipAllHuman( sceneId, Str )

	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid( sceneId, PlayerId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, PlayerId ) == 1 then
			BeginEvent(sceneId)
				AddText(sceneId, Str)
			EndEvent(sceneId)
			DispatchMissionTips(sceneId, PlayerId)
		end
	end

end
