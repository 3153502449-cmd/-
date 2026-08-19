--鬼谷NPC  学习门派生活技能
--普通

--脚本号
x080017_g_ScriptId = 080017

--所拥有的事件
--elevelup_molishu = 713580
--edialog_molishu = 701615

--所拥有的事件ID列表
x080017_g_eventList={080020,080021,080022}	

--**********************************
--事件列表
--**********************************
function x080017_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{XMPGG_160823_60}")
	for i, eventId in x080017_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	AddNumText( sceneId, x080017_g_ScriptId, "鬼谷符箓介绍", 11, 100 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x080017_OnDefaultEvent( sceneId, selfId,targetId )
	x080017_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x080017_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{XMPGG_160615_20}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	for i, findId in x080017_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText(),x080017_g_ScriptId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x080017_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x080017_g_eventList do
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
function x080017_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x080017_g_eventList do
		if missionScriptId == findId then
			x080017_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x080017_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x080017_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x080017_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x080017_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x080017_OnDie( sceneId, selfId, killerId )
end
