--耶律彦
--2019-10-27 13:09:04 逍遥子二开

--脚本号
x894072_g_ScriptId = 894072

--副本逻辑脚本号....
x894072_g_FuBenScriptId = 894063

--战败乌老大对话脚本号....
x894072_g_LoBQZcriptId = 894075

--**********************************
--任务入口函数....
--**********************************
function x894072_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)

		AddText(sceneId,"      天堂有路君不走，地狱无门送上来！")

		if 1 == CallScriptFunction( x894070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "YeLvYan" ) then
		    AddNumText( sceneId, x894072_g_ScriptId, "挑战", 10, 1 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x894072_OnEventRequest( sceneId, selfId, targetId, eventId )

	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x894072_g_FuBenScriptId, "IBQZSTimerRunning", sceneId ) then
		return
	end

local axiao = CallScriptFunction( x894072_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "YeLvYan" )
	if 1 ~= axiao then
		BeginEvent(sceneId)
			AddText( sceneId, "必须杀死 萧如筠 萧如蔚 兄弟才能和我战斗哦！"..axiao )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
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
	local ret, msg = CallScriptFunction( x894072_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--判断当前是否可以挑战乌老大....	
		if 1 ~= CallScriptFunction( x894072_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "YeLvYan" ) then
			BeginEvent(sceneId)
				AddText( sceneId, "#{PMF_20080521_11}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		--开启缥缈峰计时器来激活自己....
		CallScriptFunction( x894072_g_FuBenScriptId, "OpenBQZTimer", sceneId, 7, x894072_g_ScriptId, -1 ,-1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x894072_OnBQZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x894072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗5秒钟后开始" )
		return
	end

	if 6 == step then
		CallScriptFunction( x894072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗4秒钟后开始" )
		return
	end

	if 5 == step then
		CallScriptFunction( x894072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗3秒钟后开始" )
		return
	end

	if 4 == step then
		CallScriptFunction( x894072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗2秒钟后开始" )
		return
	end

	if 3 == step then
		CallScriptFunction( x894072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗1秒钟后开始" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x894072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗开始" )
		--删除NPC....
		CallScriptFunction( x894072_g_FuBenScriptId, "DeleteBOSS", sceneId, "YeLvYan_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		objId = CallScriptFunction( x894072_g_FuBenScriptId, "CreateBOSS", sceneId, "YeLvYan_BOSS", -1, -1 )
		SetMonsterGroupID(sceneId, objId, 1);	--每组怪物属于同一个GroupID，这样怪物们可以互相增援
		return
	end

end
