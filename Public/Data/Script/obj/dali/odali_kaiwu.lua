-- 天工开物领取人民币材料
-- 创建人[ QUFEI 2007-09-21 15:07 UPDATE BugID 24677 ]

x002097_g_ScriptId = 002097

x002097_g_Update = {

    ["id01"] = 50,
    ["id02"] = 60,
    ["id03"] = 70,
    ["id04"] = 80,
    ["id05"] = 90,
    ["id06"] = 100,
    ["id07"] = 130,
    ["id08"] = 140,

}

--提示信息
x002097_g_msg = {

    ["jl30"]	= "#c33ffcc领取#cFF000030级#G [4级宝石]#Y奖励", 
    ["jl40"]	= "#c33ffcc领取#cFF000040级#G [4级宝石]#Y奖励", 
    ["jl50"]	= "#c33ffcc领取#cFF000050级#G [5级宝石]#Y奖励", 
    ["jl60"]	= "#c33ffcc领取#cFF000060级#G [5级宝石]#Y奖励", 
    ["jl70"]	= "#c33ffcc领取#cFF000070级#G [6级宝石]#Y奖励", 
    ["jl80"]	= "#c33ffcc领取#cFF000080级#G [6级宝石]#Y奖励", 
    ["jl90"]	= "#c33ffcc领取#cFF000090级#G [7级宝石]#Y奖励", 
    ["jl100"]	= "#c33ffcc领取#cFF0000100级#G [7级宝石]#Y奖励", 

}

--奖励标记
x002097_g_flag = {

    [30]	= MF_LINGQUYUANBAOVIP,
    [40]	= MF_TianGongJiangli60,
    [50]	= MF_TianGongJiangli70,
    [60]	= MF_TianGongJiangli80,
    [70]	= MF_BUCHANG_MONEY,
    [80]	= MF_BUCHANG_STONE,
    [90]	= MF_BUCHANG_EQUIP,
    [100]	= MF_ActiveJuCard,
}

--材料奖励
-- 60 棉布碎片
-- 70 精铁碎片
-- 80 秘银碎片
x002097_g_CaiLiaoJiangLi = {

    [30]	= { NG = 50413004, WG = 39910002 },
    [40]	= { NG = 50413004, WG = 39910002 },
    [50]	= { NG = 50513004, WG = 39910003 },
    [60]	= { NG = 50513004, WG = 39910003 },
    [70]	= { NG = 50613004, WG = 39910004 },
    [80]	= { NG = 50613004, WG = 39910004 },
    [90]	= { NG = 50713004, WG = 39910005 },
    [100]	= { NG = 50713004, WG = 39910005 },

}

x002097_g_PlayerLevel = 0

--**********************************
--列举事件
--**********************************
function x002097_OnEnumerate( sceneId, selfId, targetId )	
		
	BeginEvent(sceneId)
	
		if GetLevel( sceneId, selfId ) >= 10 then
			AddNumText( sceneId, x002097_g_ScriptId,"#e0e8de5#Y领取#G高级宝石#W奖励", 6, 105 )
			--AddNumText( sceneId, x002097_g_ScriptId, "#{TGKW_20070918_004}", 11, 106 )
		end	
			
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
		
end

function x002097_OnDefaultEvent( sceneId, selfId, targetId )
	
	local	key	= GetNumText()
	x002097_g_PlayerLevel = GetNumText()
			
	if key == 105 then
		BeginEvent(sceneId)
		
		AddText(sceneId,"  #e0e8de5#Y永久天龙欢迎您......")				
		AddNumText( sceneId, x002097_g_ScriptId, x002097_g_msg["jl50"], 6, x002097_g_Update["id01"] )	
		AddNumText( sceneId, x002097_g_ScriptId, x002097_g_msg["jl60"], 6, x002097_g_Update["id02"] )	
		AddNumText( sceneId, x002097_g_ScriptId, x002097_g_msg["jl70"], 6, x002097_g_Update["id03"] )	
		AddNumText( sceneId, x002097_g_ScriptId, x002097_g_msg["jl80"], 6, x002097_g_Update["id04"] )	
		AddNumText( sceneId, x002097_g_ScriptId, x002097_g_msg["jl90"], 6, x002097_g_Update["id05"] )	
		AddNumText( sceneId, x002097_g_ScriptId, x002097_g_msg["jl100"], 6, x002097_g_Update["id06"] )	
		AddNumText( sceneId, x002097_g_ScriptId, x002097_g_msg["jl130"], 6, x002097_g_Update["id07"] )	
		AddNumText( sceneId, x002097_g_ScriptId, x002097_g_msg["jl140"], 6, x002097_g_Update["id08"] )	
		
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	
	elseif key == 106 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{TGKW_20070918_002}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		return
	elseif key == x002097_g_Update["id01"] or key == x002097_g_Update["id02"] or key == x002097_g_Update["id03"] or key == x002097_g_Update["id04"] or key == x002097_g_Update["id05"] or key == x002097_g_Update["id06"] or key == x002097_g_Update["id07"] or key == x002097_g_Update["id08"] then
		x002097_OnTianGongKaiWu( sceneId, selfId, targetId )
		return
	end	
	
end

function x002097_OnTianGongKaiWu( sceneId, selfId, targetId )
		
	local mylevel = GetLevel( sceneId, selfId )
		
	if mylevel < x002097_g_PlayerLevel then
		local strText = format("您的等级不够，待等级达到%d级再来找我吧。", x002097_g_PlayerLevel )
		x002097_TalkMsg( sceneId, selfId, targetId, strText )	
		return
	end
		
	local index =	GetMissionFlag( sceneId, selfId, x002097_g_flag[x002097_g_PlayerLevel] )
		
	if index == 1 then
		x002097_TalkMsg( sceneId, selfId, targetId, "您已经领取过该项奖励，不能再领了。" )	
		return
	end
	
	if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 2 then
		x002097_TalkMsg( sceneId, selfId, targetId, "  你的背包背包材料栏不够了，整理后再来找我。" )
		return
	end
	-- 奖励材料
	local bagpos01 = TryRecieveItem( sceneId, selfId, x002097_g_CaiLiaoJiangLi[x002097_g_PlayerLevel].NG, QUALITY_MUST_BE_CHANGE )	-- 放不下就没有了
	local bagpos02 = TryRecieveItem( sceneId, selfId, x002097_g_CaiLiaoJiangLi[x002097_g_PlayerLevel].WG, QUALITY_MUST_BE_CHANGE )	-- 放不下就没有了
	--local bagpos03 = TryRecieveItem( sceneId, selfId, x002097_g_CaiLiaoJiangLi[x002097_g_PlayerLevel], QUALITY_MUST_BE_CHANGE )	-- 放不下就没有了
	--local bagpos04 = TryRecieveItem( sceneId, selfId, x002097_g_CaiLiaoJiangLi[x002097_g_PlayerLevel], QUALITY_MUST_BE_CHANGE )	-- 放不下就没有了
	
	local itemInfo = GetBagItemTransfer( sceneId, selfId, bagpos01 )
	local itemName = GetBagItemTransfer( sceneId, selfId, bagpos02 )
		
	-- 强制绑定										
	local	bindidx01	=	LuaFnItemBind( sceneId, selfId, bagpos01 )
	local	bindidx02	=	LuaFnItemBind( sceneId, selfId, bagpos02 )
	--local	bindidx03	=	LuaFnItemBind( sceneId, selfId, bagpos03 )
	--local	bindidx04	=	LuaFnItemBind( sceneId, selfId, bagpos04 )
	
	if bindidx01 ~= 1 or bindidx02 ~= 1 then
		local bindmsg = "绑定失败"													
		BeginEvent( sceneId )
			AddText( sceneId, bindmsg )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		return
	end
		
	SetMissionFlag( sceneId, selfId, x002097_g_flag[x002097_g_PlayerLevel], 1 )
	
	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,18,1000)
	local retmsg = format("#Y%s#W和#G%s#W物品领取成功", GetItemName(sceneId,x002097_g_CaiLiaoJiangLi[x002097_g_PlayerLevel].NG), GetItemName(sceneId,x002097_g_CaiLiaoJiangLi[x002097_g_PlayerLevel].WG) )
	x002097_TalkMsg( sceneId, selfId, targetId, retmsg )	

	-- 发送系统公告										
	local playername = GetName(sceneId, selfId)
	local strText = format("#gffff00#{_INFOUSR%s}#{TGKW_20070918_005}#Y%d#{TGKW_20070918_006}#e0e8de5#G#{_INFOMSG%s}#W和#e0e8de5#G#{_INFOMSG%s}#W各#G1个。", playername, x002097_g_PlayerLevel, itemInfo, itemName)										
	BroadMsgByChatPipe(sceneId, selfId, strText, 4)
end

--**********************************
--消息提示
--**********************************
function x002097_MsgBox( sceneId, selfId, str )	
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--对话提示
--**********************************
function x002097_TalkMsg( sceneId, selfId, targetId, str )	
	BeginEvent(sceneId)
      AddText(sceneId, str)      
  EndEvent(sceneId)
  DispatchEventList(sceneId,selfId,targetId)    
end
