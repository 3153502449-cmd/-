--循环任务
--一千零一夜
--逍遥子重写 QQ857904341

--注意：
--物品技能的逻辑只能使用基础技能和脚本来实现
--脚本号
x300084_g_scriptId = 300084

x300084_g_event = 808131

--**********************************
--事件交互入口
--**********************************
function x300084_OnDefaultEvent( sceneId, selfId, bagIndex )

end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x300084_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x300084_CancelImpacts( sceneId, selfId )
	return 0;
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x300084_OnConditionCheck( sceneId, selfId )
	if sceneId~=4 then
        BeginEvent( sceneId )
			AddText( sceneId, "#{SQXY_09061_14}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
        return 0
	end
    local nWishNum = GetMissionDataEx(sceneId,selfId,MD_WISHTREE_NUM)
	if nWishNum == 5  then
		BeginEvent( sceneId )
			AddText( sceneId, "许愿任务已经完成，不能再使用愿灵泉！" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
        return 0
	end
	--看看是不是骑着坐骑
	if LuaFnIsRiding( sceneId, selfId ) == 1 then 
		BeginEvent( sceneId )
			AddText( sceneId, "#{SQXY_09061_15}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
        return 0
	end
	--看看是不是在变身
	if LuaFnIsModelOrMount( sceneId, selfId ) == 1 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{SQXY_09061_16}" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
        return 0
	end
	
    --任务达成坐标点
	treasureX = 157
	treasureZ = 188
	--取得玩家当前坐标
	PlayerX = GetHumanWorldX(sceneId,selfId)
	PlayerZ = GetHumanWorldZ(sceneId,selfId)
	Distance = floor(sqrt((treasureX-PlayerX)*(treasureX-PlayerX)+(treasureZ-PlayerZ)*(treasureZ-PlayerZ)))
	if Distance > 5 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SQXY_09061_14}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
        return 0
	end
	BeginEvent(sceneId)
		AddText(sceneId,"#{SQXY_09061_17}")
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
    return  CallScriptFunction(x300084_g_event,"CheckAccept",sceneId, selfId, -1, -1)
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x300084_OnDeplete( sceneId, selfId )
	return 1; --不消耗
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x300084_OnActivateOnce( sceneId, selfId )
    if sceneId==4 then
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 146, 0);
		CallScriptFunction(x300084_g_event,"OnUseItem",sceneId, selfId, -1)
		return 1;
	else
		BeginEvent( sceneId )
			AddText( sceneId, "#{SQXY_090731_1}" )
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
function x300084_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

