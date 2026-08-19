-- 遁甲奇书
--20190512 添加通天符箓

x330060_g_scriptId = 330060
x330060_g_ItemId = 30008121
x330060_g_ItemId_DJQS = 30008122 --添加通天符箓
--银票
x330060_g_ItemId01 = 30000002
x330060_g_Yinpiao = 40002000
-- 限制使用传送功能的场景
x330060_g_NoChuangsongScn=
{
	151,	-- 监狱
	125,	-- 监狱
	540,	-- 监狱
	184,	-- 监狱
	410,	-- 监狱
	544,	-- 监狱
	545,	-- 监狱
	546,	-- 监狱
	547,	-- 监狱
	548,	-- 监狱
	181,	-- 监狱
	433,	-- 监狱
	593,	-- 监狱
	564,	-- 监狱
	581,	-- 监狱
	582,	-- 监狱
	583,	-- 监狱
	584,	-- 监狱
	585,	-- 监狱
	571,	-- 监狱
	128,	-- 监狱
	43,	-- 监狱
	561,
	562,
	599,		-- 监狱
	390,--凤凰战场
}

-- 限制使用彻地符箓定位的场景
x330060_g_UselessScn=
{
	125,	-- 华山
	540,	-- 华山
	184,	  -- 竞技场
	410,	  -- 竞技场
	544,	  -- 竞技场
	545,	  -- 竞技场
	546,	  -- 竞技场	
	547,  -- 竞技场
	548,  -- 竞技场
	414,  -- 竞技场
	181,  -- 竞技场
	433,  -- 竞技场
	593,  -- 竞技场
	564,  -- 竞技场
	581,  -- 通天塔1
	582,  -- 通天塔2
	583,  -- 通天塔3
	584,  -- 通天塔4
	585,  -- 通天塔5
	517,  -- 竞技场
	128,  -- 竞技场
	43,  -- 竞技场
	561,
	562,
	599,	 -- 监狱
    317, -- 争霸赛
    180, --凤凰战场
    191, --凤凰古城
	390,--凤凰战场
}


--禁止传送到某些场景的等级限制....
x330060_g_LimitTransScene =
{
	{423,90},	--火焰山
	{581,90},	--火焰山
	{582,90},	--火焰山
	{583,90},	--火焰山
	{584,90},	--火焰山
	{585,90},	--火焰山
	{519,90},	--火焰谷
	{424,90},	--高昌
	{520,90},	--高昌迷宫
	{425,90},	--塔里木
	{427,90},	--塔克拉玛干
	{186,75},	--楼兰
	{517,150},	--楼兰
	{128,150},	--楼兰
	{43,150},	--楼兰
	{431,90},       --大宛
	{432,90},       --汗血岭
	{546,200},       --汗血岭
}

x330060_g_Impact_NotTransportList = { 5929 } -- 禁止传送的Impact
x330060_g_TalkInfo_NotTransportList = { "#{GodFire_Info_062}" } -- 禁止传送的Impact提示信息
--缺省场景,仅显示需要
x330060_g_DefaultScn=
{
	{"#{DJTS_110509_34}",401,223,225},	--秦皇地宫二层
	{"#{DJTS_110509_36}",402,31,33},	--秦皇地宫四层
	{"#{DJTS_110509_36}",161,13,25},	--燕王古墓三层
	{"#{DJTS_110509_37}",165,25,108},	--燕王古墓七层
}
--**********************************
-- 事件交互入口
--**********************************
function x330060_OnDefaultEvent( sceneId, selfId, nItemIndex )
	
end

function x330060_IsSkillLikeScript( sceneId, selfId )
	return 1	 --这个脚本需要动作支持
end

function x330060_CancelImpacts( sceneId, selfId )
	return 0	 --不需要这个接口，但要保留空函数,并且始终返回0。
end

function x330060_OnDeplete( sceneId, selfId )
	return 1
end

--**********************************
-- 
--**********************************
function x330060_OnConditionCheck( sceneId, selfId , idid)

	local	bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	
	-- 判断这个物品是不是已经定位
	local nItemID = GetItemTableIndexByIndex(sceneId, selfId, bagId) 
	if nItemID ~= x330060_g_ItemId and nItemID ~= x330060_g_ItemId_DJQS then
		return 0
	end
	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, bagId, 0 ) < 0 then
		return 0
	end

	--检测Impact状态驻留效果
	for i, ImpactId in x330060_g_Impact_NotTransportList do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactId) ~= 0 then
			BeginEvent(sceneId)			
				AddText(sceneId, x330060_g_TalkInfo_NotTransportList[i]);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return 0
		end
	end

	--检测目标场景是否限制等级....
	for _, tmp in x330060_g_LimitTransScene do
		if ( (tmp[1] == nTarSceneId) and (GetLevel(sceneId, selfId) < tmp[2]) ) then
			local szMsg = format("此场景需要%d级以上方可入内", tmp[2])
			x330060_MsgBox( sceneId, selfId, szMsg)
			return 0
		end
	end
        local myusepos = GetMissionData(sceneId,selfId,MD_ZDFS_Y)
	if myusepos < 1 or myusepos > 15 then
		--x330060_MsgBox( sceneId, selfId, "您的策地符篆已经损坏，无法使用了" )
		return 0
	end
	-- 1，检测这个物品是不是有记录的数据了，
	-- 需要记录的数据是，使用次数，定位场景Id，以及坐标
	local nCount = mod(GetMissionData(sceneId,selfId,MD_ZDFS_SCENE ),100)
    local ScenePosData = x330060_ReadTxt( sceneId, selfId)
	local mydata = tonumber(ScenePosData[myusepos])
	-- 执行传送
	local nTarSceneId = mod(mydata,1000)
	local nPointX = floor((mod(mydata,(10^6)))/10^3)
	local nPointZ = floor(mydata/(10^6))
	if nPointX==0 and nPointZ==0 and myusepos >= 1 and myusepos <= 4 then
		nTarSceneId = x330060_g_DefaultScn[myusepos][2]
		nPointX	= x330060_g_DefaultScn[myusepos][3]
		nPointZ	= x330060_g_DefaultScn[myusepos][4]
	end
	if  nPointX==0 and nPointZ==0  then
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_31}" )
		return 0
	end

	return 1
end
--**********************************
--客户端回调
--**********************************
function x330060_CallMe( sceneId, selfId, nItemIndex, PlayerGuid)	
--	AddGlobalCountNews(sceneId,"PlayerGuid "..PlayerGuid);
	--检测这个玩家是不是能够使用彻地符箓定位
	--判断当前状态是否可使用定位符
	if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
		x330060_MsgBox( sceneId, selfId, "您处于不允许传送的状态，不能传送！" )
		return 0
	end

	--检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x330060_g_Yinpiao) >= 1  then
		x330060_MsgBox(sceneId, selfId, "#{JXPVP_170814_210}")
		return 0
	end
	
	--检测玩家是不是处于不允许传送的场景，比如监狱
	for _, tmp in x330060_g_NoChuangsongScn do
		if tmp == sceneId then
			x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_44}" )
			return 0
		end
	end
	
	-- 检测玩家是不是处于摆摊状态，
	if LuaFnIsStalling(sceneId, selfId) == 1  then
		x330060_MsgBox( sceneId, selfId, "#{JXPVP_170814_208}" )
		return 0
	end
	
	-- 处于组队跟随状态下，不能传送
	if IsTeamFollow(sceneId, selfId) == 1  then
		x330060_MsgBox( sceneId, selfId, "#{JXPVP_170814_207}" )
		return 0
	end
	
	-- [ QUFEI 2007-08-23 20:50 UPDATE BugID 23699 ]
	-- 处于使用交通工具状态下，不能传送
	local inbus = LuaFnGetBusPassengerIDIsInBus(sceneId, selfId)
	if inbus == 1 then
		x330060_MsgBox( sceneId, selfId, "您处于无法使用传送的情况下，无法使用传送道具！" )
		return 0
	end
	
	--检测Impact状态驻留效果
	for i, ImpactId in x330060_g_Impact_NotTransportList do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactId) ~= 0 then
			BeginEvent(sceneId)			
				AddText(sceneId, x330060_g_TalkInfo_NotTransportList[i]);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return 0
		end
	end
	
	-- 看PlayerGuid 是不是队伍中的人，然后再看时间是不是过期，别的也没有什么能检查的了
	local Time = GetMissionData(sceneId,selfId,MD_ZDFS_TIME)
	local nTarSceneId = floor(GetMissionData(sceneId,selfId,MD_ZDFS_SCENE)/100)
	local posdata = GetMissionData(sceneId,selfId,MD_ZDFS_X)
	local x = mod(posdata,10^3)
	local z = floor(mod(posdata,10^6)/(10^3))
	
	--检测目标场景是否限制等级....
	for _, tmp in x330060_g_LimitTransScene do
		if ( (tmp[1] == nTarSceneId) and (GetLevel(sceneId, selfId) < tmp[2]) ) then
			local szMsg = format("此场景需要%d级以上方可入内", tmp[2])
			x330060_MsgBox( sceneId, selfId, szMsg)
			return 0
		end
	end
	
	if LuaFnGetCurrentTime() - Time < 30  then
		CallScriptFunction((400900), "TransferFunc",sceneId, selfId, nTarSceneId, x, z)
	end

	SetMissionData(sceneId,selfId,MD_ZDFS_TIME,0)
	SetMissionData(sceneId,selfId,MD_ZDFS_SCENE,mod(GetMissionData(sceneId,selfId,MD_ZDFS_SCENE),100))
	SetMissionData(sceneId,selfId,MD_ZDFS_X,0)
	
end

--**********************************
--激活物品
--**********************************
function x330060_OnActivateOnce( sceneId, selfId )
	local bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	if bagId < 0  then
		return 0
	end
	x330060_PlayerGoto( sceneId, selfId, bagId )
end

--**********************************
-- 打开彻底符
--**********************************
function x330060_Ce_DifuCs( sceneId, selfId,bagpos,nSign)
    local ScenePosData = x330060_ReadTxt( sceneId, selfId)
    local ScenePos = ""
	local nIndex = 0
	local sceneName = ""
    for i = 1,15 do
		nIndex =	tonumber(ScenePosData[i])
		ScenePos = ScenePos..format("%06d",floor(mod(nIndex,10^9)/(10^3)))
		if nIndex > 0 then
			sceneName = sceneName..GetSceneName(mod(nIndex,(10^3))).."|"
		else
			sceneName = sceneName.."|"
		end
	end
	if ScenePos == nil or ScenePos == "" then
		ScenePos = strrep("0",90)
	end
	if sceneName == nil or sceneName == "" then
		sceneName = strrep("|",15)
	end
	nIndex =	mod(GetMissionData(sceneId,selfId,MD_ZDFS_SCENE),100)
	BeginUICommand(sceneId)
	    if nSign ~= nil and nSign == 1 then
			UICommand_AddInt(sceneId,0)
			UICommand_AddInt(sceneId,bagpos)
		elseif nSign ~= nil and nSign == 2 then
			UICommand_AddInt(sceneId,1)
			UICommand_AddInt(sceneId,bagpos-1)
		elseif nSign ~= nil and nSign == 3 then
			UICommand_AddInt(sceneId,2)
			UICommand_AddInt(sceneId,bagpos-1)
		end
		UICommand_AddInt(sceneId,nIndex)
		UICommand_AddString(sceneId,ScenePos)
		UICommand_AddString(sceneId,sceneName)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1122361)
end

--**********************************
-- 设置定位点
--**********************************
function x330060_SetPosition( sceneId, selfId,bagpos,bagitempos)
	if bagpos == nil or bagpos < 0 or bagpos > 29 then
	x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_43}" )
		return
	end
	if bagitempos == nil or bagitempos < 0 or bagitempos > 14 then
		return
	end

	if LuaFnGetSceneType( sceneId ) == 1 or LuaFnGetSceneType( sceneId ) == 4 then
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_43}" )
		return 0
	end
	for _, tmp in x330060_g_UselessScn do
		if tmp == sceneId then
			x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_33}" )
			return 0
		end
	end

	-- 0，物品安全性检查
	-- 先检测这个 bagpos 的物品是不是和当前的对应，
	local nItemID = GetItemTableIndexByIndex(sceneId, selfId, bagpos)
	if nItemID ~= x330060_g_ItemId and nItemID ~= x330060_g_ItemId_DJQS then
		x330060_MsgBox( sceneId, selfId, "背包内部错误" )
		return
	end
	
	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, bagpos, 0 ) < 0 then
		x330060_MsgBox( sceneId, selfId, "此物品已被锁定！" )
		return 0
	end

	local x,z = GetWorldPos(sceneId, selfId)
	x,z = floor(x),floor(z)

	local myGuid = LuaFnGetGUID( sceneId, selfId)
	local nFinalDATA = ""
	local handle = openfile("./ZY_DataBase/DingWei/DW"..tostring(myGuid )..".txt", "r")
	if nil ~= handle then
		for i=1, 15 do
			local line=read(handle, "*l")
			if line==nil then
				line=0
			end

			if i == bagitempos+1 then 
				line	= tonumber(sceneId+x*10^3+z*10^6)	
			end	
			nFinalDATA = nFinalDATA..line.."\n"
		end
		closefile(handle)
	end
	local handle = openfile("./ZY_DataBase/DingWei/DW"..tostring(myGuid )..".txt", "wb")
	if nil ~= handle  then
	   write(handle,tostring(nFinalDATA))
	   closefile(handle)
	end
	if nItemID == x330060_g_ItemId then
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_50}")
	elseif nItemID == x330060_g_ItemId_DJQS then
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_45}")
	end
end
--**********************************
--使用遁甲术
--**********************************
function x330060_SetUISelIdx( sceneId, selfId,bagpos,bagitempos)
	if bagpos == nil or bagpos < 0 or bagpos > 29 then
		return
	end
	if bagitempos == nil or bagitempos < 0 or bagitempos > 14 then
		return
	end

	-- 0，物品安全性检查
	-- 先检测这个 nItemIndex 的物品是不是和当前的对应
	local nItemID = GetItemTableIndexByIndex(sceneId, selfId, bagpos) 
	if  nItemID ~= x330060_g_ItemId and nItemID ~= x330060_g_ItemId_DJQS then
		return
	end

	-- 处于组队跟随状态下，不能传送
	if IsTeamFollow(sceneId, selfId) == 1  then
		--return 0
	end
	
	--判断当前状态是否可使用定位符
	if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
		return 0
	end

	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, bagpos, 0 ) < 0 then
		return 0
	end

	--检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x330060_g_Yinpiao) >= 1  then
		return 0
	end
	
	--检测玩家是不是处于不允许传送的场景，比如监狱
	for _, tmp in x330060_g_NoChuangsongScn do
		if tmp == sceneId then
			return 0
		end
	end
	
	-- 检测玩家是不是处于摆摊状态，
	if LuaFnIsStalling(sceneId, selfId) == 1  then
		return 0
	end
	
	--检测Impact状态驻留效果
	for i, ImpactId in x330060_g_Impact_NotTransportList do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactId) ~= 0 then
			BeginEvent(sceneId)			
				AddText(sceneId, x330060_g_TalkInfo_NotTransportList[i]);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return 0
		end
	end
	if HaveSkill(sceneId,selfId,510) < 0 then
	   AddSkill(sceneId,selfId,510);
	end	
	SetMissionData(sceneId,selfId,MD_ZDFS_Y,bagitempos+1)
	BeginUICommand(sceneId)
	UICommand_AddInt(sceneId,510)
	UICommand_AddString(sceneId,"ski13")
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,2014092002)
	-- x330060_PlayerGoto( sceneId, selfId, bagpos )
end
--**********************************
-- 玩家自己的传送
--**********************************
function x330060_PlayerGoto( sceneId, selfId, nItemIndex )
	-- 0，物品安全性检查
	-- 先检测这个 nItemIndex 的物品是不是和当前的对应，
	local myusepos = GetMissionData(sceneId,selfId,MD_ZDFS_Y)
	if myusepos < 1 or myusepos > 15 then
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_39}" )
		return 0
	end
	local nItemID = GetItemTableIndexByIndex(sceneId, selfId, nItemIndex)
	if nItemID ~= x330060_g_ItemId and nItemID ~= x330060_g_ItemId_DJQS then
		x330060_MsgBox( sceneId, selfId, "背包内部错误" )
		return
	end

	-- 处于组队跟随状态下，不能传送
	if IsTeamFollow(sceneId, selfId) == 1 and nItemID ~= x330060_g_ItemId_DJQS then
		x330060_MsgBox( sceneId, selfId, "#{JXPVP_170814_207}" )
		return 0
	end
	
	--判断当前状态是否可使用定位符
	if IsHaveMission( sceneId, selfId, 4021 ) > 0 then
		x330060_MsgBox( sceneId, selfId, "您处于不允许传送的状态，不能传送！" )
		return 0
	end

	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, nItemIndex, 0 ) < 0 then
		x330060_MsgBox( sceneId, selfId, "此物品已被锁定！" )
		return 0
	end

	--检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x330060_g_Yinpiao) >= 1  then
		x330060_MsgBox(sceneId, selfId, "#{JXPVP_170814_210}")
		return 0
	end
	
	--检测玩家是不是处于不允许传送的场景，比如监狱
	for _, tmp in x330060_g_NoChuangsongScn do
		if tmp == sceneId then
			x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_44}" )
			return 0
		end
	end
	
	-- 检测玩家是不是处于摆摊状态，
	if LuaFnIsStalling(sceneId, selfId) == 1  then
		x330060_MsgBox( sceneId, selfId, "#{JXPVP_170814_208}" )
		return 0
	end
	
	--检测Impact状态驻留效果
	for i, ImpactId in x330060_g_Impact_NotTransportList do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactId) ~= 0 then
			BeginEvent(sceneId)			
				AddText(sceneId, x330060_g_TalkInfo_NotTransportList[i]);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
			return 0
		end
	end
	
	-- 1，检测这个物品是不是有记录的数据了，
	-- 需要记录的数据是，使用次数，定位场景Id，以及坐标
    local ScenePosData=x330060_ReadTxt( sceneId, selfId)
	local nCount = mod(GetMissionData(sceneId,selfId,MD_ZDFS_SCENE),100)
	local mydata = tonumber(ScenePosData[myusepos])
	-- 执行传送
	local nTarSceneId = mod(mydata,1000)
	local nPointX = floor((mod(mydata,(10^6)))/10^3)
	local nPointZ = floor(mydata/(10^6))
	if nPointX==0 and nPointZ==0 and myusepos >= 1 and myusepos <= 4 then
	nTarSceneId = x330060_g_DefaultScn[myusepos][2]
	nPointX	= x330060_g_DefaultScn[myusepos][3]
	nPointZ	= x330060_g_DefaultScn[myusepos][4]
	end
	if  nPointX==0 and nPointZ==0  then
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_31}" )
		return
	end
	if nCount >= 20 then  --[20190110]xyz修正，按照规划，设定20为佳
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_51}" )
		return 
	end
	-- 检查目标场景是不是能够到达
	if sceneId ~= nTarSceneId then
		if IsCanNewWorld( sceneId, selfId, nTarSceneId, nPointX, nPointZ ) ~= 1 then
			x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_39}" )
			return 0
		end
	end
	SetMissionData(sceneId,selfId,MD_ZDFS_SCENE,nCount+1 )
	SetMissionData(sceneId,selfId,MD_ZDFS_Y,0)
	--附近玩家设计
	local nTeamCount = GetNearTeamCount(sceneId,selfId)
	local selfGuid = LuaFnGetGUID(sceneId,selfId)
	local nTarSceneName = GetSceneName(nTarSceneId)
	if nTeamCount > 0  then
		if nItemID == 30008121 then --遁甲奇书才能传送
--			if LuaFnIsTeamLeader( sceneId, selfId ) == 1 then --队长才可以
				for i=0, nTeamCount-1  do
					local nPlayerId = GetNearTeamMember(sceneId,selfId, i)
					if nPlayerId ~= selfId and LuaFnIsCharacterLiving(sceneId, nPlayerId) == 1 then
						-- 给这个玩家发送一个传送邀请
						local str = "你的队友" .. GetName(sceneId, selfId) .. "使用了通天符箓，回到了【" .. nTarSceneName .. "】，你是否也要跟着一起传送？注意：超过20秒仍未做决定将取消传送。"
						BeginUICommand(sceneId)
							UICommand_AddInt(sceneId,x330060_g_scriptId);
							UICommand_AddInt(sceneId,nItemIndex)
							UICommand_AddInt(sceneId,selfGuid)
							UICommand_AddString(sceneId,"CallMe");
							UICommand_AddString(sceneId,str);
						EndUICommand(sceneId)
						DispatchUICommand(sceneId,nPlayerId, 1009)
						-- 同时把这些重要数据记录到MissionData中
						SetMissionData(sceneId,nPlayerId,MD_ZDFS_TIME,	LuaFnGetCurrentTime())
						SetMissionData(sceneId,nPlayerId,MD_ZDFS_SCENE,mod(GetMissionData(sceneId,nPlayerId,MD_ZDFS_SCENE),100)+nTarSceneId*100)
						SetMissionData(sceneId,nPlayerId,MD_ZDFS_X,	nPointX+nPointZ*10^3)
					end
				end
--			end
		end
	end

	-- 传送自己
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, nTarSceneId, nPointX, nPointZ)

end

--**********************************
-- 遁甲书增加符咒
--**********************************
function x330060_AddFuZhou( sceneId, selfId,bagpos)
	if bagpos == nil or bagpos < 0 or bagpos > 29 then
		return
	end
	if LuaFnGetSceneType( sceneId ) == 1 or LuaFnGetSceneType( sceneId ) == 4 then
		return 0
	end
	for _, tmp in x330060_g_UselessScn do
		if tmp == sceneId then
			x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_33}" )
			return 0
		end
	end

	-- 0，物品安全性检查
	-- 先检测这个 bagpos 的物品是不是和当前的对应，
	local nItemID = GetItemTableIndexByIndex(sceneId, selfId, bagpos)
	if nItemID ~= x330060_g_ItemId and nItemID ~= x330060_g_ItemId_DJQS then
		x330060_MsgBox( sceneId, selfId, "背包内部错误" )
		return
	end
	
	--检测物品是否加锁
	if LuaFnLockCheck( sceneId, selfId, bagpos, 0 ) < 0 then
		x330060_MsgBox( sceneId, selfId, "此物品已被锁定！" )
		return 0
	end
	local nHaveNum = LuaFnGetAvailableItemCount(sceneId, selfId, 30008123)
	if nHaveNum < 1 then
		LuaFnBuyNotEnoughMaterial(sceneId,selfId,30008123,1,1);
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_28}" )
		return
	end
	local nCount = mod(GetMissionData(sceneId,selfId, MD_ZDFS_SCENE ),100)
	if nCount == 0 then
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_29}" )
		return 0
	end
	if LuaFnDelAvailableItem(sceneId,selfId,30008123,1) ~= 1 then
		x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_28}" )
		return 
	end
	nCount = nCount - 20
	if nCount < 0 then
		nCount = 0
	end
	SetMissionData(sceneId,selfId, MD_ZDFS_SCENE,nCount )
	x330060_Ce_DifuCs( sceneId, selfId,bagpos,1)
	x330060_MsgBox( sceneId, selfId, "#{DJTS_110509_30}" )
end
--**********************************
-- 遁甲书数据库
--**********************************
function x330060_ReadTxt( sceneId, selfId)
	local nGUID = LuaFnGetGUID( sceneId, selfId)
	local ScenePosData={}
	local handle = openfile("./ZY_DataBase/DingWei/DW"..tostring(nGUID)..".txt", "r")
    if nil ~= handle then
		for i=1, 15 do
			local nLineData = read(handle, "*l")
			if nLineData == nil then
				nLineData = 0
			end
			ScenePosData[i]=tonumber(nLineData)				
		end
		closefile(handle)
    else
        local nData =""
        for j =1,15 do 
            nData = nData.."0".."\n"
            ScenePosData[j]=0
        end
        local handle = openfile("./ZY_DataBase/DingWei/DW"..tostring(nGUID)..".txt", "wb")
        if nil ~= handle  then
			write(handle,nData)
			closefile(handle)
        end		
    end
	return ScenePosData
end
--**********************************
-- 屏幕中间提示
--**********************************
function x330060_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
