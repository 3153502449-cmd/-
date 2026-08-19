--缥缈峰副本....
--战败乌老大对话脚本....

--脚本号
x893075_g_ScriptId = 893075

--副本逻辑脚本号....
x893075_g_FuBenScriptId = 893063


--**********************************
--任务入口函数....
--**********************************
function x893075_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText( sceneId, "呸，这个奸险小人就叫庞企。当年为了独占师傅要传给我们的秘宝，下毒给我们师兄妹三人。" )

		--判断当前是否可以挑战李秋水....	
		if 1 == CallScriptFunction( x893075_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
			AddNumText( sceneId, x893075_g_ScriptId, "决战BOSS庞企？", 10, 1 )
		end
		--判断当前是否可以挑战过李秋水....	
		if 2 == CallScriptFunction( x893075_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
			AddNumText( sceneId, x893075_g_ScriptId, "返回苏州", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x893075_OnEventRequest( sceneId, selfId, targetId, eventId )
   if GetNumText() == 1 then

	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x893075_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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

	--判断当前是否可以挑战李秋水....	
	if 1 ~= CallScriptFunction( x893075_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
		return
	end

	--如果正在和别的BOSS战斗则返回....
	local ret, msg = CallScriptFunction( x893075_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x893075_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893075_g_ScriptId, -1 ,-1 )
	
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
      CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1, 195,215,10 )--传送
  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893075_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗5秒钟后开始" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗4秒钟后开始" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗3秒钟后开始" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗2秒钟后开始" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗1秒钟后开始" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x893075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗开始" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x893075_g_FuBenScriptId, "CreateBOSS", sceneId, "PangQi_BOSS", -1, -1 )
		return
	end

end

