--种花脚本

--脚本号
x335700_g_scriptId = 335700

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x335700_OnDefaultEvent( sceneId, selfId )

end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x335700_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x335700_CancelImpacts( sceneId, selfId )
	return 0;
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x335700_OnConditionCheck( sceneId, selfId )

    if sceneId~=2 then
        BeginEvent( sceneId )
		AddText( sceneId, "只能在大理东大街或者西大街才能种花" )
	    EndEvent( sceneId )
	    DispatchMissionTips( sceneId, selfId )
        return 0
    end

	--取得玩家当前坐标
	PlayerX = GetHumanWorldX(sceneId,selfId)
	PlayerZ = GetHumanWorldZ(sceneId,selfId)
    if ( PlayerX < 40 or PlayerX > 293 ) or ( PlayerZ < 141 or PlayerZ > 155 ) then
        BeginEvent( sceneId )
		AddText( sceneId, "这个位置不能种花，只能在东大街或者西大街才能种花哦~" )
	    EndEvent( sceneId )
	    DispatchMissionTips( sceneId, selfId )
        return 0
    end
    return 1
end

--**********************************
--消耗检测及处理入口：
--系统会在技能消耗的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--注意：这不光负责消耗的检测也负责消耗的执行。
--**********************************
function x335700_OnDeplete( sceneId, selfId )
	return 1; --不消耗
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x335700_OnActivateOnce( sceneId, selfId )

      if sceneId==2 then
	--LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0);

	x335700_OnImpactFadeOut( sceneId, selfId )
	else
	BeginEvent( sceneId )
		AddText( sceneId, "物品使用失败，请联系雄霸天龙运营团队" )
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
function x335700_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

--**********************************
--种植成功：
--**********************************
function x335700_OnImpactFadeOut( sceneId, selfId )
 	local PlayerName=GetName(sceneId,selfId)
	local guid = LuaFnGetGUID(sceneId, selfId)  ----得到人物的GUID
    DelItem( sceneId, selfId, 30505260, 1 )
	local nMonsterId = LuaFnCreateMonster(sceneId, 90, GetHumanWorldX(sceneId,selfId)+1, GetHumanWorldZ(sceneId,selfId)+1, 3, -1, 335701 )
	SetCharacterName(sceneId, nMonsterId, ""..PlayerName.."的鲜花幼苗")
	LuaFnSetLifeTimeAttrRefix_AttackPhysics( sceneId, nMonsterId, guid )
	SetCharacterDieTime(sceneId, nMonsterId1, 600000)
end

