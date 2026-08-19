--缥缈峰副本....
--桑土公对话脚本....

--脚本号
x893071_g_ScriptId = 893071

--副本逻辑脚本号....
x893071_g_FuBenScriptId = 893063

--**********************************
--任务入口函数....
--**********************************
function x893071_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText( sceneId, "   这里就是陶青所在的盘龙阁了。江湖传言陶青的双眼因患恶疾，已经不能视物了。但功夫依然是四绝庄中最强。#r    陶青饲养了四只墨虎和十只青鹰，它们对陶青是忠心耿耿。如果战斗中出现的话，一定要首先击退！" )
		AddText( sceneId, "   另外他还有一项绝技——三峰流云。使出来后，陶青会如鬼神一般，神出鬼没。据说，此技能有一破绽，好好利用可以将三峰流云给破了！#r    你们准备好了就通知我，我这就去引陶青出来！" )
		if 1 == CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		    AddNumText( sceneId, x893071_g_ScriptId, "挑战BOSS陶青", 10, 1 )
		end
		if 0 ~= CallScriptFunction( x893070_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "PangQi" ) then
		    AddNumText( sceneId, x893071_g_ScriptId, "传送到下一关", 10, 2 )
		end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x893071_OnEventRequest( sceneId, selfId, targetId, eventId )
   if GetNumText() == 1 then
	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x893071_g_FuBenScriptId, "IsSJZTimerRunning", sceneId ) then
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
	local ret, msg = CallScriptFunction( x893071_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--判断当前是否可以挑战桑土公....	
	if 1 ~= CallScriptFunction( x893071_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "QinYun" ) then
		BeginEvent(sceneId)
			AddText( sceneId, "你已经挑战过我了。" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x893071_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893071_g_ScriptId, -1, -1 )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
  end

   if GetNumText() == 2 then
	SetPos(sceneId, selfId, 72, 33)
  end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893071_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗5秒钟后开始" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗4秒钟后开始" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗3秒钟后开始" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗2秒钟后开始" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗1秒钟后开始" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x893071_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗开始" )
		--删除NPC....
		--CallScriptFunction( x893071_g_FuBenScriptId, "DeleteBOSS", sceneId, "QinYun_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x893071_g_FuBenScriptId, "CreateBOSS", sceneId, "QinYun_BOSS", -1, -1 )
		return
	end

end

