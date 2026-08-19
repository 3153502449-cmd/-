--洛阳 空先生
--2019-11-13 21:14:59 逍遥子

--脚本号
x000158_g_ScriptId	= 000158
--**********************************
--事件交互入口
--**********************************
function x000158_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{THD_190613_01}" )
		AddNumText( sceneId, x000158_g_ScriptId, "#G满怒治疗", 6, 1 )
		--传送
		AddNumText( sceneId, x000158_g_ScriptId, "城市 - 苏州", 9, 1003 )
		AddNumText( sceneId, x000158_g_ScriptId, "城市 - 苏州 - 铁匠铺", 9, 1004 )
		AddNumText( sceneId, x000158_g_ScriptId, "城市 - 大理", 9, 1005 )
		AddNumText( sceneId, x000158_g_ScriptId, "城市 - 楼兰", 9, 1015 )
		AddNumText( sceneId, x000158_g_ScriptId, "城市 - 束河古镇", 9, 1016 )
		AddNumText( sceneId, x000158_g_ScriptId, "城市 - #G凤鸣镇", 9, 1020 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000158_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 1 then
		RestoreHp( sceneId, selfId )
		RestoreMp( sceneId, selfId )
		RestoreRage( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "你的生命数值已经完全恢复了！" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	
	local nOperation = GetNumText();
	if nOperation == 1003 then	--苏州
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 202, 257 )
		return
	end
	if nOperation == 1004 then	--苏州铁匠
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 333, 224 )
		return
	end

  	if nOperation == 1005 then	--大理
		CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 2, 253, 122 )
		return
	end

  	if nOperation == 1015 then	--楼兰
        if GetLevel( sceneId, selfId ) >= 75 then  
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 288, 136, 75 )
			return
		end
		x000158_NotifyTip( sceneId, selfId, "你的等级不足75级，暂时不能使用。" )
	end
	
	if GetNumText()== 1016 then		--束河古镇
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId, 1100);
			UICommand_AddInt(sceneId, targetId);
			UICommand_AddString(sceneId, "GotoShuHeGuZhen");
			UICommand_AddString(sceneId, "束河古镇为不加杀气场景，请注意安全。你确认要进入吗？");
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 24)    
		return
	end

  	if nOperation == 1020 then	--凤鸣
        if GetLevel( sceneId, selfId ) >= 85 then  
		    CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 580, 158, 120, 85 )
		    return
	    end
		x000158_NotifyTip( sceneId, selfId, "#{KVKGZ_110620_129}" )
    end
end
--**********************************
--醒目提示
--**********************************
function x000158_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
