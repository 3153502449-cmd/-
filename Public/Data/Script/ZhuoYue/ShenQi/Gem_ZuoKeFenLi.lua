--宝石熔炼

--脚本号
x290205_g_ScriptId	= 290205
function x290205_OnDoubleGemZhuoKe( sceneId, selfId, ItemIndex1, ItemIndex2, ItemIndex3)
	if not ItemIndex1 or not ItemIndex2  or not ItemIndex3  or ItemIndex1==-1  or  ItemIndex2 ==-1  or  ItemIndex3 ==-1  then
		return
	end
	local nAssistCount =4
	local GemItemID1 = LuaFnGetItemTableIndexByIndex(sceneId, selfId, ItemIndex1) --获取物品ID	
    local GemItemID2 = LuaFnGetItemTableIndexByIndex(sceneId, selfId, ItemIndex2) --获取物品ID	
    local GemItemID3 = LuaFnGetItemTableIndexByIndex(sceneId, selfId, ItemIndex3) --获取物品ID	
	local insx = GetItemQuality(GemItemID1)
	local insx1 = GetItemQuality(GemItemID2)
    if insx1 >6 then
      nAssistCount =3
    end 
	if insx1 > insx then 
	x290205_NotifyFailTips(sceneId, selfId, "等级不可大于冥石。")	
	return
	end
    if mod(GemItemID1,10) ~= mod(GemItemID2,10) -4  then	
	x290205_NotifyFailTips(sceneId, selfId, "参与琢刻的宝石种类必须相同。")		
	return
	end
	
	
	if x290205_IsGem( GemItemID1 ) ~= 1 then 
	  x290205_NotifyFailTips( sceneId, selfId,"请放入胜利宝石!" )	
	return
	end	
	if x290205_IsGem( GemItemID2 ) ~= 1 then 
	  x290205_NotifyFailTips( sceneId, selfId,"请放入智慧宝石!" )	
	return
	end	
	if LuaFnGetItemType( GemItemID1 ) ~= 21 then 
	x290205_NotifyFailTips( sceneId, selfId,"请放入胜利宝石!" )
	return
	end
	if LuaFnGetItemType( GemItemID2 ) ~= 2 then 
	x290205_NotifyFailTips( sceneId, selfId,"请放入智慧宝石!" )
	return
	end	
	
	if LuaFnGetAvailableItemCount(sceneId, selfId, GemItemID2) <nAssistCount   then 
	x290205_NotifyFailTips(sceneId, selfId, "你的#{_ITEM"..tostring(GemItemID2).."}不足"..nAssistCount.."个")	
	return
	end
	
	if GemItemID3  ~= 38000446  and  GemItemID3  ~= 38000445 then 
	 x290205_NotifyFailTips(sceneId, selfId, "你的#{_ITEM38000446}不足一个")	
	return
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, GemItemID3) < 1   then
	x290205_NotifyFailTips(sceneId, selfId, "你的#{_ITEM38000446}不足一个")
	return
	end 	
	--是否金钱足够，为0说明是没有金钱要求
	local havemoney = GetMoney(sceneId, selfId)
	local haveJiaoZi = GetMoneyJZ(sceneId, selfId)
	if  havemoney+haveJiaoZi < 200000 then
		x290205_NotifyFailTips(sceneId, selfId, "#{JNHC_81015_18}20个金")
		return
	end
	local NewGemItemID=x290205_NewIsGem( GemItemID1,insx1 )	
	if NewGemItemID <1 then
		return
	end
        local   strv1 = GetBagItemTransfer( sceneId, selfId, ItemIndex1 )
        local   strv2 =   GetBagItemTransfer( sceneId, selfId, ItemIndex2 )
	--扣除金钱，为0说明是没有金钱要求
	if havemoney+haveJiaoZi > 0 then
		local jz, jb = LuaFnCostMoneyWithPriority(sceneId, selfId, 200000)
		if jz == -1 then
			x290205_NotifyFailTips(sceneId, selfId, "扣除金钱失败！")
			return
		end
	end
    if LuaFnEraseItem(sceneId, selfId, ItemIndex1) ~= 1 then
	x290205_NotifyFailTips(sceneId, selfId, "扣除物品失败！")
	return
	end 
	if LuaFnDelAvailableItem(sceneId,selfId,GemItemID2, nAssistCount) ~=1 then 
	x290205_NotifyFailTips(sceneId, selfId, "扣除物品失败！")	
	return
	end
    if LuaFnDelAvailableItem(sceneId,selfId,GemItemID3, 1) ~= 1 then
	x290205_NotifyFailTips(sceneId, selfId, "扣除物品失败！")
	return
	end
			
	


        local   itemindex2 = GetBagItemTransfer( sceneId, selfId, ItemIndex2 )
        local   itemindex1 =   GetBagItemTransfer( sceneId, selfId, ItemIndex1 )

	

	
	
	--给物品
	local BagIndex = TryRecieveItem( sceneId, selfId, NewGemItemID, 1 )
	if BagIndex ~= -1 then
	LuaFnItemBind( sceneId, selfId, BagIndex )	
	strv3 =   GetBagItemTransfer( sceneId, selfId, BagIndex )	
	end
	
	
		
	
       local bagindex = GetBagItemTransfer( sceneId, selfId, BagIndex )
		x290205_NotifyFailTips(sceneId, selfId, "恭喜你，琢刻成功！！你成功琢刻了一颗 #{_INFOMSG"..strv3.."}")
		
		
		
	 	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
	 	LuaFnSendAbilitySuccessMsg( sceneId, selfId, -1, -1,NewGemItemID )		-- 提示生成物
	 	local str = format( "#{_INFOUSR%s}#H极为小心的将四颗#{_INFOMSG%s1}#H琢刻至#{_INFOMSG%s2}#H内，光影流转中，却未曾料到这几块宝石竟然灵气相融，竟化作奇珍#{_INFOMSG%s3}#H。", GetName( sceneId, selfId), strv2, strv1, strv3)
	    BroadMsgByChatPipe( sceneId, selfId,str, 4 )
	 	


	
end
---------------分离



function x290205_NewIsGem( itemIndex,GemLevel )
	local idx =0 
	idx =mod(itemIndex,10)
    if idx <1 or idx >4 then 
	return 0 
	end		
	ddfw,k =gsub(itemIndex,"(%d%d%d%d%d)%d(%d)%d","%1"..tostring(idx).."%2"..GemLevel)
	if k ==0 then 
		return 0
	end		
	ddfw=tonumber(ddfw)	
	if ddfw ==nil then 
		return 0
	end
    return ddfw
end



function x290205_IsGem( itemIndex )
	if floor( itemIndex / 10000000 ) == 5 then
		return 1
	end

	return 0
end
function x290205_Gemfenli_GetfdsfsdeBsgEm(GemItemID)
	 n_GemItemID =tostring(GemItemID) 
	local lksqw,ddfw,nAssistCount  = -1,nil,nil
	local x,y,GemLevel =  strfind(n_GemItemID,"%d%d(%d)%d%d%d%d%d")
	if x == nil or y == nil then 
		GemLevel=0
	end
	GemLevel=tonumber(GemLevel)
	if GemLevel ==nil or GemLevel ==0 then 
	return -1,nil,nil	
	end
	local x,y,IcemLevel = strfind(n_GemItemID,"%d%d%d%d%d%d%d(%d)")
	if x == nil or y == nil then 
		IcemLevel=0
	end	
	IcemLevel=tonumber(IcemLevel)
	if IcemLevel ==nil or IcemLevel ==0 then 
	return -1,nil,nil	
	end
	
	local x,y,GemIndex = strfind(n_GemItemID,"%d%d%d%d%d(%d)%d%d")
	if x == nil or y == nil then 
		GemIndex=0
	end	
	GemIndex=tonumber(GemIndex)
	if GemIndex ==nil or GemIndex ==0 then 
	return -1,nil,nil	
	end
	

	local x,y,HemIndex = strfind(n_GemItemID,"(%d%d%d%d%d)%d%d%d")
	if x == nil or y == nil then 
		HemIndex=0
	end		
	if HemIndex ==0 or strlen(HemIndex) ~= 5 then
		return -1,nil,nil	
	end 
	
	
    lksqw = tostring(HemIndex).."00"..GemIndex
	
	lksqw=tonumber(lksqw)
	if lksqw ==nil then 
	 return -1,nil,nil	
	end
   local baoshibiao = {50002005,50002006,50002007,50002008}
   if baoshibiao[GemIndex] == nil then 
	return -1,nil,nil
   end
    ddfw,k = gsub(baoshibiao[GemIndex],"(%d%d)%d(%d%d%d%d%d)","%1"..tostring(IcemLevel).."%2")
	if k==0 then 
		return -1,nil,nil
	end	
	if ddfw ==nil or strlen(ddfw) ~= 8 then 
		return -1,nil,nil
	end
	local x,y,kGemLevel =  strfind(ddfw,"%d%d(%d)%d%d%d%d%d")
	if x == nil or y == nil then 
		kGemLevel=0
	end	
	if kGemLevel ==nil or kGemLevel ==0 then 
	return -1,nil,nil	
	end		
	
	ddfw = tonumber(ddfw)
    if ddfw == nil then 
		return -1,nil,nil
	end
   nAssistCount =4	
   if tonumber(kGemLevel) >=7 then 
	nAssistCount=3
   end	
   return lksqw,ddfw,nAssistCount 
end

function x290205_OnDoubleGemFenLi( sceneId, selfId, g_GemItemPos, g_fenlifuPos)
	if g_GemItemPos ==nil or g_GemItemPos ==-1 then 
	return
	end
	if g_fenlifuPos ==nil or g_fenlifuPos ==-1 then 
	return
	end	
    local GemItemID1 = LuaFnGetItemTableIndexByIndex( sceneId, selfId, g_GemItemPos )		
	local GemItemID2 =LuaFnGetItemTableIndexByIndex(sceneId, selfId,  g_fenlifuPos) 
	if x290205_IsGem( GemItemID1 ) ~= 1 then 
	  x290205_NotifyFailTips( sceneId, selfId,"请放入双属性宝石!" )	
	return
	end
	
	if mod(GemItemID1,1000) <100 then 
	x290205_NotifyFailTips( sceneId, selfId,"请放入双属性宝石!" )	
	return
	end
	if  LuaFnGetMaterialBagSpace( sceneId, selfId ) < 5 then
	x290205_NotifyFailTips( sceneId, selfId,"请保持材料和道具栏有5个空位" )
	return	
    end
	
	if GemItemID2 ~= 38000447 and GemItemID2 ~= 38000444 then 
	return
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, GemItemID2) < 1   then
		x290205_NotifyFailTips(sceneId, selfId, "你的#{_ITEM38000447}不足一个")
	 return
	end
   local lksqw,ddfw,nAssistCount  = x290205_Gemfenli_GetfdsfsdeBsgEm(GemItemID1)	
	if lksqw <1 then 
	 x290205_NotifyFailTips( sceneId, selfId,"请放入双属性宝石!" )		
	return
	end 
	--检测金钱是否足够....
	local PlayerMoney = GetMoney( sceneId, selfId ) +  GetMoneyJZ(sceneId, selfId)  --交子普及 Vega
	if PlayerMoney < 200000 then
		x290205_NotifyFailTips( sceneId, selfId, "金钱不足，分离失败。" )
		return
	end
   jb = LuaFnCostMoneyWithPriority(sceneId, selfId, 200000)
   if jb ==-1 then
   x290205_NotifyFailTips( sceneId, selfId, "金钱不足，扣取失败。" )
   return
   end

    local bagindexs = GetBagItemTransfer( sceneId, selfId, g_GemItemPos )
	if LuaFnEraseItem(sceneId, selfId, g_GemItemPos) ~= 1 or LuaFnDelAvailableItem(sceneId,selfId,GemItemID2, 1) ~= 1 then
		x290205_NotifyFailTips(sceneId, selfId, "扣除物品失败！")
		return
	end
	
	local pos = TryRecieveItem( sceneId, selfId, tonumber(lksqw), 1 )
	local bagindexs1=""
	if pos ~= -1 then 
	 LuaFnItemBind( sceneId, selfId, pos )	
     bagindexs1 = GetBagItemTransfer( sceneId, selfId, pos )
    end
	
    for i=1, nAssistCount do 
		local pos = TryRecieveItem( sceneId, selfId, tonumber(ddfw), 1 )
		LuaFnItemBind( sceneId, selfId, pos )
		if bagindexs2 == nil then 
			bagindexs2=GetBagItemTransfer( sceneId, selfId, pos )
		end
	end 
	local pos = TryRecieveItem( sceneId, selfId, tonumber(38000446), 1 )
	local bagindexs3=""
	if pos ~= -1 then 
	 LuaFnItemBind( sceneId, selfId, pos )	
     bagindexs3 = GetBagItemTransfer( sceneId, selfId, pos )
    end	
  local str = format( "#{_INFOUSR%s}#H小心翼翼的从#{_INFOMSG%s1}#H分离出一个#{_INFOMSG%s2}#H和"..nAssistCount.."颗完好无损的#{_INFOMSG%s3}和一个#{_INFOMSG%s4}。", GetName( sceneId, selfId), bagindexs, bagindexs1,bagindexs2,bagindexs3)
BroadMsgByChatPipe( sceneId, selfId,str, 4 )
LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x290205_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

