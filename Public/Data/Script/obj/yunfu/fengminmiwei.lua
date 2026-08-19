--葛光佩
--脚本号
--2019-10-24 15:55:48 逍遥子
x761001_g_ScriptId = 761001

--所拥有的事件ID列表
x761001_g_eventList={1391}	

--**********************************
--事件列表
--**********************************
function x761001_UpdateEventList( sceneId, selfId,targetId )

	BeginEvent(sceneId)
	AddText(sceneId,"已移至洛阳陈子安213,315")
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)


	--按空城要求把此任务移至洛阳
	--CallScriptFunction  第一参数的脚本号,好些没搜到注册件,先注掉


	-- BeginEvent(sceneId)
	-- local  PlayerName=GetName(sceneId,selfId)
	-- AddText(sceneId,"#{JXPVP_170814_126}")
	-- AddNumText( sceneId, x761001_g_ScriptId, "关于五方镜", 11, 100 )	
	-- AddNumText( sceneId, x761001_g_ScriptId, "关于清剿：九黎余孽任务", 11, 200 )
	-- if IsHaveMission( sceneId, selfId, 1391 ) == 0 then
		-- AddNumText( sceneId, x761001_g_ScriptId, "清剿：九黎余孽", 3, 300 )	
    -- else
		-- AddNumText( sceneId, x761001_g_ScriptId, "清剿：九黎余孽", 4, 400 )	
    -- end
	-- for i, eventId in x761001_g_eventList do
		-- CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		
	-- end
	-- EndEvent(sceneId)
	-- DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x761001_OnDefaultEvent( sceneId, selfId,targetId )
	x761001_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x761001_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{JXPVP_170814_07}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	if GetNumText() == 200 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{JXMR_171027_08}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end	

	if GetNumText() == 300 then
		local missionId = TGetMissionIdByIndex( 1000340 )
		local missionName = TGetMissionName( 1000340 )
		local missionTarget, missionInfo, missionContinue = TGetMissionDesc( 1000340 )
		if GetMissionDataEx(sceneId,selfId,MD_JIULIYUNIE_MISSION) ~= GetDayTime() then
			SetMissionDataEx(sceneId,selfId,MD_JIULIYUNIE_MISSION,GetDayTime())
			BeginEvent( sceneId )
				AddText( sceneId, missionName )
				AddText( sceneId, missionInfo )
				AddText( sceneId, "#{M_MUBIAO}#r" )
				AddText( sceneId, missionTarget )
				CallScriptFunction( MOD_EVENT, "DisplayBonus", sceneId, 1000340 )
			EndEvent( )
			DispatchMissionInfo( sceneId, selfId, targetId, 1000340, missionId )
		else
			BeginEvent(sceneId)
				AddText(sceneId,"#{JXMR_171027_10}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	end

	if GetNumText() == 400 then
		local missionId = TGetMissionIdByIndex( 1000340 )
		local missionName = TGetMissionName( 1000340 )
		local missionTarget, missionInfo, missionContinue = TGetMissionDesc( 1000340 )
        local misIndex = GetMissionIndexByID( sceneId, selfId, missionId )
        local beDone = GetMissionParam(sceneId, selfId, misIndex, 0)
		BeginEvent( sceneId )
			AddText(sceneId,"    "..misIndex.."   ")
			AddText( sceneId, missionName )
			AddText( sceneId, missionContinue )
			AddText( sceneId, "#{M_MUBIAO}#r" )
			AddText( sceneId, "  " .. missionTarget )
		EndEvent( )
		DispatchMissionDemandInfo( sceneId, selfId, targetId, 1000340, missionId,beDone )
	end

	for i, findId in x761001_g_eventList do
		if eventId == findId then
			CallScriptFunction( 1000340, "OnDefaultEvent",sceneId, selfId )
			return
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x761001_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x761001_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
                if GetMissionDataEx(sceneId,selfId,MD_JIULIYUNIE_MISSION) ~= GetDayTime() then
                    SetMissionDataEx(sceneId,selfId,MD_JIULIYUNIE_MISSION,GetDayTime())
					CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
					x761001_NotifyTip( sceneId, selfId, "#{JXMR_171027_13}" )
				else
					BeginEvent(sceneId)
						AddText(sceneId,"#{JXMR_171027_10}")
					EndEvent(sceneId)
					DispatchEventList(sceneId,selfId,targetId)
					return
				end
		    end
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x761001_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x761001_g_eventList do
		if missionScriptId == findId then
			x761001_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x761001_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x761001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x761001_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x761001_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x761001_OnDie( sceneId, selfId, killerId )
end

function x761001_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end