--花肥脚本

--脚本号
x335705_g_scriptId = 335705 --临时写这个,真正用的时候一定要改.

--需要的等级
x335705_g_levelRequire = 1
--AE范围半径
x335705_g_radiusAE = 3.0
--AE的目标关系标记
x335705_g_standFlag = 1 -- 2:队友， 1：友军， -1：敌军
--AE影响数目限制
x335705_g_effectCount = 4 -- -1:不限制
--效果的ID
x335705_g_Impact1 = 3216 --临时写这个
x335705_g_Impact2 = -1 --不用

--**********************************
--事件交互入口
--**********************************
function x335705_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x335705_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x335705_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x335705_OnConditionCheck( sceneId, selfId )

    if sceneId~=2 then
        BeginEvent( sceneId )
		AddText( sceneId, "只能在大理东大街或者西大街才能对鲜花施肥" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
        return 0
    end
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	local MonsterID = GetMonsterDataID(sceneId,targetId)
    if MonsterID~=90 and MonsterID~=91 and MonsterID~=92 then
	    BeginEvent( sceneId )
		AddText( sceneId, "只能对未成熟的花苗使用此物品" )
	    EndEvent( sceneId )
	    DispatchMissionTips( sceneId, selfId )
	    return 0;
    end
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x335705_OnDeplete( sceneId, selfId )
	if(LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 0;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x335705_OnActivateOnce( sceneId, selfId )

    if sceneId==2 then
	    x335705_OnImpactFadeOut( sceneId, selfId )
	else
		BeginEvent( sceneId )
			AddText( sceneId, "物品使用失败，请联系雄霸天龙运营团队！" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
	end
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x335705_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
--施肥成功：
--**********************************
function x335705_OnImpactFadeOut( sceneId, selfId )

	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	local MonsterID = GetMonsterDataID(sceneId,targetId)
    local ownerGUID = LuaFnGetLifeTimeAttrRefix_AttackPhysics( sceneId, targetId )
	local ownerObjId = LuaFnGuid2ObjId(sceneId, ownerGUID);---通过GUID得到objID
	if ownerGUID ~= nil then
           ownerName = GetName(sceneId, ownerObjId);     ----得到佣有者名字
        else
     	   ownerName = tostring("野生")
     	end     	     		 
        local x, z = GetWorldPos(sceneId, targetId) 		   
 	LuaFnDeleteMonster(sceneId, targetId)
--先给经验
    MyLevel=GetLevel( sceneId, selfId )
	BeginEvent( sceneId )
        AddText( sceneId, "施肥成功" )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
    LuaFnAddExp( sceneId,selfId,MyLevel*500)
--花苗升级
    if MonsterID ==90 or MonsterID==91 then
 		local MonsterId = LuaFnCreateMonster(sceneId, MonsterID+1, x, z, 3, -1,335701)
		LuaFnSetLifeTimeAttrRefix_AttackPhysics( sceneId, MonsterId, ownerGUID )
		SetCharacterName(sceneId, MonsterId, ""..ownerName.."的鲜花幼苗")
		SetCharacterDieTime(sceneId, MonsterId, 1800000)
        LuaFnSendSpecificImpactToUnit(sceneId, MonsterId, MonsterId, MonsterId, 18, 0);
    elseif MonsterID ==92 then
 		local MonsterId = LuaFnCreateMonster(sceneId, MonsterID+1, x, z, 3, -1,335704)
 		--local Cmanstid = mod(LuaFnGetCurrentTime(),10000)+300
 		--SetUnitCampID(sceneId,MonsterId, MonsterId, Cmanstid)
 		LuaFnSetLifeTimeAttrRefix_AttackPhysics( sceneId, MonsterId, ownerGUID )            ----保存GUID，
 	    LuaFnSetLifeTimeAttrRefix_DefencePhysics( sceneId, MonsterId, (LuaFnGetCurrentTime()+300) )  ---保存五分钟
        SetCharacterName(sceneId, MonsterId, ""..ownerName.."的成熟鲜花")
		SetCharacterDieTime(sceneId, MonsterId, 600000)
		LuaFnSendSpecificImpactToUnit(sceneId, MonsterId, MonsterId, MonsterId, 18, 0);
		LuaFnSendSystemMail(sceneId, GetName(sceneId,ownerObjId), "您在大理#G("..(floor(x))..","..(floor(z))..")#W种植的#G鲜花已成熟#W,请在#G5分钟#W内采摘，否则可能会被盗采哦")
	 end
end	

