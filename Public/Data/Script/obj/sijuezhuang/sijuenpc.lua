-- 001090
-- 高太公 匪寨传送人

--脚本号
x001090_g_scriptId = 001090

--所拥有的事件ID列表
x001090_g_eventList={893063}

--**********************************
--事件列表
--**********************************
function x001090_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{SJZ_100129_02}")
	AddNumText( sceneId, x001090_g_scriptId, "关于四绝庄",0 ,2  )
	for i, eventId in x001090_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001090_OnDefaultEvent( sceneId, selfId,targetId )
	x001090_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001090_OnEventRequest( sceneId, selfId, targetId, eventId )
	
	if GetNumText() == 2 then
	BeginEvent(sceneId)
	    AddText(sceneId,"#{SJZ_100129_02}")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
		return
	end

	for i, findId in x001090_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x001090_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001090_g_eventList do
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
function x001090_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001090_g_eventList do
		if missionScriptId == findId then
			x001090_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001090_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001090_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001090_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x001090_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001090_OnDie( sceneId, selfId, killerId )
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x001090_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--玩家进入一个 area 时触发
function x001090_OnEnterArea( sceneId, selfId )
	CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 1,196,216)
end

--玩家在一个 area 呆了一段时间没走则定时触发
function x001090_OnTimer( sceneId, selfId )
	-- 毫秒，看在这个 area 停留多久了
	StandingTime = QueryAreaStandingTime( sceneId, selfId )
	-- 5秒后仍未传送
	if StandingTime >= 5000 then
		x001090_OnEnterArea( sceneId, selfId )
		ResetAreaStandingTime( sceneId, selfId, 0 )
	end
end

--玩家离开一个 area 时触发
function x001090_OnLeaveArea( sceneId, selfId )
end


--VMRU作式了中以我些开作上70

--DJZVMRU作式了中以我些开作

