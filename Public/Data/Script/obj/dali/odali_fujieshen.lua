--除恶天劫楼
--除恶务尽
--付劫生

x002107_g_ScriptId	= 002107
x002107_g_Yinpiao = 40002000
--**********************************
--事件交互入口
--**********************************
function x002107_OnDefaultEvent( sceneId, selfId, targetId )

	-- 检测玩家身上是不是有“银票”这个东西，有就不能使用这里的功能
	if GetItemCount(sceneId, selfId, x002107_g_Yinpiao)>=1  then
		BeginEvent( sceneId )
			AddText( sceneId, "  你身上有银票，正在跑商！我不能帮助你。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	local	mp
	local	i		= 0
	BeginEvent( sceneId )
		if GetLevel( sceneId, selfId ) >= 30 then
			AddText( sceneId, "#{TJL_090714_01}" )
			AddNumText( sceneId, x002107_g_ScriptId, "#{TJL_xml_XX(02)}", 9, 1001 )
			AddNumText( sceneId, x002107_g_ScriptId, "#{TJL_xml_XX(03)}", 11, 1002 )
		else
			AddText( sceneId, "#{TJL_090714_07}" )
		end
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002107_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1002 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{TJL_090714_09}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
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
				x002107_MsgBox( sceneId, selfId, targetId, "  你队伍成员中有人有漕运货舱在身，我不能送你们去天劫楼。" )
				return
			end
		end
	end

	--漕运相关
	if IsHaveMission(sceneId,selfId,4021) > 0 then
		x002107_MsgBox( sceneId, selfId, targetId, "  你有漕运货舱在身，我不能送你去天劫楼。" )
		return
	end

    local mylevel = GetLevel( sceneId, selfId )
	if mylevel < 30 then
	     x002107_MsgBox( sceneId, selfId, targetId, "  请到30级以后再来。" )
	   return
	end
    local iniLevel = floor( mylevel/10 ) * 10
	if GetNumText() == 1001 then		--除恶天劫楼
        if iniLevel == 10 then
		    CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 484, 82, 78, 10 );
		elseif iniLevel == 20 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 485, 82, 78, 10 );
		elseif iniLevel == 30 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 486, 82, 78, 10 );
		elseif iniLevel == 40 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 487, 82, 78, 10 );
		elseif iniLevel == 50 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 488, 82, 78, 10 );
		elseif iniLevel == 60 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 489, 82, 78, 10 );
		elseif iniLevel >= 70 then
			CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 490, 82, 78, 10 );
		end
	    return
	end


end

--**********************************
--对话窗口信息提示
--**********************************
function x002107_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end