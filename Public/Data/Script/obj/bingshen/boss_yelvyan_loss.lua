--耶律彦成
--2019-10-27 13:10:08 逍遥子二开

--脚本号
x894075_g_ScriptId = 894075

--副本逻辑脚本号....
x894075_g_FuBenScriptId = 894063


--**********************************
--任务入口函数....
--**********************************
function x894075_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
          local NPCName = GetName(sceneId,targetId)
            if NPCName == "陈勇仁" then

		AddText(sceneId,"      各位英雄多加小心，我在这里接应各位！")
		AddNumText( sceneId, x894075_g_ScriptId, "离开副本", 10, 100 )
            elseif NPCName == "陈勇义" then

		AddText(sceneId,"      我可以送各位好汉到悬崖对面挑战耶律连城！")
		AddNumText( sceneId, x894075_g_ScriptId, "送我过去", 10, 200 )
            else
		AddText(sceneId,"      天堂有路君不走，地狱无门送上来！")
		--判断当前是否可以挑战李秋水....	
		if 1 == CallScriptFunction( x894075_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "YeLvLian" ) then
			AddNumText( sceneId, x894075_g_ScriptId, "决战耶律连城", 10, 1 )
		end
            end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x894075_OnEventRequest( sceneId, selfId, targetId, eventId )

    if GetNumText() == 1 then
	--如果正在激活BOSS则返回....
	if 1 == CallScriptFunction( x894075_g_FuBenScriptId, "IBQZSTimerRunning", sceneId ) then
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
	if 1 ~= CallScriptFunction( x894075_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "YeLvLian" ) then
		return
	end

	--如果正在和别的BOSS战斗则返回....
	local ret, msg = CallScriptFunction( x894075_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x894075_g_FuBenScriptId, "OpenBQZTimer", sceneId, 7, x894075_g_ScriptId, -1 ,-1 )
	
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
      return
    end

    if GetNumText() == 100 then
	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 186, 205, 177, 75 )
      return
    end

    if GetNumText() == 200 then
	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, sceneId, 111, 203, 75 )
      return
    end

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x894075_OnBQZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		CallScriptFunction( x894075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗5秒钟后开始" )
		return
	end

	if 6 == step then
		CallScriptFunction( x894075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗4秒钟后开始" )
		return
	end

	if 5 == step then
		CallScriptFunction( x894075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗3秒钟后开始" )
		return
	end

	if 4 == step then
		CallScriptFunction( x894075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗2秒钟后开始" )
		return
	end

	if 3 == step then
		CallScriptFunction( x894075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗1秒钟后开始" )
		return
	end

	if 2 == step then
		--提示战斗开始....
		CallScriptFunction( x894075_g_FuBenScriptId, "TipAllHuman", sceneId, "战斗开始" )
		--删除NPC....
		CallScriptFunction( x894075_g_FuBenScriptId, "DeleteBOSS", sceneId, "LiFan_NPC" )
		return
	end

	if 1 == step then
		--建立BOSS....
		CallScriptFunction( x894075_g_FuBenScriptId, "CreateBOSS", sceneId, "YeLvLian_BOSS", -1, -1 )
		return
	end

end

