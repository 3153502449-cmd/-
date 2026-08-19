--赤砂之蝎
--生死擂台·吴永
--2019-10-22 14:50:21 逍遥子二开

--脚本号
x892015_g_ScriptId	= 892015

--副本逻辑脚本号....
x892015_g_FuBenScriptId = 892009

--buff....
x892015_Buff_MianYi1	= 10472	--免疫一些负面效果....
x892015_Buff_MianYi2	= 10471	--免疫普通隐身....

x892015_Buff_E1			= 10234
x892015_Buff_E2			= 10235

--AI Index....
x892015_IDX_CombatTime		= 1	--进入战斗的计时器....用于记录已经进入战斗多长时间了....
x892015_IDX_UseSkillIndex	= 2	--接下来该使用技能表中的第几个技能....

x892015_IDX_CombatFlag 			= 1	--是否处于战斗状态的标志....
x892015_IDX_IsKuangBaoMode	= 2	--是否处于狂暴模式的标志....

x892015_DogName = {"黄色妖星","红色妖星","紫色妖星"}
x892015_BossTalk = {"#{SXRW_090630_111}","#{SXRW_090630_113}","#{SXRW_090630_112}"}
x892015_DogID = {13541,13542,13543,13544,13545,13546}
x892015_BossID = {13451,13452,13453,13454,13455,13456}

--**********************************
--入口函数
--**********************************
function x892015_OnDefaultEvent( sceneId, selfId, targetId )
	CallScriptFunction(892009,"RefreshNewMonster",sceneId,selfId,targetId);
end


--**********************************
--初始化....
--**********************************
function x892015_OnInit(sceneId, selfId)
	--重置AI....
	x892015_ResetMyAI( sceneId, selfId )
end

--**********************************
--心跳....
--**********************************
function x892015_OnHeartBeat(sceneId, selfId, nTick)

	--检测是不是死了....
	if LuaFnIsCharacterLiving(sceneId, selfId) ~= 1 then
		return
	end

	--检测是否不在战斗状态....
	if 0 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892015_IDX_CombatFlag ) then
		return
	end

	--狂暴状态不需要走逻辑....
	if 1 == MonsterAI_GetBoolParamByIndex( sceneId, selfId, x892015_IDX_IsKuangBaoMode ) then
		return
	end

	--==================================
	--根据节目单释放技能....
	--==================================

	--获得战斗时间和已经执行到技能表中的第几项....
	local CombatTime = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892015_IDX_CombatTime )
    local NextSkillIndex = MonsterAI_GetIntParamByIndex( sceneId, selfId, x892015_IDX_UseSkillIndex )

	--累加进入战斗的时间....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892015_IDX_CombatTime, CombatTime + nTick )

	--如果已经到了用这个技能的时间则使用技能....
	if (CombatTime+nTick) < 300*1000 then
        if  (CombatTime+nTick) >= NextSkillIndex*20000 then
			local TeamLev = floor(LuaFnGetCopySceneData_Param(sceneId,31)/10)-6
			local nMonsterNum = GetMonsterCount(sceneId)
			local jiance = 0
			for j=0, nMonsterNum-1 do
				local MonsterId = GetMonsterObjID(sceneId,j)
				local MosDataID = GetMonsterDataID(sceneId, MonsterId )
				if MosDataID == x892015_DogID[TeamLev] then
					jiance = 1
					break
				end
			end
			if jiance == 1 then  --有小怪则返回
				return
			end

			if  LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId,8873) == 1 then
				return
			end
			MonsterAI_SetIntParamByIndex( sceneId, selfId, x892015_IDX_UseSkillIndex, NextSkillIndex+1 )
			x892015_UseMySkill( sceneId, selfId )
		end
    else
		MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892015_IDX_IsKuangBaoMode, 1 )
		x892015_SkillE_KuangBao( sceneId, selfId )
	end
end

--**********************************
--进入战斗....
--**********************************
function x892015_OnEnterCombat(sceneId, selfId, enmeyId)

	--加初始buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892015_Buff_MianYi1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892015_Buff_MianYi2, 0 )

	--重置AI....
	x892015_ResetMyAI( sceneId, selfId )

	--设置进入战斗状态....
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892015_IDX_CombatFlag, 1 )
	
	--发表讲话
	LuaFnNpcChat(sceneId, selfId, 0, "#{SXRW_090119_073}")
end


--**********************************
--离开战斗....
--**********************************
function x892015_OnLeaveCombat(sceneId, selfId)

	--重置AI....
	x892015_ResetMyAI( sceneId, selfId )

	--满血自己....
    SetHp(sceneId,selfId,GetMaxHp(sceneId,selfId))

end


--**********************************
--杀死敌人....
--**********************************
function x892015_OnKillCharacter(sceneId, selfId, targetId)

end


--**********************************
--死亡....
--**********************************
function x892015_OnDie( sceneId, selfId, killerId )

	--取得当前场景里的人数
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
	--物品掉落
	CallScriptFunction(x892015_g_FuBenScriptId,"OnDropBoxFromBoss",sceneId,selfId,3);

	if killmosternum == nil then
	     killmosternum = 3
	else
	     killmosternum = killmosternum + 1
	end
	if  killmosternum ~= nil and killmosternum <= 7 then
	     CallScriptFunction(x892015_g_FuBenScriptId,"SetFubenTimer",sceneId, killmosternum,1)
	end 
	if killmosternum == 8 then
	    killmosternum = nil
	    LuaFnSetCopySceneData_Param(sceneId, 4, 1)
		--给玩家活动数值变动
		CallScriptFunction(x892015_g_FuBenScriptId,"AddPlayerPrize",sceneId);
	end 
end


--**********************************
--重置AI....
--**********************************
function x892015_ResetMyAI( sceneId, selfId )

	--重置参数....
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892015_IDX_CombatTime, 0 )
	MonsterAI_SetIntParamByIndex( sceneId, selfId, x892015_IDX_UseSkillIndex, 1 )

	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892015_IDX_IsKuangBaoMode, 0 )
	MonsterAI_SetBoolParamByIndex( sceneId, selfId, x892015_IDX_CombatFlag, 0 )

	--清除buff....
	LuaFnCancelSpecificImpact( sceneId, selfId, x892015_Buff_E1 )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892015_Buff_E2 )

end

--**********************************
--BOSS使用技能....
--**********************************
function x892015_UseMySkill( sceneId, selfId )
	--温馨提示
	CallScriptFunction(892009,"TipAllHuman",sceneId,"#{SXRW_090119_162}");
	local Dogyes = random(3)
	LuaFnNpcChat(sceneId, selfId, 0, x892015_BossTalk[Dogyes])
	local x,z = GetWorldPos( sceneId, selfId )
	CreateSpecialObjByDataIndex(sceneId, selfId, 133, x, z, 0)
	local TeamLev = floor(LuaFnGetCopySceneData_Param(sceneId,31)/10)-6
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 8873, 0)
	for i = 1,3 do
		local a,b = random(3) - random(3),random(3)-random(3)
		local Dog_ScriptId = 892023
		if i == Dogyes then
			Dog_ScriptId = 892022
		end
		local objId = LuaFnCreateMonster(sceneId, x892015_DogID[TeamLev],x+a,z+b, 19, 0, Dog_ScriptId )
		SetUnitReputationID(sceneId, objId, objId, 28)
		SetCharacterName( sceneId, objId, x892015_DogName[i] )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, objId, 8873+i, 0)
	end
end

--**********************************
--小怪杀对了吗....
--**********************************
function x892015_KillDog(sceneId,Check)

	if Check == 1 then
		local TeamLev = floor(LuaFnGetCopySceneData_Param(sceneId,31)/10)-6
		local nMonsterNum = GetMonsterCount(sceneId)
		local jiance = 0
		for j=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,j)
			local MosDataID = GetMonsterDataID(sceneId, MonsterId )
			if MosDataID == x892015_DogID[TeamLev] then
				LuaFnDeleteMonster( sceneId, MonsterId )  --删除小怪
			end
		end
		for k=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,k)
			local MosDataID = GetMonsterDataID(sceneId, MonsterId )
			if MosDataID == x892015_BossID[TeamLev] then
				LuaFnNpcChat(sceneId, MonsterId, 0, "#{SXRW_090630_120}")
				local Hp,MaxHp = GetHp( sceneId, MonsterId ),GetMaxHp( sceneId, MonsterId )
				if Hp > MaxHp*0.1 then
					SetHp( sceneId, MonsterId,(Hp-MaxHp*0.1) )
				end
				break
			end
		end
		Check = 0
		return
	elseif Check == 0 then
		local TeamLev = floor(LuaFnGetCopySceneData_Param(sceneId,31)/10)-6
		local nMonsterNum = GetMonsterCount(sceneId)
		local jiance = 0
		for j=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,j)
			local MosDataID = GetMonsterDataID(sceneId, MonsterId )
			if MosDataID == x892015_DogID[TeamLev] then
				LuaFnCancelSpecificImpact( sceneId, selfId, 8873 )
				LuaFnDeleteMonster( sceneId, MonsterId )  --删除小怪
			end
		end
		for k=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,k)
			local MosDataID = GetMonsterDataID(sceneId, MonsterId )
			if MosDataID == x892015_BossID[TeamLev] then
				LuaFnNpcChat(sceneId, MonsterId, 0, "#{SXRW_090630_121}")
				LuaFnSendSpecificImpactToUnit(sceneId, MonsterId, MonsterId, MonsterId, 8873, 0)
				break
			end
		end
		return
	end
end

--**********************************
--狂暴技能....
--**********************************
function x892015_SkillE_KuangBao( sceneId, selfId )

	--取消BCD的buff....
	LuaFnCancelSpecificImpact( sceneId, selfId, x892015_Buff_B )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892015_Buff_C )
	LuaFnCancelSpecificImpact( sceneId, selfId, x892015_Buff_D )

	--加狂暴buff....
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892015_Buff_E1, 0 )
	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, x892015_Buff_E2, 0 )
end

--**********************************
--对话框提示
--**********************************
function x892015_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

