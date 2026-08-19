--注意：
--物品技能的逻辑只能使用基础技能和脚本来实现
--脚本:
--以下是脚本样例:
------------------------------------------------------------------------------------------
--一般物品的默认脚本

--脚本号
x340014_g_scriptId = 340014 --临时写这个,真正用的时候一定要改.

--需要的等级
x340014_g_levelRequire = 1
--AE范围半径
x340014_g_radiusAE = 3.0
--AE的目标关系标记
x340014_g_standFlag = 1 -- 2:队友， 1：友军， -1：敌军
--AE影响数目限制
x340014_g_effectCount = 4 -- -1:不限制
--效果的ID
x340014_g_Impact1 = {
	[30101175] =2715,
	[30101176] =2717,
	[30101177] =2717,
	[30101178] =2715,
	[30102031] =2719,
	[30102032] =2720,
	[30102033] =2721,
	[30102034] =2722,
	[30102035] =2723,
	[30102036] =2724,
	[30102037] =2725,
	[30102038] =2726,
	[30102039] =-1,
	[30102040] =2728,
	[30102041] =2729,
	[30102042] =-1,
	[30102043] =2732,
	[30102044] =2733,
	[30102045] =-1,
	[30102046] =2730,
	[30102047] =2731,
	[30102048] =-1,
	[30102049] =2734,
	[30102050] =2735,
	[30102051] =-1,
	[30102052] =2736,
	[30102053] =2737,
	[30102054] =-1,
	[30102055] =2738,
	[30102056] =2739,
	[30102057] =-1,
	[30102058] =2740,
	[30102059] =2741,
	[30102060] =-1,
} --临时写这个
x340014_g_Impact2 = -1 --不用

--**********************************
--事件交互入口
--**********************************
function x340014_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x340014_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x340014_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x340014_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	if(0<=targetId) then
		-- 目标必须是友军的检测
		if(1~=LuaFnUnitIsFriend(sceneId, selfId, targetId)) then
			SendOResultToPlayer(sceneId, selfId, OR_INVALID_TARGET)
			return 0;
		end
	end
	
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x340014_OnDeplete( sceneId, selfId )
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
function x340014_OnActivateOnce( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	
	if(x340014_g_Impact1[itemTblIndex] ~= -1 and x340014_g_Impact1[itemTblIndex] ~= nil ) then
		--给目标加效果
		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
		if(0<=targetId) then
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, targetId, x340014_g_Impact1[itemTblIndex], 0);
		end
	else
		BeginEvent( sceneId )
			AddText( sceneId, "#{GCPickResultHandler_2}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		return 0;
	end
	return 1;
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x340014_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end
