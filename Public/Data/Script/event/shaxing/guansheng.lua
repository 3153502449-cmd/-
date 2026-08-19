--赤砂之蝎
--生死擂台·关盛
--2019-10-22 15:49:33 逍遥子二开

--A 【灭世刀阵发招前提示】
--B 【释放灭世刀阵】

--全程都带有免疫制定技能的buff....
--20秒后开始使用A技能....冷却20秒....
--25秒后开始循环释放BCD技能....冷却分别是20..20..30....
--5分钟后进入狂暴模式....停止使用ABCD....清除ABCD的buff....使用E技能....

--脚本号
x892010_g_ScriptId	= 892010

--副本逻辑脚本号....
x892010_g_FuBenScriptId = 892009

--buff....
x892010_Buff_MianYi1	= 10472	--免疫一些负面效果....
x892010_Buff_MianYi2	= 10471	--免疫普通隐身....

x892010_Buff_E1			= 10234
x892010_Buff_E2			= 10235

--技能释放时间表....
x892010_UseSkillList =
{
	{ 28,  "A" },
	{ 29,  "A1" },
	{ 30,  "B" },
	{ 58,  "A" },
	{ 59,  "A1" },
	{ 60,  "B" },
	{ 88,  "A" },
	{ 89,  "A1" },
	{ 90,  "B" },
	{ 118,  "A" },
	{ 119,  "A1" },
	{ 120,  "B" },
	{ 148,  "A" },
	{ 149,  "A1" },
	{ 150,  "B" },
	{ 178,  "A" },
	{ 179,  "A1" },
	{ 180,  "B" },
	{ 208,  "A" },
	{ 209,  "A1" },
	{ 210,  "B" },
	{ 238,  "A" },
	{ 239,  "A1" },
	{ 240,  "B" },
	{ 268,  "A" },
	{ 269,  "A1" },
	{ 270,  "B" },
	{ 300, "E" }
}


--AI Index....
x892010_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x892010_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x892010_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x892010_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--入口函数
--**********************************
function x892010_OnDefaultEvent( sceneId, selfId, targetId )
	CallScriptFunction(892009,"RefreshNewMonster",sceneId,selfId,targetId);
end

--**********************************
--初始化....
--**********************************
function x892010_OnInit(sceneId, selfId)
	--重置AI....
	x892010_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x892010_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892010_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892010_IDX_IsKuangBaoMode ) then
		return
	end

	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892010_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892010_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892010_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x892010_UseSkillList ) then
		return
	end

	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x892010_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData[1]*1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x892010_IDX_UseSkillIndex, NextSkillIndex+1 )
		x892010_UseMySkill( sceneId, selfId, SkillData[2] )
	end

end

--**********************************
--进入战斗....
--**********************************
function x892010_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892010_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892010_Buff_MianYi2, 0 )

	--重置AI....
	x892010_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892010_IDX_CombatFlag, 1 )

end


--**********************************
--离开战斗....
--**********************************
function x892010_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x892010_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--?彼赖腥?...
--**********************************
function x892010_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x892010_OnDie( sceneId, selfId, killerId )

	--物品掉落
	CallScriptFunction(x892010_g_FuBenScriptId,"OnDropBoxFromBoss",sceneId,selfId,6);
	
	if killmosternum == nil then
	    killmosternum = 3
	else
	    killmosternum = killmosternum + 1
	end
	if  killmosternum ~= nil and killmosternum <= 7 then
	    CallScriptFunction(x892010_g_FuBenScriptId,"SetFubenTimer",sceneId, killmosternum,1)
	end 
	if killmosternum == 8 then
	    killmosternum = nil
	    LuaFnSetCopySceneData_Param(sceneId, 4, 1)
		--给玩家活动数值变动
		CallScriptFunction(x892010_g_FuBenScriptId,"AddPlayerPrize",sceneId);
	end 

end


--**********************************
--重置AI....
--**********************************
function x892010_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892010_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892010_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892010_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892010_IDX_CombatFlag, 0 )

	--清除buff....
	LuaFnCancelSpecificImpact( sceneId, selfId, x892010_Buff_E1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892010_Buff_E2 )

end


--**********************************
--BOSS使用技能....
--**********************************
function x892010_UseMySkill( sceneId, selfId, skill )

	if skill == "A" then  ----提示玩家找生门
		CallScriptFunction(x892010_g_FuBenScriptId,"TipAllHuman",sceneId,"#{SXRW_090119_158}");
	elseif skill == "A1" then
		local x,z = GetWorldPos( sceneId, selfId )
		local a,b = random(3)-random(3),random(3)-random(3)
		LuaFnUnitUseSkill( sceneId, selfId, 1756, selfId, x, z, 0, 1 )	--使用空技能....生门
	    local i
        local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
        for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
				local PlayerX,PlayerZ = GetWorldPos( sceneId, nHumanId )
				Distance = floor(sqrt((x-PlayerX)*(x-PlayerX)+(z-PlayerZ)*(z-PlayerZ)))
				if Distance < 5 then
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, nHumanId, 8872, 0)
	            end
        end
	elseif skill == "B" then
	    LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090119_146}")
        local x,z = GetWorldPos( sceneId, selfId )
        LuaFnUnitUseSkill( sceneId, selfId, 1757, selfId, x, z, 0, 1 )	--使用空技能....
	    local i
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i=0, nHumanCount-1 do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
			if LuaFnHaveImpactOfSpecificDataIndex(sceneId, nHumanId, 8872 ) ~= 1 then
				SetHp( sceneId, nHumanId,GetMaxHp( sceneId, nHumanId )*0.8 )
			end
        end

	elseif skill == "E" then
		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892010_IDX_IsKuangBaoMode, 1 )
		x892010_SkillE_KuangBao( sceneId, selfId )
	end

end

--**********************************
--狂暴技能....
--**********************************
function x892010_SkillE_KuangBao( sceneId, selfId )

	--取消BCD的buff....

	--加狂暴buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892010_Buff_E1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892010_Buff_E2, 0 )
end

--**********************************
--对话框提示
--**********************************
function x892010_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

