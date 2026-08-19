--云姗姗
--珍兽套装NPC
--脚本号
x001088_g_scriptId = 001088

x001088_g_shoptableindex=1

--所拥有的事件ID列表
x001088_g_eventList={}

x001088_g_EquipList={
--85珍兽套.胆小
{n=8510,id=39985111},{n=8510,id=39985112},{n=8510,id=39985113},{n=8510,id=39985114},{n=8510,id=39985115},
--85珍兽套.勇猛
{n=8520,id=39985211},{n=8520,id=39985212},{n=8520,id=39985213},{n=8520,id=39985214},{n=8520,id=39985215},
--85珍兽套.忠诚
{n=8530,id=39985311},{n=8530,id=39985312},{n=8530,id=39985313},{n=8530,id=39985314},{n=8530,id=39985315},
--95珍兽套.胆小
{n=9510,id=39995111},{n=9510,id=39995112},{n=9510,id=39995113},{n=9510,id=39995114},{n=9510,id=39995115},
--95珍兽套.勇猛
{n=9520,id=39995211},{n=9520,id=39995212},{n=9520,id=39995213},{n=9520,id=39995214},{n=9520,id=39995215},
--95珍兽套.忠诚
{n=9530,id=39995311},{n=9530,id=39995312},{n=9530,id=39995313},{n=9530,id=39995314},{n=9530,id=39995315},
}

x001088_g_StoneList={
{n=1,id=20301009,num=30,str="圣兽鳞"},
{n=2,id=20301009,num=100,str="圣兽鳞"},
}

--**********************************
--事件列表
--**********************************
function x001088_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"#{ZSZB_090421_09}")
	AddNumText(sceneId,x001088_g_scriptId,"珍兽套装星级提升",6,1)
	AddNumText(sceneId,x001088_g_scriptId,"珍兽套装拆解",6,2)
	AddNumText(sceneId,x001088_g_scriptId,"珍兽套装兑换",6,3)
	AddNumText(sceneId,x001088_g_scriptId,"珍兽套装星级提升介绍",11,4)
	AddNumText(sceneId,x001088_g_scriptId,"珍兽套装拆解介绍",11,5)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x001088_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 0  then
		-- 关闭窗口
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		return
	end

	if GetNumText() == 1 then
	  BeginUICommand(sceneId);
		UICommand_AddInt(sceneId, targetId);
	  EndUICommand(sceneId);
	  DispatchUICommand(sceneId, selfId, 201709251);
	end

	if GetNumText() == 2 then
	  BeginUICommand(sceneId);
		UICommand_AddInt(sceneId, targetId)
		UICommand_AddInt(sceneId, 30)
	  EndUICommand(sceneId);
	  DispatchUICommand(sceneId, selfId, 201709252);
	end


	if GetNumText() == 3 then
		BeginEvent(sceneId)
            AddText(sceneId,"#{ZSZBDH_090806_1}")
		    AddNumText( sceneId, x001088_g_ScriptId, "兑换85级珍兽套装", 6, 8500 )
		    AddNumText( sceneId, x001088_g_ScriptId, "兑换95级珍兽套装", 6, 9500 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	if GetNumText() == 4 then
		BeginEvent(sceneId)
            AddText(sceneId,"#{ZSZBSJ_090706_14}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	
	if GetNumText() == 5 then
		BeginEvent(sceneId)
            AddText(sceneId,"#{ZSZBSJ_090706_16}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end


	if GetNumText() == 8500 then
		BeginEvent(sceneId)
			AddText(sceneId, "    兑换的85级珍兽装备，每件需要“圣兽鳞”30个，大侠准备好了吗？")
		        AddNumText( sceneId, x001088_g_ScriptId, "#Y兑换·#G飞鹰翔空#Y套装", 6, GetNumText()+10 )
		        AddNumText( sceneId, x001088_g_ScriptId, "#Y兑换·#G猛虎撼山#Y套装", 6, GetNumText()+20 )
		        AddNumText( sceneId, x001088_g_ScriptId, "#Y兑换·#G巨熊哮路#Y套装", 6, GetNumText()+30 )
			AddNumText( sceneId, x001088_g_ScriptId, "离开……", 0, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end


	if GetNumText() == 9500 then
		BeginEvent(sceneId)
			AddText(sceneId, "    兑换的95级珍兽装备，每件需要“圣兽鳞”100个，大侠准备好了吗？")
		        AddNumText( sceneId, x001088_g_ScriptId, "#Y兑换·#G昆鹏异羽#Y套装", 6, GetNumText()+10 )
		        AddNumText( sceneId, x001088_g_ScriptId, "#Y兑换·#G雄狮逆鳞#Y套装", 6, GetNumText()+20 )
		        AddNumText( sceneId, x001088_g_ScriptId, "#Y兑换·#G玄龟奇血#Y套装", 6, GetNumText()+30 )
			AddNumText( sceneId, x001088_g_ScriptId, "离开……", 0, 0 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end


	if GetNumText() > 8500 and GetNumText() < 10000  then
		BeginEvent(sceneId)
			local nLevel = 0
			if GetNumText() == 8510 then
				nLevel = 1
			end
			if GetNumText() == 8520 then
				nLevel = 1
			end
			if GetNumText() == 8530 then
				nLevel = 1
			end
			if GetNumText() == 9510 then
				nLevel = 2
			end
			if GetNumText() == 9520 then
				nLevel = 2
			end
			if GetNumText() == 9530 then
				nLevel = 2
			end

			local szStr = "  要获得这些装备，你需要给我“" .. x001088_g_StoneList[nLevel].str.. "”“".. tostring(x001088_g_StoneList[nLevel].num) .. "”个  该物品可通过#G拆解75级珍兽套装#W获得,75级珍兽套装在#G十二杀星#W中爆出....#r  #G注意看装备适合什么类型的珍兽，不要换错了哦#W"
			AddText(sceneId, szStr)
			
			for i, item in x001088_g_EquipList do
				if item.n == GetNumText()  then
					AddRadioItemBonus( sceneId, item.id, 4 )
				end
			end
        EndEvent(sceneId)
        DispatchMissionContinueInfo(sceneId,selfId,targetId, x001088_g_ScriptId, 0)	
	end

	for i, findId in x001088_g_eventList do
		if eventId == findId then			
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--远程调用响应
--**********************************
function x001088_Pet_Equip( sceneId, selfId, index, arg1, arg2, arg3, arg4)
      local petEquip = LuaFnGetItemTableIndexByIndex( sceneId, selfId, arg1 )
      if  not petEquip or petEquip == nil then
          return
      end

	local petEquipAA = floor(petEquip/100000)               --是否399开头
        local petEquipBB = floor(mod(petEquip,100000)/1000)     --多少级
        local petEquipCC = floor(mod(petEquip,1000)/100)        --类型
        local petEquipDD = floor(mod(petEquip,100)/10)          --星级
        local petEquipEE = mod(petEquip,10)                     --部位

	--先检查是不是珍兽套装
	if petEquipAA ~= 399 then
		x001088_Tips( sceneId, selfId,"只能放入珍兽套装")
		return
	end
	if petEquipBB ~= 75 and petEquipBB ~= 85 and petEquipBB ~= 95 then
		x001088_Tips( sceneId, selfId,"只能放入珍兽套装")
		return
	end
	if petEquipCC < 1 and petEquipCC > 3 then
		x001088_Tips( sceneId, selfId,"只能放入珍兽套装")
		return
	end
	if petEquipDD < 1 or petEquipDD > 6 then
		x001088_Tips( sceneId, selfId,"只能放入珍兽套装")
		return
	end

	if LuaFnGetMaterialBagSpace( sceneId, selfId) < 2 or LuaFnGetPropertyBagSpace( sceneId, selfId ) < 2 then
		x001088_Tips( sceneId, selfId,"道具栏和材料栏至少各需要2以上个空位")
		return
	end


    if index == 1 then
        local CailiaoNum = {}
              CailiaoNum[75] = {3,5,7,11,16}
              CailiaoNum[85] = {16,18,20,24,28}
              CailiaoNum[95] = {36,43,50,56,63}
	if petEquipDD > 6 then
		x001088_Tips( sceneId, selfId,"你的珍兽套装已满级，无需继续升星")
		return
	end

	if LuaFnGetAvailableItemCount(sceneId, selfId, 20301009) < CailiaoNum[petEquipBB][petEquipDD] then
	   x001088_Tips( sceneId, selfId, "你的#{_ITEM20301009}不足"..CailiaoNum[petEquipBB][petEquipDD].."个，不能升星" )
	   return
	end

        if petEquipDD == 5 then
	   if LuaFnGetAvailableItemCount(sceneId, selfId, 20301010) < 1 then
	      x001088_Tips( sceneId, selfId, "你的#{_ITEM20301010}不足1个，不能升星" )
	      return
	   end
	end

	local HumanMoney = LuaFnGetMoney( sceneId, selfId )
  	local HumanMoneyJZ = GetMoneyJZ( sceneId, selfId );
	if HumanMoney + HumanMoneyJZ < 500000  then
		x001088_Tips( sceneId, selfId, "你的金钱不足，无法继续！" )
		return
	end
	local nDelJZ, nDelMoney = LuaFnCostMoneyWithPriority(sceneId, selfId, 10000);

        if LuaFnDelAvailableItem(sceneId,selfId,20301009,CailiaoNum[petEquipBB][petEquipDD]) ~= 1 then
           x895111_NotifyTips( sceneId, selfId, "#{_ITEM20301009}扣取失败，请联系运营团队" )
           return
        end

        if petEquipDD == 5 then
	   if LuaFnDelAvailableItem(sceneId,selfId,20301010,1) ~= 1 then
	      x001088_Tips( sceneId, selfId, "#{_ITEM20301010}扣取失败，请联系运营团队" )
	      return
	   end
	end

        if  LuaFnEraseItem( sceneId, selfId, arg1 ) ~= 1 then
            x001088_Tips( sceneId, selfId, "未知错误，物品扣取失败" )
            return
        end

        local pos = TryRecieveItem( sceneId, selfId, petEquip+10, 1 )
        local transfer = GetBagItemTransfer(sceneId,selfId,pos)
        x001088_Tips( sceneId, selfId, "恭喜您，珍兽装备升星成功。请查看道具栏" )
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效 
        if petEquipDD == 5 then
	        local str = format( "#ccc33cc恭喜玩家".."#{_INFOUSR%s}#c66ccff在苏州#Y云姗姗(354,268)#B处#B成功进阶出满级珍兽套装#{_INFOMSG%s}，了不得啊~", GetName(sceneId,selfId),transfer)
			BroadMsgByChatPipe( sceneId, selfId, str, 4 )
        end
     end


    if index == 2 then

        local Chaijie = {}
              Chaijie[75] = {2,5,9,14,20,27}
              Chaijie[85] = {20,30,35,42,57,69}
              Chaijie[95] = {50,68,90,115,143,171}
	local HumanMoney = LuaFnGetMoney( sceneId, selfId )
  	local HumanMoneyJZ = GetMoneyJZ( sceneId, selfId );
	if HumanMoney + HumanMoneyJZ < 500000  then
		x001088_Tips( sceneId, selfId, "你的金钱不足1金，手续费都不够" )
		return
	end
	local nDelJZ, nDelMoney = LuaFnCostMoneyWithPriority(sceneId, selfId, 10000);
        if  LuaFnEraseItem( sceneId, selfId, arg1 ) ~= 1 then
            x001088_Tips( sceneId, selfId, "未知错误，物品扣取失败" )
            return
        end
        for i = 1,Chaijie[petEquipBB][petEquipDD] do
           TryRecieveItem( sceneId, selfId, 20301009, 1)
        end
        x001088_Tips( sceneId, selfId, "恭喜您，珍兽装备拆解成功。获得了"..Chaijie[petEquipBB][petEquipDD].."个圣兽鳞" )
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效 
     end



end


--*************************************************
--屏幕中间对话提示
--*************************************************
function x001088_Tips( sceneId, selfId,msg )
BeginEvent( sceneId )
		AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end


--**********************************
--接受此NPC的任务
--**********************************
function x001088_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001088_g_eventList do
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
function x001088_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001088_g_eventList do
		if missionScriptId == findId then
			x001088_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
	for i, findId in g_eventListTest do
		if missionScriptId == findId then
			x001088_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001088_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001088_g_eventList do
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

--**********************************
--提交已做完的任务
--**********************************
function x001088_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )

	--处理提交后的显示情况
	--为了安全，这里要仔细，不能出错
	local nItemIndex = -1
	
	for i, item in x001088_g_EquipList do
		if item.id == selectRadioId  then
			nItemIndex = i
		end
	end
	
	if nItemIndex == -1  then
		return
	end
	
	-- 看完家是不是够材料提交
	local nLevel = 0
	if x001088_g_EquipList[nItemIndex].n == 8510 then
		nLevel = 1
	end
	if x001088_g_EquipList[nItemIndex].n == 8520 then
		nLevel = 1
	end
	if x001088_g_EquipList[nItemIndex].n == 8530 then
		nLevel = 1
	end
	if x001088_g_EquipList[nItemIndex].n == 9510 then
		nLevel = 2
	end
	if x001088_g_EquipList[nItemIndex].n == 9520 then
		nLevel = 2
	end
	if x001088_g_EquipList[nItemIndex].n == 9530 then
		nLevel = 2
	end

	local bStoneOk = 0
	if GetItemCount(sceneId, selfId, x001088_g_StoneList[nLevel].id) >= x001088_g_StoneList[nLevel].num  then
		bStoneOk = 1
	end
	
	if  bStoneOk == 0 then
		BeginEvent(sceneId)
			strText = "你没有足够的圣兽鳞，不能换取该装备。"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	
	-- 检查是不是有足够的石头可以扣除
	if LuaFnGetAvailableItemCount(sceneId, selfId, x001088_g_StoneList[nLevel].id) < x001088_g_StoneList[nLevel].num   then
		BeginEvent(sceneId)
			strText = "你没有足够的圣兽鳞品可以被扣除，请检查圣兽鳞是否上锁。"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
		
	end
	
	-- 检查背包空间
	BeginAddItem(sceneId)
		AddItem(sceneId, selectRadioId, 1)
	local bBagOk = EndAddItem(sceneId, selfId)
	
	if bBagOk < 1 then
		BeginEvent(sceneId)
			strText = "你的背包没有空间了。"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	end
	local nItemBagIndexStone = GetBagPosByItemSn(sceneId, selfId, x001088_g_StoneList[nLevel].id)
	local szTransferStone = GetBagItemTransfer(sceneId,selfId, nItemBagIndexStone)
	
	-- 删除相关的石头
	local bDelOk = LuaFnDelAvailableItem(sceneId,selfId, x001088_g_StoneList[nLevel].id, x001088_g_StoneList[nLevel].num)
	
	if bDelOk < 1  then
		BeginEvent(sceneId)
			strText = "扣除圣兽鳞失败。"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		return
	else
		--给完家东西，完成
		-- AddItemListToHuman(sceneId,selfId)
		--
		local nBagIndex = TryRecieveItem( sceneId, selfId, x001088_g_EquipList[nItemIndex].id, 1 );
		
		BeginEvent(sceneId)
			strText = "恭喜您，成功兑换了[#{_ITEM"..x001088_g_EquipList[nItemIndex].id.."}]"
			AddText(sceneId,strText);
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效
		
		local message;	
		local randMessage = random(3);
		local sItemName = GetItemName(sceneId, x001088_g_EquipList[nItemIndex].id)
		
		local szTransferEquip = GetBagItemTransfer(sceneId,selfId, nBagIndex)
		
		if randMessage == 1 then
		   	message = format("#W#{_INFOUSR%s}#W#{WLS_08}#Y%d#W#{WLS_09}#{_INFOMSG%s}#I毕恭毕敬送到#G苏州#R云姗姗(354,268)#I哈哈大笑：“甚好，这个#{_INFOMSG%s}#{WLS_11}", LuaFnGetName(sceneId, selfId), x001088_g_StoneList[nLevel].num, szTransferStone, szTransferEquip);
		elseif randMessage == 2 then
			message = format("#W#{_INFOUSR%s}#W#{WLS_03}#Y%d#W#{WLS_04}#{_INFOMSG%s}	#I送到#G苏州#R云姗姗(354,268)#I拱了拱手：“有劳有劳，#{_INFOMSG%s}#{WLS_06}#{_INFOMSG%s}#{WLS_07}", LuaFnGetName(sceneId, selfId), x001088_g_StoneList[nLevel].num, szTransferStone, szTransferStone, szTransferEquip);
		else
			message = format("#W#G苏州#R云姗姗(354,268)#I捧着#Y%d#cffffcc片#W#{_INFOMSG%s}#cffffcc由衷的赞道：“#W#{_INFOUSR%s}#{WLS_01}#{_INFOMSG%s}#{WLS_02}", x001088_g_StoneList[nLevel].num, szTransferStone, LuaFnGetName(sceneId, selfId), szTransferEquip);
		end
		
		BroadMsgByChatPipe(sceneId, selfId, message, 4); 
		return
	end

	for i, findId in x001088_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
	for i, findId in g_eventListTest do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end


