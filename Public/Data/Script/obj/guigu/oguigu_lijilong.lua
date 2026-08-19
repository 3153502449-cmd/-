--鬼谷NPC
--李吉龙
--普通

x080025_g_scriptId = 080025

--所拥有的事件ID列表
x080025_g_eventList={}
--x080025_g_eventList={200912,201011,201612,201811}

--**********************************
--事件列表
--**********************************
function x080025_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local  PlayerName=GetName(sceneId,selfId)
		AddText(sceneId,"#{XMPGG_160823_58}");
		x080025_g_MenPai = GetMenPai(sceneId, selfId)
		if x080025_g_MenPai == 12 then
			AddNumText(sceneId, x080025_g_scriptId, "学习技能",12,0)
		end
	for i, eventId in x080025_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	
	AddNumText(sceneId, x080025_g_scriptId, "关于心法的介绍",11,10)
	
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x080025_OnDefaultEvent( sceneId, selfId,targetId )
	x080025_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x080025_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 10 then
		BeginEvent(sceneId)	
			AddText( sceneId, "#{function_xinfajieshao_001}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 11 then
		BeginEvent(sceneId)					
			AddText( sceneId, "#{JZBZ_081031_01}" )							
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end


	if	GetNumText()==0	then
		DispatchXinfaLevelInfo( sceneId, selfId, targetId, 12 );
	else
		for i, findId in x080025_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x080025_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x080025_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x080025_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x080025_g_eventList do
		if missionScriptId == findId then
			x080025_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x080025_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x080025_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x080025_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x080025_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x080025_OnDie( sceneId, selfId, killerId )
end
