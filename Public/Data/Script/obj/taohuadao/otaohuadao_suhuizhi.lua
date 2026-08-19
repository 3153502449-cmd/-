--桃花岛NPC-宿回之

--脚本号
x000551_g_ScriptId = 000551

--所拥有的事件
--estudy_zhifu= 713518
--elevelup_zhifu = 713577
--edialog_zhifu = 713617

--所拥有的事件ID列表
x000551_g_eventList={000544,000543}	--760006,760007,760009

--**********************************
--事件列表
--**********************************
function x000551_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	local nMenPaiId = GetMenPai(sceneId,selfId);
	if nMenPaiId == 13 then
		AddText(sceneId,"#{THD_190613_13}")
	else
		AddText(sceneId,"#{THD_190613_14}")
	end
	for i, eventId in x000551_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	AddNumText( sceneId, x000551_g_ScriptId, "#{THDSH_190614_22}", 11, 100 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000551_OnDefaultEvent( sceneId, selfId,targetId )
	x000551_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000551_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{THDSH_190614_23}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	for i, findId in x000551_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x000551_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000551_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000551_g_eventList do
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
function x000551_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000551_g_eventList do
		if missionScriptId == findId then
			x000551_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000551_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000551_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000551_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000551_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000551_OnDie( sceneId, selfId, killerId )
end
