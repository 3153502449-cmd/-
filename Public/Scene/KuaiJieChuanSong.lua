-- 2016年经典游戏巨作英雄复古地图传送脚本
--**********************************
-- 事件交互入口
--**********************************
-- QQ:482930791 悟空制作编写，尊重劳动成果 版权著作 本脚本已经 注册版权
-- 版权登记涉及著作权法第三条所列的作品，如文字作品、口述作品、影视作品、工程和产品设计图纸及其说明等

x900068_g_ScriptId	= 900068

--门派信息(门派名称，SceneID，PosX，PosY，门派ID)
x900068_g_mpInfo		= {}
x900068_g_mpInfo[0]	= { "星宿", 16,  96, 152, MP_XINGSU }
x900068_g_mpInfo[1]	= { "逍遥", 14,  67, 145, MP_XIAOYAO }
x900068_g_mpInfo[2]	= { "少林",  9,  96, 127, MP_SHAOLIN }
x900068_g_mpInfo[3]	= { "天山", 17,  95, 120, MP_TIANSHAN }
x900068_g_mpInfo[4]	= { "天龙", 13,  96, 120, MP_DALI }
x900068_g_mpInfo[5]	= { "峨嵋", 15,  89, 139, MP_EMEI }
x900068_g_mpInfo[6]	= { "武当", 12, 103, 140, MP_WUDANG }
x900068_g_mpInfo[7]	= { "明教", 11,  98, 167, MP_MINGJIAO }
x900068_g_mpInfo[8]	= { "丐帮", 10,  91, 116, MP_GAIBANG }

x900068_g_Yinpiao = 40002000
--**********************************
--事件交互入口
--**********************************
function x900068_OnDefaultEvent( sceneId, selfId, targetId )

	-- 检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x900068_g_Yinpiao)>=1  then
		BeginEvent( sceneId )
			AddText( sceneId, "  你身上有银票，正在跑商！我不能帮助你。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	local	mp
	local	i		= 0
	BeginEvent( sceneId )
		if GetLevel( sceneId, selfId ) >= 1 then
			AddText( sceneId, "　#G亲爱的玩家.欢迎你来到#Y英雄天龙。" )
			AddText( sceneId, "#I地图采用全图直达模式感谢您的支持。" )
			AddNumText( sceneId, x900068_g_ScriptId, "满血满怒(免费治疗)", 1, 10000 )
			AddNumText( sceneId, x900068_g_ScriptId, "城镇传送", 6, 8888 )
			AddNumText( sceneId, x900068_g_ScriptId, "练级传送", 6, 5555 )
			AddNumText( sceneId, x900068_g_ScriptId, "副本传送", 6, 3333 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派怪物#G(元宝、经验、材料)", 6, 2222 )
			AddNumText( sceneId, x900068_g_ScriptId, "野外怪物#G(元宝、经验、材料)", 6, 9999 )
			AddNumText( sceneId, x900068_g_ScriptId, "活动怪物#G(活动、元宝、材料)", 6, 7777 )
			AddNumText( sceneId, x900068_g_ScriptId, "生活地图#H(种植、挖矿、钓鱼)", 6, 1999 )
			AddNumText( sceneId, x900068_g_ScriptId, "常去地图#H(任务、校场、打图)", 6, 10001 )
			--AddNumText( sceneId, x900068_g_ScriptId, "钓鱼-种植", 6, 6666 )
			for i, mp in x900068_g_mpInfo do
			end
		else
			AddText( sceneId, "  你需要等级到达10级以上，才能去别的城市。" )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 大理",  9, 1113 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 大理2", 9, 1114 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 大理3", 9, 1115 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市-传送", 9, 8888 )
		end

		
		

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x900068_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1011111 then
	local	mp
	local	i		= 0
		BeginEvent( sceneId )
			for i, mp in x900068_g_mpInfo do
				AddNumText( sceneId, x000128_g_ScriptId, "门派 - "..mp[1], 9, i )
			end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
      if GetNumText() == 10000 then
              x900068_Restore_hpmp( sceneId, selfId, targetId )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"治疗成功，最新仿官天龙祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	if GetNumText() == 1110 then
	local	mp
	local	i		= 0
		BeginEvent( sceneId )
			for i, mp in x900068_g_mpInfo do
				AddNumText( sceneId, x900068_g_ScriptId, "门派 - "..mp[1], 9, i )
			end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
		--队伍相关
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
				x900068_MsgBox( sceneId, selfId, targetId, "  你队伍成员中有人有漕运\货舱在身，我们驿站不能为你提供传送服务。" )
				return
			end
		end
	end

	--漕运相关
	if IsHaveMission(sceneId,selfId,4021) > 0 then
		x900068_MsgBox( sceneId, selfId, targetId, "  你有漕运货舱在身，必须徒步经过-嵩山-太湖-苏州#G（243,79）漕运处交任务。" )
		return
	end

	--顺利传送
	local	arg	= GetNumText()
	local	mp
	local	i		= 0
	local	id	= LuaFnGetMenPai( sceneId, selfId )
	if arg == 1000 then		--返回门派
		if id < 0 or id >= 9 then
			x900068_MsgBox( sceneId, selfId, targetId, "  你还没有加入任何门派！" )
		else
			mp	= x900068_GetMPInfo( id )
			if mp ~= nil then
				CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4], 10 )
			end
		end
		return
	end

--增加的传送点对应响应事件列表。

	if arg == 3333 then
			BeginEvent( sceneId )
			AddText( sceneId, "　#G亲爱的玩家.欢迎你来到#Y英雄天龙。" )
			AddText( sceneId, "#I地图采用全图直达模式感谢您的支持。" )
			AddNumText( sceneId, x900068_g_ScriptId, "副本 - #G 水    牢 ", 9, 1201 )
			AddNumText( sceneId, x900068_g_ScriptId, "副本 - #G 蹴鞠大赛 ", 9, 1202 )
			AddNumText( sceneId, x900068_g_ScriptId, "副本 - #G 珍龙棋局 ", 9, 1203 )
			AddNumText( sceneId, x900068_g_ScriptId, "副本 - #G 楼兰寻宝 ", 9, 1204 )
			AddNumText( sceneId, x900068_g_ScriptId, "副本 - #G苏州老三环", 9, 1205 )
			AddNumText( sceneId, x900068_g_ScriptId, "副本 - #G楼兰新三环", 9, 1206 )
			AddNumText( sceneId, x900068_g_ScriptId, "副本 - #G讨伐燕子坞", 9, 1207 )
			AddNumText( sceneId, x900068_g_ScriptId, "副本 - #G挑战飘渺峰", 9, 1208 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	return
	end
	
	if arg == 10001 then
			BeginEvent( sceneId )
			AddText( sceneId, "　#G亲爱的玩家.欢迎你来到#Y英雄天龙。" )
			AddText( sceneId, "#I地图采用全图直达模式感谢您的支持。" )
			AddNumText( sceneId, x900068_g_ScriptId, "敦煌", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "西湖", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "嵩山", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "洱海", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "苍山", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "雁南", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "雁北", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "草原", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "苏州铁匠 - #G打造神器 ", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "洛阳校场 - #G擂台挑战", 9, 3733 )
			AddNumText( sceneId, x900068_g_ScriptId, "苏州打图 - #G惩恶打图", 9, 3732 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	return
	end
	
	
	
	if arg == 5555 then
			BeginEvent( sceneId )
			AddText( sceneId, "　很多朋友都想找回08年玩天龙的感觉，#G可升级太慢会造成人气流失#W，我们经过考虑后对#G98级前#W的经验减半#W" )
			AddText( sceneId, "#r#I提醒:等级＜30的玩家请去做任务升级" )
			AddNumText( sceneId, x900068_g_ScriptId, "燕王古墓一层(30-50级)#G#b 推荐", 9, 1221 )
			AddNumText( sceneId, x900068_g_ScriptId, "燕王古墓五层(55-60级)", 9, 1222 )
			AddNumText( sceneId, x900068_g_ScriptId, "燕王古墓八层(60-65级)", 9, 1223 )
			AddNumText( sceneId, x900068_g_ScriptId, "秦皇地宫一层(65-68级)", 9, 1224 )
			AddNumText( sceneId, x900068_g_ScriptId, "秦皇地宫三层(70-90级)#G#b 推荐", 9, 1225 )
			AddNumText( sceneId, x900068_g_ScriptId, "高昌迷宫 (后期练级必争)", 9, 1226 )
			AddNumText( sceneId, x900068_g_ScriptId, "汗 血 岭 (后期练级必争)", 9, 1227 )
			AddNumText( sceneId, x900068_g_ScriptId, "塔克沙漠 (后期练级必争)", 9, 1228 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	return
	end
	
	if arg == 6666 then
			BeginEvent( sceneId )
			AddText( sceneId, "  当你学习生活技能后可以从我这里快速传送到达#G种植点#W或#G钓鱼点。" )
			AddText( sceneId, "  若是想要学习钓鱼技能可以打开地图找到显示#c00ffff“鱼”#W字处学习。" )
			AddText( sceneId, "  若是想要学习种植技能可以打开地图找到显示#c00ffff“农”#W字处学习。" )
			AddText( sceneId, "  #G楼兰种植#cFF0000“彩棉”#G或去草原垂钓#cFF0000“鲑鱼”#G可兑换任意#Y５级手工材料#G！除了合成外，这是唯一获得途径喔…" )
			AddText( sceneId, "  #R提醒：#Y５级手工材料#R要比４级材料出#cFF0000“９星”#R的几率高出几十倍！" )
			AddNumText( sceneId, x900068_g_ScriptId, "种植 - #G楼兰", 9, 1231 )	
			AddNumText( sceneId, x900068_g_ScriptId, "钓鱼 - #G草原", 9, 1232 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	return
	end
	
	if arg == 2222 then
			BeginEvent( sceneId )
			AddText( sceneId, "　#G亲爱的玩家.欢迎你来到#Y小柱天龙。" )
			AddText( sceneId, "#I地图采用全图直达模式感谢您的支持。" )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G峨眉", 9, 1211 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G逍遥", 9, 1212 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G天山", 9, 1213 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G明教", 9, 1214 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G星宿", 9, 1215 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G天龙", 9, 1216 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G少林", 9, 1217 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G丐帮", 9, 1218 )
			AddNumText( sceneId, x900068_g_ScriptId, "门派Ｂoss - #G武当", 9, 1219 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
			end
	
	if arg == 7777 then
			BeginEvent( sceneId )
			AddText( sceneId, "　#G亲爱的玩家.欢迎你来到#Y英雄天龙。" )
			AddText( sceneId, "#I地图采用全图直达模式感谢您的支持。" )
			AddText( sceneId, "#I活动精彩不断.奖励多多请务必参与哦" )
			AddNumText( sceneId, x900068_g_ScriptId, "至尊名人 - #G玄武岛", 9, 1241 )
			AddNumText( sceneId, x900068_g_ScriptId, "妖猴现世 - #G无量山", 9, 1242 )
			AddNumText( sceneId, x900068_g_ScriptId, "上古魔兽 - #G镜  湖", 9, 1243 )
			AddNumText( sceneId, x900068_g_ScriptId, "仙草争夺 - #G镜  湖", 9, 1244 )
			AddNumText( sceneId, x900068_g_ScriptId, "圣兽宝箱 - #G圣兽山", 9, 1245 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
			end
	
	if arg == 8888 then
			BeginEvent( sceneId )
			AddText( sceneId, "#{XIYU_20071228_01}" )
			--AddNumText( sceneId, x900068_g_ScriptId, "许愿 - #G太湖", 9, 8878 )
			AddNumText( sceneId, x900068_g_ScriptId, "返回门派", 9, 1011111 )
			AddNumText( sceneId, x900068_g_ScriptId, "前往 - 钱庄", 9, 1220 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 洛阳", 9, 1001 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 洛阳 - 九州商会", 9, 5678 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 大理",  9, 1113 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 苏州", 9, 1002 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 苏州 - 铁匠铺", 9, 3731 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 楼兰", 9, 8877 )
			AddNumText( sceneId, x900068_g_ScriptId, "城市 - 束河古镇", 9, 8879 )
			AddNumText( sceneId, x900068_g_ScriptId, "带我去其他门派", 9, 1110 )

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	return
	end
	
	if arg == 9999 then
			BeginEvent( sceneId )
			AddText( sceneId, "　#G亲爱的玩家.欢迎你来到#Y英雄天龙。" )
			AddText( sceneId, "#I地图采用全图直达模式感谢您的支持。" )
			AddText( sceneId, "#I日常怪物刷新系统将会自动发送公告。" )
			AddNumText( sceneId, x900068_g_ScriptId, "武  夷 - #G冰妖", 9, 1251 )
			AddNumText( sceneId, x900068_g_ScriptId, "苍  山 - #G金刚", 9, 1252 )
			AddNumText( sceneId, x900068_g_ScriptId, "草  原 - #G小白", 9, 1253 )
			AddNumText( sceneId, x900068_g_ScriptId, "玄武岛 - #G蛤蟆", 9, 1254 )
			AddNumText( sceneId, x900068_g_ScriptId, "圣兽山 - #G龙龟", 9, 1255 )
			AddNumText( sceneId, x900068_g_ScriptId, "银凯雪原 - #G企鹅王", 9, 1256 )

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	return
	end
	
	if arg == 1999 then
			BeginEvent( sceneId )
			AddText( sceneId, "　#G亲爱的玩家.欢迎你来到#Y英雄天龙。" )
			AddText( sceneId, "#I地图采用全图直达模式感谢您的支持。" )
			AddText( sceneId, "#H（本服因考虑到部分无法赞助的平民玩家，为了其生存特此提供种植，钓鱼，挖矿三项生活技能，产物均可兑换各种物品元宝奖励。）" )
			AddNumText( sceneId, x900068_g_ScriptId, "前往种植地图", 9, 1251 )
			AddNumText( sceneId, x900068_g_ScriptId, "前往钓鱼地图", 9, 1251 )
			AddNumText( sceneId, x900068_g_ScriptId, "前往挖矿地图", 9, 1251 )

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	return
	end
--增加的传送点对应响应事件列表
	local	arg	= GetNumText()
	local	mp
	local	i		= 0
	local	id	= LuaFnGetMenPai( sceneId, selfId )
	if arg == 1000 then		--返回门派
		if id < 0 or id >= 9 then
			x900068_MsgBox( sceneId, selfId, targetId, "  你还没有加入任何门派！" )
		else
			mp	= x900068_GetMPInfo( id )
			if mp ~= nil then
				CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4], 10 )
			end
		end
		return
	end
	if arg == 1001 then		--洛阳
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 137, 182, 10 )
		return
	end
	if arg == 1002 then		--苏州
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 203,258, 10 )
		return
	end
	if arg == 3731 then		--苏州铁匠
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 346, 240, 10 )
		return
	end
	if arg == 3732 then		--苏州铁匠
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 225, 224, 10 )
		return
	end
	if arg == 3733 then		--苏州铁匠
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 91, 184, 10 )
		return
	end
	
	if arg == 5678 then		--洛阳 - 九州
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 0, 232, 130, 10 )
		return
	end
	if arg == 8877 then		--楼兰
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 286, 130, 10 )
		return
	end
	if arg == 8878 then		--太湖许愿树
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 4, 161, 182, 10 )
		return
	end
	if arg == 8879 then		--束河古镇
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 420, 201, 212, 10 )
		return
	end
	if arg == 1201 then		--太湖水牢
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 4, 63, 76, 10 )
	end
	if arg == 1202 then		--大理蹴鞠
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 278, 94, 10 )
	end
	if arg == 1203 then		--大理棋局
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 278, 94, 10 )
	end
	if arg == 1204 then		--楼兰寻宝
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 161, 76, 10 )
	end
	if arg == 1205 then		--苏州老三环
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 60, 162, 10 )
	end
	if arg == 1206 then		--楼兰新三环
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 292, 68, 10 )
	end
	if arg == 1207 then		--讨伐燕子坞
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 4, 78, 121, 10 )
		return
	end
	if arg == 1208 then		--挑战飘渺峰
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 190, 222, 10 )
		return
	end
	if arg == 1211 then		--峨眉
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 145, 46, 40, 10 )
		return
	end
	if arg == 1212 then		--逍遥
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 144, 140, 41, 10 )
		return
	end
	if arg == 1213 then		--天山
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 147, 93, 39, 10 )
		return
	end
	if arg == 1214 then		--明教
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 141, 98, 60, 10 )
		return
	end
	if arg == 1215 then		--星宿
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 146, 142, 54, 10 )
		return
	end
	if arg == 1216 then		--天龙
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 143, 95, 35, 10 )
		return
	end
	if arg == 1217 then		--少林
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 139, 46, 41, 10 )
		return
	end
	if arg == 1218 then		--丐帮
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 140, 44, 38, 10 )
		return
	end
	if arg == 1219 then		--武当
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 142, 88, 52, 10 )
		return
	end
	if arg == 1221 then		--古墓一层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 159, 68, 93, 10 )
	end
	if arg == 1222 then		--古墓五层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 163, 25, 25, 10 )
	end
	if arg == 1223 then		--古墓八层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 166, 25, 12, 10 )
	end
	if arg == 1224 then		--地宫一层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 400, 227, 221, 10 )
	end
	if arg == 1225 then		--地宫三层
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 402, 225, 217, 10 )
	end
	if arg == 1226 then		--高昌迷宫
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 520, 99, 102, 10 )
	end
	if arg == 1227 then		--汗血岭
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 432, 87, 89, 10 )
		return
	end
	if arg == 1228 then		--塔克拉玛干
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 427, 38, 24, 10 )
		return
	end
	if arg == 1231 then		--楼兰种植
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 49, 210, 10 )
		return
	end
	if arg == 1232 then		--草原钓鱼
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 20, 238, 137, 10 )
		return
	end
	if arg == 1241 then		--玄武岛-至尊名人
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 39, 149, 131, 10 )
		return
	end
	if arg == 1242 then		--无量山-妖猴现世
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 6, 43, 172, 10 )
		return
	end
	if arg == 1243 then		--镜湖-上古魔兽
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 5, 210, 58, 10 )
		return
	end
	if arg == 1244 then		--镜湖-仙草争夺
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 5, 101, 41, 10 )
		return
	end
	if arg == 1245 then		--圣兽山宝箱
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 158, 142, 114, 10 )
		return
	end
	if arg == 1251 then		--武夷冰妖
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 32, 99, 85, 10 )
	end
	if arg == 1252 then		--苍山金刚
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 25, 165, 54, 10 )
	end
	if arg == 1253 then		--草原小白
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 20, 65, 165, 10 )
	end
	if arg == 1254 then		--玄武蛤蟆
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 39, 214, 220, 10 )
		return
	end
	if arg == 1255 then		--圣兽山龙龟
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 158, 178, 34, 10 )
		return
	end
	if arg == 1256 then		--银凯雪原企鹅王
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 188, 78, 47, 10 )
		return
	end
	if arg == 1257 then		--西湖十二煞星
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 30, 80, 74, 10 )
		return
	end
	if arg == 1258 then		--太湖九大凶兽
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 4, 233, 233, 10 )
		return
	end
	if arg == 1259 then		--雁南黄金马贼
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 18, 248, 240, 10 )
		return
	end
	if arg == 1260 then		--束河古镇魔尊重楼
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 420, 168, 185, 10 )
		return
	end
	if arg == 1220 then		--钱庄
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 181, 64, 45, 10 )
		return
	end

	if arg == 1113 then		--大理1
		--如果玩家就在大理1则不传送
		if sceneId == 2 then
			x900068_MsgBox( sceneId, selfId, targetId, "  你已经在大理了。" )
		else
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 241, 138 )
		end
		return
	end
	if arg == 1114 then		--大理2
		--如果玩家就在大理2则不传送
		if sceneId == 71 then
			x900068_MsgBox( sceneId, selfId, targetId, "  你已经在大理2了。" )
		else
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 71, 241, 138 )
		end
		return
	end
	if arg == 1115 then		--大理3
		--如果玩家就在大理3则不传送
		if sceneId == 72 then
			x900068_MsgBox( sceneId, selfId, targetId, "  你已经在大理3了。" )
		else
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 72, 241, 138 )
		end
		return
	end

	for i, mp in x900068_g_mpInfo do
		if arg == i then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, mp[2], mp[3], mp[4], 10 )
			return
		end
	end

	if arg == 1010 then		--束河古镇
		-- add by zchw
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, x900068_g_ScriptId);
			-- zchw fix Transfer bug
			UICommand_AddInt(sceneId, targetId);
			UICommand_AddString(sceneId, "GotoShuHeGuZhen");
			UICommand_AddString(sceneId, "束河古镇为不加杀气场景，请注意安全。你确认要进入吗？");
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 24)
		return
	end

	if GetNumText() == 2000 then		--
		BeginEvent( sceneId )
			AddText( sceneId, "#{GOTO_DUNHUANF_SONGSHAN}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )

		return
	end

end
--  add by zchw
function x900068_GotoShuHeGuZhen( sceneId, selfId, targetId )
	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 420, 200, 211, 20 );
	return
end
--**********************************
--根据门派ID获取门派信息
--**********************************
function x900068_GetMPInfo( mpID )
	local	mp
	local	i		= 0
	for i, mp in x900068_g_mpInfo do
		if mp[5] == mpID then
			return mp
		end
	end
	return nil
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x900068_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x900068_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话窗口信息提示
--**********************************
function x900068_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--恢复血和气
--**********************************
function x900068_Restore_hpmp( sceneId, selfId, targetId )
	RestoreHp( sceneId, selfId )
	RestoreMp( sceneId, selfId )
	RestoreRage( sceneId, selfId )
end