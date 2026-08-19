--赤砂之蝎
--生死擂台·花容
--2019-10-22 15:44:08 逍遥子二开
--A 【天罡阵】降低玩家移动速度
--B 【地煞阵】降低玩家命中
--C 【人亡阵】直接伤害10%
--D 【强化阵】强化玩家内外攻击
--E 【狂暴】给自己加一击致命buff....

--全程都带有免疫制定技能的buff....
--20秒后开始使用A技能....冷却20秒....
--25秒后开始循环释放BCD技能....冷却分别是20..20..30....
--5分钟后进入狂暴模式....停止使用ABCD....清除ABCD的buff....使用E技能....

--脚本号
x892013_g_ScriptId	= 892013

--副本逻辑脚本号....
x892013_g_FuBenScriptId = 892009

--buff....
x892013_Buff_MianYi1	= 10472	--免疫一些负面效果....
x892013_Buff_MianYi2	= 10471	--免疫普通隐身....
x892013_Skill_A		= 1759
x892013_SkillA_SpecObj	= 128
x892013_Skill_B		= 1760
x892013_SkillB_SpecObj	= 129
x892013_Skill_C		= 1761
x892013_SkillC_SpecObj	= 130
x892013_Skill_D		= 1762
x892013_SkillD_SpecObj	= 131
x892013_Buff_E1			= 10234
x892013_Buff_E2			= 10235

--技能释放时间表....
x892013_UseSkillList =
{
	{ 20,  "A" },
	{ 25,  "B" },
	{ 40,  "A" },
	{ 45,  "C" },
	{ 60,  "A" },
	{ 65,  "D" },
	{ 61,  "D1" },
	{ 80,  "A" },
	{ 95,  "B" },
	{ 100, "A" },
	{ 115, "C" },
	{ 120, "A" },
	{ 135, "D" },
	{ 136,  "D1" },
	{ 140, "A" },
	{ 160, "A" },
	{ 165, "B" },
	{ 180, "A" },
	{ 185, "C" },
	{ 200, "A" },
	{ 205, "D" },
	{ 206,  "D1" },
	{ 220, "A" },
	{ 235, "B" },
	{ 240, "A" },
	{ 255, "C" },
	{ 260, "A" },
	{ 275, "D" },
	{ 276,  "D1" },
	{ 280, "A" },
	{ 300, "E" }
}


--AI Index....
x892013_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x892013_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x892013_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x892013_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--入口函数
--**********************************
function x892013_OnDefaultEvent( sceneId, selfId, targetId )
	CallScriptFunction(892009,"RefreshNewMonster",sceneId,selfId,targetId);
end

--**********************************
--初始化....
--**********************************
function x892013_OnInit(sceneId, selfId)
	--重置AI....
	x892013_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x892013_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892013_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892013_IDX_IsKuangBaoMode ) then
		return
	end

	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892013_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892013_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892013_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x892013_UseSkillList ) then
		return
	end

	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x892013_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData[1]*1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x892013_IDX_UseSkillIndex, NextSkillIndex+1 )
		x892013_UseMySkill( sceneId, selfId, SkillData[2] )
	end

end

--**********************************
--进入战斗....
--**********************************
function x892013_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892013_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892013_Buff_MianYi2, 0 )

	--重置AI....
	x892013_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892013_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x892013_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x892013_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀掉对象
--**********************************
function x892013_OnKillCharacter(sceneId, selfId, targetId)

end

--**********************************
--死亡事件
--**********************************
function x892013_OnDie( sceneId, selfId, killerId )

	--物品掉落
	CallScriptFunction(x892013_g_FuBenScriptId,"OnDropBoxFromBoss",sceneId,selfId,9);
	
	if killmosternum == nil then
	    killmosternum = 3
	else
	    killmosternum = killmosternum + 1
	end
	if  killmosternum ~= nil and killmosternum <= 7 then
	    CallScriptFunction(x892013_g_FuBenScriptId,"SetFubenTimer",sceneId, killmosternum,1)
	end 
	if killmosternum == 8 then
	    killmosternum = nil
	    LuaFnSetCopySceneData_Param(sceneId, 4, 1)
		--给玩家活动数值变动
		CallScriptFunction(x892013_g_FuBenScriptId,"AddPlayerPrize",sceneId);
	end 

end


--**********************************
--重置AI....
--**********************************
function x892013_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892013_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892013_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892013_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892013_IDX_CombatFlag, 0 )

	--清除buff....
	LuaFnCancelSpecificImpact( sceneId, selfId, x892013_Buff_E1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892013_Buff_E2 )

end


--**********************************
--BOSS使用技能....
--**********************************
function x892013_UseMySkill( sceneId, selfId, skill )

	if skill == "A" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_123}")
		local x,z = GetWorldPos( sceneId, selfId )
		local a,b = random(3)-random(3),random(3)-random(3)
		LuaFnUnitUseSkill( sceneId, selfId, x892013_Skill_A, selfId, x, z, 0, 1 )	--使用空技能....
		CreateSpecialObjByDataIndex(sceneId, selfId, x892013_SkillA_SpecObj, x+a, z+b, 0)
		CallScriptFunction(x892013_g_FuBenScriptId,"TipAllHuman",sceneId,"#{SXRW_090119_164}");
	elseif skill == "B" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_124}")
		local x,z = GetWorldPos( sceneId, selfId )
		local a,b = random(3)-random(3),random(3)-random(3)
		LuaFnUnitUseSkill( sceneId, selfId, x892013_Skill_B, selfId, x, z, 0, 1 )	--使用空技能....
		CreateSpecialObjByDataIndex(sceneId, selfId, x892013_SkillB_SpecObj, x+a, z+b, 0)
		CallScriptFunction(x892013_g_FuBenScriptId,"TipAllHuman",sceneId,"#{SXRW_090119_164}");
	elseif skill == "C" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_125}")
		local x,z = GetWorldPos( sceneId, selfId )
		local a,b = random(3)-random(3),random(3)-random(3)
		LuaFnUnitUseSkill( sceneId, selfId, x892013_Skill_C, selfId, x, z, 0, 1 )	--使用空技能....
		CreateSpecialObjByDataIndex(sceneId, selfId, x892013_SkillC_SpecObj, x+a, z+b, 0)
		CallScriptFunction(x892013_g_FuBenScriptId,"TipAllHuman",sceneId,"#{SXRW_090119_164}");
	elseif skill == "D" then
		LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090630_126}")
		local x,z = GetWorldPos( sceneId, selfId )
		local a,b = random(3)-random(3),random(3)-random(3)
		LuaFnUnitUseSkill( sceneId, selfId, x892013_Skill_D, selfId, x, z, 0, 1 )	--使用空技能....
		CreateSpecialObjByDataIndex(sceneId, selfId, x892013_SkillD_SpecObj, x+a, z+b, 0)
	elseif skill == "D1" then
		
	elseif skill == "E" then
		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892013_IDX_IsKuangBaoMode, 1 )
		x892013_SkillE_KuangBao( sceneId, selfId )
	end

end

--**********************************
--狂暴技能....
--**********************************
function x892013_SkillE_KuangBao( sceneId, selfId )

	--取消BCD的buff....
	LuaFnCancelSpecificImpact( sceneId, selfId, x892013_Buff_B )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892013_Buff_C )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892013_Buff_D )

	--加狂暴buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892013_Buff_E1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892013_Buff_E2, 0 )
end

--**********************************
--对话框提示
--**********************************
function x892013_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

