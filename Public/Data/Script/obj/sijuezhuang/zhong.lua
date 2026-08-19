--缥缈峰副本....
--符敏仪对话脚本....

--脚本号
x893081_g_ScriptId = 893081

--副本逻辑脚本号....
x893081_g_FuBenScriptId = 893063

--震慑buff表....
x893081_g_BUFF = { 10264, 10265, 10266 }



--**********************************
--任务入口函数....
--**********************************
function x893081_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent(sceneId)
		AddText( sceneId, "四绝殿内有很多护卫，但只要听到殿内的四绝钟声，就会离开。" )

		--判断当前是否可以挑战双子....	
		--if 1 == CallScriptFunction( x893081_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "ShuangZi" ) then
			AddNumText( sceneId, x893081_g_ScriptId, "敲钟", 10, 1 )
		--end

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)

end

--**********************************
--事件列表选中一项
--**********************************
function x893081_OnEventRequest( sceneId, selfId, targetId, eventId )

	--是不是队长....
	if GetTeamLeader(sceneId,selfId) ~= selfId then
		BeginEvent(sceneId)
			AddText( sceneId, "#{PMF_20080521_07}" )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end

	--判断当前是否可以挑战双子....	
	--if 1 ~= CallScriptFunction( x893081_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "ShuangZi" ) then
		--return
	--end

	--如果正在和别的BOSS战斗则返回....
	local ret, msg = CallScriptFunction( x893081_g_FuBenScriptId, "CheckHaveBOSS", sceneId )
	if 1 == ret then
		BeginEvent(sceneId)
			AddText( sceneId, msg )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end

	--开启缥缈峰计时器来激活自己....
	CallScriptFunction( x893081_g_FuBenScriptId, "OpenSJZTimer", sceneId, 7, x893081_g_ScriptId, -1 ,-1 )
	
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)

end

--**********************************
--缥缈峰计时器的OnTimer....
--**********************************
function x893081_OnSJZTimer( sceneId, step, data1, data2 )

	if 7 == step then
		MonsterTalk(sceneId, -1, "", "#{SJZ_100129_31}" )
		CallScriptFunction( x893081_g_FuBenScriptId, "DeleteBOSS", sceneId, "Zhong_NPC" )
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "您可以点击潘菁菁进行挑战BOSS闵墨" )
		return
	end

	if 6 == step then
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "您可以点击潘菁菁进行挑战BOSS闵墨" )
		return
	end

	if 5 == step then
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "您可以点击潘菁菁进行挑战BOSS闵墨" )
		return
	end

	if 4 == step then
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "您可以点击潘菁菁进行挑战BOSS闵墨" )
		return
	end

	if 3 == step then
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "您可以点击潘菁菁进行挑战BOSS闵墨" )
	--删除隐身状态....
	  local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	  for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if LuaFnIsObjValid(sceneId, nHumanId) == 1 and LuaFnIsCanDoScriptLogic(sceneId, nHumanId) == 1 and LuaFnIsCharacterLiving(sceneId, nHumanId) == 1 then
			--LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, nHumanId, x893064_Buff_A, 0 )
			LuaFnCancelSpecificImpact(sceneId,nHumanId,22211)
		end
	  end
		return
	end

	if 2 == step then

		--提示战斗开始....
		CallScriptFunction( x893081_g_FuBenScriptId, "TipAllHuman", sceneId, "您可以点击潘菁菁进行挑战BOSS闵墨" )
		--删除NPC....
		CallScriptFunction( x893081_g_FuBenScriptId, "DeleteBOSS", sceneId, "Panqinqin_NPC" )

		return
	end

	if 1 == step then
		--设置可以挑战BOSS闵墨....
		CallScriptFunction( x893081_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "MinMo", 1 )
		--删除所有怪物....
	  local nCount = GetMonsterCount(sceneId)
	  for i=0, nCount-1  do
		local nObjId = GetMonsterObjID(sceneId, i)
		local MosDataID = GetMonsterDataID( sceneId, nObjId )
		if MosDataID == 14112 or MosDataID == 14118 then
			LuaFnDeleteMonster(sceneId, nObjId)
		end
	  end

		return
	end
end


