--赤砂之蝎
--生死擂台·卢俊义
--2019-10-22 15:28:50 逍遥子

--脚本号
x892011_g_ScriptId	= 892011

--副本逻辑脚本号....
x892011_g_FuBenScriptId = 892009

--buff....
x892011_Buff_MianYi1	= 10472	--免疫一些负面效果....
x892011_Buff_MianYi2	= 10471	--免疫普通隐身....

x892011_Buff_E1			= 10234
x892011_Buff_E2			= 10235

--技能释放时间表....
x892011_UseSkillList =
{
	{ 26,  "A0" },
	{ 28,  "A" },
	{ 45,  "B" },
	{ 66,  "A0" },
	{ 68,  "A" },
	{ 85,  "B" },
	{ 106,  "A0" },
	{ 108,  "A" },
	{ 125,  "B" },
	{ 146,  "A0" },
	{ 148,  "A" },
	{ 165,  "B" },
	{ 186,  "A0" },
	{ 188,  "A" },
	{ 205,  "B" },
	{ 226,  "A0" },
	{ 228,  "A" },
	{ 245,  "B" },
	{ 266,  "A0" },
	{ 268,  "A" },
	{ 285,  "B" },
	{ 300, "E" },
}


--AI Index....
x892011_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x892011_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x892011_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x892011_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--入口函数
--**********************************
function x892011_OnDefaultEvent( sceneId, selfId, targetId )
	CallScriptFunction(892009,"RefreshNewMonster",sceneId,selfId,targetId);
end


--**********************************
--初始化....
--**********************************
function x892011_OnInit(sceneId, selfId)
	--重置AI....
	x892011_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x892011_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892011_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892011_IDX_IsKuangBaoMode ) then
		return
	end

	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892011_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892011_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892011_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x892011_UseSkillList ) then
		return
	end

	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x892011_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData[1]*1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x892011_IDX_UseSkillIndex, NextSkillIndex+1 )
		x892011_UseMySkill( sceneId, selfId, SkillData[2] )
	end

end

--**********************************
--进入战斗....
--**********************************
function x892011_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892011_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892011_Buff_MianYi2, 0 )

	--重置AI....
	x892011_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892011_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x892011_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x892011_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀死敌人....
--**********************************
function x892011_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x892011_OnDie( sceneId, selfId, killerId )

	--取得当前场景里的人数
	--物品掉落
	CallScriptFunction(x892011_g_FuBenScriptId,"OnDropBoxFromBoss",sceneId,selfId,2);

	if killmosternum == nil then
	     killmosternum = 3
	else
	     killmosternum = killmosternum + 1
	end
	if  killmosternum ~= nil and killmosternum <= 7 then
	     CallScriptFunction(x892011_g_FuBenScriptId,"SetFubenTimer",sceneId, killmosternum,1)
	end 
	if killmosternum == 8 then
	    killmosternum = nil
	    LuaFnSetCopySceneData_Param(sceneId, 4, 1)
		--给玩家活动数值变动
		CallScriptFunction(x892011_g_FuBenScriptId,"AddPlayerPrize",sceneId);
	end 
end


--**********************************
--重置AI....
--**********************************
function x892011_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892011_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892011_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892011_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892011_IDX_CombatFlag, 0 )

	--清除buff....
	LuaFnCancelSpecificImpact( sceneId, selfId, x892011_Buff_E1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892011_Buff_E2 )

end

--**********************************
--BOSS使用技能....
--**********************************
function x892011_UseMySkill( sceneId, selfId,skill )
	--温馨提示
	CallScriptFunction(x892011_g_FuBenScriptId,"TipAllHuman",sceneId,"#{SXRW_090119_155}");
	
	if skill == "A0" then  ----这里以后加聚气
        LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090119_072}")
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,8887,0)
	elseif skill == "A" then  ----提示玩家找生门
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090119_143}")
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,8877,0)
	elseif skill == "B" then
	    LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_115}")
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,8878,0)
	elseif skill == "E" then
        MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892011_IDX_IsKuangBaoMode, 1 )
	    x892011_SkillE_KuangBao( sceneId, selfId )
	end
end

--**********************************
--狂暴技能....
--**********************************
function x892011_SkillE_KuangBao( sceneId, selfId )
	--加狂暴buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892011_Buff_E1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892011_Buff_E2, 0 )
end

--**********************************
--对话框提示
--**********************************
function x892011_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

