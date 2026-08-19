-- 宝石合成

-- 脚本号
x701602_g_scriptId = 701602

-- 脚本名称
x701602_g_scriptName = "合成宝石"

-- 合成规则表


x701602_g_CompoundRule={
5000,
6000,
7000,
8000,
9000,
10000,
11000,
12000,
13000,
11000,
}

-- 合成材料玄天寒玉
x701602_g_HanYu_MaterialId = 20310110
-- 生成物寒玉精碎
x701602_g_HanYu_OutPutId = 20310111

--**********************************************************************
-- 任务入口函数
--**********************************************************************
function x701602_OnDefaultEvent( sceneId, selfId, targetId )

	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 23)

end

--**********************************************************************
-- 列举事件
--**********************************************************************
function x701602_OnEnumerate( sceneId, selfId, targetId )

	AddNumText(sceneId, x701602_g_scriptId, x701602_g_scriptName,6,-1)

end

--**********************************************************************
-- 判断是否宝石
--**********************************************************************
function x701602_IsGem( itemIndex )
	if floor( itemIndex / 10000000 ) == 5 then
		return 1
	end

	return 0
end

--**********************************************************************
-- 判断是否材料
--**********************************************************************
function x701602_IsMaterial( itemIndex )
	--if floor( itemIndex / 100000 ) == 205 then
	--	return 1
	--end

	if itemIndex >= 20500000 and itemIndex <= 20500008 then
		return 1
	end

	if itemIndex >= 20501000 and itemIndex <= 20501008 then
		return 1
	end

	if itemIndex >= 20502000 and itemIndex <= 20502008 then
		return 1
	end

	return 0
end

--**********************************************************************
-- 根据一个物品号得到该物品的大分类
--**********************************************************************
function x701602_GetStuffClass( itemIndex )
	if x701602_IsGem( itemIndex ) == 1 then
		return 1
	elseif x701602_IsMaterial( itemIndex ) == 1 then
		return 2
	elseif itemIndex == x701602_g_HanYu_MaterialId then
		return 3
	end

	return -1
end

--**********************************************************************
-- 根据一个物品号得到该物品的类型
--**********************************************************************
function x701602_GetStuffType( itemIndex )
	if x701602_IsGem( itemIndex ) == 1 then
		return mod( itemIndex, 100000 )
	elseif x701602_IsMaterial( itemIndex ) == 1 then
		return LuaFnGetItemType( itemIndex )
	elseif itemIndex == x701602_g_HanYu_MaterialId then
		return LuaFnGetItemType( itemIndex )
	end

	return -1
end

--**********************************************************************
-- 根据一个物品号得到该物品的等级
--**********************************************************************
function x701602_GetStuffGrade( itemIndex )
	if x701602_IsGem( itemIndex ) == 1 then
		return GetItemQuality( itemIndex )
	elseif x701602_IsMaterial( itemIndex ) == 1 then
		return GetCommonItemGrade( itemIndex )
	elseif itemIndex == x701602_g_HanYu_MaterialId then
		return GetCommonItemGrade( itemIndex )
	end

	return -1
end

--**********************************************************************
-- 根据一个物品号得到该物品的升级物品号
--**********************************************************************
function x701602_GetStuffUpgraded( itemIndex )
	if x701602_IsGem( itemIndex ) == 1 then
		return ( itemIndex + 100000 )
	elseif x701602_IsMaterial( itemIndex ) == 1 then
		return ( itemIndex + 1 )
	elseif itemIndex == x701602_g_HanYu_MaterialId then
		return x701602_g_HanYu_OutPutId
	end

	return -1
end

--**********************************************************************
-- 宝石以及材料合成接口
-- bagIndex1, bagIndex2 ... bagIndex5：五个宝石或材料所在的格子
-- bagIndex6：特殊材料
---1    pos -- nis 
--**********************************************************************
function x701602_GemCompctoound( sceneId, selfId, Index, bagIndex, bagns)
	if not bagIndex or bagIndex ==-1 then 
		return
	end
	
	if Index ==1 then   --宝石合成
		
		local IsBind=0		
		if bagns <0 or bagns > 3 then 
			x701602_NotifyTip( sceneId, selfId, "选择错误" )
		return
		end
		if LuaFnIsItemAvailable( sceneId, selfId, bagIndex ) < 1 then	-- 使用有问题的物品则退出流程
		return OR_STUFF_LACK
		end
		local itemIndex= LuaFnGetItemTableIndexByIndex( sceneId, selfId,bagIndex )
		if x701602_IsGem( itemIndex ) ~=1 then 
			x701602_NotifyTip( sceneId, selfId, "只能宝石合成" )
		 return 0 
		end

		local nSuiPianCount = LuaFnGetAvailableItemCount(sceneId, selfId, itemIndex)
		local baoshishuliang =5
		local hechengjilv = 0
		if bagns ==0 then 
		 baoshishuliang =5 	
		hechengjilv=100
		elseif bagns ==1 then 
		baoshishuliang =4 	
		hechengjilv=75
		elseif bagns ==2 then 	
		 baoshishuliang =3	
		hechengjilv=50
		end 	
	    local baoshidengji = x701602_GetStuffGrade( itemIndex )
		--检查合成符
		local n_CaiLiao = {}
		if baoshidengji <4 then 
		n_CaiLiao={30900815,30900015}	
		else
		n_CaiLiao={30900816,30900016}	
		end
		local cailiao1 = LuaFnGetAvailableItemCount(sceneId, selfId, n_CaiLiao[1])
		local cailiao2 = LuaFnGetAvailableItemCount(sceneId, selfId, n_CaiLiao[2])
		
		if cailiao1 <1 and cailiao2 <1 then 
		x701602_NotifyTip( sceneId, selfId, "您包裹内没有发现宝石合成符" )
		return
		end
		

		if nSuiPianCount < baoshishuliang then 
		x701602_NotifyTip( sceneId, selfId, "您包裹内的宝石数量不足"..baoshishuliang.."个" )
		return
	    end
		
		_,IsBind=ScriptGlobal_IsGemItemNumberTable( sceneId, selfId,bagIndex,baoshishuliang )
		if cailiao1 >0 then 
		IsBind = 1;	
		end	
		local shanchuitm = 0
		if cailiao1 >0 then 
			shanchuitm=n_CaiLiao[1]
			else
			shanchuitm=n_CaiLiao[2]
		end
		if shanchuitm ==0 then 
			return
		end
	--合成8，9级宝石功能关闭
	if baoshidengji > 6 then
		return OR_CANNOT_UPGRADE
	end
     local CompoundRule= x701602_g_CompoundRule[baoshidengji]
	
	local selfMoney = GetMoney( sceneId, selfId )  +  GetMoneyJZ(sceneId, selfId)  --交子普及 Vega
	
	if  selfMoney < CompoundRule then
		return OR_NOTENOUGH_MONEY												-- 钱不够，一般由客户端自行提示
	end		
	local ret = LuaFnCostMoneyWithPriority( sceneId, selfId,CompoundRule )  --交子普及 Vega
	if ret < 0 then
		return OR_NOTENOUGH_MONEY
	end		
    local newItemIndex = x701602_GetStuffUpgraded( itemIndex )	
	if LuaFnDelAvailableItem(sceneId,selfId,shanchuitm,1) ~= 1 then 
		x701602_NotifyTip( sceneId, selfId, "合成符扣除失败" )
		return
	end	
    local dsad =  LuaFnDelAvailableItem(sceneId,selfId,itemIndex,baoshishuliang)
	if dsad~= 1 then
		x701602_NotifyTip( sceneId, selfId, "扣除物品失败，无法合成宝石。" )
		return
	end		
	if hechengjilv < random(1,100) then												-- 合成失败
		LuaFnSendAbilityFailureMsg( sceneId, selfId, -1, -1, -1 )
	else
	
		res = LuaFnTryRecieveItemIgnoreFatigueState( sceneId, selfId, newItemIndex, QUALITY_MUST_BE_CHANGE)
		if res == -1 then
			return OR_FAILURE
		end
		--强制绑定
		if(IsBind == 1) then
			LuaFnItemBind( sceneId, selfId, res);
		end
		
		--增加特效
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		
		--醒目提示
		BeginEvent( sceneId )
			AddText( sceneId, "合成成功")
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		
		if x701602_IsGem( newItemIndex ) == 1 then
			stuffGrade = x701602_GetStuffGrade( newItemIndex )
			--公告精简，小于4级的宝石合成不发公告
			if stuffGrade >= 4 then
				local szTransferItem = GetBagItemTransfer( sceneId, selfId, res )
				BroadMsgByChatPipe( sceneId, selfId, "#W#{_INFOUSR" .. GetName( sceneId, selfId ) .. "}#H经过一番努力，终于合成出了#W#{_INFOMSG" .. szTransferItem .. "}#H。", 4 )
			end
		end
		LuaFnSendAbilitySuccessMsg( sceneId, selfId, -1, -1, newItemIndex )		-- 提示生成物
	end
	return OR_OK			
	end 
	
	
	

end
function x701602_NotifyTip( sceneId, selfId, Msg )

	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )

end