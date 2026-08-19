--生死擂台
--2019-10-22 07:28:40 逍遥子二开 原作蝎子
--************************************************************************
--MisDescBegin

--脚本号
x892009_g_ScriptId = 892009

--复活次数
x892009_g_ReLifeTimes = 100
--副本名称
x892009_g_CopySceneName="生死擂台"
x892009_g_BossName = {"宋姜","李魁","吴永","卢君逸","公孙圣","关盛","鲁志生","呼延啄","林充","秦冥","花容","武颂"}
x892009_g_BossScript = {892016,892012,892015,892011,892014,892010,892017,892020,892019,892018,892013,892021}
x892009_g_BossTitle = {"天魁星","天杀星","天机星","天罡星","天闲星","天勇星","天孤星","天威星","天雄星","天猛星","天英星","天伤星"}
x892009_g_BossID = {}
x892009_g_BossID[70] = {13433,13442,13451,13460,13469,13478,13487,13496,13505,13514,13523,13532}
x892009_g_BossID[80] = {13434,13443,13452,13461,13470,13479,13488,13497,13506,13515,13524,13533}
x892009_g_BossID[90] = {13435,13444,13453,13462,13471,13480,13489,13498,13507,13516,13525,13534}
x892009_g_BossID[100] = {13436,13445,13454,13463,13472,13481,13490,13499,13508,13517,13526,13535}
x892009_g_BossID[110] = {13437,13446,13455,13464,13473,13482,13491,13500,13509,13518,13527,13536}
x892009_g_BossID[120] = {13438,13447,13456,13465,13474,13483,13492,13501,13510,13519,13528,13537}

x892009_g_DogID = {13541,13542,13543,13544,13545,13546}

x892009_g_MissBoss = {8,9,10,11,12,13}
--MisDescEnd
--************************************************************************

--角色Mission变量说明
x892009_g_Param_huan		=0	--0号：已经完成的环数，在接收任务时候赋值
x892009_g_Param_ok			=1	--1号：当前任务是否完成(0未完成；1完成)
x892009_g_Param_sceneid		=2	--2号：当前副本任务的场景号
x892009_g_Param_teamid		=3	--3号：接副本任务时候的队伍号
x892009_g_Param_killcount	=4	--4号：杀死任务怪的数量
x892009_g_Param_time		=5	--5号：完成副本所用时间(单位：秒)
--6号：未用
--7号：未用

x892009_g_CopySceneType=FUBEN_GODFIRE	--副本类型，定义在ScriptGlobal.lua里面
x892009_g_LimitMembers=1			--可以进副本的最小队伍人数
x892009_g_TickTime=5				--回调脚本的时钟时间（单位：秒/次）
x892009_g_LimitTotalHoldTime=360 	--360,1440副本可以存活的时间（单位：次数）,如果此时间到了，则任务将会失败--暂定半小时
x892009_g_LimitTimeSuccess=500		--360,1440副本时间限制（单位：次数），如果此时间到了，任务完成
x892009_g_CloseTick=6				--副本关闭前倒计时（单位：次数）
x892009_g_NoUserTime=5			--副本中没有人后可以继续保存的时间（单位：秒）
x892009_g_DeadTrans=0				--死亡转移模式，0：死亡后还可以继续在副本，1：死亡后被强制移出副本
x892009_g_Fuben_X=16				--进入副本的位置X
x892009_g_Fuben_Z=33				--进入副本的位置Z
--还没定义
x892009_g_TotalNeedKill=6			--需要杀死怪物数量

--**********************************
--任务入口函数
--**********************************
function x892009_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
    if sceneId == 2 then
		AddText( sceneId, "#{SXRW_090119_001}" )	
		AddNumText( sceneId, x892009_g_ScriptId, "#{SXRW_090119_015}", 10, 1 )
		AddNumText( sceneId, x892009_g_ScriptId, "#{SXRW_090119_003}", 11, 2 )
		--
		AddNumText( sceneId, x892009_g_ScriptId, "#{FBSD_150126_03}", 11, 3 )
    else
		AddText( sceneId, "#{SXRW_090119_001}" )	
		AddNumText( sceneId, x892009_g_ScriptId, "送我回大理", 9, 4 )
    end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--随机生成怪物
--**********************************
function x892009_XuanGuai(sceneId, selfId )
    local shuzu = {}
    while getn(shuzu) < 6 do
        local pdcf = 0
        local seed = random(12)
        if getn(shuzu) > 0 then
            for i = 1,getn(shuzu) do
                if seed == shuzu[i] then
                    pdcf = 1
                end
            end
        end
        if pdcf == 0 then
            shuzu[getn(shuzu)+1] = seed
        end
    end
    return shuzu[1],shuzu[2],shuzu[3],shuzu[4],shuzu[5],shuzu[6]
end

--**********************************
--事件列表选中一项
--**********************************
function x892009_OnEventRequest( sceneId, selfId, targetId, eventId)
	if GetNumText() == 1 then
	    local ret, msg = x892009_CheckAccept( sceneId, selfId, targetId )
	    if 1 ~= ret then
			BeginEvent(sceneId)
				AddText(sceneId,msg)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
	    end
	    local nearmembercount = GetNearTeamCount( sceneId, selfId )
	    x892009_MakeCopyScene( sceneId, selfId, nearmembercount )
	elseif GetNumText() == 2 then
	    BeginEvent( sceneId )
			AddText( sceneId, "#{SXRW_090119_069}" )
	    EndEvent( sceneId )
	    DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 3 then
	    BeginEvent( sceneId )
			AddText( sceneId, "#{FBSD_150126_04}" )
	    EndEvent( sceneId )
	    DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 4 then
        CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 130, 77 )
	end
end

--**********************************
--检测接受条件
--**********************************
function x892009_CheckAccept( sceneId, selfId, targetId )
--	if  1== 1 then
--		return 1,""
--	end
	if GetLevel(sceneId,selfId) < 70 then
		return 0,"#{SXRW_090119_011}"
	end

	if LuaFnHasTeam(sceneId,selfId) ~= 1 then
		return 0, "#{SXRW_090119_014}"
	end

	--是不是队长....
	if GetTeamLeader(sceneId,selfId) ~= selfId then
		return 0, "#{SXRW_090119_018}"
	end

	--人数是否够....
	if GetTeamSize(sceneId,selfId) < 3 then
		return 0, "#{SXRW_090119_019}"
	end

	--是否都在附近....
	local NearTeamSize = GetNearTeamCount(sceneId,selfId)
	if GetTeamSize(sceneId,selfId) ~= NearTeamSize then
		return 0, "#{SXRW_090119_020}"
	end

	local Humanlist = {}
	local nHumanNum = 0

	--是否有人不够90级....
	for i=0, NearTeamSize-1 do
		local PlayerId = GetNearTeamMember( sceneId, selfId, i )
		if GetLevel( sceneId, PlayerId ) < 75 then
			Humanlist[nHumanNum] = GetName( sceneId, PlayerId )
			nHumanNum = nHumanNum + 1
		end
	end

	if nHumanNum > 0 then

		local msg = "#{SXRW_090119_027}"
		for i=0, nHumanNum - 2 do
			msg = msg .. Humanlist[i] .. "，"
		end
		msg = msg .. Humanlist[nHumanNum - 1] .. "的修为尚浅，不足75级，还是不要去为妙。"
		return 0, msg

	end

	nHumanNum = 0
	local CurDayTime = GetDayTime()
	for i=0, NearTeamSize-1 do
		local PlayerId = GetNearTeamMember( sceneId, selfId, i )
		local lastTime = GetMissionDataEx(sceneId, PlayerId, MD_SHENGSILEITAI)
		local lastDayTime = floor( lastTime / 100 )
		local lastDayCount = mod( lastTime, 100 )
		if CurDayTime > lastDayTime then
			lastDayTime = CurDayTime
			lastDayCount = 0
		end
		if lastDayCount >= 2 then
			Humanlist[nHumanNum] = GetName( sceneId, PlayerId )
			nHumanNum = nHumanNum + 1
		end
	end

	if nHumanNum > 0 then
		local msg = "    "
		for i=0, nHumanNum-2 do
			msg = msg .. Humanlist[i] .. "，"
		end
		msg = msg .. Humanlist[nHumanNum-1] .. "今天已经挑战过2次杀星了。"
		return 0, msg
	end
	return	1, msg
end

--**********************************
--接受
--**********************************
function x892009_OnAccept( sceneId, selfId, targetId )
	
end

--**********************************
--放弃
--**********************************
function x892009_OnAbandon( sceneId, selfId )
	
end

--**********************************
--创建副本
--**********************************
function x892009_MakeCopyScene( sceneId, selfId, nearmembercount)
    local teamemissdata = {}
    teamemissdata[1],teamemissdata[2],teamemissdata[3],teamemissdata[4],teamemissdata[5],teamemissdata[6] = x892009_XuanGuai(sceneId, selfId )

	--指数参数
	local	param0	= 4;
	local	param1	= 3;

	--最终结果
	local nHumanLevel	= 0;

	--临时变量
	local mems		= {};
	local	tempMemlevel = 0;
	local	level0 = 0;
	local	level1 = 0;
	for	i = 0, nearmembercount - 1 do
		mems[i]	= GetNearTeamMember(sceneId, selfId, i);
		tempMemlevel = GetLevel(sceneId, mems[i]);
		level0	= level0 + (tempMemlevel ^ param0);
		level1	= level1 + (tempMemlevel ^ param1);
	end

	if level1 == 0 then
		nHumanLevel = 70;
	else
		nHumanLevel = level0/level1;
	end

    nHumanLevel = floor(nHumanLevel/10) * 10
	if nHumanLevel < 70 then
		nHumanLevel = 70;
	elseif nHumanLevel > 120 then
		nHumanLevel = 120
    end

	local leaderguid = LuaFnObjId2Guid(sceneId,selfId)
	LuaFnSetSceneLoad_Map(sceneId, "shengsileitai.nav"); --地图是必须选取的，而且必须在Config/SceneInfo.ini里配置好
	LuaFnSetCopySceneData_TeamLeader(sceneId, leaderguid);
	LuaFnSetCopySceneData_NoUserCloseTime(sceneId, x892009_g_NoUserTime*1000);
	LuaFnSetCopySceneData_Timer(sceneId, x892009_g_TickTime*1000);
	LuaFnSetCopySceneData_Param(sceneId, 0, x892009_g_CopySceneType);--设置副本数据，这里将0号索引的数据设置为999，用于表示副本号999(数字自定义)
	LuaFnSetCopySceneData_Param(sceneId, 1, x892009_g_ScriptId);--将1号数据设置为副本场景事件脚本号
	LuaFnSetCopySceneData_Param(sceneId, 2, 0);--设置定时器调用次数
	LuaFnSetCopySceneData_Param(sceneId, 3, -1);--设置副本入口场景号, 初始化
	LuaFnSetCopySceneData_Param(sceneId, 4, 0);--设置副本关闭标志, 0开放，1关闭
	LuaFnSetCopySceneData_Param(sceneId, 5, 0);--设置离开倒计时次数
	LuaFnSetCopySceneData_Param(sceneId, 6, GetTeamId(sceneId,selfId)); --保存队伍号
	LuaFnSetCopySceneData_Param(sceneId, 7, 0) ;--杀死Boss的数量
	LuaFnSetCopySceneData_PvpRuler( sceneId, 9 )

	for i = 8,13 do
	    if teamemissdata[i - 7] ~= nil then
	        LuaFnSetCopySceneData_Param( sceneId, i,teamemissdata[i-7] )
	    else
	        LuaFnSetCopySceneData_Param( sceneId, i,0 )
	    end
	end

	local x,z = GetWorldPos( sceneId, selfId )		
    LuaFnSetSceneLoad_Monster( sceneId, "shengsileitai_monster.ini" )
	local CopyScene_LevelGap = 31
	LuaFnSetCopySceneData_Param(sceneId, CopyScene_LevelGap, nHumanLevel) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值
	local bRetSceneID = LuaFnCreateCopyScene(sceneId); --初始化完成后调用创建副本函数
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
--继续
--**********************************
function x892009_OnContinue( sceneId, selfId, targetId )
	
end

--**********************************
--检测是否可以提交
--**********************************
function x892009_CheckSubmit( sceneId, selfId )
	
end

--**********************************
--提交
--**********************************
function x892009_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	
end

--**********************************
--玩家数值操作
--**********************************
function x892009_AddPlayerPrize(sceneId)
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanNum-1  do
		local PlayerId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid( sceneId, PlayerId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, PlayerId ) == 1 then
			local nTeamLeader = GetTeamLeader(sceneId,PlayerId);
			AddGlobalCountNews( sceneId,"#{SXRW_090119_038}"..GetName(sceneId,nTeamLeader).."#{SXRW_090119_039}#{SXRW_090119_040}")
			break;
		end
	end
	
	
end
--**********************************
--怪物死亡
--**********************************
function x892009_OnDie(sceneId, objId, killerId)
--  CallScriptFunction( 898992, "MonsterOnDie", sceneId, objId, killerId,1 )
    CallScriptFunction( 501000, "OnDie", sceneId, objId, killerId)
end
--**********************************
--杀死怪物或玩家
--**********************************
function x892009_OnKillObject( sceneId, selfId, objdataId ,objId )
	
end

--**********************************
--进入区域事件
--**********************************
function x892009_OnEnterZone( sceneId, selfId, zoneId )
	
end

--**********************************
--道具改变
--**********************************
function x892009_OnItemChanged( sceneId, selfId, itemdataId )
end

--**********************************
--副本事件
--**********************************
function x892009_OnCopySceneReady( sceneId, destsceneId )
	LuaFnSetCopySceneData_Param(destsceneId, 3, sceneId);--设置副本入口场景号
	local leaderguid  = LuaFnGetCopySceneData_TeamLeader(destsceneId) ;
	local leaderObjId = LuaFnGuid2ObjId(sceneId,leaderguid);
	NewWorld( sceneId,leaderObjId, destsceneId, x892009_g_Fuben_X, x892009_g_Fuben_Z)
	local nearmembercount = GetNearTeamCount( sceneId, leaderObjId )
	local member
	for	i=0, nearmembercount - 1 do
		member = GetNearTeamMember( sceneId, leaderObjId, i )
		if LuaFnIsCanDoScriptLogic( sceneId, member ) == 1 then
			NewWorld( sceneId, member, destsceneId, x892009_g_Fuben_X, x892009_g_Fuben_Z )
		end
	end
end

--**********************************
--有玩家进入副本事件
--**********************************
function x892009_OnPlayerEnter( sceneId, selfId )

	--设置死亡后复活点位置
	SetPlayerDefaultReliveInfo( sceneId, selfId, "%50", "%50", "%50", sceneId, x892009_g_Fuben_X, x892009_g_Fuben_Z );

	local lastTime = GetMissionDataEx(sceneId, selfId, MD_SHENGSILEITAI)
	local lastDayTime = floor( lastTime / 100 )
	local lastDayCount = mod( lastTime, 100 )
	local CurDayTime = GetDayTime()
	if CurDayTime > lastDayTime then
		lastDayTime = CurDayTime
		lastDayCount = 0
	end
	lastDayCount = lastDayCount + 1
	lastTime = lastDayTime * 100 + lastDayCount
	SetMissionDataEx(sceneId, selfId, MD_SHENGSILEITAI,lastTime)
	if lastDayCount > 2 then
		x892009_KickOut( sceneId, selfId )
	end

	--创建初始NPC....
	local nHumanLevel = LuaFnGetCopySceneData_Param(sceneId, 31)
	local nCount = GetMonsterCount(sceneId)
	if nCount < 2 then
		for i = 1,6 do
			local BossId = LuaFnGetCopySceneData_Param(sceneId, i+7)
			if BossId ~= 0 then
				local objId = LuaFnCreateMonster(sceneId, x892009_g_BossID[nHumanLevel][BossId], 46, 16+i*4, 19, 0, x892009_g_BossScript[BossId] )
				SetUnitReputationID(sceneId, objId, objId, 0)
				SetCharacterTitle(sceneId, objId, x892009_g_BossTitle[BossId])
				SetObjDir(sceneId,objId, 18 )
			end
		end
	end
end

--**********************************
--有玩家在副本中死亡事件
--**********************************
function x892009_OnHumanDie( sceneId, selfId, killerId )
	
end

--**********************************
--刷新擂台煞星
--**********************************
function x892009_RefreshNewMonster(sceneId,selfId,targetId)
	--是不是队长....
	if GetTeamLeader(sceneId,selfId) ~= selfId then
		x892009_NotifyTip( sceneId, selfId, "#{SXGWTZ_150415_09}" )
		return
	end
	
	BeginEvent(sceneId)
		AddText(sceneId,"#{SXGWTZ_150415_03}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--副本场景定时器事件
--**********************************
function x892009_OnCopySceneTimer( sceneId, nowTime )
	--副本时钟读取及设置
	local TickCount = LuaFnGetCopySceneData_Param(sceneId, 2) ;--取得已经执行的定时次数
	TickCount = TickCount+1 ;
	LuaFnSetCopySceneData_Param(sceneId, 2, TickCount);--设置新的定时器调用次数
	local CopyScene_LevelGap = 31
	local nHumanLevel = LuaFnGetCopySceneData_Param(sceneId, CopyScene_LevelGap) --级别差，CopyScene_LevelGap 在 scene.lua 中赋值

	--副本关闭标志
	leaveFlag = LuaFnGetCopySceneData_Param(sceneId, 4) ;
	if TickCount == 1 then
		--通知当前副本场景里的所有人，准备出怪
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			BeginEvent(sceneId)
				local nBossId = LuaFnGetCopySceneData_Param(sceneId,x892009_g_MissBoss[1])
				strText = format("%s·%s将在%s秒后加入战斗，请做好准备!",x892009_g_BossTitle[nBossId],x892009_g_BossName[nBossId],10)
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,mems[i])
		end
	end


	if TBsytiemer ~= nil and  TickCount == TBsytiemer then
		--通知当前副本场景里的所有人，准备出怪	   		
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			if TBsytiemer1 < 7 then	
				delmiss = LuaFnGetCopySceneData_Param(sceneId,x892009_g_MissBoss[TBsytiemer1-1])
				local nMonsterNum = GetMonsterCount(sceneId)
				for j=0, nMonsterNum-1 do
					local MonsterId = GetMonsterObjID(sceneId,j)
					local MosDataID = GetMonsterDataID(sceneId, MonsterId )
					if MosDataID == x892009_g_BossID[nHumanLevel][delmiss] then
						SetUnitReputationID(sceneId, MonsterId, MonsterId, 28)
						SetPos(sceneId, MonsterId, 30, 32)
						LuaFnSendSpecificImpactToUnit(sceneId, MonsterId, MonsterId, MonsterId,18,0)
						break
					end
				end
			else
				delmiss = LuaFnGetCopySceneData_Param(sceneId,x892009_g_MissBoss[6])
				--遍历场景中所有的怪....更新BOSS重建状态....
				local nMonsterNum = GetMonsterCount(sceneId)
				for k=0, nMonsterNum-1 do
					local MonsterId = GetMonsterObjID(sceneId,k)
					local MosDataID = GetMonsterDataID( sceneId, MonsterId )
					if MosDataID == x892009_g_BossID[nHumanLevel][delmiss] then
						SetUnitReputationID(sceneId, MonsterId, MonsterId, 28)
						SetPos(sceneId, MonsterId, 30, 32)
						LuaFnSendSpecificImpactToUnit(sceneId, MonsterId, MonsterId, MonsterId,18,0)
						break
					end
				end
			end
			BeginEvent(sceneId)
				strText = format("%s·%s加入了战斗，#{SXRW_090714_127}",x892009_g_BossTitle[delmiss],x892009_g_BossName[delmiss])
				AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,mems[i])     
		end
		TBsytiemer = nil
		TBsytiemer1 = nil
	end

	local a,b = x892009_SetFubenTimer( sceneId, 0,2 )
	if a ~= 0 and b ~= 0 then
		TBsytiemer = a
		TBsytiemer1 = b
		--通知当前副本场景里的所有人，准备出怪
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			BeginEvent(sceneId)
			if b <= 7 then
				local nBossId = LuaFnGetCopySceneData_Param(sceneId,x892009_g_MissBoss[b-1])
				strText = format("下一个煞星将在%s秒后主动出现，队长与任意剩余杀星对话都可以直接开启挑战！",x892009_g_BossName[nBossId],(a-TickCount)*5)
			end
			AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,mems[i])
		end
	end

    if TickCount == 2 then
		--通知当前副本场景里的所有人，准备出怪
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
			local miss = LuaFnGetCopySceneData_Param(sceneId, x892009_g_MissBoss[1])
			local nMonsterNum = GetMonsterCount(sceneId)
			for j=0, nMonsterNum-1 do
	            local MonsterId = GetMonsterObjID(sceneId,j)
	            local MosDataID = GetMonsterDataID(sceneId, MonsterId )
	            if MosDataID == x892009_g_BossID[nHumanLevel][miss] then
					SetUnitReputationID(sceneId, MonsterId, MonsterId, 28)
					SetPos(sceneId, MonsterId, 30, 32)
					LuaFnSendSpecificImpactToUnit(sceneId, MonsterId, MonsterId, MonsterId,18,0)
					break
                end
			end
			BeginEvent(sceneId)
	            strText = format("可以挑战%s·%s了!",x892009_g_BossTitle[miss],x892009_g_BossName[miss])
	            AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,mems[i])                
        end
    end

	if leaveFlag == 1 then --需要离开
		--离开倒计时间的读取和设置
		leaveTickCount = LuaFnGetCopySceneData_Param(sceneId, 5) ;
		leaveTickCount = leaveTickCount+1 ;
		LuaFnSetCopySceneData_Param(sceneId, 5, leaveTickCount) ;
		if leaveTickCount == x892009_g_CloseTick then --倒计时间到，大家都出去吧
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
			--将当前副本场景里的所有人传送回原来进入时候的场景
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
			local mems = {}
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				x892009_KickOut( sceneId, mems[i] )
				----调用同一个函数NewWorld( sceneId, mems[i], oldsceneId, x892009_g_Back_X, x892009_g_Back_Z )
			end
		elseif leaveTickCount<x892009_g_CloseTick then
			oldsceneId = LuaFnGetCopySceneData_Param(sceneId, 3) ;--取得副本入口场景号
			--通知当前副本场景里的所有人，场景关闭倒计时间
			local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
			local mems = {}
			for	i=0,membercount-1 do
				mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)
				BeginEvent(sceneId)
					strText = format("你将在%d秒后离开场景!", (x892009_g_CloseTick-leaveTickCount)*x892009_g_TickTime )
					AddText(sceneId,strText);
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,mems[i])
			end
		end
	elseif TickCount == x892009_g_LimitTimeSuccess then
		--此处设置有时间限制的任务完成处理
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)

  			BeginEvent(sceneId)
  				AddText(sceneId,"任务时间到，完成!");
  			EndEvent(sceneId)
  			DispatchMissionTips(sceneId,mems[i])	
		end
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1) ;
	elseif TickCount == x892009_g_LimitTotalHoldTime then --副本总时间限制到了
		--此处设置副本任务有时间限制的情况，当时间到后处理...
		local membercount = LuaFnGetCopyScene_HumanCount(sceneId)
		local mems = {}
		for	i=0,membercount-1 do
			mems[i] = LuaFnGetCopyScene_HumanObjId(sceneId,i)

  			BeginEvent(sceneId)
  				AddText(sceneId,"任务失败，超时!");
  			EndEvent(sceneId)
  			DispatchMissionTips(sceneId,mems[i])
		end
		--设置副本关闭标志
		LuaFnSetCopySceneData_Param(sceneId, 4, 1) ;
	end
end
--**********************************
--将某玩家传送出副本,回到进入时的位置
--**********************************
function x892009_KickOut( sceneId, objId )
	if LuaFnIsCharacterLiving(sceneId, objId) ~= 1 or LuaFnIsObjValid( sceneId, objId ) ~= 1 or LuaFnIsCanDoScriptLogic( sceneId, objId ) ~= 1 then
		return
    end
    local oldsceneId = LuaFnGetCopySceneData_Param( sceneId, 3 )	--取得副本入口场景号
	local x = 252 --进入时的坐标X
	local z = 259 --进入时的坐标Z
	if oldsceneId == 0 then
		x = 217 --进入时的坐标X
		z = 242 --进入时的坐标Z
	elseif  oldsceneId == 1 then
		x = 200 --进入时的坐标X
		z = 334 --进入时的坐标Z
	elseif  oldsceneId == 2 then
		x = 131 --进入时的坐标X
		z = 82 --进入时的坐标Z
	end
	if LuaFnIsObjValid( sceneId, objId ) == 1 then
	    NewWorld( sceneId, objId, oldsceneId, x, z )
	end
	
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x892009_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x892009_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- 检测开放时间
--**********************************
function x892009_IsActivityOpen(sceneId)
	local nHour = GetHour();
	local nMinute = GetMinute();
	local nCurTempTime = nHour * 60 + nMinute;
	if nCurTempTime >= 20 * 60 and nCurTempTime < 21 * 60 + 20 then
		return 1;
	end
	return 0;
--	return 1
end
--**********************************
-- 检测开放时间2
--**********************************
function x892009_IsActivityOpen2(sceneId)
	local nHour = GetHour();
	local nMinute = GetMinute();
	local nCurTempTime = nHour * 60 + nMinute;
	if nCurTempTime >= 21 * 60 + 20 and nCurTempTime < 21 * 50 then
		return 1;
	end
	return 0;
--	return 1
end
--**********************************
-- 赋值
--**********************************
function x892009_ToMax( sceneId, selfId, killerId ,guildName,maxCount )
	PK_MAXCOUNTGUILD=guildName
	PK_MAXCOUNT=maxCount
end
--**********************************
-- 全球通告
--**********************************
function x892009_GlobalCountNews( sceneId, selfId, targetId,str )
	AddGlobalCountNews( sceneId, str )
end
--**********************************
--提示所有副本内玩家....
--**********************************
function x892009_TipAllHuman( sceneId, Str )
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
--**********************************
--珍兽装备掉包
--**********************************
function x892009_OnDropBoxFromBoss(sceneId,selfId,nIndex)
	--38000639
	--20301007
	local nHumanNum = LuaFnGetCopyScene_HumanCount(sceneId)
	for i = 0, nHumanNum - 1 do
	    local nObjId = LuaFnGetCopyScene_HumanObjId( sceneId, i )
        local nRand = random(100)
		local nDorpItemNum = 0;
		local nDorpItemMax = 4;--2019-11-3 15:25:12 逍遥子修正，底层最大数量为4
		if nRand <= 30 and nDorpItemNum < nDorpItemMax then
			--长生草
			AddMonsterDropItem( sceneId, selfId, nObjId,38000639 );
			nDorpItemNum = nDorpItemNum + 1;
		end
		if nRand <= 50 and nDorpItemNum < nDorpItemMax then
			--圣兽鳞
			AddMonsterDropItem( sceneId, selfId, nObjId,20301007 );
			nDorpItemNum = nDorpItemNum + 1;
		end	
		if nRand <= 45 and nDorpItemNum < nDorpItemMax then
			--换颜丹
			AddMonsterDropItem( sceneId, selfId, nObjId,30502007 );
			nDorpItemNum = nDorpItemNum + 1;
		end		
		if nRand <= 45 and nDorpItemNum < nDorpItemMax then
			--魂冰珠1级
			AddMonsterDropItem( sceneId, selfId, nObjId,20310117 );
			nDorpItemNum = nDorpItemNum + 1;
		end
		if nRand <= 25 and nDorpItemNum < nDorpItemMax then
			--雕纹蚀刻
			AddMonsterDropItem( sceneId, selfId, nObjId,30503149 );
			nDorpItemNum = nDorpItemNum + 1;
		end	
		if nRand <= 25 and nDorpItemNum < nDorpItemMax then
			--熔金粉
			AddMonsterDropItem( sceneId, selfId, nObjId,30503150 );
			nDorpItemNum = nDorpItemNum + 1;
		end
		if nRand <= 35 and nDorpItemNum < nDorpItemMax then
			--金蚕丝
			AddMonsterDropItem( sceneId, selfId, nObjId,20310167 );
			nDorpItemNum = nDorpItemNum + 1;
		end	
		if nRand <= 55 and nDorpItemNum < nDorpItemMax then
			--功力丹
			AddMonsterDropItem( sceneId, selfId, nObjId,38000655 );
			nDorpItemNum = nDorpItemNum + 1;
		end		
		if nRand <= 55 and nDorpItemNum < nDorpItemMax then
			--500元宝票
			AddMonsterDropItem( sceneId, selfId, nObjId,30008090 );
			nDorpItemNum = nDorpItemNum + 1;
		end
		--BOSS死亡记录
		local nBossDataTab = {231,231,232,232,233,233,234,234,235,235,236,236}
		local nBossData = GetMissionDataEx(sceneId,nObjId,nBossDataTab[nIndex]);
		if mod(nIndex,2) == 0 then
			nBossData = nBossData + 10000;
		else
			nBossData = nBossData + 1;
		end
		SetMissionDataEx(sceneId,nObjId,nBossDataTab[nIndex],nBossData);
    end
end
--**********************************
--副本场景定时器事件
--**********************************
function x892009_SetFubenTimer( sceneId, nowTime,tabey )
    if tabey == 1 then
		Timer = LuaFnGetCopySceneData_Param(sceneId, 2) ;--取得已经执行的定时次数
		FubenTimer = Timer+5
		TBtiemer = nowTime
		return
	end
	if tabey == 2 then
		if TBtiemer == nil then
			return 0,0
		end
		atiemer = TBtiemer
		TBtiemer = nil
		return FubenTimer,atiemer
    end
end
--**********************************
--醒目提示
--**********************************
function x892009_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

