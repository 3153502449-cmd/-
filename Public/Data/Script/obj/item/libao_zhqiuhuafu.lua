--物品礼包-玉兔纳福礼盒
--2019-10-21 20:25:03 
---===================================================
x892928_g_scriptId = 892928
x892928_g_GiftItem = 38002323
x892928_g_Item = {
	{item = 30503140,count = 1,bind = 1,percent = 50},
	{item = 30008114,count = 1,bind = 1,percent = 80},
	{item = 10125336,count = 1,bind = 1,percent = 10},
	{item = 10141854,count = 1,bind = 1,percent = 10},
	{item = 10125335,count = 1,bind = 1,percent = 5},
	{item = 59000020,count = 1,bind = 1,percent = 5},
}
--**********************************
--事件交互入口
--**********************************
function x892928_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x892928_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x892928_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x892928_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if x892928_g_GiftItem ~= itemTblIndex then
		x892928_Tip(sceneId,selfId,"物品非法");
		return 0 
	end
	--背包空间检测
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 3 or LuaFnGetMaterialBagSpace(sceneId,selfId) < 3 then
		x892928_Tip(sceneId,selfId,"至少保证道具背包或材料背包空出3格空间");
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
function x892928_OnDeplete( sceneId, selfId )
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
function x892928_OnActivateOnce( sceneId, selfId )
	local Itemid = LuaFnGetItemIndexOfUsedItem(sceneId,selfId);
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nNum = random(1,100)
	for i = 1,getn(x892928_g_Item) do
		if nNum <= x892928_g_Item[i].percent then
			for j = 1,x892928_g_Item[i].count do
				local pos = TryRecieveItem( sceneId, selfId, x892928_g_Item[i].item, 1)
				if x892928_g_Item[i].bind == 1 then
					if LuaFnGetItemBindStatus(sceneId,selfId,pos) ~= 1 then
						LuaFnItemBind(sceneId,selfId,pos)
					end
				end
			end
		end
	end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 151, 0)
	x892928_Tip(sceneId,selfId,format("恭喜你成功打开了%s！",GetItemName(sceneId,x892928_g_GiftItem)))
	return 1
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x892928_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x892928_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end