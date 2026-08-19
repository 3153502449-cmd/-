--注意：

--物品技能的逻辑只能使用基础技能和脚本来实现

--脚本:

--以下是脚本样例:


--obj_71.lua
------------------------------------------------------------------------------------------
--一般物品的默认脚本

--脚本号
x890130_g_scriptId = 890130 --临时写这个,真正用的时候一定要改.

--需要的等级

--**********************************
--事件交互入口
--**********************************
function x890130_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x890130_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x890130_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x890130_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	local bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	
	if itemTblIndex ~= 38000640 and itemTblIndex ~= 38000641 then
		x890130_NotifyTip( sceneId, selfId,"道具内部错误")
		return 0
	end
	
	if GetMissionDataEx(sceneId,selfId,MD_ZAOHUADAN_USE_NUM) >= 3 then
		x890130_NotifyTip( sceneId, selfId,"#{LZZHD_130520_48}")
		return 0
	end
	
	if GetLevel(sceneId,selfId) < 70 then
		x890130_NotifyTip( sceneId, selfId,"您的等级尚未达到70级，无法使用")
		return 0
	end
	--今日杀怪数量检测
	if GetMissionData(sceneId,selfId,XYJ_DAY_KILL) > 9000 then
		x890130_NotifyTip( sceneId, selfId,"您的今日杀怪数已接近上限，无法使用造化丹")
		return 0
	end
	if LuaFnLockCheck( sceneId, selfId, bagId, 0 ) < 0 then
		return 0
	end		
	return 1; --不需要任何条件，并且始终返回1。
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x890130_OnDeplete( sceneId, selfId )
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
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
function x890130_OnActivateOnce( sceneId, selfId )

	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local bagId	= LuaFnGetBagIndexOfUsedItem( sceneId, selfId )	
	local nLevel = GetLevel(sceneId,selfId)
	if nLevel < 70 then
		x890130_NotifyTip( sceneId, selfId,"您的等级尚未达到70级，无法使用")
		return 0
	end
	--今日杀怪数量检测
	local nTodayKill = GetMissionData(sceneId,selfId,XYJ_DAY_KILL)
	if nTodayKill > 9000 then
		x890130_NotifyTip( sceneId, selfId,"您的今日杀怪数已接近上限，无法使用造化丹")
		return 0
	end
    if itemTblIndex  >= 38000640 and itemTblIndex <= 38000641 then
		local nUseNum = GetMissionDataEx(sceneId,selfId,MD_ZAOHUADAN_USE_NUM)
		nUseNum = nUseNum + 1
		nTodayKill = nTodayKill + 1000
		AddExp(sceneId,selfId,10000 * nLevel)
		SetMissionData(sceneId,selfId,XYJ_DAY_KILL,nTodayKill)
		SetMissionDataEx(sceneId,selfId,MD_ZAOHUADAN_USE_NUM,nUseNum)
		LuaFnEraseItem(sceneId,selfId,bagId)
		x890130_NotifyTip( sceneId, selfId, "成功使用1颗造化丹" );
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,151, 0);
		return 1;
    end
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x890130_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
--屏幕中间提示：
--**********************************
function x890130_NotifyTip( sceneId, selfId, Tips)
	BeginEvent( sceneId )
		AddText( sceneId, Tips )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end