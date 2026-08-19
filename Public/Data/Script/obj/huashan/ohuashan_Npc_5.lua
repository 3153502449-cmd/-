x124500_g_scriptId = 124500

x124500_g_SceneData_1 = 8

x124500_g_eventList={}

function x124500_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		
		if LuaFnGetCopySceneData_Param(sceneId, 8) < 10  then
			AddText(sceneId, "  #cFF0000单人华山论剑：#r#G第一关：挑战十大门派，点击挑战后，在少林门口的桥边会刷出一少林弟子，胜利后以顺时针方向挑战其余九大门派。当战胜天山派后找寒霜开启第二关！#r$N，#Y你武艺高强，定能所向披靡！")
		elseif LuaFnGetCopySceneData_Param(sceneId, 8) >= 10  then
			AddText(sceneId, "$N，没想到你的武功如此之高强，竟然轻松战胜十大门派！")
		end	
		
		
		if LuaFnGetCopySceneData_Param(sceneId, 8) == 1  then
			AddNumText( sceneId, x124500_g_scriptId, "挑战", 10 ,1  )
		end
		
		for i, eventId in x124500_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

function x124500_OnDefaultEvent( sceneId, selfId,targetId )
	x124500_UpdateEventList( sceneId, selfId, targetId )
end

function x124500_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 1  then
		if GetName(sceneId, targetId) ~= "赤霄"  then
			return
		end
		
		if LuaFnGetCopySceneData_Param(sceneId, 8) == 1  then
			LuaFnSetCopySceneData_Param(sceneId, 8, 2)
		end

		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		
		return
	end
	
	if GetNumText() == 2  then
		if GetName(sceneId, targetId) ~= "赤霄"  then
			return
		end
		
		if LuaFnGetCopySceneData_Param(sceneId, 8) == 1  then
			LuaFnSetCopySceneData_Param(sceneId, 8, 10)
		end
		BeginEvent(sceneId)
			AddText(sceneId, "第二关已经开启。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)

		return
	end

	for i, findId in x124500_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

function x124500_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x124500_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId, targetId )
			end
			return
		end
	end
end

function x124500_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x124500_g_eventList do
		if missionScriptId == findId then
			x124500_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

function x124500_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x124500_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

function x124500_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x124500_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

function x124500_OnDie( sceneId, selfId, killerId )
	LuaFnSetCopySceneData_Param(sceneId, 26, 500)
end

