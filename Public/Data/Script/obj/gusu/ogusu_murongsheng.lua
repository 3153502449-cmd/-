--慕容山庄NPC
--慕容胜
--普通

--所拥有的事件ID列表
x002127_g_eventList={229014,240000,240001,240002,240003,240004,240005,240006,240007,240008,240009,240010,240011,240012,240020,228905,050061}
--**********************************
--事件交互入口
--**********************************
function x002127_UpdateEventList( sceneId, selfId,targetId )
    local   id	= LuaFnGetMenPai( sceneId, selfId )
		--判断门派
		if id < 0 or id == 9 or id>11  then
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
		end
	if playerMenpai ~= MP_GUSU then
	BeginEvent(sceneId)
		AddText(sceneId,"你不是本门的弟子，请速速走开！。")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	else 	
	
	BeginEvent(sceneId)
		AddText(sceneId,"我是慕容胜，我发布慕容门派的师门任务。")
		CallScriptFunction( x002127_g_eventList[1], "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 228905, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 229011, "OnEnumerate",sceneId, selfId, targetId, MP_GUSU )
		CallScriptFunction( 050025, "OnEnumerate",sceneId, selfId, targetId )
		CallScriptFunction( 050061, "OnEnumerate",sceneId, selfId, targetId )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
end

--**********************************
--事件交互入口
--**********************************
function x002127_OnDefaultEvent( sceneId, selfId,targetId )
	x002127_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002127_OnEventRequest( sceneId, selfId, targetId, eventId )

	if eventId == 229011 then
		CallScriptFunction( 229011, "OnDefaultEvent",sceneId, selfId, targetId, MP_GUSU, GetNumText() )
		return
	elseif eventId == 050025 then
    CallScriptFunction( 050025, "OnDefaultEvent",sceneId, selfId, targetId, MP_GUSU)
		return
	elseif eventId == 050061 then
		CallScriptFunction( 050061, "OnDefaultEvent",sceneId, selfId, targetId,MP_GUSU)
		return
	end

	for i, findId in x002127_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002127_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002127_g_eventList do
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
function x002127_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002127_g_eventList do
		if missionScriptId == findId then
			x002127_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002127_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002127_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002127_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002127_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002127_OnDie( sceneId, selfId, killerId )
end

--**********************************
--提交物品
--**********************************
function x002127_OnMissionCheck( sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
	for i, findId in x002127_g_eventList do
		if scriptId == findId then
			CallScriptFunction( scriptId, "OnMissionCheck", sceneId, selfId, npcid, scriptId, index1, index2, index3, indexpet )
			return
		end
	end
end