--热卖元宝 NPC
--注意本脚本含有随身元宝相关功能，请一定参照现有的例子进行修改。
--[MODIFY 2019-6-26 13:46:57 XYZ QQ857904341 增加批量兑换系统]
x181002_g_scriptId 	= 181002
x181002_g_buyrate 	= 0.5

x181002_g_shoptableindex=151 --已经废弃了，现在用188和189
x181002_g_goodact		= 1		--热卖元宝商店
x181002_g_YuanBaoIntro	= 18	--元宝介绍
x181002_g_eventList = {}

--以下是批量兑换系统
x181002_g_ExchangeItem = {
	[200] = {needItem = 39901012,needItemNum = 100,nPrizeItem = 10141865,nPrizeItemNum = 1}, --霞上仙
	[201] = {needItem = 39901012,needItemNum = 400,nPrizeItem = 10553108,nPrizeItemNum = 1}, --重楼肩
	[202] = {needItem = 39901012,needItemNum = 1200,nPrizeItem = 10553109,nPrizeItemNum = 1}, --真重楼肩
	--
	[300] = {needItem = 20102001,needItemNum = 500,nPrizeItem = 30008067,nPrizeItemNum = 1}, --玄灵丹
	[301] = {needItem = 20102001,needItemNum = 100,nPrizeItem = 39999901,nPrizeItemNum = 1}, --功力丹
	[302] = {needItem = 20102001,needItemNum = 150,nPrizeItem = 38000010,nPrizeItemNum = 1}, --3级宝石
	[303] = {needItem = 20102001,needItemNum = 200,nPrizeItem = 30502002,nPrizeItemNum = 10}, --高级根骨丹
	[304] = {needItem = 20102001,needItemNum = 100,nPrizeItem = 30900045,nPrizeItemNum = 1},--天罡强化露
	[305] = {needItem = 20102001,needItemNum = 100,nPrizeItem = 30509014,nPrizeItemNum = 1},--15朵玫瑰

}
x181002_g_ExchangeMaterial = {
	[10141865] = {needItem = 39901012,needItemNum = 100,nPrizeItemNum = 1},
	[10553108] = {needItem = 39901012,needItemNum = 400,nPrizeItemNum = 1},
	[10553109] = {needItem = 39901012,needItemNum = 1200,nPrizeItemNum = 1},
	[30008067] = {needItem = 20102001,needItemNum = 500,nPrizeItemNum = 1},
	[39999901] = {needItem = 20102001,needItemNum = 100,nPrizeItemNum = 1},
	[38000010] = {needItem = 20102001,needItemNum = 150,nPrizeItemNum = 1},
	[30502002] = {needItem = 20102001,needItemNum = 200,nPrizeItemNum = 10},	
	[30900045] = {needItem = 20102001,needItemNum = 100,nPrizeItemNum = 1},	
	[30509014] = {needItem = 20102001,needItemNum = 100,nPrizeItemNum = 1},	
}
--宝石兑换券要求
x181002_g_GemExchange = {
	[3] = 38000010,
	[4] = 38000011,
	[5] = 38000012,
	[6] = 38000013,
	[7] = 38000014,
}
--**********************************
--事件交互入口
--**********************************
function x181002_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		strText = "    快来看一看啦，全城最畅销的商品，最便宜的价格，客官您赶紧挑几件吧，绝对超值，包您买回去后今夜做梦都会笑呢~"
		AddText( sceneId, strText )
		
		--20190626开放琉璃明珠、月白明珠兑换系统
		-- AddNumText( sceneId, x181002_g_scriptId, "#G#{TJMZYCL_130322_02}", 6, 100)
		AddNumText( sceneId, x181002_g_scriptId, "#G使用草鱼兑换奖励", 6, 101)
		--20190626开放宝石兑换
		AddNumText( sceneId, x181002_g_scriptId, "#{BSDHQ_140327_02}", 6, 102)
		
		--AddNumText( sceneId, x181002_g_scriptId, "购买热卖商品", 7, x181002_g_goodact)
		--AddNumText( sceneId, x181002_g_scriptId, "元宝介绍", 11, x181002_g_YuanBaoIntro)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x181002_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nOperation = GetNumText()
	if nOperation == x181002_g_goodact then
	--新的元宝商店
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 1)
			UICommand_AddInt( sceneId, 2 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 888902)
	elseif nOperation == x181002_g_YuanBaoIntro	then
		BeginEvent( sceneId )
			AddText( sceneId, "#{INTRO_YUANBAO}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif nOperation == 100 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{TJMZYCL_130322_16}" )
			AddNumText( sceneId, x181002_g_scriptId, "琉璃明珠兑换霞上仙", 6, 200) --霞上仙
			AddNumText( sceneId, x181002_g_scriptId, "#{TJMZYCL_130322_18}", 6, 201) --重楼肩
			AddNumText( sceneId, x181002_g_scriptId, "#{TJMZYCL_130322_19}", 6, 202) --真重楼肩
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif nOperation == 101 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{TJMZYCL_130322_03}" )
			AddNumText( sceneId, x181002_g_scriptId, "#{TJMZYCL_130322_04}", 6, 300) --天灵丹
			AddNumText( sceneId, x181002_g_scriptId, "#{TJMZYCL_130322_05}", 6, 301) --玄灵丹
			AddNumText( sceneId, x181002_g_scriptId, "#{TJMZYCL_130322_06}", 6, 302) 
			AddNumText( sceneId, x181002_g_scriptId, "#{TJMZYCL_130322_07}", 6, 303)
			AddNumText( sceneId, x181002_g_scriptId, "草鱼兑换天罡强化露", 6, 304)
			AddNumText( sceneId, x181002_g_scriptId, "草鱼兑换15朵玫瑰", 6, 305)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif nOperation == 102 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{BSDHQ_140327_03}" )
			AddNumText( sceneId, x181002_g_scriptId, "#{BSDHQ_140327_04}", 6, 995) --3
			AddNumText( sceneId, x181002_g_scriptId, "#{BSDHQ_140327_05}", 6, 999) --4
			AddNumText( sceneId, x181002_g_scriptId, "#{BSDHQ_140327_06}", 6, 998) --5
			AddNumText( sceneId, x181002_g_scriptId, "#{BSDHQ_140327_07}", 6, 997) --6
			AddNumText( sceneId, x181002_g_scriptId, "#{BSDHQ_140327_08}", 6, 996) --7
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	--批量兑换系统
	if x181002_g_ExchangeItem[nOperation] ~= nil then
		BeginEvent(sceneId)	
			local c_Str = format("    这位少侠，若您拥有#G%s#W颗#Y%s#W，便可在此兑换#G%s#W个#Y%s#W了。#r    #G注：您所兑换的奖励均为绑定物品。#W",x181002_g_ExchangeItem[nOperation].needItemNum,
								GetItemName(sceneId,x181002_g_ExchangeItem[nOperation].needItem),
								x181002_g_ExchangeItem[nOperation].nPrizeItemNum,
								GetItemName(sceneId,x181002_g_ExchangeItem[nOperation].nPrizeItem))
		AddText(sceneId,c_Str)
			AddRadioItemBonus( sceneId, x181002_g_ExchangeItem[nOperation].nPrizeItem, 4 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		DispatchMissionContinueInfo(sceneId,selfId,targetId, x181002_g_scriptId, 0)
		return
	end
	--宝石兑换系统
	if nOperation >= 995 and nOperation <= 999 then
		--这里为了配合字典，上头的写法
		local nStrDictionary = {
			[999] = {str = "#{BSDHQ_140327_10}",start = 15},
			[998] = {str = "#{BSDHQ_140327_11}",start = 16},
			[997] = {str = "#{BSDHQ_140327_12}",start = 17},
			[996] = {str = "#{BSDHQ_140327_13}",start = 18},
			[995] = {str = "#{BSDHQ_140327_09}",start = 14},
		}
		BeginEvent( sceneId )
			AddText( sceneId, nStrDictionary[nOperation].str )
			for i = 0,11 do
				AddNumText( sceneId, x181002_g_scriptId, "#{BSDHQ_140327_"..tostring(nStrDictionary[nOperation].start + i * 5).."}", 6, 1000 + (nStrDictionary[nOperation].start + i * 5)) --4
			end
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end
	--此处区段只给宝石兑换系统用，其他不要占用
	if nOperation >= 1000 and nOperation <= 2000 then
		local nGemTable = {[14] =50301001,[15] =50401001,[16] =50501001,[17] =50601001,[18] =50701001,[19] =50301002,[20] =50401002,[21] =50501002,[22] =50601002,[23] =50701002,[24] =50302001,[25] =50402001,[26] =50502001,[27] =50602001,[28] =50702001,[29] =50302002,[30] =50402002,[31] =50502002,[32] =50602002,[33] =50702002,[34] =50302003,[35] =50402003,[36] =50502003,[37] =50602003,[38] =50702003,[39] =50302004,[40] =50402004,[41] =50502004,[42] =50602004,[43] =50702004,[44] =50303001,[45] =50403001,[46] =50503001,[47] =50603001,[48] =50703001,[49] =50312001,[50] =50412001,[51] =50512001,[52] =50612001,[53] =50712001,[54] =50312002,[55] =50412002,[56] =50512002,[57] =50612002,[58] =50712002,[59] =50312003,[60] =50412003,[61] =50512003,[62] =50612003,[63] =50712003,[64] =50312004,[65] =50412004,[66] =50512004,[67] =50612004,[68] =50712004,[69] =50313004,[70] =50413004,[71] =50513004,[72] =50613004,[73] =50713004,}
		local nGemIndex = nGemTable[nOperation - 1000]
		if nGemIndex == nil then
			BeginEvent( sceneId )
				AddText( sceneId, "服务端数据异常，暂停宝石兑换" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		local nGemLevel = mod(floor(nGemIndex/100000),10)
		local nNeedMaterial = x181002_g_GemExchange[nGemLevel]
		if LuaFnGetAvailableItemCount(sceneId,selfId,nNeedMaterial) < 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{BSDHQ_140327_74}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 then
			BeginEvent( sceneId )
				AddText( sceneId, "#{BSDHQ_140327_75}" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		LuaFnDelAvailableItem(sceneId,selfId,nNeedMaterial,1)
		local npos = TryRecieveItem(sceneId,selfId,nGemIndex,1);
		LuaFnItemBind(sceneId,selfId,npos)
		--LuaFnAuditExchangeLog(sceneId, selfId,nGemIndex,1) --记录一下
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		BeginEvent( sceneId )
		AddText( sceneId, "您兑换了一个"..GetItemName(sceneId,nGemIndex) )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		return
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x181002_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x181002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
	if x181002_g_ExchangeMaterial[selectRadioId] ~= nil then
		local nNeedItemID = x181002_g_ExchangeMaterial[selectRadioId].needItem
		local nNeedItemNum = x181002_g_ExchangeMaterial[selectRadioId].needItemNum
		local nPrizeItem = selectRadioId
		local nPrizeItemNum = x181002_g_ExchangeMaterial[selectRadioId].nPrizeItemNum
		if LuaFnGetAvailableItemCount(sceneId,selfId,nNeedItemID) < nNeedItemNum then
			BeginEvent( sceneId )
				AddText( sceneId, "您的背包中没有足够数量的"..GetItemName(sceneId,nNeedItemID).."或所携带的"..GetItemName(sceneId,nNeedItemID).."已被锁定，无法进行兑换" )
			EndEvent( sceneId )
			DispatchMissionTips( sceneId, selfId )
			return
		end
		--这里因为涉及绑定问题所以必须使用tryreceiveitem来发放奖励
		--对应多个物品请使用在物品列表中添加绑定属性
		if nPrizeItemNum > 1 then
			BeginAddItem( sceneId )
			AddItem( sceneId, nPrizeItem, nPrizeItemNum )
			local nSpace = EndAddItem( sceneId, selfId )
			if nSpace <= 0 then 
				BeginEvent( sceneId )
					AddText( sceneId, "#{TJMZYCL_130322_12}" )
				EndEvent( sceneId )
				DispatchMissionTips( sceneId, selfId )
				return
			end
			AddItemListToHuman(sceneId,selfId)
		else
			if LuaFnGetPropertyBagSpace( sceneId, selfId) < 1  then
				BeginEvent( sceneId )
					AddText( sceneId, "#{TJMZYCL_130322_12}" )
				EndEvent( sceneId )
				DispatchMissionTips( sceneId, selfId )
				return
			end
			local nNewPos = TryRecieveItem(sceneId,selfId,nPrizeItem,1);
			if LuaFnGetItemBindStatus(sceneId,selfId,nNewPos) ~= 1 then
			   LuaFnItemBind(sceneId,selfId,nNewPos)
			end
		end
		--现在开始扣除物品
		LuaFnDelAvailableItem(sceneId,selfId,nNeedItemID,nNeedItemNum)
		BeginEvent( sceneId )
			AddText( sceneId, GetItemName(sceneId,nPrizeItem).."#H兑换成功！请打开背包进行查看。" )
		EndEvent( sceneId )
		DispatchMissionTips( sceneId, selfId )
		LuaFnAuditExchangeLog(sceneId, selfId,nPrizeItem,nPrizeItemNum) --记录一下
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0);
		return
	end
end

--**********************************
--按需来弹出商店，分为随身商店和NPC商店
--**********************************
function x181002_NewDispatchShopItem(sceneId,selfId,targetId,shopId)
	if targetId >= 0 then
		DispatchShopItem( sceneId, selfId,targetId, shopId )
	else
		DispatchNoNpcShopItem( sceneId, selfId, shopId )
	end
end


--**********************************
--接受此NPC的任务
--**********************************
function x181002_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x181002_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
	for i, findId in g_eventListTest do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x181002_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x181002_g_eventList do
		if missionScriptId == findId then
			x181002_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
	for i, findId in g_eventListTest do
		if missionScriptId == findId then
			x181002_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end
--**********************************
--继续（已经接了任务）
--**********************************
function x181002_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x181002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
	for i, findId in g_eventListTest do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end