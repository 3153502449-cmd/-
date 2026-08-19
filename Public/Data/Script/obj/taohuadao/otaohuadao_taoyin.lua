--桃花岛NPC--桃殷
--传送....

x000510_g_ScriptId	= 000510
x000510_g_xuanWuDaoId=400918 --[tx42913]
--门派信息(门派名称，SceneID，PosX，PosY，门派ID)
x000510_g_mpInfo		= {}
x000510_g_mpInfo[0]	= { "星宿", 16,  96, 152, MP_XINGSU }
x000510_g_mpInfo[1]	= { "逍遥", 14,  67, 145, MP_XIAOYAO }
x000510_g_mpInfo[2]	= { "少林",  9,  96, 127, MP_SHAOLIN }
x000510_g_mpInfo[3]	= { "天山", 17,  95, 120, MP_TIANSHAN }
x000510_g_mpInfo[4]	= { "天龙", 13,  96, 120, MP_DALI }
x000510_g_mpInfo[5]	= { "峨嵋", 15,  89, 139, MP_EMEI }
x000510_g_mpInfo[6]	= { "武当", 12, 103, 140, MP_WUDANG }
x000510_g_mpInfo[7]	= { "明教", 11,  98, 167, MP_MINGJIAO }
x000510_g_mpInfo[8]	= { "丐帮", 10,  91, 116, MP_GAIBANG }
x000510_g_mpInfo[9]	= { "慕容", 435,  29, 135, MP_WUMENPAI }
x000510_g_mpInfo[10]	= { "唐门", 495,  123, 69, MP_TANGMEN }
x000510_g_mpInfo[11]	= { "鬼谷", 197,  87, 151, MP_GUIGU }
x000510_g_mpInfo[12]	= { "桃花岛", 720,  250, 171, MP_TAOHUADAO }

x000510_g_Yinpiao = 40002000 

x000510_g_Impact_NotTransportList = { 5929, 5944 } -- 禁止传送的Impact
x000510_g_TalkInfo_NotTransportList = { "#{GodFire_Info_062}", "#{XSHCD_20080418_099}" } -- 禁止传送的Impact提示信息

--**********************************
--事件交互入口
--**********************************
function x000510_OnDefaultEvent( sceneId, selfId,targetId )
	
	-- 检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x000510_g_Yinpiao)>=1  then
		BeginEvent( sceneId )
			AddText( sceneId, "  你身上有银票，正在跑商！我不能帮助你。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
    local NPCName = GetName(sceneId,targetId)
	local nMenPaiId = GetMenPai(sceneId,selfId);
	BeginEvent( sceneId )
		if nMenPaiId == 13 then
			AddText( sceneId, "#{THD_190613_19}")
		else
			AddText( sceneId, "#{THD_190613_20}")
		end
		AddNumText( sceneId, x000510_g_ScriptId, "城市 - 大理", 9, 1006 )
		AddNumText( sceneId, x000510_g_ScriptId, "城市 - 洛阳", 9, 1001 )
		AddNumText( sceneId, x000510_g_ScriptId, "城市 - 洛阳 - 九州商会", 9, 1002 )
		AddNumText( sceneId, x000510_g_ScriptId, "城市 - 苏州", 9, 1003 )
		AddNumText( sceneId, x000510_g_ScriptId, "城市 - 苏州 - 铁匠铺", 9, 1004 )
		AddNumText( sceneId, x000510_g_ScriptId, "城市 - 楼兰", 9, 1005 )
		AddNumText( sceneId, x000510_g_ScriptId, "城市 - #G凤鸣镇", 9, 1017 )
        CallScriptFunction( x000510_g_xuanWuDaoId, "OnEnumerate",sceneId, selfId, targetId ) 
		AddNumText( sceneId, x000510_g_ScriptId, "带我去其它门派", 9, 1011 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000510_OnEventRequest( sceneId, selfId, targetId, eventId )

	--漕运禁止传送....
	if GetTeamId(sceneId,selfId)>=0 and 
		IsTeamFollow(sceneId, selfId)==1 and
		LuaFnIsTeamLeader(sceneId,selfId)==1 then
		num=LuaFnGetFollowedMembersCount( sceneId, selfId)
		local mems = {}
		for	i=0,num-1 do
			mems[i] = GetFollowedMember(sceneId, selfId, i)
			if mems[i] == -1 then
				return
			end
			if IsHaveMission(sceneId,mems[i],4021) > 0 then
				x000510_MsgBox( sceneId, selfId, targetId, "  你队伍成员中有人有漕运货舱在身，我们驿站不能为你提供传送服务。" )
				return
			end
		end
	end

	if IsHaveMission(sceneId,selfId,4021) > 0 then
		x000510_MsgBox( sceneId, selfId, targetId, "  你有漕运货舱在身，我们驿站不能为你提供传送服务。" )
		return
	end

	--检测Impact状态驻留效果
	for i, ImpactId in x000510_g_Impact_NotTransportList do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactId) ~= 0 then
			x000510_MsgBox( sceneId, selfId, targetId, x000510_g_TalkInfo_NotTransportList[i] )			
			return 0
		end
	end

	
	--返回门派....
	local	arg	= GetNumText()
	local	mp
	local	i		= 0
	local	id	= LuaFnGetMenPai( sceneId, selfId )
        local xiezi=GetHumanMaxVigor(sceneId,selfId) 
	if arg == 1000 then		--返回门派
		if id == 9 and xiezi < 25000 then
			x000510_MsgBox( sceneId, selfId, targetId, "  你还没有加入任何门派！" )
		else
			mp	= x000510_GetMPInfo( id )
			if mp ~= nil then
				CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4] )
			end
		    if id == 9 and xiezi > 25000 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 197, 87, 151 )
                end
		end
		return
	end

	--鬼谷
  	--if arg == 9999 then
		--CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 197, 87, 151 )
		--return
	--end

        --大理
        if arg == 1006 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 253, 122 )
		return
	end

	--洛阳....
	if arg == 1001 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 233, 321 )
		return
	end

	--洛阳九州....
	if arg == 1002 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 325, 270 )
		return
	end

	--苏州....
	if arg == 1003 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 202,257 )
		return
	end

	--苏州铁匠....
	if arg == 1004 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 331, 226 )
		return
	end

	--楼兰....
	if arg == 1005 then
         if GetLevel( sceneId, selfId ) >= 75 then  
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 288, 136, 75 )
		return
	        end
              	x000510_MsgBox( sceneId, selfId, targetId, "  你的等级不足75级，暂时不能使用。" )
            end

	--凤鸣镇....
	if arg == 1017 then
         if GetLevel( sceneId, selfId ) >= 85 then  
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 580, 158, 120, 75 )
		return
	        end
              	x000510_MsgBox( sceneId, selfId, targetId, "  你的等级不足85级，暂时不能进入天荒古镇。" )
                end

	if arg == 1011 then		
		BeginEvent( sceneId )
		                --AddNumText( sceneId, x000510_g_ScriptId, "#G测试 - 鬼谷", 9, 9999 )
			for i, mp in x000510_g_mpInfo do
				AddNumText( sceneId, x000510_g_ScriptId, "门派 - "..mp[1], 9, i )
			end
			
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	
		return
	end
	
	if arg == 1016 then		--束河古镇
			-- add by zchw
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, x000510_g_ScriptId);
			-- zchw fix Transfer bug
			UICommand_AddInt(sceneId, targetId);
			UICommand_AddString(sceneId, "GotoShuHeGuZhen");
			UICommand_AddString(sceneId, "束河古镇为不加杀气场景，请注意安全。你确认要进入吗？");
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 24)
		return
	end
--[tx42913]
	if eventId == x000510_g_xuanWuDaoId then --去玄武岛
		CallScriptFunction( x000510_g_xuanWuDaoId, "OnDefaultEvent",sceneId, selfId, targetId )
		return
	end

	
	--门派....
	for i, mp in x000510_g_mpInfo do
		if arg == i then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4] )
			return
		end
	end

end
--  add by zchw
function x000510_GotoShuHeGuZhen( sceneId, selfId, targetId )
	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 420, 200, 211, 20 );
	return
end

--add by WTT
--function x000510_GotoShuHeGuZhen( sceneId, selfId, targetId )
	--CallScriptFunction((400900), "TransferFuncFromNpc", sceneId, selfId, 420, 200, 211, 20 );
	--return
--end

--**********************************
--根据门派ID获取门派信息
--**********************************
function x000510_GetMPInfo( mpID )
	local	mp
	local	i		= 0
	for i, mp in x000510_g_mpInfo do
		if mp[5] == mpID then
			return mp
		end
	end
	return nil
end

--**********************************
--对话窗口信息提示
--**********************************
function x000510_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end