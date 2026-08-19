--**********************************
-- 财富大使，领取物品以及福利 极致 Q546528533
--**********************************

--脚本号
x391002_g_ScriptId = 391002

--**********************************
-- 财富卡奖励设置。
--**********************************
x391002_g_GiftItem = {[1] = {10156001,10156002},
                      [2] = {20501007},
                      [3] = {20502007},
                      [4] = {20501007,20501007,39000010},
                      [5] = {20502007,20502007,39000011},
                      [6] = {20501007,20501007,20501007,39000012},
                      [7] = {20502007,20502007,20502007,39000014},
                      [8] = {38000011,39000015},
                      [9] = {38000011,39000017},
                      [10] = {38000012,38000952,38000952,38000952,39000018,39000018,39000018,39000017},
                      [11] = {38000012,38000952,38000952,38000952,38000952,39000019,},
                      [12] = {38000012,38000956,38000956,38000956,39000019,39000018},
                      [13] = {38000012,38000952,38000952,38000952,38000952,38000952,39000019,39000018,39000018},
                      [14] = {38000013,38000956,38000956,38000956,38000956,38000956,39000019,39000019,},
}
--**********************************
--测试内容调用
--**********************************
function x391002_SelefTest(sceneId,selfId)
    Msg2Player(  sceneId, selfId,"@*;npcpaopao;210;2034",MSG2PLAYER_PARA )
end
--**********************************
--事件列表
--**********************************
function x391002_UpdateEventList( sceneId, selfId,targetId )
	

    local CardTest = GetMissionData(sceneId,selfId,MD_NewUserCard)
	BeginEvent(sceneId)
		AddText( sceneId, "#{CFKYH_120723_82}" )
		if CardTest == 0 then
		AddNumText( sceneId, x391002_g_ScriptId, "#G天龙代金卡激活", 6, 1 )
		else
		AddNumText( sceneId, x391002_g_ScriptId, "#G天龙代金卡激活", 6, 1 )
		end
		--AddNumText( sceneId, x391002_g_ScriptId, "588财富卡CD-KEY激活", 6, 2 )
		AddNumText( sceneId, x391002_g_ScriptId, "CD-KEY抽奖", 6, 4 )
		AddNumText( sceneId, x391002_g_ScriptId, "CD-KEY购买", 6, 5 )
		AddNumText( sceneId, x391002_g_ScriptId, "领取累计登陆奖励", 6, 3 )
		--AddNumText( sceneId, x391002_g_ScriptId, "多余重楼回收", 6, 6 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	  x391002_SelefTest(sceneId,selfId)
end

--**********************************
--事件列表选中一项
--**********************************
function x391002_OnEventRequest( sceneId, selfId, targetId, eventId )

    if GetNumText() == 1 then
	  local CardTest = GetMissionData(sceneId,selfId,MD_NewUserCard)
	  if CardTest == 0 then--没有激活。
	     if LuaFnGetAvailableItemCount(sceneId, selfId,30505080) < 1 then
		    x391002_NotifyTip( sceneId, selfId, "代金卡不足，无法激活天龙代金卡。可前往木桶伯掉落" )
			 --TryRecieveItem( sceneId, selfId,30505080, 1 )
		    return
		 end
		 if LuaFnDelAvailableItem(sceneId,selfId,30505080,1) ~= 1 then
		    return
		 end
		 SetMissionData(sceneId,selfId,MD_NewUserCard,1)
		 --为了下面功能方便，几句代码搞定，这里初始化一下
		 SetMissionData(sceneId,selfId,MD_NewUserCard1,1111111)
		 SetMissionData(sceneId,selfId,MD_NewUserCard2,1111111)
	  else
	  ---这里表演一下菜单消失之术。
	   local Test_3 = GetMissionData(sceneId,selfId,MD_NewUserCard1)--1-7菜单领取情况
	   local Test_4 = GetMissionData(sceneId,selfId,MD_NewUserCard2)--8-14菜单领取情况
	   local nLingQu = {{},{}}
	    _,_,nLingQu[1][1],nLingQu[1][2],nLingQu[1][3],nLingQu[1][4],nLingQu[1][5],nLingQu[1][6],nLingQu[1][7] =strfind(tostring(Test_3),"(%d)(%d)(%d)(%d)(%d)(%d)(%d)")
	    _,_,nLingQu[2][1],nLingQu[2][2],nLingQu[2][3],nLingQu[2][4],nLingQu[2][5],nLingQu[2][6],nLingQu[2][7] =strfind(tostring(Test_4),"(%d)(%d)(%d)(%d)(%d)(%d)(%d)")
	    BeginEvent(sceneId)
	    if tonumber(nLingQu[1][1]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡15级奖励", 6, 101 )
		end
		if tonumber(nLingQu[1][2]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡20级奖励", 6, 102 )
		end
		if tonumber(nLingQu[1][3]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡30级奖励", 6, 103 )
		end
		if tonumber(nLingQu[1][4]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡40级奖励", 6, 104 )
		end
		if tonumber(nLingQu[1][5]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡50级奖励", 6, 105 )
		end
		if tonumber(nLingQu[1][6]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡60级奖励", 6, 106 )
		end
		if tonumber(nLingQu[1][7]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡70级奖励", 6, 107 )
		end
		if tonumber(nLingQu[2][1]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡80级奖励", 6, 108 )
		end
		if tonumber(nLingQu[2][2]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡90级奖励", 6, 109 )
		end
		if tonumber(nLingQu[2][3]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡100级奖励", 6, 110 )
		end
		if tonumber(nLingQu[2][4]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡105级奖励", 6, 111 )
		end
		if tonumber(nLingQu[2][5]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡110级奖励", 6, 112 )
		end
		if tonumber(nLingQu[2][6]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡115级奖励", 6, 113 )
		end
		if tonumber(nLingQu[2][7]) == 1 then
		AddNumText( sceneId, x391002_g_ScriptId, "财富卡119级奖励", 6, 114 )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	  
	  end
	end
	if GetNumText() == 2 then
	   DispatchUICommand(sceneId,selfId, 202005061)
	end
	if GetNumText() == 3 then
	   CallScriptFunction(892002, "LeiJiLoginGame", sceneId, selfId)
	end
	if GetNumText() == 4 then
	   CallScriptFunction(892002,"Scripttransitcenter",sceneId,selfId,13)
	end
	if GetNumText() == 5 then
	    LUR = "https://www.80faka.com/links/470D3EB1"               --这个是充值地址
		BeginUICommand( sceneId )
		UICommand_AddString( sceneId, LUR)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 20151126 )	
	    return	
	end
	if GetNumText() == 6 then
		BeginEvent(sceneId)
		
			--AddText( sceneId, "重楼肩 可回收 30元充值" )
			--AddText( sceneId, "重楼玉 可回收 200元充值" )
			--AddText( sceneId, "重楼戒 可回收 200元充值" )
			--AddText( sceneId, "重楼链 可回收 200元充值" )
			--AddText( sceneId, "重楼甲 可回收 500元充值" )
		
			--AddNumText( sceneId, x391002_g_ScriptId, "回收 重楼肩", 6, 11 )
			--AddNumText( sceneId, x391002_g_ScriptId, "回收 重楼玉", 6, 12 )
			--AddNumText( sceneId, x391002_g_ScriptId, "回收 重楼戒", 6, 13 )
			--AddNumText( sceneId, x391002_g_ScriptId, "回收 重楼链", 6, 14 )
			--AddNumText( sceneId, x391002_g_ScriptId, "回收 重楼甲", 6, 15 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if GetNumText() == 11 then
		local m_StuffNum = 0
		local  CL1 = 0
	    m_StuffId = 10553108
        m_StuffNum = 1
		CL1 =LuaFnGetAvailableItemCount(sceneId, selfId, m_StuffId)
		
		if CL1 < m_StuffNum then
		   x391002_NotifyTip( sceneId, selfId, "你没有 重楼肩 休想忽悠我!" )
		   return
		end
		
		LuaFnDelAvailableItem(sceneId,selfId,m_StuffId,m_StuffNum)
		TryRecieveItem( sceneId, selfId, 39000022, 1)
		x391002_NotifyTip( sceneId, selfId, "你回收了一个 重楼肩 获得 30元充值点 !" )
		return
	end
	if GetNumText() == 12 then
		local m_StuffNum = 0
		local  CL1 = 0
	    m_StuffId = 10553102
        m_StuffNum = 1
		CL1 =LuaFnGetAvailableItemCount(sceneId, selfId, m_StuffId)
		
		if CL1 < m_StuffNum then
		   x391002_NotifyTip( sceneId, selfId, "你没有 重楼玉 休想忽悠我!" )
		   return
		end
		
		LuaFnDelAvailableItem(sceneId,selfId,m_StuffId,m_StuffNum)
		TryRecieveItem( sceneId, selfId, 39000025, 1)
		x391002_NotifyTip( sceneId, selfId, "你回收了一个 重楼玉 获得 200元充值点 !" )
		return
	end
	if GetNumText() == 13 then
		local m_StuffNum = 0
		local  CL1 = 0
	    m_StuffId = 10553101
        m_StuffNum = 1
		CL1 =LuaFnGetAvailableItemCount(sceneId, selfId, m_StuffId)
		
		if CL1 < m_StuffNum then
		   x391002_NotifyTip( sceneId, selfId, "你没有 重楼戒 休想忽悠我!" )
		   return
		end
		
		LuaFnDelAvailableItem(sceneId,selfId,m_StuffId,m_StuffNum)
		TryRecieveItem( sceneId, selfId, 39000025, 1)
		x391002_NotifyTip( sceneId, selfId, "你回收了一个 重楼戒 获得 200元充值点 !" )
		return
	end
	if GetNumText() == 14 then
		local m_StuffNum = 0
		local  CL1 = 0
	    m_StuffId = 10553100
        m_StuffNum = 1
		CL1 =LuaFnGetAvailableItemCount(sceneId, selfId, m_StuffId)
		
		if CL1 < m_StuffNum then
		   x391002_NotifyTip( sceneId, selfId, "你没有 重楼链 休想忽悠我!" )
		   return
		end
		
		LuaFnDelAvailableItem(sceneId,selfId,m_StuffId,m_StuffNum)
		TryRecieveItem( sceneId, selfId, 39000025, 1)
		x391002_NotifyTip( sceneId, selfId, "你回收了一个 重楼链 获得 200元充值点 !" )
		return
	end
	if GetNumText() == 15 then
		local m_StuffNum = 0
		local  CL1 = 0
	    m_StuffId = 10553110
        m_StuffNum = 1
		CL1 =LuaFnGetAvailableItemCount(sceneId, selfId, m_StuffId)
		
		if CL1 < m_StuffNum then
		   x391002_NotifyTip( sceneId, selfId, "你没有 重楼甲 休想忽悠我!" )
		   return
		end
		
		LuaFnDelAvailableItem(sceneId,selfId,m_StuffId,m_StuffNum)
		TryRecieveItem( sceneId, selfId, 39000027, 1)
		x391002_NotifyTip( sceneId, selfId, "你回收了一个 重楼甲 获得 500元充值点 !" )
		return
	end

	if GetNumText() > 100 then
       local Test_1 = {"0","0","0","0","0","0","0","0","0","0","0","0","0","0"}
	   local Test_2 = mod(GetNumText(),100)--菜单按钮索引取值
	   local Test_3 = GetMissionData(sceneId,selfId,MD_NewUserCard1)--1-7菜单领取情况
	   local Test_4 = GetMissionData(sceneId,selfId,MD_NewUserCard2)--8-14菜单领取情况
	   local needLevel = {15,20,30,40,50,60,70,80,90,100,105,110,115,119}
	   local nTestMsg = tostring(Test_3)..tostring(Test_4)
	   if nTestMsg ~= "00" and nTestMsg ~= nil then
		     _,_,Test_1[1],Test_1[2],Test_1[3],Test_1[4],Test_1[5],Test_1[6],Test_1[7],Test_1[8],Test_1[9],Test_1[10],Test_1[11],Test_1[12],Test_1[13],Test_1[14] = strfind(nTestMsg,"(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)(%d)")
	   end
	   if GetLevel(sceneId,selfId) < needLevel[Test_2] then
	      x391002_NotifyTip( sceneId, selfId, "等级不足无法领取。")
	      return
	   end
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 5 then
			x391002_NotifyTip( sceneId, selfId, "道具栏不足5个" )
		   return 
		end
		if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 5 then
			x391002_NotifyTip( sceneId, selfId, "材料栏不足5个" )
			return
		end	   
	   if Test_1[Test_2] == "2" then
	      x391002_NotifyTip( sceneId, selfId, "您已经领取了该奖励。")
	      return
	   end  
		 --处理奖品发送
		  for i = 1,getn(x391002_g_GiftItem[Test_2]) do
		     local nPos = TryRecieveItem(sceneId,selfId,x391002_g_GiftItem[Test_2][i],1)
			 LuaFnItemBind(sceneId,selfId,nPos)
		  end		  
		  Test_1[Test_2] = "2"
          local Test_n = tonumber(Test_1[1]..Test_1[2]..Test_1[3]..Test_1[4]..Test_1[5]..Test_1[6]..Test_1[7])	  
          local Test_t = tonumber(Test_1[8]..Test_1[9]..Test_1[10]..Test_1[11]..Test_1[12]..Test_1[13]..Test_1[14])
		  SetMissionData(sceneId,selfId,MD_NewUserCard1,Test_n)
		  SetMissionData(sceneId,selfId,MD_NewUserCard2,Test_t)
		  x391002_NotifyTip( sceneId, selfId, "恭喜您领取成功。" )
	   return
	end
end
function x391002_GetCardButtnTest(sceneId,selfId)


end
--**********************************
--事件交互入口
--**********************************
function x391002_OnDefaultEvent( sceneId, selfId,targetId )
	x391002_UpdateEventList( sceneId, selfId, targetId )
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x391002_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end