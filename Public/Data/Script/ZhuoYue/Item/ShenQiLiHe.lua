--物品礼包-15级神器宝盒
---===================================================
x892325_g_scriptId = 892325
x892325_g_GiftItem = 38001875
x892325_g_Item = {
	{item = 10310001,count = 1,bind = 1,percent = 100},--熔金落日刀
	{item = 10310011,count = 1,bind = 1,percent = 100},--秋水无痕剑
	{item = 10310021,count = 1,bind = 1,percent = 100},--万壑松风扇
	{item = 10310031,count = 1,bind = 1,percent = 100},--碧海银涛环
}
--**********************************
--事件交互入口
--**********************************
function x892325_OnDefaultEvent( sceneId, selfId, bagIndex )
-- 不需要这个接口，但要保留空函数
end

--**********************************
--这个物品的使用过程是否类似于技能：
--系统会在执行开始时检测这个函数的返回值，如果返回失败则忽略后面的类似技能的执行。
--返回1：技能类似的物品，可以继续类似技能的执行；返回0：忽略后面的操作。
--**********************************
function x892325_IsSkillLikeScript( sceneId, selfId)
	return 1; --这个脚本需要动作支持
end

--**********************************
--直接取消效果：
--系统会直接调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x892325_CancelImpacts( sceneId, selfId )
	return 0; --不需要这个接口，但要保留空函数,并且始终返回0。
end

--**********************************
--条件检测入口：
--系统会在技能检测的时间点调用这个接口，并根据这个函数的返回值确定以后的流程是否执行。
--返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x892325_OnConditionCheck( sceneId, selfId )
	--校验使用的物品
	if(1~=LuaFnVerifyUsedItem(sceneId, selfId)) then
		return 0
	end
	--等级检查
	if GetLevel(sceneId,selfId) < 15 then
		x892325_Tip(sceneId,selfId,"请在15级以后再来使用礼包");
		return 0 
	end
	if GetMenPai(sceneId,selfId) == 9 then
		x892325_Tip(sceneId,selfId,"请在加入门派以后再来使用礼包");
		return 0 
	end
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId );
	if x892325_g_GiftItem ~= itemTblIndex then
		x892325_Tip(sceneId,selfId,"物品非法");
		return 0 
	end
	--背包空间检测
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		x892325_Tip(sceneId,selfId,"#{XSHLY_150522_166}");
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
function x892325_OnDeplete( sceneId, selfId )
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
function x892325_OnActivateOnce( sceneId, selfId )
	--等级检查
	if GetLevel(sceneId,selfId) < 15 then
		x892325_Tip(sceneId,selfId,"请在15级以后再来使用礼包");
		return 0 
	end
	if GetMenPai(sceneId,selfId) == 9 then
		x892325_Tip(sceneId,selfId,"请在加入门派以后再来使用礼包");
		return 0 
	end
	--背包空间检测
	if LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		x892325_Tip(sceneId,selfId,"#{XSHLY_150522_166}");
		return 0 
	end
	local Itemid = LuaFnGetItemIndexOfUsedItem(sceneId,selfId);
	local nBagPos = LuaFnGetBagIndexOfUsedItem(sceneId,selfId);
	local nMenPai = GetMenPai(sceneId,selfId);
	local nSuperWeaponId = 0;
	if nMenPai == MP_WUDANG or nMenPai == MP_EMEI or nMenPai == MP_XINGSU then
		nSuperWeaponId = x892325_g_Item[2].item;
	elseif nMenPai == MP_DALI or nMenPai == MP_TIANSHAN then
		nSuperWeaponId = x892325_g_Item[4].item;
	elseif nMenPai == MP_MINGJIAO or nMenPai == MP_GAIBANG or nMenPai == MP_SHAOLIN then
		nSuperWeaponId = x892325_g_Item[1].item;
	elseif nMenPai == MP_XIAOYAO then
		nSuperWeaponId = x892325_g_Item[3].item;
	elseif nMenPai == MP_TANGMEN then
		nSuperWeaponId = x892325_g_Item[5].item;
	elseif nMenPai == MP_GUIGU then
		nSuperWeaponId = x892325_g_Item[6].item;	
	elseif nMenPai == 13 then
		nSuperWeaponId = x892325_g_Item[7].item;
	end
	local pos = TryRecieveItem( sceneId, selfId, nSuperWeaponId, 1)
	if LuaFnGetItemBindStatus(sceneId,selfId,pos) ~= 1 then
		LuaFnItemBind(sceneId,selfId,pos)
	end

	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 151, 0)
	x892325_Tip(sceneId,selfId,format("恭喜你成功打开了%s！获得%s一把",GetItemName(sceneId,x892325_g_GiftItem),GetItemName(sceneId,nSuperWeaponId)))
	x892325_Xinshouxiangqian( sceneId, selfId )
	return 1
end

function x892325_Xinshouxiangqian( sceneId, selfId )
	local bing = {
	[10310001] = {50402006,50403001,50404002},
	[10310011] = {50402006,50403001,50404002},
	[10310021] = {50402006,50403001,50404002},
	[10310031] = {50402006,50403001,50404002},}	--冰
	
	local huo  = {
	[10310001] = {50402007,50403001,50404002},
	[10310011] = {50402007,50403001,50404002},
	[10310021] = {50402007,50403001,50404002},	
	[10310031] = {50402007,50403001,50404002},}	--火
	
	local xuan = {
	[10310001] = {50402005,50403001,50404002},
	[10310011] = {50402005,50403001,50404002},
	[10310021] = {50402005,50403001,50404002},
	[10310031] = {50402005,50403001,50404002},}	--玄
	
	local du   = {
	[10310001] = {50402008,50403001,50404002},
	[10310011] = {50402008,50403001,50404002},
	[10310021] = {50402008,50403001,50404002},
	[10310031] = {50402008,50403001,50404002},}	--毒

	---新手装宝石镶嵌。
			local MenPai = GetMenPai(sceneId,selfId)
			local Table
			if MenPai == 3 or MenPai == 7 then--冰
			    Table = bing
			end
			if MenPai == 1 or MenPai == 8 then--火
			    Table = huo
			end
			if MenPai == 0 or MenPai == 4 or MenPai == 6 then--玄
			    Table = xuan
			end
			if MenPai == 2 or MenPai == 5 then--毒
			    Table = du
			end
            for i = 0,29 do
			   local item = LuaFnGetItemTableIndexByIndex(sceneId,selfId,i)	
			   if item == 10310001 or item == 10310011 or item == 10310021 or item == 10310031 then
	              local nowBore_Count =  GetBagGemCount( sceneId, selfId, i )
	              while nowBore_Count ~= 3 do
		          AddBagItemSlot( sceneId, selfId, i )				  
		          nowBore_Count =  GetBagGemCount( sceneId, selfId, i )				  
	              end				  
			   end
			end
			for i = 0,29 do
			   local item = LuaFnGetItemTableIndexByIndex(sceneId,selfId,i)
			   if item == 10310001 or item == 10310011 or item == 10310021 or item == 10310031 then
			   for k = 1,3 do
			     local PosGem = TryRecieveItem(sceneId,selfId,Table[item][k],1)
			     GemEnchasing( sceneId, selfId, PosGem, i )
			   end
			   end
			end
end
--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能生效一次的入口
--**********************************
function x892325_OnActivateEachTick( sceneId, selfId)
	return 1; --不是引导性脚本, 只保留空函数.
end

function x892325_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
	AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end