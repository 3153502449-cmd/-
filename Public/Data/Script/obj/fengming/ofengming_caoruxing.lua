--三城接引使
--巢汝昕
--普通
x760100_g_strGongGaoInfo = {
  "#H凤鸣城内一道金光闪过，只见#{_INFOUSR%s}#H的手中出现一个稀有物品#{_INFOMSG%s}，看来人间又要迎来一场血雨腥风了！", 
  "#H凤鸣城内一道金光闪过，只见#{_INFOUSR%s}#H的手中出现一个稀有物品#{_INFOMSG%s}，看来人间又要迎来一场血雨腥风了！", 
  "#H凤鸣城内一道金光闪过，只见#{_INFOUSR%s}#H的手中出现一个稀有物品#{_INFOMSG%s}，看来人间又要迎来一场血雨腥风了！", 
  "#H凤鸣城内一道金光闪过，只见#{_INFOUSR%s}#H的手中出现一个稀有物品#{_INFOMSG%s}，看来人间又要迎来一场血雨腥风了！", 
}
x760100_g_ScriptId = 760100
--**********************************
--事件交互入口
--**********************************
function x760100_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{NXJL_140210_14}" )
			AddNumText( sceneId, x760100_g_ScriptId, "研磨九黎骨粉", 6, 2000)
			AddNumText( sceneId, x760100_g_ScriptId, "逆袭钧天城", 9, 2001 )
			AddNumText( sceneId, x760100_g_ScriptId, "逆袭罗浮城", 9, 2002 )
			AddNumText( sceneId, x760100_g_ScriptId, "逆袭潮京城", 9, 2003 )
			AddNumText( sceneId, x760100_g_ScriptId, "关于研磨九黎骨粉", 11, 2004 )		
			AddNumText( sceneId, x760100_g_ScriptId, "关于逆袭九黎", 11, 2005 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x760100_OnEventRequest( sceneId, selfId, targetId, eventId)

	if GetNumText() == 2001 then		--钧天城
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 560, 57, 75, 10 )
		return
	end		
	if GetNumText() == 2002 then		--罗浮城
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 561, 78, 200, 10 )
		return
	end
	if GetNumText() == 2003 then		--潮京城
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 562, 196,188, 10 )
		return
	end		
	if GetNumText() == 2004 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{NXJL_140210_22}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if GetNumText() == 2005 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{NXJL_140210_21}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end	

	if GetNumText() == 2000 then
		BeginEvent( sceneId )
		    AddText( sceneId, "#{WHOATN_12103146_01}" )
			AddNumText( sceneId, x760100_g_scriptId, "将1个骨雕研磨为1份骨粉", 6, 3001)
			AddNumText( sceneId, x760100_g_scriptId, "将10个骨雕研磨为11份骨粉", 6, 3002)
			AddNumText( sceneId, x760100_g_scriptId, "将50个骨雕研磨为65份骨粉", 6, 3003)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )

	elseif GetNumText() == 3001 then
	local nStoneId0 = 20700066
	       	local nStoneId1 = 20700066
			c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		    c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
            if c0 >=1 and c1 >=1 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,20700066,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20700066,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 20700067, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x760100_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜您，成功研磨出1份骨粉，真是可喜可贺！"
					AddText( sceneId, strText )
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
                    else
               	BeginEvent( sceneId ) 
					strText = "你所携带的骨雕数量不够啊，恐怕研磨不出这个分量的骨粉。"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end
	elseif GetNumText() == 3002 then
	local nStoneId0 = 20700066
	       	local nStoneId1 = 20700066
			c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
            if c0 >=10 and c1 >=10 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,20700066,5)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20700066,5)--删除物品
					local bagpos01 = 0
					for i = 1,11 do
					    bagpos01 = TryRecieveItem( sceneId, selfId, 20700067, 1)--给予物品
					end
				    local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x760100_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜您，成功研磨出11份骨粉，真是可喜可贺！"
					AddText( sceneId, strText )
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
                    else
               	BeginEvent( sceneId ) 
					strText = "你所携带的骨雕数量不够啊，恐怕研磨不出这个分量的骨粉。"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 3003 then
	    local nStoneId0 = 20700066
	    local nStoneId1 = 20700066
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=50 and c1 >=50 then
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,20700066,25)--删除物品
				LuaFnDelAvailableItem(sceneId,selfId,20700066,25)--删除物品
				local bagpos01 = 0
				for i = 1,65 do
					bagpos01 = TryRecieveItem( sceneId, selfId, 20700067, 1)--给予物品				
				end
				local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
				x760100_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
				strText = "#G恭喜您，成功研磨出65份骨粉，真是可喜可贺！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
				else
			BeginEvent( sceneId ) 
				strText = "你所携带的骨雕数量不够啊，恐怕研磨不出这个分量的骨粉。"
				AddText( sceneId, strText )					
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	end
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x760100_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x760100_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

function x760100_ShowRandomSystemNotice( sceneId, selfId, strItemInfo )
	
	local PlayerName = GetName(sceneId,selfId)
	local nMsgIndex = random( 1, 4 )
	local str
	if nMsgIndex == 1 then
		str = format( x760100_g_strGongGaoInfo[1], PlayerName, strItemInfo )
	elseif nMsgIndex == 2 then
		str = format( x760100_g_strGongGaoInfo[2], PlayerName, strItemInfo )
	elseif nMsgIndex == 3 then
		str = format( x760100_g_strGongGaoInfo[3], PlayerName, strItemInfo )
	else
		str = format( x760100_g_strGongGaoInfo[4], PlayerName, strItemInfo )
	end
	BroadMsgByChatPipe( sceneId, selfId, str, 4 )
	
end
