--缥缈峰副本....
--哈大霸对话脚本....

--脚本号
x893070_g_ScriptId = 893070

--副本逻辑脚本号....
x893070_g_FuBenScriptId = 893063

--**********************************
--任务入口函数....
--**********************************
function x893070_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText(sceneId,"  前方就是四绝庄，我们必须进到深处才能找到秘宝。首先要通过的是四绝殿。")
		AddText(sceneId,"  四绝殿内有很多护卫，但只要听到殿内的四绝钟声，就会离开。我能让近战门派偷偷的潜入敲钟，否则就只能硬闯了！")

		--判断当前是否可以挑战....	
		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "MinMo" ) then
		AddText(sceneId,"   殿内护卫已经清理，我去将四绝之书生闵墨引来，大家将他擒下，让我来逼问他秘宝保存的地方。他非常喜欢李白的《将进酒》，每次使绝技的时候都会吟唱一翻。大家只要注意躲开他发出的将进酒气劲，轻松擒下他不是问题！")
		    AddNumText( sceneId, x893070_g_ScriptId, "挑战BOSS闵墨", 10, 1 )
		end
		--判断当前是否挑战完毕之后传送....	
		if 0 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
		    AddNumText( sceneId, x893070_g_ScriptId, "传送到下一关", 10, 2 )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x893070_OnEventRequest( sceneId, selfId, targetId, eventId )

   if GetNumText() == 1 then

	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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
	local ret, msg = CallScriptFunction( x893070_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--判断当前是否可以挑战桑土公....	
	if 1 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "MinMo" ) then
		BeginEvent(sceneId)
			AddText( sceneId, "你已经挑战过我了。" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x893070_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893070_g_ScriptId, -1 ,-1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 72, 92)

  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893070_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗5秒钟后开始" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗4秒钟后开始" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗3秒钟后开始" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗2秒钟后开始" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗1秒钟后开始" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x893070_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗开始" )
		--删除NPC....
		--CallScriptFunction( x893070_g_FuBenScriptId, "DeleteBOSS", sceneId, "MinMo_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x893070_g_FuBenScriptId, "CreateBOSS", sceneId, "MinMo_BOSS", -1, -1 )
		return
	end

end

