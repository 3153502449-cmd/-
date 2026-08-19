--桃花岛NPC-枕梦归
--2019-11-15 20:06:01 逍遥子

x000513_g_scriptId = 000513
x000513_g_eventList={229009,229012}
--**********************************
--事件交互入口
--**********************************
function x000513_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local mp = GetMenPai(sceneId, selfId)
		if mp ~= 13 then
			AddText(sceneId,"#{THD_190613_02}")
		else
			AddText(sceneId,"#{THD_190613_01}")
		end
		--修缮离人轻甲
--		AddNumText(sceneId, x000513_g_scriptId, "门派介绍",8,1)
--		AddNumText(sceneId, x000513_g_scriptId, "如何学习门派技能",8,6)		--指路到技能学习人
		for i, eventId in x000513_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x000513_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x000513_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_TAOHUADAO )
			return
		end
	end

	if GetNumText()==0	then
	
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000513_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000513_g_eventList do
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
function x000513_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000513_g_eventList do
		if missionScriptId == findId then
			x000513_OnDefaultEvent( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000513_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000513_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000513_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000513_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000513_OnDie( sceneId, selfId, killerId )
end

--**********************************
--消息提示
--**********************************
function x000513_MsgBox( sceneId, selfId, str )
	Msg2Player( sceneId, selfId, str, MSG2PLAYER_PARA )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
