--唐门NPC
--唐清秋
--普通

--所拥有的事件ID列表
x017508_g_eventList={229015,260000,260001,260002,260003,260004,260005,260006,260007,260008,260009,260010,260011,260012,260020,228907,050061}

--**********************************
--事件交互入口
--**********************************
function x017508_UpdateEventList( sceneId, selfId,targetId )
    local   id	= LuaFnGetMenPai( sceneId, selfId )
	--判断门派
	if id < 0 or id == 9 or id>12  then
		playerMenpai=MP_WUMENPAI
	elseif id==0 then
		playerMenpai=MP_SHAOLIN
	elseif id == 1 then
		playerMenpai=MP_MINGJIAO
	elseif id == 2 then
		playerMenpai=MP_GAIBANG
	elseif id == 3 then
		playerMenpai=MP_WUDANG
	elseif id == 4 then
		playerMenpai=MP_EMEI
	elseif id == 5 then
		playerMenpai=MP_XINGSU
	elseif id == 6 then
		playerMenpai=MP_DALI
	elseif id == 7 then
		playerMenpai=MP_TIANSHAN
	elseif id == 8 then
		playerMenpai=MP_XIAOYAO
	elseif id == 10 then
		playerMenpai=MP_GUSU
	elseif id == 11 then
		playerMenpai=MP_TANGMEN
	elseif id == 12 then
		playerMenpai=MP_GUIGU
	end
	if playerMenpai ~= MP_TANGMEN then
		BeginEvent(sceneId)
			AddText(sceneId,"你不是唐门的弟子，请速速离开！。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else 	
	
	BeginEvent(sceneId)
		AddText(sceneId,"#{XMPTM_130813_05}")
		CallScriptFunction( x017508_g_eventList[1], "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 228907, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 229011, "OnEnumerate",sceneId, selfId, targetId, MP_TANGMEN )
		CallScriptFunction( 050025, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 050061, "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
end

--**********************************
--事件交互入口
--**********************************
function x017508_OnDefaultEvent( sceneId, selfId,targetId )
	x017508_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x017508_OnEventRequest( sceneId, selfId, targetId, eventId )

	if eventId == 229011 then
		CallScriptFunction( 229011, "OnDefaultEvent",sceneId, selfId, targetId, MP_TANGMEN, GetNumText() )
		return
	elseif eventId == 050025 then
		CallScriptFunction( 050025, "OnDefaultEvent",sceneId, selfId, targetId, MP_TANGMEN)
		return
	elseif eventId == 050061 then
		CallScriptFunction( 050061, "OnDefaultEvent",sceneId, selfId, targetId,MP_TANGMEN)
		return
	end

	for i, findId in x017508_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x017508_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x017508_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId)
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x017508_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x017508_g_eventList do
		if missionScriptId == findId then
			x017508_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x017508_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x017508_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x017508_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x017508_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x017508_OnDie( sceneId, selfId, killerId )
end

--**********************************
--提交物品
--**********************************
function x017508_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
	for i, findId in x017508_g_eventList do
		if scriptId == findId then
			CallScriptFunction( scriptId, "OnMissionCheck", sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
			return
		end
	end
end