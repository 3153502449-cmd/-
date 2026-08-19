x124504_g_scriptId = 124504

x124504_g_SceneData_1 = 8

x124504_g_eventList={}

function x124504_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nStep = LuaFnGetCopySceneData_Param(sceneId, 8)
		if nStep==11   then
			AddText(sceneId, "  #cFF0000单人华山论剑：#r#G第二关：混战。点击开战后，在这附近会刷出多批各门派弟子，战胜上届比武探花、榜眼、状元即可通关！#r#Y小提示：善用隐身技能！")
		elseif nStep == 15  then
			AddText(sceneId, "阁下武功高强，成为今届比武状元！")
		else
			AddText(sceneId, "少来烦俺......很容易闹出人命的！")
		end

		for i, eventId in x124504_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		
		if nStep == 10  then
			AddNumText( sceneId, x124504_g_scriptId, "开战！", 10 ,1  )
		end
			
		if nStep < 14  then
		end
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x124504_OnDefaultEvent( sceneId, selfId,targetId )
	x124504_UpdateEventList( sceneId, selfId, targetId )
end

function x124504_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 1  then
		if GetName(sceneId, targetId) ~= "寒霜"  then
			return
		end
		
		if LuaFnGetCopySceneData_Param(sceneId, 8) == 10  then
			LuaFnSetCopySceneData_Param(sceneId, 8, 11)
		end
		
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		return
	end
	
	if GetNumText() == 2  then
		LuaFnSetCopySceneData_Param(sceneId, 8, 15)
		
		CallScriptFunction( 401040, "CreateMonster_9",sceneId )
		CallScriptFunction( 401040, "CreateMonster_10",sceneId )
		CallScriptFunction( 401040, "CreateMonster_11",sceneId )
		
		BeginEvent(sceneId)
			AddText(sceneId, "  第3关已经开启")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		
	end

	for i, findId in x124504_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
	
end

function x124504_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x124504_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

function x124504_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x124504_g_eventList do
		if missionScriptId == findId then
			x124504_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

function x124504_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x124504_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

function x124504_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x124504_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

function x124504_OnDie( sceneId, selfId, killerId )
	LuaFnSetCopySceneData_Param(sceneId, 26, 501)
end

