-- 893082 宝箱
-- 获取buff的宝箱

x893082_g_scriptId = 893082


--所拥有的事件ID列表用ID集合实现
x893082_g_LimitiBuffCollectionID = 75;

--稀有材料 新莽神符4-7 50%
x893082_g_LootItem_3 = {
30505803,30505804,30505805,30505806,
}

--3级宝石，100%掉落随机 1 件
x893082_g_LootItem_2 = {
50301001,50301002,50302001,
50302002,50302003,50302008,50303001,50304002,50311001,50311002,50312005,
50312006,50312007,50312008,50313001,50313002,50313003,50313004,50313005,
50313006,50314001,
}
--3级冥晶石
x893082_g_LootItem_5 = {
50321001,50321002,50321004,50321003,50321101,50321102,50321103,50321201,
50321202,50321203,50321301,50321302,50321303,50321401,50321402,50321403,
}

--残缺神节6 7级  强化卷轴5789级 至尊强化精华 御兽道具 
x893082_g_LootItem_1 = {
30505706,30505705,38000552,38000553,38000554,38000555,38000572,38002011,
38002013,38002015,30503122,30503123,30503124,30503125,30503126,30503127,
30503129,30503130,30503131,30503132,30503133,30503134,30503140,
}

--狸美人
x893082_g_LootItem_4 = {
30309873,
}
--无敌buff
x893082_g_BuffId_1 = 54

--武林盟主buff
x893082_g_BuffId_2 = 8046

--驱散不该有的BUFF的效果
x893082_g_BuffId_3 = 8055	--心无旁骛（开箱驱散）


--心无旁骛BuffID
x893082_g_BuffId_4 = 8056	--心无旁骛（开箱免疫）

--Code Check Only
--QUALITY_CREATE_BY_BOSS =nil

--**********************************
--事件列表
--**********************************
function x893082_OnDefaultEvent( sceneId, selfId, targetId )
	
end

--**********************************
--特殊交互:条件判断
--**********************************
function x893082_OnActivateConditionCheck( sceneId, selfId, activatorId )
	-- 限制身上的buff
	local bOk = x893082_IsCanOpenBox( sceneId,activatorId )
	
	if bOk == 0  then
    BeginEvent(sceneId)
      AddText(sceneId,"你现在不能开启这个宝箱。");
    EndEvent(sceneId)
    DispatchMissionTips(sceneId,activatorId,selfId)
	end
	-- 驱散不该有的BUFF并添加心无旁骛Buff
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, activatorId, x893082_g_BuffId_3, 0);
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, activatorId, x893082_g_BuffId_4, 0);

	if bOk == 1  then
		local str = "#G[四绝庄]#W" .. GetName(sceneId, activatorId) .."#P正在打开宝箱呢！"
		CallScriptFunction((200060), "Duibai",sceneId, "", "", str)
	end
	
	return bOk
end

--**********************************
-- 检测当前玩家身上的buff，能不能开启宝箱
--**********************************
function x893082_IsCanOpenBox( sceneId,activatorId )
		return 1
end

--**********************************
--特殊交互:消耗和扣除处理
--**********************************
function x893082_OnActivateDeplete( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:聚气类成功生效处理
--**********************************
function x893082_OnActivateEffectOnce( sceneId, selfId, activatorId )
	
	-- selfId == 宝箱Id
	-- activatorId == 开启人Id
	
	local x
	local z
	
	x,z = GetWorldPos(sceneId, selfId)
	
	local nCount = GetMonsterCount(sceneId)
	local bDelOk = 0
	for i=0, nCount-1  do
		local nObjId = GetMonsterObjID(sceneId, i)
		local MosDataID = GetMonsterDataID( sceneId, nObjId )
		if MosDataID == 14156 then
		--if GetName(sceneId, nObjId) == "黄色宝箱"  then
			bDelOk = 1
			LuaFnDeleteMonster(sceneId, nObjId)
		end
	end
	
	-- 给开启成功的玩家一个掉落包
	local nItemCount = 2
	local nItemId_1
	local nItemId_2
	local nItemId_3
	local nItemId_4
	local nItemId_5
	local nItemId_6

	if random(1000) <= 900  then
		nItemCount = 3
		nItemId_1 = x893082_g_LootItem_1[random( getn(x893082_g_LootItem_1))]
	end

	if random(1000) <= 50  then
		nItemCount = 4
	       nItemId_3 = x893082_g_LootItem_3[random( getn(x893082_g_LootItem_3) )]
	end	
	if random(1000) <= 150  then
		nItemCount = 5
	       nItemId_6 = x893082_g_LootItem_4[random( getn(x893082_g_LootItem_4) )]
	end

	nItemId_2 = x893082_g_LootItem_2[random( getn(x893082_g_LootItem_2) )]
	nItemId_4 = x893082_g_LootItem_2[random( getn(x893082_g_LootItem_2) )]
	nItemId_5 = x893082_g_LootItem_5[random( getn(x893082_g_LootItem_5) )]
	
	
	if bDelOk == 1  then
		local nBoxId = DropBoxEnterScene(	x,z,sceneId )
		if nBoxId > -1  then
			if nItemCount == 3  then
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS,4,
								nItemId_1,nItemId_2,nItemId_4,nItemId_5)
			elseif nItemCount == 2  then
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS,3,
								nItemId_2,nItemId_4,nItemId_5)
			elseif nItemCount == 4  then
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS,4,
								nItemId_2,nItemId_3,nItemId_4,nItemId_5)

			elseif nItemCount == 5  then
				AddItemToBox(sceneId,nBoxId,QUALITY_CREATE_BY_BOSS,5,
								nItemId_2,nItemId_3,nItemId_4,nItemId_5,nItemId_6)
			end
			
			-- 把这个掉落绑定给制定玩家
			SetItemBoxOwner(sceneId, nBoxId, LuaFnGetGUID(sceneId,activatorId))
			
			-- 发送系统公告
			local nCurHour = GetHour()
			if nCurHour==0 or nCurHour==2 or nCurHour==4 or
				 nCurHour==6 or nCurHour==8 or nCurHour==10 or
				 nCurHour==12 or nCurHour==14 or nCurHour==16 or
				 nCurHour==18 or nCurHour==20 or nCurHour==22  then
				
					nCurHour = nCurHour + 2
			else
					nCurHour = nCurHour + 1
			
			end
			
			if nCurHour >= 2 and nCurHour < 10  then
				nCurHour = 10
			end
			
			if nCurHour == 24  then
				nCurHour = 0
			end
			
			--#P [世界]于九莲大喊：天下英雄们！强大的AAA已经打开了武林盟主的宝箱！请大家XXX点再来封禅台争夺武林盟主之位吧！
			local str = format("#{SJZ_100129_109}",GetName(sceneId,activatorId))
	BroadMsgByChatPipe(sceneId, selfId, str, 4)
			
		end
	end
	
	return 1
end

--**********************************
--特殊交互:引导类每时间间隔生效处理
--**********************************
function x893082_OnActivateEffectEachTick( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互开始时的特殊处理
--**********************************
function x893082_OnActivateActionStart( sceneId, selfId, activatorId )
	--PrintNum(777)
	return 1
end

--**********************************
--特殊交互:交互撤消时的特殊处理
--**********************************
function x893082_OnActivateCancel( sceneId, selfId, activatorId )
	local str = "#G[封禅台]#W" .. GetName(sceneId,activatorId) .. "#P打开宝箱的努力功败垂成！"
	CallScriptFunction((200060), "Duibai",sceneId, "", "", str)
	return 0
end

--**********************************
--特殊交互:交互中断时的特殊处理
--**********************************
function x893082_OnActivateInterrupt( sceneId, selfId, activatorId )
	
	return 0
end

function x893082_OnActivateInterrupt( sceneId, selfId, activatorId )

end

function x893082_DealExp(sceneId, activatorId)

	local nPlayerCamp = GetUnitCampID(sceneId, activatorId, activatorId)

	-- 开启宝箱的同时，分配Exp
	local nHumanIdList = {}
	
	for i=1, 10  do
		nHumanIdList[i] = -1
	end
	
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	local j=1
	for i=0, nHumanCount-1  do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if GetUnitCampID(sceneId, nHumanId, nHumanId) == nPlayerCamp   then
			nHumanIdList[j] = nHumanId
			j = j+1
		end
	end
	
	j = j-1
	
	for i=1, j  do
		if nHumanIdList[i] ~= -1  then
			AddExp(sceneId, nHumanIdList[i], floor(10000000/j))
		end
	end
	
	for i=0, nHumanCount-1  do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i)
		if GetUnitCampID(sceneId, nHumanId, nHumanId) ~= nPlayerCamp   then
			AddExp(sceneId, nHumanId, floor(10000000/(nHumanCount-j)))
		end
	end
	
end

--经验，
--和开宝箱的人相同阵营的人平分 10 万
--在场的除这些人以外的人平分 10 万

