-- 鬼谷
-- 杨衍
--脚本号
x002105_g_scriptId = 002105
--所拥有的事件ID列表
x002105_g_eventList={210209,210287}

--**********************************
--事件列表
--**********************************
function x002105_UpdateEventList( sceneId, selfId,targetId )
	local  Menpai=LuaFnGetMenPai(sceneId,selfId)
	local  PlayerSex=GetSex(sceneId,selfId)
	if PlayerSex == 0 then
		PlayerSex = "师妹"
	else
		PlayerSex = "师弟"
	end
	BeginEvent(sceneId)	
	if Menpai == 9 then
		AddText(sceneId,"#{GGXS_160620_01}")
	elseif Menpai == MP_GUIGU then
		AddText(sceneId,"  "..PlayerSex.."#{GGXS_160620_02}")
	else
		AddText(sceneId,"#{GGXS_160620_05}")
	end
	
--	if	GetLevel( sceneId, selfId)<=10	then
		AddNumText(sceneId,x002105_g_scriptId,"去鬼谷看看",9,0)
--	end
	for i, eventId in x002105_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x002105_OnDefaultEvent( sceneId, selfId,targetId )
	x002105_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002105_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if IsHaveMission(sceneId,selfId,4021) > 0 then
			BeginEvent(sceneId)
				AddText(sceneId,"你有漕运货舱在身，我们驿站不能为你提供传送服务。");
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else	
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 197,86,150)
		end

	elseif   GetNumText()==10	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XMPGG_160524_06}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==11	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XMPGG_160524_03}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==12	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XMPGG_160524_07}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif   GetNumText()==13	then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XMPGG_160524_06}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	else
		for i, findId in x002105_g_eventList do
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
function x002105_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002105_g_eventList do
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
function x002105_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002105_g_eventList do
		if missionScriptId == findId then
			x002105_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002105_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002105_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002105_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002105_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002105_OnDie( sceneId, selfId, killerId )
end
