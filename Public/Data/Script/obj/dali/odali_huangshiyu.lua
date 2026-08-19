--桃花岛-黄时雨
--2019-11-1 18:37:13 逍遥子
--脚本号
x000538_g_scriptId = 000538
--所拥有的事件ID列表
x000538_g_eventList={210209,210287}

--**********************************
--事件列表
--**********************************
function x000538_UpdateEventList( sceneId, selfId,targetId )
	
	local  Menpai=LuaFnGetMenPai(sceneId,selfId)
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "师妹"
	else
		PlayerSex = "师弟"
	end
	
	BeginEvent(sceneId)	
	if Menpai == 9 then
		AddText(sceneId,"#{THDRZ_190613_01}")
	elseif Menpai == MP_TANGMEN then
		AddText(sceneId,"  #R"..PlayerSex.."#W，许久不久，你的武功又精进不少。")
	else
		AddText(sceneId,"  #{THDRZ_190613_05}")
	end
	AddNumText(sceneId,x000538_g_scriptId,"#{THDRZ_190613_09}",9,0)
	for i, eventId in x000538_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000538_OnDefaultEvent( sceneId, selfId,targetId )
	x000538_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000538_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if IsHaveMission(sceneId,selfId,4021) > 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"你有漕运货舱在身，我们驿站不能为你提供传送服务。");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else	
			CallScriptFunction((400900), "TransferFunc", sceneId, selfId, 720, 256,171)
		end
	elseif   GetNumText()==10	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THDRZ_190613_50}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==11	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THDRZ_190613_51}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==12	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THDRZ_190613_52}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==13	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THDRZ_190613_53}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		for i, findId in x000538_g_eventList do
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
function x000538_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000538_g_eventList do
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
function x000538_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000538_g_eventList do
		if missionScriptId == findId then
			x000538_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000538_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000538_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000538_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000538_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000538_OnDie( sceneId, selfId, killerId )
end
