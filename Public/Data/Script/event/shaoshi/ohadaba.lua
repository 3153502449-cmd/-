--缥缈峰副本....
--哈大霸对话脚本....

--脚本号
x890070_g_ScriptId = 890070

--副本逻辑脚本号....
x890070_g_FuBenScriptId = 890063

--**********************************
--任务入口函数....
--**********************************
function x890070_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText(sceneId,"      藏经阁的绝世武学，此次我们势在必得，人挡杀人，佛挡杀佛！。"..GetUnitReputationID(sceneId, selfId, targetId))
		--判断当前是否可以挑战....	
		if 0 == CallScriptFunction( x890070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "JiuMoZhi" ) then
		    AddNumText( sceneId, x890070_g_ScriptId, "挑战", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x890070_OnEventRequest( sceneId, selfId, targetId, eventId )

   if GetNumText() == 1 then

	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x890070_g_FuBenScriptId, "IsSSSTimerRunning", sceneId ) then
		return
	end

	--是不是队长....
	if GetTeamLeader(sceneId,selfId) ~= selfId then
		BeginEvent(sceneId)
			AddText( sceneId, "#{PMF_20080521_07}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--如果正在和别的BOSS战斗则返回....
	local ret, msg = CallScriptFunction( x890070_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--判断当前是否可以挑战桑土公....	
	if 0 ~= CallScriptFunction( x890070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "JiuMoZhi" ) then
		BeginEvent(sceneId)
			AddText( sceneId, "你已经挑战过我了。" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x890070_g_FuBenScriptId, "OpenSSSTimer", sceneId, 7, x890070_g_ScriptId, -1 ,-1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	BeginEvent(sceneId)
		AddText(sceneId,"      你确认开始挑战么？开始挑战后，寺门将被封印，死亡后将无法立即参与战斗；所有队员脱离战斗，封印将解除。")
		    AddNumText( sceneId, x890070_g_ScriptId, "挑战", 10, 1 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x890070_OnSSSTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x890070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗5秒钟后开始" )
		return
	end

	if 6 == step then
		CallScriptFunction( x890070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗4秒钟后开始" )
		return
	end

	if 5 == step then
		CallScriptFunction( x890070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗3秒钟后开始" )
		return
	end

	if 4 == step then
		CallScriptFunction( x890070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗2秒钟后开始" )
		return
	end

	if 3 == step then
		CallScriptFunction( x890070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗1秒钟后开始" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x890070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗开始" )
		--删除NPC....
		CallScriptFunction( x890070_g_FuBenScriptId, "DeleteBOSS", sceneId, "JiuMoZhi_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x890070_g_FuBenScriptId, "CreateBOSS", sceneId, "JiuMoZhi_BOSS", -1, -1 )
		return
	end

end
