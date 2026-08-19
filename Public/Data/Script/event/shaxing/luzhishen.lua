--赤砂之蝎
--生死擂台·鲁智深

--脚本号
x892017_g_ScriptId	= 892017

--副本逻辑脚本号....
x892017_g_FuBenScriptId = 892009

--buff....
x892017_Buff_MianYi1	= 10472	--免疫一些负面效果....
x892017_Buff_MianYi2	= 10471	--免疫普通隐身....

x892017_Buff_E1			= 10234
x892017_Buff_E2			= 10235

--技能释放时间表....
x892017_UseSkillList =
{
	{ 28,  "A" },
	{ 45,  "B" },
	{ 68,  "A" },
	{ 85,  "B" },
	{ 108,  "A" },
	{ 125,  "B" },
	{ 148,  "A" },
	{ 165,  "B" },
	{ 188,  "A" },
	{ 205,  "B" },
	{ 228,  "A" },
	{ 245,  "B" },
	{ 268,  "A" },
	{ 285,  "B" },
	{ 300, "E" }
}


--AI Index....
x892017_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x892017_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x892017_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x892017_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

--**********************************
--入口函数
--**********************************
function x892017_OnDefaultEvent( sceneId, selfId, targetId )
	CallScriptFunction(892009,"RefreshNewMonster",sceneId,selfId,targetId);
end

--**********************************
--初始化....
--**********************************
function x892017_OnInit(sceneId, selfId)
	--重置AI....
	x892017_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x892017_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892017_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892017_IDX_IsKuangBaoMode ) then
		return
	end

	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892017_IDX_CombatTime )
	local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892017_IDX_UseSkillIndex )
	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892017_IDX_CombatTime, CombatTime + nTick )

	--如果已经执行完整张技能表则不使用技能....
	if NextSkillIndex < 1 or NextSkillIndex > getn( x892017_UseSkillList ) then
		return
	end

	--如果已经到了用这个技能的时间则使用技能....
	local SkillData = x892017_UseSkillList[NextSkillIndex]
	if ( CombatTime + nTick ) >= SkillData[1]*1000 then
		MonsterAI_SetIntParamByIndex( sceneId, selfId, x892017_IDX_UseSkillIndex, NextSkillIndex+1 )
		x892017_UseMySkill( sceneId, selfId, SkillData[2] )
	end

end

--**********************************
--进入战斗....
--**********************************
function x892017_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892017_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892017_Buff_MianYi2, 0 )

	--重置AI....
	x892017_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892017_IDX_CombatFlag, 1 )

	--发表讲话
	LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090119_090}")
end


--**********************************
--离开战斗....
--**********************************
function x892017_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x892017_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀死敌人....
--**********************************
function x892017_OnKillCharacter(sceneId, selfId, targetId)
    local objType = GetCharacterType( sceneId, targetId )
	if objType == 3 then --objType等于1是人，objType等于2是怪，objType等于3是宠	
		local Hp,MaxHp = GetHp( sceneId, selfId ),GetMaxHp( sceneId, selfId )
		if Hp <= MaxHp*0.9 then
			SetHp( sceneId, selfId,(Hp+MaxHp*0.1) )
		end
	end
end


--**********************************
--死亡....
--**********************************
function x892017_OnDie( sceneId, selfId, killerId )

	--取得当前场景里的人数
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
    --物品掉落
	CallScriptFunction(x892017_g_FuBenScriptId,"OnDropBoxFromBoss",sceneId,selfId,11);

	if killmosternum == nil then
	    killmosternum = 3
	else
	    killmosternum = killmosternum + 1
	end
	if  killmosternum ~= nil and killmosternum <= 7 then
	    CallScriptFunction(x892017_g_FuBenScriptId,"SetFubenTimer",sceneId, killmosternum,1)
	end 
	if killmosternum == 8 then
	    killmosternum = nil
	    LuaFnSetCopySceneData_Param(sceneId, 4, 1)
		--给玩家活动数值变动
		CallScriptFunction(x892017_g_FuBenScriptId,"AddPlayerPrize",sceneId);
	end 
end


--**********************************
--重置AI....
--**********************************
function x892017_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892017_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892017_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892017_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892017_IDX_CombatFlag, 0 )

	--清除buff....
	LuaFnCancelSpecificImpact( sceneId, selfId, x892017_Buff_E1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892017_Buff_E2 )

end

--**********************************
--BOSS使用技能....
--**********************************
function x892017_UseMySkill( sceneId, selfId,skill )
	--温馨提示
	CallScriptFunction(x892017_g_FuBenScriptId,"TipAllHuman",sceneId,"#{SXRW_090119_157}");
	
	if skill == "A" then  ----提示玩家找生门
		LuaFnNpcChat(sceneId, selfId, 0, "洒家的护体真气，岂是你们这些人可以攻破的！")
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, 1763, selfId, x, z, 0, 1 )	--使用空技能....
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,8879,0)    ------这里加上孤芳自赏buff
	elseif skill == "B" then
		local x,z = GetWorldPos( sceneId, selfId )
		LuaFnUnitUseSkill( sceneId, selfId, 1763, selfId, x, z, 0, 1 )	--使用空技能....
	    LuaFnNpcChat(sceneId, selfId, 0, "怎么回事？我的生命一直在流逝。枯荣，又是你这个爱管闲事的家伙在背后害我！")
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,8880,0)
    end
end

--**********************************
--狂暴技能....
--**********************************
function x892017_SkillE_KuangBao( sceneId, selfId )
	--加狂暴buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892017_Buff_E1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892017_Buff_E2, 0 )
end

--**********************************
--对话框提示
--**********************************
function x892017_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

