--骨粉商人
--普通
x760102_g_scriptId = 760102
x760102_g_strGongGaoInfo = {
  "#H凤鸣城内一道金光闪过，只见#{_INFOUSR%s}#H的手中出现一个稀有物品#{_INFOMSG%s}，看来人间又要迎来一场血雨腥风了！", 
  "#H凤鸣城内一道金光闪过，只见#{_INFOUSR%s}#H的手中出现一个稀有物品#{_INFOMSG%s}，看来人间又要迎来一场血雨腥风了！", 
  "#H凤鸣城内一道金光闪过，只见#{_INFOUSR%s}#H的手中出现一个稀有物品#{_INFOMSG%s}，看来人间又要迎来一场血雨腥风了！", 
  "#H凤鸣城内一道金光闪过，只见#{_INFOUSR%s}#H的手中出现一个稀有物品#{_INFOMSG%s}，看来人间又要迎来一场血雨腥风了！", 
}
--**********************************
--事件交互入口
--**********************************
function x760102_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{NXJL_140210_69}" )
			AddNumText( sceneId, x760102_g_scriptId, "10份骨粉兑换1个龙纹", 6, 2000)
			AddNumText( sceneId, x760102_g_scriptId, "18份骨粉兑换10个净云水", 6, 2001)
			AddNumText( sceneId, x760102_g_scriptId, "20份骨粉兑换1个缀龙石·元", 6, 2002)
			AddNumText( sceneId, x760102_g_scriptId, "20份骨粉兑换1个缀龙石·暴", 6, 2003)
			AddNumText( sceneId, x760102_g_scriptId, "20份骨粉兑换1个缀龙石·伤", 6, 2004)
			AddNumText( sceneId, x760102_g_scriptId, "30份骨粉兑换1个铸纹血玉", 6, 2005)		
			AddNumText( sceneId, x760102_g_scriptId, "60份骨粉兑换1个铸纹精玉", 6, 2006)	
			AddNumText( sceneId, x760102_g_scriptId, "99份骨粉兑换1个铸纹龙玉", 6, 2007)	
			AddNumText( sceneId, x760102_g_scriptId, "关于九黎骨粉", 11, 2008)				
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x760102_OnEventRequest( sceneId, selfId, targetId, eventId)

	if GetNumText() == 2008 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{NXJL_140210_74}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	if GetNumText() == 2000 then
	    local nStoneId0 = 20700067
	    local nStoneId1 = 20700067
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=5 and c1 >=5 then
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,20700067,5)--删除物品
				LuaFnDelAvailableItem(sceneId,selfId,20700067,5)--删除物品
				local bagpos01 = TryRecieveItem( sceneId, selfId, 10157001, 1)--给予物品
				   local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
				x760102_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
				strText = "#G恭喜您，成功兑换龙纹1个，真是可喜可贺！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
				else
			BeginEvent( sceneId ) 
				strText = "你所携带的九黎骨粉数量不足或已加锁，无法兑换奖励。"
				AddText( sceneId, strText )					
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	elseif GetNumText() == 2001 then
		local nStoneId0 = 20700067
		local nStoneId1 = 20700067
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=9 and c1 >=9 then
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,20700067,9)--删除物品
				LuaFnDelAvailableItem(sceneId,selfId,20700067,9)--删除物品
				local bagpos01 = 0
				for i = 1,10 do
					bagpos01 = TryRecieveItem( sceneId, selfId, 20310180, 1)--给予物品				
				end
				local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
				x760102_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
				strText = "#G恭喜您，成功兑换净云水10个，真是可喜可贺！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
				else
			BeginEvent( sceneId ) 
				strText = "你所携带的九黎骨粉数量不足或已加锁，无法兑换奖励。"
				AddText( sceneId, strText )					
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	elseif GetNumText() == 2002 then
		local nStoneId0 = 20700067
		local nStoneId1 = 20700067
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=10 and c1 >=10 then
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,20700067,10)--删除物品
				LuaFnDelAvailableItem(sceneId,selfId,20700067,10)--删除物品
				local bagpos01 = TryRecieveItem( sceneId, selfId, 20310181, 1)--给予物品
				   local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
				x760102_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
				strText = "#G恭喜您，成功兑换了1个缀龙石·元！真是可喜可贺。"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
				else
			BeginEvent( sceneId ) 
				strText = "你所携带的九黎骨粉数量不足或已加锁，无法兑换奖励。"
				AddText( sceneId, strText )					
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	elseif GetNumText() == 2003 then
	local nStoneId0 = 20700067
	       	local nStoneId1 = 20700067
			c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
            if c0 >=10 and c1 >=10 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,20700067,10)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20700067,10)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 20310182, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x760102_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜您，成功兑换了1个缀龙石·元！真是可喜可贺。"
					AddText( sceneId, strText )
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
                    else
               	BeginEvent( sceneId ) 
					strText = "你所携带的九黎骨粉数量不足或已加锁，无法兑换奖励。"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 2004 then
		local nStoneId0 = 20700067
		local nStoneId1 = 20700067
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=10 and c1 >=10 then
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,20700067,10)--删除物品
				LuaFnDelAvailableItem(sceneId,selfId,20700067,10)--删除物品
				local bagpos01 = TryRecieveItem( sceneId, selfId, 20310183, 1)--给予物品
				   local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
				x760102_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
				strText = "#G恭喜您，成功兑换了1个缀龙石·伤！真是可喜可贺。"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
				else
			BeginEvent( sceneId ) 
				strText = "你所携带的九黎骨粉数量不足或已加锁，无法兑换奖励。"
				AddText( sceneId, strText )					
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	elseif GetNumText() == 2005 then
		local nStoneId0 = 20700067
		local nStoneId1 = 20700067
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=15 and c1 >=15 then
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,20700067,15)--删除物品
				LuaFnDelAvailableItem(sceneId,selfId,20700067,15)--删除物品
				local bagpos01 = TryRecieveItem( sceneId, selfId, 38000184, 1)--给予物品
				   local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
				x760102_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
				strText = "#G恭喜您，成功兑换了1个铸纹血玉！真是可喜可贺。"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
				else
			BeginEvent( sceneId ) 
				strText = "你所携带的九黎骨粉数量不足或已加锁，无法兑换奖励。"
				AddText( sceneId, strText )					
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	elseif GetNumText() == 2006 then
		local nStoneId0 = 20700067
		local nStoneId1 = 20700067
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=30 and c1 >=30 then
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,20700067,30)--删除物品
				LuaFnDelAvailableItem(sceneId,selfId,20700067,30)--删除物品
				local bagpos01 = TryRecieveItem( sceneId, selfId, 38000185, 1)--给予物品
				   local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
				x760102_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
				strText = "#G恭喜您，成功兑换了1个铸纹精玉！真是可喜可贺。"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
				else
			BeginEvent( sceneId ) 
				strText = "你所携带的九黎骨粉数量不足或已加锁，无法兑换奖励。"
				AddText( sceneId, strText )					
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end	
	elseif GetNumText() == 2007 then
		local nStoneId0 = 20700067
		local nStoneId1 = 20700067
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=45 and c1 >=45 then
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,20700067,45)--删除物品
				LuaFnDelAvailableItem(sceneId,selfId,20700067,45)--删除物品
				local bagpos01 = TryRecieveItem( sceneId, selfId, 38000186, 1)--给予物品
				   local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
				x760102_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
				strText = "#G恭喜您，成功兑换了1个铸纹龙玉！真是可喜可贺。"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
				else
			BeginEvent( sceneId ) 
				strText = "你所携带的九黎骨粉数量不足或已加锁，无法兑换奖励。"
				AddText( sceneId, strText )					
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end	
		return
	end
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x760102_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x760102_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

function x760102_ShowRandomSystemNotice( sceneId, selfId, strItemInfo )
	
	local PlayerName = GetName(sceneId,selfId)
	local nMsgIndex = random( 1, 4 )
	local str
	if nMsgIndex == 1 then
		str = format( x760102_g_strGongGaoInfo[1], PlayerName, strItemInfo )
	elseif nMsgIndex == 2 then
		str = format( x760102_g_strGongGaoInfo[2], PlayerName, strItemInfo )
	elseif nMsgIndex == 3 then
		str = format( x760102_g_strGongGaoInfo[3], PlayerName, strItemInfo )
	else
		str = format( x760102_g_strGongGaoInfo[4], PlayerName, strItemInfo )
	end
	BroadMsgByChatPipe( sceneId, selfId, str, 4 )
	
end
