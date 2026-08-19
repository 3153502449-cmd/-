--凤鸣镇
--巢云硅
x760103_g_ScriptId	= 760103
--**********************************
--事件交互入口
--**********************************
function x760103_OnDefaultEvent( sceneId, selfId, targetId )
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 199999999)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,201423524)
	GuildList(sceneId, selfId, -1);
	
	BeginEvent( sceneId )
		AddText( sceneId, "#{KVKNPC_140304_01}" )
		AddNumText( sceneId, x760103_g_ScriptId, "查看战盟信息", 9, 4 )
		AddNumText( sceneId, x760103_g_ScriptId, "盟主帮会竞争", 6, 5 ) 
		AddNumText( sceneId, x760103_g_ScriptId, "进入战盟城市", 9, 1 )
		AddNumText( sceneId, x760103_g_ScriptId, "#{SLJC_150811_598}", 11, 2 )--关于战盟	
		AddNumText( sceneId, x760103_g_ScriptId, "#{SLJC_150811_703}", 11, 3 )							
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x760103_OnEventRequest( sceneId, selfId, targetId, eventId )
	local opNum = GetNumText() 
	if opNum == 2 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{SLJC_150811_705}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if opNum == 3 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{SLJC_150811_706}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end	

	if opNum == 1 then		--战盟
	    local GUILD_Pos = LuaFnGetKVK_GuildID(sceneId,selfId)
		if GUILD_Pos <901 then
			x760103_NotifyFailTips( sceneId,selfId,"你所在的帮会没有战盟哦！无法进入战盟城市！" )
			return
		end
		GUILD_Pos = mod(GUILD_Pos,10)
		if GUILD_Pos == 1 then --"千秋殿","不归林","无涯海","炎罗天","玉皇山"
		    CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 499, 208, 190, 10 )
			return
		elseif GUILD_Pos == 2 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 500, 208, 190, 10 )
			return
		elseif GUILD_Pos == 3 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 501, 208, 190, 10 )
			return
		elseif GUILD_Pos == 4 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 502, 208, 190, 10 )
			return
		elseif GUILD_Pos == 5 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 503, 208, 190, 10 )
			return
		else
			x760103_NotifyFailTips( sceneId,selfId,"数据异常！进入场景请求被服务器拒绝" )
			return
		end
		return
	end
	
	if opNum == 4 then
	    CallScriptFunction( (990014), "FJQH_OPUI", sceneId, selfId, 55556 )
		return
	end
	
	if opNum == 5 then
	    BeginUICommand( sceneId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,2019022733)
		return
	end

end

--**********************************
-- 对话窗口信息提示
--**********************************
function x760103_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x760103_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
--对话窗口信息提示
--**********************************
function x760103_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end