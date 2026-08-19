--绑定的花种30505260
--不绑定的花种30505268--这个废弃掉，脚本不针对他
--花肥30505261
--******************
--    种花系统
--     Sunyan
--  无存储位占用
--   QQ857904341
--******************
--大理巴盖里兑换
x002101_g_ScriptId	= 002101
--************************************************************************
--事件列表
--************************************************************************
function x002101_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "    只要是喜爱鲜花的人，就是我最尊贵的朋友，你替我保存这些波斯玫瑰，现在是回报你的时候了。你有足够的波斯玫瑰的话，可以兑换如下的物品。")
		AddNumText( sceneId, x002101_g_ScriptId, "30个波斯玫瑰兑换奖励",6,1 )
		AddNumText( sceneId, x002101_g_ScriptId, "60个波斯玫瑰兑换奖励",6,2 )
		AddNumText( sceneId, x002101_g_ScriptId, "70个波斯玫瑰兑换奖励",6,3 )
		AddNumText( sceneId, x002101_g_ScriptId, "80个波斯玫瑰兑换奖励",6,4 )
		AddNumText( sceneId, x002101_g_ScriptId, "关于波斯玫瑰",11,15 )		 
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**************************************************************************
--事件列表选中一项
--**************************************************************************
function x002101_OnEventRequest( sceneId, selfId, targetId, eventId )
	local	key	= GetNumText()
	if key == 1 then
	    BeginEvent(sceneId)
		    AddNumText( sceneId, x001154_g_ScriptId, "兑换天罡强化露", 6, 101 )
	    EndEvent(sceneId)
	    DispatchEventList(sceneId,selfId,targetId)
	elseif key == 101 then
        if LuaFnGetAvailableItemCount(sceneId, selfId, 30505262) >=30 then
		    BeginEvent( sceneId ) 
		    LuaFnDelAvailableItem(sceneId,selfId,30505262,30)--删除波斯玫瑰
		    local bagpos01 = TryRecieveItem( sceneId, selfId, 30900045, 1)--给东西
		    local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
    	    local strText = format("#G#{_INFOUSR%s}#W用30朵[#{_ITEM30505262}]从#c00ffff大理[182,70]#cff99ff巴盖里#W处兑换了一个#G[#{_ITEM"..szItemTransfer.."}]！",playerName ) 
	        BroadMsgByChatPipe(sceneId, selfId, strText, 4)
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
            x002101_CloseMe(sceneId, selfId)
        else
		    BeginEvent( sceneId ) 
		    strText = "    你的波斯玫瑰数量不够啊！"
		    AddText( sceneId, strText )
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
	    end
	elseif key == 2 then
	    BeginEvent(sceneId)
		AddNumText( sceneId, x001154_g_ScriptId, "兑换珍兽蛋:花仙子", 6, 201 )
	    EndEvent(sceneId)
	    DispatchEventList(sceneId,selfId,targetId)
    elseif key == 201 then
        if LuaFnGetAvailableItemCount(sceneId, selfId, 30505262) >=60 then
		    BeginEvent( sceneId ) 
		    LuaFnDelAvailableItem(sceneId,selfId,30505262,60)--删除波斯玫瑰
		    local bagpos01 = TryRecieveItem( sceneId, selfId, 30309766, 1)--给东西
		    local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
    	    local strText = format("#G#{_INFOUSR%s}#W用60朵[#{_ITEM30505262}]从#c00ffff大理[182,70]#cff99ff巴盖里#W处兑换了一个#G[#{_ITEM"..szItemTransfer.."}]！",playerName ) 
	        BroadMsgByChatPipe(sceneId, selfId, strText, 4)
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
            x002101_CloseMe(sceneId, selfId)
        else
		    BeginEvent( sceneId ) 
		    strText = "    你的波斯玫瑰数量不够啊！"
		    AddText( sceneId, strText )
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
	    end
	elseif key == 3 then
	    BeginEvent(sceneId)
		AddNumText( sceneId, x001154_g_ScriptId, "兑换珍兽蛋:傀儡狼", 6, 301 )
	    EndEvent(sceneId)
	    DispatchEventList(sceneId,selfId,targetId)
	elseif key == 301 then
        if LuaFnGetAvailableItemCount(sceneId, selfId, 30505262) >=70 then
		    BeginEvent( sceneId ) 
		    LuaFnDelAvailableItem(sceneId,selfId,30505262,70)--删除波斯玫瑰
		    local bagpos01 = TryRecieveItem( sceneId, selfId, 30309775, 1)--给东西
		    local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
    	    local strText = format("#G#{_INFOUSR%s}#W用70朵[#{_ITEM30505262}]从#c00ffff大理[182,70]#cff99ff巴盖里#W处兑换了一个#G[#{_ITEM"..szItemTransfer.."}]！",playerName ) 
	        BroadMsgByChatPipe(sceneId, selfId, strText, 4)
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
            x002101_CloseMe(sceneId, selfId)
        else
		    BeginEvent( sceneId ) 
		    strText = "    你的波斯玫瑰数量不够啊！"
		    AddText( sceneId, strText )
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
	    end
	elseif key == 4 then
	    BeginEvent(sceneId)
		AddNumText( sceneId, x001154_g_ScriptId, "兑换珍兽蛋:神企鹅", 6, 401 )
		AddNumText( sceneId, x001154_g_ScriptId, "兑换珍兽蛋:蝶恋花", 6, 402 )
		AddNumText( sceneId, x001154_g_ScriptId, "兑换珍兽蛋:五色神牛", 6, 403 )
	    EndEvent(sceneId)
	    DispatchEventList(sceneId,selfId,targetId)
	elseif key == 401 then
        if LuaFnGetAvailableItemCount(sceneId, selfId, 30505262) >=80 then
		    BeginEvent( sceneId ) 
		    LuaFnDelAvailableItem(sceneId,selfId,30505262,80)--删除波斯玫瑰
		    local bagpos01 = TryRecieveItem( sceneId, selfId, 30309781, 1)--给东西
		    local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
    	    local strText = format("#G#{_INFOUSR%s}#W用80朵[#{_ITEM30505262}]从#c00ffff大理[182,70]#cff99ff巴盖里#W处兑换了一个#G[#{_ITEM"..szItemTransfer.."}]！",playerName ) 
	        BroadMsgByChatPipe(sceneId, selfId, strText, 4)
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
            x002101_CloseMe(sceneId, selfId)
        else
		    BeginEvent( sceneId ) 
		    strText = "    你的波斯玫瑰数量不够啊！"
		    AddText( sceneId, strText )
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
	    end
	elseif key == 402 then
        if LuaFnGetAvailableItemCount(sceneId, selfId, 30505262) >=80 then
		    BeginEvent( sceneId ) 
		    LuaFnDelAvailableItem(sceneId,selfId,30505262,80)--删除波斯玫瑰
		    local bagpos01 = TryRecieveItem( sceneId, selfId, 30309774, 1)--给东西
		    local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
    	    local strText = format("#G#{_INFOUSR%s}#W用80朵[#{_ITEM30505262}]从#c00ffff大理[182,70]#cff99ff巴盖里#W处兑换了一个#G[#{_ITEM"..szItemTransfer.."}]！",playerName ) 
	        BroadMsgByChatPipe(sceneId, selfId, strText, 4)
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
            x002101_CloseMe(sceneId, selfId)
        else
		    BeginEvent( sceneId ) 
		    strText = "    你的波斯玫瑰数量不够啊！"
		    AddText( sceneId, strText )
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
	    end
	elseif key == 403 then
        if LuaFnGetAvailableItemCount(sceneId, selfId, 30505262) >=80 then
		    BeginEvent( sceneId ) 
		    LuaFnDelAvailableItem(sceneId,selfId,30505262,80)--删除波斯玫瑰
		    local bagpos01 = TryRecieveItem( sceneId, selfId, 30309776, 1)--给东西
		    local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
    	    local strText = format("#G#{_INFOUSR%s}#W用80朵[#{_ITEM30505262}]从#c00ffff大理[182,70]#cff99ff巴盖里#W处兑换了一个#G[#{_ITEM"..szItemTransfer.."}]！",playerName ) 
	        BroadMsgByChatPipe(sceneId, selfId, strText, 4)
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
            x002101_CloseMe(sceneId, selfId)
        else
		    BeginEvent( sceneId ) 
		    strText = "    你的波斯玫瑰数量不够啊！"
		    AddText( sceneId, strText )
		    EndEvent( sceneId )
		    DispatchEventList( sceneId, selfId, targetId )
	    end
	elseif key == 15 then
		BeginEvent( sceneId )
		    AddText( sceneId, "#{SDJZH_091106_28}")
	    EndEvent( sceneId )
	    DispatchEventList( sceneId, selfId, targetId )
	end	
end	

--**************************************************************************
--对话
--**************************************************************************
function x002101_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--关闭对话框
--**********************************
function x002101_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end