x001218_g_ScriptId	= 001218

--**********************************
--事件交互入口
--**********************************
function x001218_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId, "#cFF0000凤凰古城，一座没落的古城，没人知道它是怎么走向没落的，但依然蕴藏大量宝藏，是兵家必争之地。同时也吸引了大量的盗墓贼，其中由搬山道人率领的摸金校尉更是明目张胆。我可以送你进去，但你的生死我不负责。#W（80级以上方可进入）")
		AddNumText(sceneId, x001218_g_ScriptId,"进入", 6, 101)
		--AddNumText(sceneId, x001218_g_ScriptId,"你看，我这里有些零钱。。", 5, 102)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,-1)
end

--**********************************
--事件列表选中一项
--**********************************
function x001218_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 101  then
		local	lev	= GetLevel( sceneId, selfId )
		if lev>=80 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 441, 161, 161 )
		end
	elseif GetNumText() == 102  then
		local reply = CostMoney(sceneId,selfId,5000000)
		if reply == -1 then
			x001218_MsgBox( sceneId, selfId, targetId, "    #Y小子，钱呢，你不说你有钱的吗?麻痹，死穷鬼，没钱想忽悠我，滚远点！" )
			return	
		end
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 584, 258, 310 )
	end
end

--**********************************
--对话窗口信息提示
--**********************************
function x001218_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
