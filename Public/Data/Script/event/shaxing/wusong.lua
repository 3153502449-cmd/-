--赤砂之蝎
--生死擂台·武松
--2019-10-22 14:46:42 逍遥子二开

--脚本号
x892021_g_ScriptId	= 892021

--副本逻辑脚本号....
x892021_g_FuBenScriptId = 892009

--buff....
x892021_Buff_MianYi1	= 10472	--免疫一些负面效果....
x892021_Buff_MianYi2	= 10471	--免疫普通隐身....

x892021_Buff_E1			= 10234
x892021_Buff_E2			= 10235

--AI Index....
x892021_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x892021_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x892021_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x892021_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--入口函数
--**********************************
function x892021_OnDefaultEvent( sceneId, selfId, targetId )
	CallScriptFunction(892009,"RefreshNewMonster",sceneId,selfId,targetId);
end


--**********************************
--初始化....
--**********************************
function x892021_OnInit(sceneId, selfId)
	--重置AI....
	x892021_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x892021_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892021_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892021_IDX_IsKuangBaoMode ) then
		return
	end

	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892021_IDX_CombatTime )
                local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892021_IDX_UseSkillIndex )

	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892021_IDX_CombatTime, CombatTime + nTick )

	--如果已经到了用这个技能的时间则使用技能....
	if (CombatTime+nTick) < 300*1000 then
		if  (CombatTime+nTick) >= NextSkillIndex*25000 then
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x892021_IDX_UseSkillIndex, NextSkillIndex+1 )
			x892021_UseMySkill( sceneId, selfId )
		end
	else
		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892021_IDX_IsKuangBaoMode, 1 )
		x892021_SkillE_KuangBao( sceneId, selfId )
	end

end

--**********************************
--进入战斗....
--**********************************
function x892021_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892021_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892021_Buff_MianYi2, 0 )

	--重置AI....
	x892021_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892021_IDX_CombatFlag, 1 )

	--发表讲话
	LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090119_149}")
end


--**********************************
--离开战斗....
--**********************************
function x892021_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x892021_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀死敌人....
--**********************************
function x892021_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x892021_OnDie( sceneId, selfId, killerId )

	--取得当前场景里的人数
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
	--物品掉落
	CallScriptFunction(x892021_g_FuBenScriptId,"OnDropBoxFromBoss",sceneId,selfId,10);

	if killmosternum == nil then
	     killmosternum = 3
	else
	     killmosternum = killmosternum + 1
	end
	if  killmosternum ~= nil and killmosternum <= 7 then
	     CallScriptFunction(x892021_g_FuBenScriptId,"SetFubenTimer",sceneId, killmosternum,1)
	end 
	if killmosternum == 8 then
	    killmosternum = nil
	    LuaFnSetCopySceneData_Param(sceneId, 4, 1)
		--给玩家活动数值变动
		CallScriptFunction(x892021_g_FuBenScriptId,"AddPlayerPrize",sceneId);
	end 
end


--**********************************
--重置AI....
--**********************************
function x892021_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892021_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892021_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892021_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892021_IDX_CombatFlag, 0 )

	--清除buff....
	LuaFnCancelSpecificImpact( sceneId, selfId, x892021_Buff_E1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892021_Buff_E2 )

end

--**********************************
--BOSS使用技能....
--**********************************
function x892021_UseMySkill( sceneId, selfId )
	
	--温馨提示
	CallScriptFunction(892009,"TipAllHuman",sceneId,"#{SXRW_090119_161}");
	
    LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090119_171}");
	
	local x,z = GetWorldPos( sceneId, selfId )
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i=0, nHumanCount-1 do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		local PlayerX,PlayerZ = GetWorldPos( sceneId, nHumanId )
		Distance = floor(sqrt((x-PlayerX)*(x-PlayerX)+(z-PlayerZ)*(z-PlayerZ)))
		if Distance < 5 then
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, nHumanId, 8882, 0)
		end
	end
end

--**********************************
--狂暴技能....
--**********************************
function x892021_SkillE_KuangBao( sceneId, selfId )
	--加狂暴buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892021_Buff_E1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892021_Buff_E2, 0 )
end

--**********************************
--对话框提示
--**********************************
function x892021_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

