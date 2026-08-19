--鲛人衣
--2019-11-30 23:27:23 逍遥子
x000526_g_scriptId = 000526

--**********************************
--事件交互入口
--**********************************
function x000526_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x000526_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x000526_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x000526_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	--门派使用次数校验
	local nMenPai = GetMenPai(sceneId,selfId);
	if nMenPai ~= MP_TAOHUADAO then
		if GetMissionFlag(sceneId,selfId,MF_IS_USEDJIAORENYI) == 1 then
			x000526_Tip( sceneId,selfId,"今日已使用一次了，非我桃花岛门人一日仅可使用一次" )
			return 0
		end
	end
	if LuaFnHasTeam(sceneId,selfId) == 1 then
		x000526_Tip( sceneId,selfId,"#{THD_190613_121}" )
		return 0
	end
	if IsTeamFollow( sceneId, selfId ) == 1 then --是不是组队跟随
		x000526_Tip( sceneId,selfId,"#{THD_190613_122}" )
		return 0
	end
	if LuaFnIsModelOrMount( sceneId, selfId ) == 1 then --是不是变身
		x000526_Tip( sceneId, selfId, "#{THD_190613_123}" )
		x000526_Tip( sceneId, selfId, "#{THD_190613_124}" )
		return 0
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if itemTblIndex ~= 38004033 then
		return 0
	end
	--使用位置探测
	local nPlayerPosX,nPlayerPosZ = LuaFnGetUnitPosition(sceneId, selfId);
	if nPlayerPosX > 78 or nPlayerPosX < 54 then
		x000526_Tip( sceneId, selfId, "#{THD_190613_119}" )
		return 0
	end
	if nPlayerPosZ > 154 or nPlayerPosZ < 111 then
		x000526_Tip( sceneId, selfId, "#{THD_190613_119}" )
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
function x000526_OnDeplete( sceneId, selfId )
	if(0<LuaFnDepletingUsedItem(sceneId, selfId)) then
		return 1;
	end
	return 1;
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x000526_OnActivateOnce( sceneId, selfId )
	local Itemid = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	local nSex = GetSex(sceneId,selfId);
	if nSex == 0 then
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,13626,0)
	else
		LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,13627,0)
	end
	SetMissionFlag(sceneId,selfId,MF_IS_USEDJIAORENYI,1)
	return 1
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x000526_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x000526_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

