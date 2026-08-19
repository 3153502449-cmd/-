--缥缈峰副本....
--乌老大对话脚本....

--脚本号
x893072_g_ScriptId = 893072

--副本逻辑脚本号....
x893072_g_FuBenScriptId = 893063

--战败乌老大对话脚本号....
x893072_g_LossScriptId = 893075

--**********************************
--任务入口函数....
--**********************************
function x893072_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)

		AddText( sceneId, "    这里就是秦韵所在的西韵阁了。据我调查的信息，秦韵有烛影摇红和金色狂舞两大绝技。#r    烛影摇红会让你伤害自己的队友。" )
		AddText( sceneId, "    金色狂舞则是依靠回音幡强化秦韵的功力，据说有将人一击毙命的威力！#r    你们准备好了就通知我，我这就去引秦韵出来！" )

		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
		    AddNumText( sceneId, x893072_g_ScriptId, "挑战BOSS秦韵", 10, 1 )
		end

		--判断当前是否可以挑战李秋水....	
		if 0 ~= CallScriptFunction( x893072_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		    AddNumText( sceneId, x893072_g_ScriptId, "传送到下一关", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x893072_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then

	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x893072_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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
	local ret, msg = CallScriptFunction( x893072_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--判断当前是否可以挑战乌老大....	
		if 1 ~= CallScriptFunction( x893072_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "TaoQin" ) then
			BeginEvent(sceneId)
				AddText( sceneId, "#{PMF_20080521_11}" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		--开启缥缈峰计时器来激活自己....
		CallScriptFunction( x893072_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893072_g_ScriptId, -1 ,-1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 38, 77)
  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893072_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗5秒钟后开始" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗4秒钟后开始" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗3秒钟后开始" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗2秒钟后开始" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗1秒钟后开始" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x893072_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗开始" )
		--删除NPC....
		--CallScriptFunction( x893072_g_FuBenScriptId, "DeleteBOSS", sceneId, "TaoQin_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x893072_g_FuBenScriptId, "CreateBOSS", sceneId, "TaoQin_BOSS", -1, -1 )
		return
	end

end

