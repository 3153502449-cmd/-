--束河NPC
--驿站....

x045000_g_ScriptId	= 045000

--门派信息(门派名称，SceneID，PosX，PosY，门派ID)
x045000_g_mpInfo		= {}
x045000_g_mpInfo[0]	= { "星宿", 16,  96, 152, MP_XINGSU }
x045000_g_mpInfo[1]	= { "逍遥", 14,  67, 145, MP_XIAOYAO }
x045000_g_mpInfo[2]	= { "少林",  9,  96, 127, MP_SHAOLIN }
x045000_g_mpInfo[3]	= { "天山", 17,  95, 120, MP_TIANSHAN }
x045000_g_mpInfo[4]	= { "天龙", 13,  96, 120, MP_DALI }
x045000_g_mpInfo[5]	= { "峨嵋", 15,  89, 139, MP_EMEI }
x045000_g_mpInfo[6]	= { "武当", 12, 103, 140, MP_WUDANG }
x045000_g_mpInfo[7]	= { "明教", 11,  98, 167, MP_MINGJIAO }
x045000_g_mpInfo[8]	= { "丐帮", 10,  91, 116, MP_GAIBANG }
x045000_g_mpInfo[9]	= { "唐门", 495,  129, 71, MP_GAIBANG }--预留

x045000_g_Yinpiao = 40002000 

x045000_g_Impact_NotTransportList = { 5929, 5944 } -- 禁止传送的Impact
x045000_g_TalkInfo_NotTransportList = { "#{GodFire_Info_062}", "#{XSHCD_20080418_099}" } -- 禁止传送的Impact提示信息

--**********************************
--事件交互入口
--**********************************
function x045000_OnDefaultEvent( sceneId, selfId,targetId )
	
	-- 检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x045000_g_Yinpiao)>=1  then
		BeginEvent( sceneId )
			AddText( sceneId, "  你身上有银票，正在跑商！我不能帮助你。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	local	mp
	local	i		= 0
	BeginEvent( sceneId )

		AddText( sceneId, "#{loulan_yizhan_20080329}")
		 
		AddNumText( sceneId, x045000_g_ScriptId, "返回门派", 9, 1000 )
		AddNumText( sceneId, x045000_g_ScriptId, "城市 - 洛阳", 9, 1001 )
		AddNumText( sceneId, x045000_g_ScriptId, "城市 - 洛阳 - 九州商会", 9, 1002 )
		AddNumText( sceneId, x045000_g_ScriptId, "城市 - 苏州", 9, 1003 )
		AddNumText( sceneId, x045000_g_ScriptId, "城市 - 苏州 - 铁匠铺", 9, 1004 )
		AddNumText( sceneId, x045000_g_ScriptId, "城市 - 大理", 9, 1005 )
		AddNumText( sceneId, x045000_g_ScriptId, "城市 - 楼兰", 9, 1016 )
		AddNumText( sceneId, x045000_g_ScriptId, "城市 -束河古镇", 9, 1017 )
		 
		AddNumText( sceneId, x045000_g_ScriptId, "带我去其它门派", 9, 1011 )
		
		--for i, mp in x045000_g_mpInfo do
			--AddNumText( sceneId, x045000_g_ScriptId, "门派 - "..mp[1], 9, i )
		--end

	
	
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end

--**********************************
--事件列表选中一项
--**********************************
function x045000_OnEventRequest( sceneId, selfId, targetId, eventId )

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
				x045000_MsgBox( sceneId, selfId, targetId, "  你队伍成员中有人有漕运货舱在身，我们驿站不能为你提供传送服务。" )
				return
			end
		end
	end

	if IsHaveMission(sceneId,selfId,4021) > 0 then
		x045000_MsgBox( sceneId, selfId, targetId, "  你有漕运货舱在身，我们驿站不能为你提供传送服务。" )
		return
	end

	--检测Impact状态驻留效果
	for i, ImpactId in x045000_g_Impact_NotTransportList do
		if LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, ImpactId) ~= 0 then
			x045000_MsgBox( sceneId, selfId, targetId, x045000_g_TalkInfo_NotTransportList[i] )			
			return 0
		end
	end

	
	--返回门派....
	local	arg	= GetNumText()
	local	mp
	local	i		= 0
	local	id	= LuaFnGetMenPai( sceneId, selfId )
	if arg == 1000 then		--返回门派
		if id < 0 or id >= 9 then
			x045000_MsgBox( sceneId, selfId, targetId, "  你还没有加入任何门派！" )
		else
			mp	= x045000_GetMPInfo( id )
			if mp ~= nil then
				CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4] )
			end
		end
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

	--大理....
	if arg == 1005 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 376, 222 )
		return
	end

	--束河古镇....
	if arg == 1016 then		--束河古镇
			-- add by zchw
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, x045000_g_ScriptId);
			-- zchw fix Transfer bug
			UICommand_AddInt(sceneId, targetId);
			UICommand_AddString(sceneId, "GotoShuHeGuZhen");
			UICommand_AddString(sceneId, "束河古镇为不加杀气场景，请注意安全。你确认要进入吗？");
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 24)
		return
	end

	if arg == 1011 then		
		BeginEvent( sceneId )
			for i, mp in x045000_g_mpInfo do
				AddNumText( sceneId, x045000_g_ScriptId, "门派 - "..mp[1], 9, i )
			end
			
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	
		return
	end
	
	--楼兰....
	if arg == 1016 then
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 286, 129 )
		return
	end
	
	--门派....
	for i, mp in x045000_g_mpInfo do
		if arg == i then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4] )
			return
		end
	end

end
--  add by zchw
function x045000_GotoShuHeGuZhen( sceneId, selfId, targetId )
	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 420, 200, 211, 20 );
	return
end
--**********************************
--根据门派ID获取门派信息
--**********************************
function x045000_GetMPInfo( mpID )
	local	mp
	local	i		= 0
	for i, mp in x045000_g_mpInfo do
		if mp[5] == mpID then
			return mp
		end
	end
	return nil
end

--**********************************
--对话窗口信息提示
--**********************************
function x045000_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
