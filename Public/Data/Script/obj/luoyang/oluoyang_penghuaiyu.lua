x000110_g_scriptId = 000110

--**********************************
--事件交互入口
--**********************************
function x000110_OnDefaultEvent( sceneId, selfId, targetId )

	BeginEvent( sceneId )
		BeginEvent( sceneId )
		AddText( sceneId, "    在我这里可以进行装备和宝石的大部分操作。" )
		AddText( sceneId, "    点击#G装备工坊#W选项，可打开装备打孔#W、#G宝石镶嵌#W和#G宝石摘除#W界面；" )
		AddText( sceneId, "    点击#G宝石工坊#W选项，可打开宝石合成#W、#G宝石雕琢#W、#G宝石熔炼#W、#G宝石琢刻#W、#G琢刻分离#W和#G装备宝石升级#W界面。" )
        --AddNumText( sceneId, x000110_g_scriptId, "一键四孔", 6, 2010 )	
		AddNumText( sceneId, x000110_g_scriptId, "#G装备工坊", 6, 18 )
		AddNumText( sceneId, x000110_g_scriptId, "#G宝石工坊", 6, 17 )
		AddNumText( sceneId, x000110_g_scriptId, "材料合成", 6, 4 )
		AddNumText( sceneId, x000110_g_scriptId, "材料点金", 6, 102 )
		--AddNumText( sceneId, x000110_g_scriptId, "一键镶嵌", 6, 2020 )		

	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x000110_OnEventRequest( sceneId, selfId, targetId, eventId )

-------------------用于返回主界面----------------------------------------
	if GetNumText() == 3003 then
	        BeginEvent( sceneId )
		AddText( sceneId, "    在我这里可以进行装备和宝石的大部分操作。" )
		AddText( sceneId, "    点击#G装备工坊#W选项，可打开装备打孔#W、#G宝石镶嵌#W和#G宝石摘除#W界面；" )
		AddText( sceneId, "    点击#G宝石工坊#W选项，可打开宝石合成#W、#G宝石雕琢#W、#G宝石熔炼#W、#G宝石琢刻#W、#G琢刻分离#W和#G装备宝石升级#W界面。" )
                AddNumText( sceneId, x000110_g_scriptId, "#G装备工坊", 6, 18 )
		AddNumText( sceneId, x000110_g_scriptId, "#G宝石工坊", 6, 17 )
		AddNumText( sceneId, x000110_g_scriptId, "材料合成", 6, 4 )
		AddNumText( sceneId, x000110_g_scriptId, "装备工坊介绍", 11, 0 )
		AddNumText( sceneId, x000110_g_scriptId, "宝石工坊介绍", 11, 55 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	return
end
if GetNumText() == 102 then
		--local nWeekSJ_Times = GetMissionData(sceneId,selfId,MD_DIANJING_NUM_WEEK)--取消限制次数
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 0 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,2018101301)
		return
end
---------------------------介绍-------------------------------------------------
		if GetNumText() == 0 then
			BeginEvent(sceneId)		
				AddText(sceneId,"#{function_help_054}")	
				AddNumText(sceneId, x000110_g_scriptId,"装备打孔介绍",11,8);
				AddNumText(sceneId, x000110_g_scriptId,"宝石合成介绍",11,9);
				AddNumText(sceneId, x000110_g_scriptId,"宝石镶嵌介绍",11,10);
				AddNumText(sceneId, x000110_g_scriptId,"宝石摘除介绍",11,11);
				AddNumText(sceneId, x000110_g_scriptId,"装备修理介绍",11,12);
				AddNumText(sceneId, x000110_g_scriptId,"宝石雕琢介绍",11,13);
				AddNumText(sceneId, x000110_g_scriptId,"宝石熔炼介绍",11,14);
				AddNumText(sceneId, x000110_g_scriptId,"胜利宝石介绍",11,15);
				AddNumText(sceneId, x000110_g_scriptId,"#W返回上一页",8,3003);
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
---------------------------材料合成介绍-------------------------------------------
		if GetNumText() == 20 then  
			BeginEvent(sceneId)			
				AddText(sceneId,"#{SJSJ_081021_001}")
				AddNumText(sceneId, x000110_g_scriptId,"精铁的操作介绍",11,21);
				AddNumText(sceneId, x000110_g_scriptId,"秘银的操作介绍",11,22);
				AddNumText(sceneId, x000110_g_scriptId,"棉布的操作介绍",11,23);				
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
---------------------------宝石工坊-------------------------------------------
	    if  GetNumText() == 17 then
			BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 23)
			return
         end
---------------------------装备工坊-------------------------------------------
		if	GetNumText()==18 then
			BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 2013060601)
			return
		end

--****************************************************************************

--------------------------- 装备强化-----------------------------------
		if	GetNumText()==1001 then
		        BeginEvent(sceneId)
		        AddText(sceneId,"#{ZBQHJ_130508_1}")
		        AddNumText(sceneId,x000110_g_ScriptId,"#cffcc00使用#G强化道具#cffcc00强化装备",6,1599)
		        AddNumText(sceneId,x000110_g_ScriptId,"#cffcc00使用#G强化卷轴#cffcc00强化装备",6,1699)
		        AddNumText(sceneId,x000110_g_ScriptId,"#cffcc00强化转移",6,1002)
		        AddNumText(sceneId,x000110_g_ScriptId,"#cffcc00装备强化介绍",11,3333)
		        AddNumText(sceneId,x000110_g_ScriptId,"#cffcc00强化转移介绍",11,3334)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		if GetNumText()== 1599 then
			BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 1002)
			return
		end

		if GetNumText() == 1699 then
	   	        BeginUICommand( sceneId )
		        UICommand_AddInt( sceneId, selfId )
                        UICommand_AddInt( sceneId, 11)
                        UICommand_AddInt( sceneId, 50000)---需要的钱
	                UICommand_AddInt( sceneId, 10000000) --装备开始
	                UICommand_AddInt( sceneId, 20000000)  --装备结束
	                UICommand_AddInt( sceneId, -1)  --物品id
		        UICommand_AddString(sceneId,"装备强化·卷轴");
		        UICommand_AddString(sceneId,"#{ZBQHJ_130508_7}");
		        UICommand_AddString(sceneId,"请将装备放入此框");
		        UICommand_AddString(sceneId,"请将强化卷轴放入此框");
		        EndUICommand( sceneId )
		        DispatchUICommand( sceneId,selfId,21090722)
			return
		end

--------------------------- 装备强化转移-------------------------------

		if GetNumText() == 1002 then
                    BeginUICommand(sceneId)
		    UICommand_AddInt(sceneId,targetId);
		    EndUICommand(sceneId )
		    DispatchUICommand(sceneId,selfId, 20130521 )
                    return
                end


--------------------------- 装备刻铭------------------------------------
		if	GetNumText()==1003 then
			BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 1005)
			return
		end


-------------------------装备资质鉴定-----------------------------------
		if GetNumText() == 1004 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 1001 )
			return
		end
		
	

--------------------- 重新鉴定装备资质-----------------------------------
		if	GetNumText()==1005 then
			BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,targetId)
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId, 112233)
			return
		end
------------------------- 材料合成---------------------------------------
		if GetNumText() == 4 then
			BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, 0 )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 920170825 )
			return
		end



		if GetNumText()== 300 then --宝石升级，暂时没有这个UI
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 201408140 )
		 return
		 end

	if GetNumText() == 2 then
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId);
		UICommand_AddInt(sceneId,0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 201302201 )
	   return
	end

	if GetNumText()== 2010 then
		 x000110_OneKey4Slot( sceneId, selfId,targetId)
		 return
	end

	if GetNumText()== 2020 then
		 --x000110_yiqianaddbiaoshi( sceneId, selfId,targetId)
		 return
	end

        if GetNumText() == 889 then	
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
                UICommand_AddInt( sceneId, 6)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  20090721)		
	return
        end	

	
	if GetNumText() == 888 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,2013060601 )
		return
	end	
	
	if GetNumText() == 100 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,201210120)
		return
	elseif GetNumText() == 200 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  201210121)
		return
	end
	
	if GetNumText() == 889 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1001 )
		return
	end
	if GetNumText() == 893 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1004 )
		return
	end
	if GetNumText() == 890 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1005 )
		return
	end
	if GetNumText() == 891 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1006 )
		return
	end
	if GetNumText() == 892 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 112233 )
		return
	end
	if GetNumText() == 8 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{function_help_039}#r")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 9 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{function_help_040}#r")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 10 then
		BeginEvent(sceneId)						
		AddNumText( sceneId, x000110_g_scriptId, "寒玉极限", 6, 30 )
		AddNumText( sceneId, x000110_g_scriptId, "点金极限", 6, 11 )
		AddNumText( sceneId, x000110_g_scriptId, "#W返回上一页", 8, 18 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
		
	if GetNumText() == 30 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 2 )		--type，区分点金还是寒玉
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 75117 )
		return
	end
		
	if GetNumText() == 31 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 751107 )
		return
	end
		
	if GetNumText() == 32 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 25702 )
		return
	end
		
	if GetNumText() == 11 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 1 )		--type，区分点金还是寒玉
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 75117 )
		return
	end	
	if GetNumText() == 12 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{function_help_043}#r")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 13 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{INTERFACE_XML_GemCarve_6}#r")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 10000 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 23 )
		return
	end
	if GetNumText() == 3 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 27 )
		return
	end
	
	if GetNumText() == 5 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 19830424 )
		return
	end
	if GetNumText() == 6 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 112236 )
		return
	end
		
	if GetNumText() == 7 then
	  BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 112237 )
		return
	end
	if GetNumText() == 2010 then
		x000110_OneKey4Slot( sceneId, selfId, 1 )
    end	
end	




function x000110_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId ) --完成
    if not selectRadioId then
		return
	end	 

	local itemid = LuaFnGetItemTableIndexByIndex(sceneId, selfId,30)
	if floor( itemid/ 10000000 ) ~= 5 then
	    x000110_NotifyTip( sceneId, selfId, "将需要进行转换的宝石放道具栏第一个格子" )	
		return
	end
	local bagindex = GetBagItemTransfer( sceneId, selfId, 30 )
	
	ret = LuaFnIsItemAvailable( sceneId, selfId, 30 )
	if ret ~= 1 then
	x000110_NotifyTip( sceneId, selfId, "加锁宝石不可兑换" )
		return		
	end	

	  if LuaFnGetItemType(itemid) ~= LuaFnGetItemType(selectRadioId) then
        x000110_NotifyTip( sceneId, selfId, "选择的和材料栏第一个的类型不匹配" )	
		return
	 end
	 if GetItemQuality( itemid ) ~= GetItemQuality( selectRadioId ) then
	    x000110_NotifyTip( sceneId, selfId, "选择的和材料栏第一个的等级不匹配" )	
		return
	 end
	local idxa = 30503177  --4级的副
	
	--if  GetItemQuality( itemid ) == 6 then
	--idxa = 30503179
	--elseif GetItemQuality( itemid ) == 7 then
	--  idxa = 30503180
	--elseif GetItemQuality( itemid ) == 8 then
	--idxa = 30503181
	--end
	
	
	if LuaFnGetAvailableItemCount(sceneId, selfId,idxa) < 1 then
		
	x000110_NotifyTip(sceneId, selfId, "你缺少"..GetItemName( sceneId,idxa))	
		return
	end	
	
	LuaFnDelAvailableItem(sceneId,selfId,idxa,1)
		if LuaFnEraseItem(sceneId, selfId, 30) ~= 1 then
			x000110_NotifyTip(sceneId, selfId, "扣除物品失败！")
			return
		end
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
	local ret1 = TryRecieveItem(sceneId, selfId, selectRadioId, 1)
	LuaFnItemBind( sceneId, selfId,ret1);
	x000110_NotifyTip( sceneId, selfId,"兑换成功")
	local szTranItm1	= GetBagItemTransfer( sceneId, selfId, ret1 )
	local szMsg = format( "#H恭喜玩家#{_INFOUSR%s}使用 #{_INFOMSG%s} 在#G洛阳(163.106)#H处成功兑换了一颗#{_INFOMSG%s1}！",LuaFnGetName( sceneId, selfId ), bagindex,szTranItm1 )
	BroadMsgByChatPipe( sceneId, selfId, szMsg,4)
end

function x000110_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
function x000110_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
function x000110_OneKey4Slot( sceneId, selfId,isTips )
	local tEquipGemTable = {0,1,3,4,5,6,7,9,10,11,12,13,14,15,16,17,18}
    local bagbegin = GetBasicBagStartPos(sceneId, selfId)
    local bagend = GetBasicBagEndPos(sceneId, selfId)
    for i = 0,10 do
		for i=bagbegin, bagend do
			local itemIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, i )	
			if itemIndex>0 then
				local ret = LuaFnIsItemLocked( sceneId, selfId, i )
				if ret ~= 0 then
					return
				end	
				local EquipType = LuaFnGetBagEquipType( sceneId, selfId, i )	
				local find = 0
				for j, gem in tEquipGemTable do
					if gem == EquipType then
						find = 1
					end
				end
				if find == 1 then
					local equipMaxGemCount = GetBagGemCount( sceneId, selfId, i )	
					local ret = AddBagItemSlot( sceneId, selfId, i )
					local ret1 = AddBagItemSlotFour( sceneId, selfId, i )  
					equipMaxGemCount = GetBagGemCount( sceneId, selfId, i )

				end
			end
		end
	end
	
	if isTips==1 then
	x000110_NotifyTip( sceneId, selfId, "恭喜您，您包裹所有装备已经成功开了四孔" )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
	end
end
--**********************************
--一键镶嵌8级宝石
--**********************************
function x000110_yiqianaddbiaoshi( sceneId, selfId,targetId)
local mybiaoshilist_g_Gem = 
{
{ 50821108,50802005,50803001,50821108,50813004,50814001,50812005,50812005 },--少林0玄
{ 50821308,50802007,50803001,50821308,50813004,50814001,50812007,50812007 },--明教1火
{ 50821408,50802008,50803001,50821408,50813004,50814001,50812008,50812008 },--丐帮2毒
{ 50821208,50802006,50803001,50821208,50813004,50814001,50812006,50812006 },--武当3冰
{ 50821208,50802006,50803001,50821208,50813004,50814001,50812006,50812006 },--峨眉4冰
{ 50821408,50802008,50803001,50821408,50813004,50814001,50812008,50812008 },--星宿5毒
{ 50821108,50802005,50803001,50821108,50813004,50814001,50812005,50812005 },--天龙6玄
{ 50821208,50802006,50803001,50821208,50813004,50814001,50812006,50812006 },--天山7冰
{ 50821308,50802007,50803001,50821308,50813004,50814001,50812007,50812007 },--逍遥8火
{ 50821108,50802005,50803001,50821108,50813004,50814001,50812005,50812005 },--无门派9玄
{ 50821108,50802005,50803001,50821108,50813004,50814001,50812005,50812005 },--慕容10玄
{ 50821408,50802008,50803001,50821408,50813004,50814001,50812008,50812008 },--唐门11毒
{ 50821108,50802005,50803001,50821108,50813004,50814001,50812005,50812005 },--鬼谷12玄
{ 50821208,50802006,50803001,50821208,50813004,50814001,50812006,50812006 },--桃花岛13冰
}

		local tEquipGemTable	= { 0, 1, 3, 4, 5, 6, 7, 9, 10, 12, 14, 15, 16, 17, 18 } 
		local Bore_Count			= GetBagGemCount( sceneId, selfId, 0 )
		local nLevel					= GetBagItemLevel( sceneId, selfId, 0 )
		local EquipType				= LuaFnGetBagEquipType( sceneId, selfId, 0 )
		local find						= 0
		local bagbegin = GetBasicBagStartPos(sceneId, selfId)
		local bagend = GetBasicBagEndPos(sceneId, selfId)		
		for i=bagbegin, bagend do
			local itemIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, i )			
			if itemIndex>0 then
				local ret = LuaFnIsItemLocked( sceneId, selfId, i )
				if ret ~= 0 then
					return
				end	
				local EquipType = LuaFnGetBagEquipType( sceneId, selfId, i )				
				local find = 0
			for i, gem in tEquipGemTable do
				if gem == EquipType then
					find = 1
				end
			end
				if find == 1 then	
					local equipMaxGemCount = GetBagGemCount( sceneId, selfId, i )					
					while equipMaxGemCount < 3 do				
						local ret = AddBagItemSlot( sceneId, selfId, i )
						equipMaxGemCount = GetBagGemCount( sceneId, selfId, i )			
					end
                    AddBagItemSlotFour( sceneId, selfId, i )
				    --AddBagItemSlot( sceneId, selfId, i )
				end
			end
                local can = 0
                local EquipType = LuaFnGetBagEquipType( sceneId, selfId, i )
				local equipEmbededGemCount = 0
				equipMaxGemCount = 0
				if EquipType >= 0 and EquipType ~= 2 then
				-- 判断是否还可以镶嵌更多宝石
				equipMaxGemCount = GetBagGemCount( sceneId, selfId, i )
				equipEmbededGemCount = GetGemEmbededCount( sceneId, selfId, i )
                end
				--modi:lby是否可以镶嵌
				if equipMaxGemCount > equipEmbededGemCount and equipMaxGemCount ~= 0 then
					can = 1
				end
				if can == 1 then	
					if EquipType == 0 or EquipType == 6 or EquipType == 7 or EquipType == 11 or EquipType == 12 or EquipType == 13 or EquipType == 14 or EquipType == 17 or EquipType == 18 or EquipType == 10 or EquipType == 9 then

						local nMenpai = GetMenPai(sceneId, selfId)
						local Gem = mybiaoshilist_g_Gem[nMenpai + 1]
						local gemEmbededIdx = -1
						local gemYi = 0
						for j=1, 4 do
							local gemType = LuaFnGetItemType(Gem[j])
							for k = 0, equipMaxGemCount - 1 do
								gemEmbededIdx = GetGemEmbededType( sceneId, selfId, i, k )
								local Type = LuaFnGetItemType( gemEmbededIdx )
								if Type == gemType then
									-- 对比两颗宝石的类型（宝石大类）
									gemYi = 1
								end
							end
							if gemYi == 0 then
								local BagIndex = TryRecieveItem( sceneId, selfId, Gem[j], QUALITY_MUST_BE_CHANGE)
								GemEnchasing( sceneId, selfId, BagIndex, i )
							end
						end
						
					elseif EquipType == 1 or EquipType == 16 or EquipType == 3 or EquipType == 4 or EquipType == 5 or EquipType == 15  then
						local nMenpai = GetMenPai(sceneId, selfId)
						local Gem = mybiaoshilist_g_Gem[nMenpai + 1]
						local gemEmbededIdx = -1
						local gemYi = 0
						for j=5, 8 do
							local gemType = LuaFnGetItemType(Gem[j])
							for k = 0, equipMaxGemCount - 1 do
								gemEmbededIdx = GetGemEmbededType( sceneId, selfId, i, k )
								local Type = LuaFnGetItemType( gemEmbededIdx )
								if Type == gemType then
									-- 对比两颗宝石的类型（宝石大类）
									gemYi = 1
								end
							end
							if gemYi == 0 then
								local BagIndex = TryRecieveItem( sceneId, selfId, Gem[j], QUALITY_MUST_BE_CHANGE)
								GemEnchasing( sceneId, selfId, BagIndex, i )
							end
						end
					end
				end
	end
		x000110_NotifyTip( sceneId, selfId, "  恭喜您，您背包里所有的装备均已全部镶嵌了[#R8级宝石#Y]。"  )
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)

end


function x000110_OneKey4Slot( sceneId, selfId,targetId )

	local tEquipGemTable = {0,1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18}
    local bagbegin = GetBasicBagStartPos(sceneId, selfId)
    local bagend = GetBasicBagEndPos(sceneId, selfId)
    for i = 0,10 do
		for i=bagbegin, bagend do
			local itemIndex = LuaFnGetItemTableIndexByIndex( sceneId, selfId, i )	
			if itemIndex>0 then
				local ret = LuaFnIsItemLocked( sceneId, selfId, i )
				if ret ~= 0 then
					return
				end	
				local EquipType = LuaFnGetBagEquipType( sceneId, selfId, i )	
				local find = 0
				for j, gem in tEquipGemTable do
					if gem == EquipType then
						find = 1
					end
				end
				if find == 1 then
					local equipMaxGemCount = GetBagGemCount( sceneId, selfId, i )	
					local ret = AddBagItemSlot( sceneId, selfId, i )
					local ret1 = AddBagItemSlotFour( sceneId, selfId, i )
					equipMaxGemCount = GetBagGemCount( sceneId, selfId, i )
				end
			end
		end
	end
	x000110_NotifyTip( sceneId, selfId, "恭喜您，您包裹所有装备已经成功开了四孔" )
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)	
end