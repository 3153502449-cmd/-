----帮战脚本 by 卓越 qq:314696597
----脚本号
----本脚本 需要在场景文件中增加  启动定时器，死亡 ，进入场景 和全局变量 MF_BZ_JIFEN MF_BZ_LIANZHAN MF_BZ_MYKILL MF_BZ_LASTPLAY MD_SONGLIAO_LASTPLAY
----14003 紫，14005 橙14007黄 14009 绿
x889630_g_scriptId = 889630
x889630_g_hudongtime ={  { 20,45},{21,30} } -----设置活动开始,结束范围----如是7点，就写  {7，0} 不要写 {07，00}-后面是结束时间
x889630_g_Back_scene,x889630_g_Back_X ,x889630_g_Back_Z =0,91,177   -------出副本的场景ID和坐标
x889630_g_playerLevel = 90  ---大于100级的玩家进入战场会有公告
x889630_jiangliYB = {30000,20000,10000,1000} -------设置帮战结束 个人元宝奖励，分别是第一名，第二名，第三名，第四名
x889630_jiangliZB = {0.5,0.2,0.1,0.1}
x889630_killjifen = 5  ----设置每杀一个人个人和帮派增加的积分
x889630_gonggaolevel = 90  ----设置死亡或杀死别人上帮会公告的等级
x889630_gonggaoHp = 100000 ----设置死亡或杀死别人上帮会公告的血量
x889630_bzboss_time = 3000 ----帮战BOSS出现的时间，单位秒
---------------水晶的坐标---------------------------
x889630_g_MosterDing = {
{  ID=14003, PosX=90,  PosY=229, BaseAI=7, ExtAIScript=-1, ScriptID=889632  },---紫
{  ID=14005, PosX=229,  PosY=230, BaseAI=7, ExtAIScript=-1, ScriptID=889632  },---橙
{  ID=14007, PosX=92,  PosY=90, BaseAI=7, ExtAIScript=-1, ScriptID=889632  },---黄
{  ID=14009, PosX=228,  PosY=90, BaseAI=7, ExtAIScript=-1, ScriptID=889632  },---绿
{  ID=14004, PosX=161,  PosY=161, BaseAI=7, ExtAIScript=-1, ScriptID=889632  },---绿
}

---------------守卫塔1的坐标---------------------------
x889630_g_MosterTa = {
{  ID=14715, PosX=245,  PosY=159, BaseAI=25, ExtAIScript=303, ScriptID=889631  },---东
{  ID=14715, PosX=161,  PosY=246, BaseAI=25, ExtAIScript=303, ScriptID=889631  },---南
{  ID=14715, PosX=72,  PosY=161, BaseAI=25, ExtAIScript=303, ScriptID=889631  },---西
{  ID=14715, PosX=161,  PosY=63, BaseAI=25, ExtAIScript=303, ScriptID=889631  },---北
}
---------------守卫塔2的坐标---------------------------
x889630_g_MosterTa2 = {
{  ID=13325, PosX=265,  PosY=159, BaseAI=25, ExtAIScript=303, ScriptID=889631  },---东
{  ID=13325, PosX=161,  PosY=266, BaseAI=25, ExtAIScript=303, ScriptID=889631  },---南
{  ID=13325, PosX=52,  PosY=161, BaseAI=25, ExtAIScript=303, ScriptID=889631  },---西
{  ID=13325, PosX=161,  PosY=43, BaseAI=25, ExtAIScript=303, ScriptID=889631  },---北
}

---------------四个NPC的坐标---------------------------
x889630_g_MosterNPC = {
{  ID=14002, PosX=255,  PosY=159, BaseAI=7, ExtAIScript=-1, ScriptID=889633  },---东
{  ID=14002, PosX=161,  PosY=256, BaseAI=7, ExtAIScript=-1, ScriptID=889633  },---南
{  ID=14002, PosX=62,  PosY=161, BaseAI=7, ExtAIScript=-1, ScriptID=889633  },---西
{  ID=14002, PosX=161,  PosY=53, BaseAI=7, ExtAIScript=-1, ScriptID=889633  },---北
}

x889630_g_Moster_Boss ={  ID=45808, PosX=999,  PosY=999, BaseAI=0, ExtAIScript=272, ScriptID=-1  }---帮战战场BOSS

cs_intX = {
[256] =11,
[160] =12,
[60] =13,
[160] =14,
}
cs_intZ = {
[157] =11,
[256] =12,
[160] =13,
[55] =14,
}

--**********************************
---场景定时判断
--**********************************
function x889630_TongZi( sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount >=1 then
		for i=1, nHumanCount do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
			if LuaFnIsObjValid( sceneId, nHumanId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, nHumanId ) == 1 then
				x889630_Tips( sceneId, nHumanId, "帮战正式开始，四方水晶已刷新，击杀水晶可得积分！" )
			end
		end
	end
end

function x889630_OnSceneTimer( sceneId)
	
	local isok,duojiukaishi,yikaishiTime,duojiujieshu,yiguotime = x889630_GetTimer(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if isok ==0 then  ------活动结束或者未开始
		if nHumanCount >=1 then
			for i=1, nHumanCount do
				local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
				if LuaFnIsObjValid( sceneId, nHumanId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, nHumanId ) == 1 then
					x889630_Tips( sceneId, nHumanId, "现在不是帮战活动时间,您将被传送出去！" )
					NewWorld( sceneId, nHumanId, x889630_g_Back_scene, x889630_g_Back_X, x889630_g_Back_Z )
				end
			end
		end
		if yiguotime ==1 then
			LuaFnSetCopySceneData_Param( sceneId,4,0)
			LuaFnSetCopySceneData_Param( sceneId,31,0)
			LuaFnSetCopySceneData_Param( sceneId,11,0)
			LuaFnSetCopySceneData_Param( sceneId,12,0)
			LuaFnSetCopySceneData_Param( sceneId,13,0)
			LuaFnSetCopySceneData_Param( sceneId,14,0)
		end
		return
	end
	
	local jieshubiaoji = LuaFnGetCopySceneData_Param( sceneId,4)
	if nHumanCount <1 or jieshubiaoji ==1 then
		return
	end
	
	local nowtime=LuaFnGetCopySceneData_Param( sceneId,31)
	nowtime = nowtime+1
	LuaFnSetCopySceneData_Param( sceneId,31,nowtime)
	---------场景数据清空-----------
	if nowtime ==60 and jieshubiaoji ==0 then
		x889630_ClearMonster(sceneId,1) ----清除场景中原来水晶
		x889630_UPCampMoster(sceneId)  ---更新水晶
		x889630_TongZi( sceneId)
	end

	--if nowtime ==x889630_bzboss_time and jieshubiaoji ==0 then
	--	local MonsterID = LuaFnCreateMonster(sceneId, x889630_g_Moster_Boss.ID, x889630_g_Moster_Boss.PosX, x889630_g_Moster_Boss.PosY, x889630_g_Moster_Boss.BaseAI, x889630_g_Moster_Boss.ExtAIScript, x889630_g_Moster_Boss.ScriptID )
	--	if MonsterID >=0 then
	--		SetCharacterName( sceneId,MonsterID,"浴火重生")
	--	else
	--		AddGlobalCountNews(sceneId,"公告：帮战BOSS已经刷新在161，161附近，击杀可掉落大量宝物！")
	--	end	
	--end
	
	if duojiujieshu ==1 and  jieshubiaoji == 0 then 	----- 活动结束1分钟后全场景通告
		LuaFnSetCopySceneData_Param( sceneId, 4,1) ---加个结束标志
		AddGlobalCountNews ( sceneId, "本次帮派大战圆满结束,奖励将由系统自动发放，请注意查收！将于1分钟后传出战场！" )
		local ret = x889630_jiangli( sceneId )
		if ret== 1 then
			x889630_ClearMonster(sceneId,0) ----清除所有怪
			x889630_qingkong(sceneId )  ---清空文档！
		end
		
		if nHumanCount >=1 then
			for i=1, nHumanCount do
				local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
				SetUnitCampID(sceneId,nHumanId ,nHumanId, 0 )	 -------设置新手阵营
				SetPvpAuthorizationFlagByID(sceneId, nHumanId, 2, 0) -----关闭竞技
			end
		end
	end
	
end

-----------------进入场景事件------------------
function x889630_OnPlayerEnter( sceneId, playerId )
	-------清空数据----
	SetMissionData( sceneId, playerId, MF_BZ_JIFEN,0)
	SetMissionData( sceneId, playerId, MF_BZ_LIANZHAN,0)
	SetMissionData( sceneId, playerId, MF_BZ_MYKILL,0)
	SetMissionData( sceneId, playerId, MF_BZ_LASTPLAY,0)
	------------
	local isok,duojiukaishi,yikaishiTime,duojiujieshu,yiguotime = x889630_GetTimer(sceneId)
	if isok ==0 then
		return
	end
	RestoreHp( sceneId, playerId )
	RestoreMp( sceneId, playerId )
	RestoreRage( sceneId, playerId)
	SetPvpAuthorizationFlagByID(sceneId, playerId, 2, 1) -----设置竞技
	local sismyguildid 	= GetHumanGuildID(sceneId,playerId)
	local Xpos,Zpos = GetWorldPos(sceneId,playerId)
	
	local nHour	 = GetHour()--小时
	local nMinute = GetMinute()--分钟
	
	if (nHour > 20 and nMinute==40) or (nHour < 21 and nMinute==25)then
		SetPlayerDefaultReliveInfo( sceneId, playerId, "%100", "%100", "%100",0,91,189 )--洛阳复活
	end
	
	if (nHour > 21 and nMinute==25) then
		SetPlayerDefaultReliveInfo( sceneId, playerId, "%100", "%100", "%100",sceneId,Xpos,Zpos )--原地复活
	end
	
	SetUnitCampID(sceneId,playerId ,playerId, sismyguildid+100 )
	x889630_KaiTa(sceneId,playerId,(sismyguildid+100) ) --------自动开附近的塔子
	local nowtime=LuaFnGetCopySceneData_Param( sceneId,31)
	if nowtime <60 then
		x889630_Tips( sceneId, playerId, "帮战将于"..(60-nowtime).."秒后正式开始" )
	else
		x889630_Tips( sceneId, playerId, "帮战已经进行了"..(nowtime-60).."秒,请快去寻找大部队吧！" )
	end
	--------一定等级的玩家给进入公告-------
	if  GetLevel(sceneId, playerId) >= x889630_g_playerLevel  then
		local GuildName = LuaFnGetGuildName(sceneId, playerId)
		local	playerName = GetName( sceneId, playerId )
		AddGlobalCountNews( sceneId, "["..GuildName.."]帮会的高手玩家["..playerName.."] 正进入帮战战场" )
	end
end

--**********************************
----人物死亡事件
--**********************************
function x889630_OnSceneHumanDie(sceneId, dieId, nHumanId)
	------不在活动时间----------
	local isok,duojiukaishi,yikaishiTime,duojiujieshu,yiguotime = x889630_GetTimer(sceneId)
	if isok ==0 then
		return
	end
	
	if LuaFnGetCopySceneData_Param( sceneId,4)==1 then
		return
	end
	
	-- 如果这个杀手是个宠物，需要现找到主人
	local nObjType = GetCharacterType(sceneId, nHumanId);
	local killerId = -1;
	if nObjType then
		if nObjType == 1 then
			killerId = nHumanId
		elseif nObjType == 3 then
			killerId = GetPetCreator(sceneId, nHumanId);
		end
	end
	if killerId == -1 then
		BeginEvent( sceneId )
		AddText( sceneId, "哎哟，敢去人家老家堵门，塔子射死了活该" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, dieId )
		return
	end
	-----判断逻辑----------
	if LuaFnIsObjValid( sceneId, killerId ) ~= 1 or LuaFnIsCanDoScriptLogic( sceneId, killerId ) ~= 1 then
		return
	end
	local mycamp = GetUnitCampID(sceneId, killerId, killerId)
	-- 1，杀死自己的人，不能是同一个阵营的人，
	if  mycamp == GetUnitCampID(sceneId, dieId, dieId)  then
		AddGlobalCountNews( sceneId, GetName(sceneId,killerId).."杀死本帮会成员不加分" )
		return
	end
	
	local killerName = LuaFnGetName( sceneId, killerId );
	local dieName = LuaFnGetName( sceneId, dieId );
	local killerLvl = GetLevel(sceneId, killerId)
	local diedLvl = GetLevel(sceneId, dieId)
	local killerhp = GetMaxHp(sceneId, killerId) ---得杀人者的HP
	local diehp = GetMaxHp(sceneId, dieId)   ---得到死亡的HP
	local guildName_self = LuaFnGetGuildName(sceneId, dieId);
	local guildName_killer = LuaFnGetGuildName(sceneId, killerId);
	if diedLvl >=x889630_gonggaolevel or diehp >=x889630_gonggaoHp then
		local sMessage = format("@*;SrvMsg;GLD:#W本帮主力#R%s#W在帮战中浴血奋战，不敌#G%s#W帮会的#R%s#W，为帮会英勇献身！", dieName, guildName_killer ,killerName);
		BroadMsgByChatPipe(sceneId, dieId, sMessage, 6);
	end
	
	if killerLvl >=x889630_gonggaolevel or killerhp >=x889630_gonggaoHp then
		sMessage = format("@*;SrvMsg;GLD:#R%s#W在帮战中大展身手，成功击杀#G%s#W帮会主力#R%s#W，捍卫了帮会的荣誉！", killerName, guildName_self, dieName);
		BroadMsgByChatPipe(sceneId, killerId, sMessage,6);
	end
	
	----检测是不是刷的小号-------------------
	-----------------------------------------
	local lastplayer = GetMissionData( sceneId, killerId, MF_BZ_LASTPLAY )
	local shalastID = floor(lastplayer/100)
	local shacum = mod(lastplayer,100)
	if shalastID == dieId then
		shacum = shacum+1
		hpcha = killerhp - diehp
		if diedLvl >=90 and diehp <100000 then ---防大号脱装备刷
			x889630_Tips( sceneId, killerId,"你小子行啊，大号脱了在裤子刷呀？")
			shacum = shacum+1
		end
		
		if hpcha >300000  then
			x889630_Tips( sceneId, killerId,"你就留点德吧，秒人家有意思？")
			shacum = shacum+2
		elseif hpcha >= 200000  then
			x889630_Tips( sceneId, killerId,"你也忍心？")
			shacum = shacum+1
		elseif hpcha >= 100000 then
			x889630_Tips( sceneId, killerId,"感觉你们差距有点大呀，别老杀他呀！")
			shacum = shacum+1
		end
		
		if shacum >= 10 then
			shacum = 0
			x889630_Tips( sceneId, killerId,"你就留点德吧，还重复杀小号，你觉得你还能有分吗？")
			BroadMsgByChatPipe(sceneId, killerId, "发现一个用小号刷分的家伙【"..killerName.."】其行为恶劣，特进行积分清零处理！", 4);
			SetMissionData( sceneId, killerId, MF_BZ_JIFEN,0)  ---设置积分
			SetMissionData( sceneId, killerId, MF_BZ_LIANZHAN,0)  ---设置杀人者+1
			SetMissionData( sceneId, killerId, MF_BZ_MYKILL,0)  ---设置杀人者+1
			SetMissionData( sceneId, killerId, MF_BZ_LASTPLAY,0)  ---设置杀人者+1
			return
		end
	end
	
	SetMissionData( sceneId, killerId, MF_BZ_LASTPLAY, (dieId*100+shacum) )
	------如果大号被我杀了，就重新计算刷小号-----
	if shalastID == killerId then
		SetMissionData( sceneId, killerId, MF_BZ_LASTPLAY,0)  ---设置ID清零
	end
	--------------得到杀人者相关数据-----------------
	local killerlianzhan = GetMissionData( sceneId, killerId, MF_BZ_LIANZHAN)
	local killerkill = GetMissionData( sceneId, killerId, MF_BZ_MYKILL)
	local Killerjifen0 = GetMissionData( sceneId, killerId, MF_BZ_JIFEN)
	local killerjifen = Killerjifen0+x889630_killjifen  ---每杀一个人增加积分
	--------------------------------------------------------------------------------------
	SetMissionData( sceneId, killerId, MF_BZ_LIANZHAN,killerlianzhan+1)  ---设置连斩+1
	SetMissionData( sceneId, killerId, MF_BZ_MYKILL,killerkill+1)  ---设置杀人数+1
	SetMissionData( sceneId, killerId, MF_BZ_JIFEN,killerjifen )  ---设置积分
	--------把个人增加的积分加到团队里------
	CallScriptFunction( 889633, "SetText",sceneId,killerId,1,x889630_killjifen)  ---增加总积分+5
	---------------------------------------------------------
	SetMissionData( sceneId, dieId, MF_BZ_LIANZHAN,0)  ---死亡设置连斩清0
	----------------公告处理---------------------------------
	if killerlianzhan > 9  then
		local str=" "
		if 	killerlianzhan == 10  then
			str = "#b已连#cFF0000斩杀"..killerlianzhan.."人#W，送你一个字，牛！。"
		elseif 	killerlianzhan == 20  then
			str = "#b#cFF0000已经连斩"..killerlianzhan.."人，以气吞万里江山之势，秒杀全场，全都干趴！，武林盟主非你莫属"
		elseif 	killerlianzhan == 30  then
			str = "#b#cFF0000已经连斩"..killerlianzhan.."人,达到万剑归宗之境，再次证明RMB玩家就是强，谁敢与他争锋，就送你一个 死 字！"
		elseif 	killerlianzhan == 40  then
			str = "#b#cFF0000已经连斩"..killerlianzhan.."，达到有剑胜无剑之境 ，GM已不再说话，因为GM也搞不过他，他已超出牛顿定理，不在三界之内"
		else
			str = "已连#cFF0000斩杀"..killerlianzhan.."人#W"
		end
		local message = format("#W帮战中，#cff9966#{_INFOUSR%s}#W击杀了#cff9966#{_INFOUSR%s}#W"..str.."，目前他个人积分为："..killerjifen.."分", killerName, dieName);
		BroadMsgByChatPipe(sceneId, killerId, message, 4);
	end
	x889630_Tips( sceneId, killerId, "您目前个人积分为："..killerjifen.."分， ")
end
---------**************************************
---------刷水晶事件
---------**************************************
function x889630_UPCampMoster(sceneId)
	for _ ,BossData in x889630_g_MosterDing  do
		local MonsterID = LuaFnCreateMonster(sceneId, BossData.ID, BossData.PosX, BossData.PosY, BossData.BaseAI, BossData.ExtAIScript, BossData.ScriptID )
		if MonsterID >=0 then
			SetUnitCampID(sceneId, MonsterID, MonsterID,1000)
		else
			AddGlobalCountNews(sceneId,"怪物创建错误：请检查服务端是否有"..BossData.ID.."号怪物")
		end
	end
end

--********************************
function x889630_UPCampMosterNPC( sceneId )
	for _ ,BossData in x889630_g_MosterNPC  do
		local MonsterID = LuaFnCreateMonster(sceneId, BossData.ID, BossData.PosX, BossData.PosY, BossData.BaseAI, BossData.ExtAIScript, BossData.ScriptID )
		if MonsterID >=0 then
			SetUnitCampID(sceneId, MonsterID, MonsterID,0)
		else
			AddGlobalCountNews(sceneId,"怪物创建错误：请检查服务端是否有"..BossData.ID.."号怪物")
		end
	end
end

--********************************

---**********************************
--- 清除场景内的怪
---**********************************
function x889630_ClearMonster(sceneId,biaoji)
	local nMonsterNum = GetMonsterCount(sceneId)
	for i=1, nMonsterNum do
		local nMonsterId = GetMonsterObjID(sceneId,i-1)
		if biaoji ==0 then
			LuaFnDeleteMonster(sceneId, nMonsterId)
		else
			local DataID = GetMonsterDataID( sceneId, nMonsterId )
			for _ ,Data in x889630_g_MosterDing  do
				if DataID == Data.ID then
					LuaFnDeleteMonster(sceneId, nMonsterId)
				end
			end
		end
	end
	
end

-------------------奖励排行---------------------
function x889630_jiangli( sceneId )
	local shuzu ,key = x889630_BZpaiming(sceneId)
	if key== -1 then
		return -1
	end
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount <1 then
		return 0
	end
	for i=1, nHumanCount do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
		if LuaFnIsObjValid( sceneId, nHumanId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, nHumanId ) == 1 then
			local myJF = GetMissionData( sceneId, nHumanId, MF_BZ_JIFEN)
			if myJF > 1 then
				local myGuildID = GetHumanGuildID(sceneId,nHumanId)
				for j=1,getn(shuzu) do
					if shuzu[j] ~= nil then
						if myGuildID == shuzu[j].guildId then
							if x889630_jiangliYB[j] ~=nil then
								ZengDian(sceneId,nHumanId,-1,1,x889630_jiangliYB[j])
							end
							if x889630_jiangliZB[j] ~= nil then
								--SetHumanMenpaiPoint(sceneId,selfId,GetHumanMenpaiPoint(sceneId,selfId)+(LuaFnGetWorldGlobalData(99)*x889630_jiangliZB[j]))
							end
							x889630_Tips( sceneId, nHumanId, "本次帮战结束，恭喜贵帮获得第"..j.."名，奖励"..x889630_jiangliYB[j].."绑元" )
							--LuaFnSetWorldGlobalData(99,0)
						end
					end
				end
				
			else
				x889630_Tips( sceneId, nHumanId, "本次帮战，你积分为零，没有任何奖励哈哈" )
			end
		end
	end
	
	for i = 1, getn(shuzu) do
		if shuzu[i] ~=nil then
			local szName = shuzu[i].GuildName
			local bhjf = shuzu[i].guildJiFen
			if i ==1 and  bhjf>0 and x889630_jiangliYB[i]~=nil then
				AddGlobalCountNews ( sceneId, "#b["..szName.."]#W帮会取得了本次帮战活动#cff9966第一名#cFF0000,全帮总积分："..bhjf.."分，每人奖励"..x889630_jiangliYB[1].."绑元")
			elseif i==2 and bhjf>0 and x889630_jiangliYB[i]~=nil then
				AddGlobalCountNews ( sceneId, "#b#cff99cc["..szName.."]#W帮会取得了本次帮战活动#cff9966第二名#cff99cc,全帮总积分："..bhjf.."分，每人奖励"..x889630_jiangliYB[2].."绑元" )
			elseif i==3 and bhjf>0 and x889630_jiangliYB[i]~=nil then
				AddGlobalCountNews ( sceneId, "#b#G["..szName.."]#W帮会取得了本次活动#cff9966第三名#G,全帮总积分："..bhjf.."分，每人奖励"..x889630_jiangliYB[3].."绑元")
			elseif i==4 and bhjf>0 and x889630_jiangliYB[i]~=nil then
				AddGlobalCountNews ( sceneId, "#b#W["..szName.."]#W帮会取得了本次活动#cff9966第四名#G，哎！下次努力吧！每人安慰奖励"..x889630_jiangliYB[4].."绑元" )
			end
		end
	end
	return 1
end

-----------排名----------------
function x889630_BZpaiming(sceneId)
	local shuzu = x889630_readTxt(sceneId)
	if shuzu[1] == nil then
		return shuzu , -1
	end
	
	for i = 1, getn(shuzu) do
		for j = 1, i do
			if shuzu[i].guildJiFen > shuzu[j].guildJiFen  then
				local temp ={}
				temp[1] = shuzu[i]
				shuzu[i] = shuzu[j]
				shuzu[j] = temp[1]
			end
		end
	end
	return shuzu , 1
end

------------文件读取--------------------
function x889630_readTxt(sceneId)
	local savetxt = openfile("./ZY_DataBase/BangZhan/bangzhan.txt", "r")
	local Myall = {}
	if savetxt and nil ~= savetxt then
		for i=1, 20  do
			local line1=read(savetxt, "*l")
			if line1==nil then
				break
			end
			local line2=read(savetxt, "*l")
			if line2==nil then
				break
			end
			local line3=read(savetxt, "*l")
			if line3==nil  then
				break
			end
			local line4=read(savetxt, "*l")
			if line4==nil  then
				break
			end
			Myall[i] = {GuildName = line1, guildId = tonumber(line2),guildJiFen = tonumber(line3),guildPos = tonumber(line4)}
		end
		closefile(savetxt)
	else
		AddGlobalCountNews(sceneId,"帮战系统 文档bangzhan.txt不存在或打开失败")
		return
	end
	return Myall
end

-------------处理是不是活动时间------------------------------
function x889630_GetTimer(sceneId)
	local begintime = x889630_g_hudongtime[1][1]*60+x889630_g_hudongtime[1][2]
	local endtime = x889630_g_hudongtime[2][1]*60+x889630_g_hudongtime[2][2]
	local nowtime = floor(mod((LuaFnGetCurrentTime()+28800),86400)/60)
	local duojiukaishi = -1  ---没开始
	local yiguotime = -1       ---已过了
	local isok = 0
	local yikaishiTime = -1
	local duojiujieshu = -1
	
	if begintime > nowtime then
		duojiukaishi = begintime - nowtime  ------离多少分钟后开始
	elseif nowtime > endtime then
		yiguotime = nowtime - endtime	  ----活动时间已经结束多久
	else
		isok = 1
		duojiujieshu = endtime - nowtime         -------还有多少分钟活动结束
		yikaishiTime = nowtime - begintime       -------已经进行了多少分钟
	end
	return isok,duojiukaishi,yikaishiTime,duojiujieshu,yiguotime
end
--**********************************
function x889630_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
	AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

function x889630_qingkong(sceneId )
	local Coldfile = openfile("./ZY_DataBase/BangZhan/bangzhan.txt", "w")
	if Coldfile and nil ~= Coldfile then
		local mystring = ""
		write(Coldfile, mystring)
		closefile(Coldfile)
	end
	
end

function x889630_jiangliret(sceneId )
	local ji1 = x889630_jiangliYB[1]+0
	local ji2 = x889630_jiangliYB[2]+0
	local ji3 = x889630_jiangliYB[3]+0
	local ji4 = x889630_jiangliYB[4]+0
	return ji1,ji2,ji3,ji4
end


function x889630_shjjianret(sceneId )
	local ji1 = x889630_g_hudongtime[1][1]+0
	local ji2 = x889630_g_hudongtime[1][2]+0
	local ji3 = x889630_g_hudongtime[2][1]+0
	local ji4 = x889630_g_hudongtime[2][2]+0
	return ji1,ji2,ji3,ji4
end

---**********************************
--- 清除场景内的怪
---**********************************
function x889630_KaiTa(sceneId,selfId,mycamp )
	local x,z=GetWorldPos(sceneId,selfId)
	local keyzu = -1
	if cs_intX[x] ~=nil and cs_intZ[z] ~=nil    then
		if cs_intX[x] == cs_intZ[z] then
			local keyzu = cs_intX[x]
			if LuaFnGetCopySceneData_Param( sceneId,keyzu) ==0 then  -----表示没有刷这组怪
				if x889630_UPCampMosterTa( sceneId,selfId,(keyzu-10),mycamp )==3 then
					LuaFnSetCopySceneData_Param( sceneId,keyzu,1)
				end
			else
				x889630_Tips( sceneId, selfId, "防御塔已开放，可查看本帮战绩" )
			end
		end
	else
		x889630_Tips( sceneId, selfId, "非正常渠道进入战场" )
	end
end

function x889630_UPCampMosterTa( sceneId,selfId,newzu,mycamp )
	local BossData = x889630_g_MosterTa[newzu]
	local a ,b ,c = 0, 0,0
	local MonsterID = LuaFnCreateMonster(sceneId, BossData.ID, BossData.PosX, BossData.PosY, BossData.BaseAI, BossData.ExtAIScript, BossData.ScriptID )
	if MonsterID >=0 then
		SetUnitCampID(sceneId, MonsterID, MonsterID,mycamp)
		local GuildName = LuaFnGetGuildName(sceneId, selfId)
		SetCharacterName( sceneId,MonsterID,GuildName.."帮的守卫塔")
		a = 1
	else
		AddGlobalCountNews(sceneId,"怪物创建错误：请检查服务端是否有"..BossData.ID.."号怪物或怪物技能")
	end
	
	local BossData1 = x889630_g_MosterTa2[newzu]
	local MonsterID = LuaFnCreateMonster(sceneId, BossData1.ID, BossData1.PosX, BossData1.PosY, BossData1.BaseAI, BossData1.ExtAIScript, BossData1.ScriptID )
	if MonsterID >=0 then
		SetUnitCampID(sceneId, MonsterID, MonsterID,mycamp)
		local GuildName = LuaFnGetGuildName(sceneId, selfId)
		SetCharacterName( sceneId,MonsterID,GuildName.."帮的守卫塔")
		b = 1
	else
		AddGlobalCountNews(sceneId,"怪物创建错误：请检查服务端是否有"..BossData1.ID.."号怪物或怪物技能")
	end
	
	local BossData2 = x889630_g_MosterNPC[newzu]
	local MonsterID = LuaFnCreateMonster(sceneId, BossData2.ID, BossData2.PosX, BossData2.PosY, BossData2.BaseAI, BossData2.ExtAIScript, BossData2.ScriptID )
	
	if MonsterID >=0 then
		c = 1
	end
	return (a+b+c)
	--	SetUnitCampID(sceneId, MonsterID, MonsterID,0)
	--else
	--	AddGlobalCountNews(sceneId,"怪物创建错误：请检查服务端是否有"..BossData2.ID.."号怪物")
	--end
end





