--循环任务
--召集同伴
--************************************************************************
--MisDescBegin
--脚本号
x808131_g_ScriptId = 808131
x808131_g_ItemMsg = {39000004,39000005,38000010,38000011}

function x808131_OnDefaultEvent( sceneId, selfId, targetId )
	
	local bbb = LuaFnGetWorldGlobalData(18)
	if bbb >= 101 then
		x808131_SendGiftToAllPeople(sceneId,selfId,x808131_g_ItemMsg) --给大家发奖
		LuaFnSetWorldGlobalData(18,0)
	end
	
	BeginEvent( sceneId )
	AddText(sceneId,"  #Y您是否拥有着美丽的愿望呢？#W#r #r    传说#G太湖#W的#G（157,185）#W长着一棵神奇的#G许愿树#W，找到#G愿灵泉#W，怀着您的真心去浇灌它，让您的心愿开花结果吧！当前许愿次数为:"..bbb)
	AddNumText( sceneId, x808131_g_scriptId, "我要许愿", 6, 1)
	AddNumText(sceneId,x808131_g_ScriptId,"许愿果兑换奖励",6,3) 
	AddNumText( sceneId, x808131_g_scriptId, "我没有愿望", 6, 2 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

end
--**********************************
function x808131_OnEventRequest( sceneId, selfId, targetId, eventId )
local nCount = GetMissionData( sceneId, selfId, HETI_PETID)
if GetNumText() == 1 then
if  nCount >= 5 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SQXY_09061_7}")
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	return
end
if LuaFnGetAvailableItemCount(sceneId, selfId, 39000040) < 1 then
	BeginEvent( sceneId )
	AddText(sceneId,"缺少材料：#{_ITEM39000040}")
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
return
end

if LuaFnDelAvailableItem(sceneId,selfId,39000040, 1) ~= 1 then
	BeginEvent( sceneId )
	AddText(sceneId,"#{_ITEM39000040}扣除失败，请检查背包")
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
return
end



	BeginEvent( sceneId )
	AddText(sceneId,"找到愿灵泉，怀着你的真心去浇灌它，让你的心愿开花结果吧！")
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	TryRecieveItem( sceneId, selfId,20502010, 1 )

	TryRecieveItem( sceneId, selfId,39000016, 1 )

SetMissionData( sceneId, selfId, HETI_PETID,GetMissionData( sceneId, selfId, HETI_PETID)+1)
LuaFnSetWorldGlobalData(18,LuaFnGetWorldGlobalData(18)+1)
return
end

if GetNumText() == 2 then

		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)

return
end
if	GetNumText() == 3	then
	        BeginEvent(sceneId)
		AddText( sceneId, "  #W7个#G许愿果#W兑换#G红宝石(4级)#W一个#r  #W20个#G许愿果#W兑换#G红宝石(5级)#W一个#r #r  请确保你的背包道具栏和材料栏至少有一个空位。" )
		AddNumText( sceneId, x001086_g_scriptId, "兑换红宝石(4级)", 6, 321 )
		AddNumText( sceneId, x001086_g_scriptId, "兑换红宝石(5级)", 6, 351 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if  GetNumText() == 321	then	
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, 20502010)
        if c0 >=7 then
			BeginEvent( sceneId ) 
			LuaFnDelAvailableItem(sceneId,selfId,20502010,7)--删除许愿果
			local bagpos01 = TryRecieveItem( sceneId, selfId, 50413004, 1)--给予至尊强化
			local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
			x001086_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer,c0 )
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			strText = "    #Y恭喜你，获得#b#G红宝石(4级)！"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
				BeginEvent( sceneId ) 
				strText = "您身上没有#G7个许愿果#W啊！参加“一千零一个愿望”活动能够获得许愿果，快快行动吧。"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
	    end
    end

	if GetNumText() == 351 then
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, 20502010)
		if c0 >=20 then
			BeginEvent( sceneId ) 
			LuaFnDelAvailableItem(sceneId,selfId,20502010,20)--删除许愿果
			local bagpos01 = TryRecieveItem( sceneId, selfId, 50513004, 1)--给予红宝石
			local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
			x001086_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer ,c0)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			strText = "    #Y恭喜你，获得#b#G红宝石(5级)！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				strText = "您身上没有#G20个许愿果#W啊！参加“一千零一个愿望”活动能够获得许愿果，快快行动吧。"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
	    end
    end
end
--事件列表选中一项
--**********************************
function x808131_SendGiftToAllPeople(sceneId,objID,nItemID)
	local nMaxItemNum = getn(nItemID);		--掉落包最多出现数量
	local nSpaceX = 20;	--X方向正负方向 偏移范围
	local nSpaceZ = 20;	--Z方向正负方向 偏移范围
	local nDropNum = 20;	--生成掉落包数量
	local nDropTime = 60*1000;--掉落包消失时间 单位毫秒
	local nObjX, nObjZ = GetWorldPos(sceneId, objID);
	nObjX = floor(nObjX)
	nObjZ = floor(nObjZ)
	local nObjZ_Min = nObjX -nSpaceX;
	local nObjZ_Max;
	if nObjZ_Min < 0 then 
		nObjZ_Max = nObjX+nSpaceX-nObjZ_Min;
		nObjZ_Min = 0;
	else
		nObjZ_Max = nObjX+nSpaceX;
	end
	local nSpace_Min = nObjZ -nSpaceZ;
	local nSpace_Max;
	if nSpace_Min < 0 then 
		nSpace_Max = nObjZ +nSpaceZ-nSpace_Min;
		nSpace_Min = 0;
	else
		nSpace_Max = nObjZ +nSpaceZ;
	end
	local nSpace_X_Tab = {};
	local nSpace_Z_Tab = {};
	for i = nObjZ_Min,nObjZ_Max do
		tinsert(nSpace_X_Tab,i)
	end
	for i = nSpace_Min,nSpace_Max do
		tinsert(nSpace_Z_Tab,i)
	end
	local nSpace_Z_Tab_Tract = {};
	local nSpace_X_Tab_Tract = {};
	nObjX = getn(nSpace_X_Tab)
	for i=1,nDropNum do
		nObjZ = random(nObjX)
		tinsert(nSpace_Z_Tab_Tract,nSpace_X_Tab[nObjZ])
		tremove(nSpace_X_Tab,nObjZ)
		nObjX=nObjX-1
	end
	nObjX = getn(nSpace_Z_Tab)
	for i=1,nDropNum do
		nObjZ = random(nObjX)
		tinsert(nSpace_X_Tab_Tract,nSpace_Z_Tab[nObjZ])
		tremove(nSpace_Z_Tab,nObjZ)
		nObjX=nObjX-1
	end
	local nDropItemNum = getn(nItemID)
	local nDropItem_ID,nDropItem_NUMB,nDropItem_BOXID;
	for i=1,nDropNum do
		nDropItem_ID=random(nDropItemNum)
		nDropItem_ID=nItemID[nDropItem_ID]
		nDropItem_NUMB=random(nMaxItemNum)
		nDropItem_BOXID = LuaFnItemBoxEnterSceneEx(sceneId, nSpace_Z_Tab_Tract[i], nSpace_X_Tab_Tract[i], 773, nDropTime);
		if nDropItem_BOXID and nDropItem_BOXID ~= -1 then
			for i=1,nDropItem_NUMB do
				AddItemToBox(sceneId, nDropItem_BOXID, QUALITY_MUST_BE_CHANGE, 1, nDropItem_ID);
			end
		end
	end
	
end
function x808131_Tip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end