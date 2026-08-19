--仲夏除魔脚本

--脚本号
x808133_g_scriptId = 808133
x808133_g_beginTime1 = 19 * 60 + 30;
x808133_g_endTime1 = 22 * 60 ;
--所拥有的事件ID列表
x808133_g_eventList={808134}
--x808133_g_MissionId = 1439
--**********************************
--事件列表
--**********************************
function x808133_UpdateEventList( sceneId, selfId, targetId )
	
end
--**********************************
--事件交互入口
--**********************************
function x808133_OnDefaultEvent( sceneId, selfId, targetId )--sceneId, selfId, targetId
	x808133_UpdateEventList( sceneId, selfId, targetId )
	local PlayerName = GetName( sceneId, selfId )
	local PlayerSex = GetSex( sceneId, selfId )

	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
	AddText( sceneId, "    #P"..PlayerName..PlayerSex..":#G 你好！话说千年前中原大旱，黄帝为拯救苍生，将暑魔封于黄泉之下。夏日来临，一些法力高深之暑魔便挣脱了符咒的束缚出来危害人间。#r     仲夏期间，#G每天19:00到22:00#W是暑魔们较为虚弱的时候。若大侠能抓住这个时机除掉这些暑魔，不仅能为民除害，还能有助提升修为。" )
	AddNumText( sceneId, x808133_g_ScriptId, "仲夏除魔", 6, 1)
    AddNumText( sceneId, x808133_g_ScriptId, "离开……", 9, 0 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x808133_OnEventRequest( sceneId, selfId, targetId)
   
    if nNumText==0  then
	-- 关闭窗口
       BeginUICommand(sceneId)
       EndUICommand(sceneId)
       DispatchUICommand(sceneId,selfId, 1000)
       return
	--end

    elseif nNumText==1  then
	    local PlayerLevel  = GetLevel(sceneId, selfId)
        local PlayerName = GetName( sceneId, selfId )
	    local PlayerSex = GetSex( sceneId, selfId )
        if PlayerSex == 0 then
		PlayerSex = "姑娘"
	    else
		PlayerSex = "少侠"
	    end
	   if PlayerLevel < 30 then
		BeginEvent(sceneId)
            AddText( sceneId, "    #R"..PlayerName..PlayerSex..":" )
	    AddText( sceneId, "    #G你级别不到30级，30级后才能领取仲夏除魔任务！#r#Y    快去升级后再来吧。" )
	    EndEvent(sceneId)
	    DispatchEventList(sceneId,selfId,targetId)
	     return
	    end
	  --CallScriptFunction( 808134, "OnDefaultEvent", sceneId, selfId, targetId ) --任务脚本ID，场景ID，玩家角色ID，目标ID
      for i, eventId in x808133_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	    end
	   EndEvent(sceneId)
	   DispatchEventList(sceneId,selfId,targetId)              
    end
end

--function x808133_IsActivityOpen(sceneId)
	--local nHour = GetHour();
	--local nMinute = GetMinute();
	--local nCurTempTime = nHour * 60 + nMinute;
	--if nCurTempTime >= x808133_g_beginTime1 and nCurTempTime < x808133_g_endTime1 then
		--for i, eventId in x808133_g_eventList do
		--CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	    --end
	   --EndEvent(sceneId)
	  -- DispatchEventList(sceneId,selfId,targetId)
	--else
	--return 0;
	--end
--end
--**********************************
--print(nRet_rw)
--接受此NPC的任务
--**********************************

function x808133_OnMissionAccept( sceneId, selfId, targetId )
	
			--local ret1 = CallScriptFunction( x808133_IsActivityOpen, "CheckAccept", sceneId, selfId, targetId )
			--local ret1 = CallScriptFunction( sceneId, selfId, targetId )
			--if ret1 > 0 then
			--	CallScriptFunction( 808134, "OnDefaultEvent", sceneId, selfId, targetId ) --任务脚本ID，场景ID，玩家角色ID，目标ID
			--end
			--return
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x808133_OnMissionRefuse( sceneId, selfId, targetId, x808133_MY_ZH )
			x808133_UpdateEventList( sceneId, selfId, targetId )
			return
end

--**********************************
--继续（已经接了任务）
--**********************************
function x808133_OnMissionContinue( sceneId, selfId, targetId, x808133_MY_ZH )

			CallScriptFunction( 808134, "OnContinue", sceneId, selfId, targetId )
			return
end

--**********************************
--提交已做完的任务
--**********************************
function x808133_OnMissionSubmit( sceneId, selfId, targetId, x808133_MY_ZH, selectRadioId )
	
			CallScriptFunction( 808134, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
	

end

--**********************************
--死亡事件
--**********************************
function x808133_OnDie( sceneId, selfId, killerId )
end

--**********************************
--对话窗口信息提示
--**********************************
function x808133_NotifyFailBox( sceneId, selfId, targetId, msg )
	
end