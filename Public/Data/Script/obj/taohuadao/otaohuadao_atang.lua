--桃花岛NPC-阿棠
--2019-11-15 20:27:34 逍遥子
--脚本号
x000525_g_scriptId = 000525
x000525_g_JiaoRenYi = 38004033
x000525_g_TaoHuaDaoSceneID = 720;
--**********************************
--事件列表
--**********************************
function x000525_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{THD_190613_103}");
		AddNumText(sceneId, x000525_g_scriptId, "#{THD_190613_104}",6,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000525_OnDefaultEvent( sceneId, selfId,targetId )
	x000525_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000525_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	if sign == 0 then
		local nMenPai = GetMenPai(sceneId,selfId);
		if nMenPai == MP_TAOHUADAO then
			if sceneId ~= x000525_g_TaoHuaDaoSceneID then
				x000525_Tips( sceneId, selfId, "#{THD_190613_105}" )
				return
			end
			if IsTeamFollow( sceneId, selfId ) == 1 then --是不是组队跟随
				x000525_Tips( sceneId, selfId, "#{THD_190613_108}" )
				x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_109}" )
				return 
			end
			if LuaFnIsModelOrMount( sceneId, selfId ) == 1 then --是不是变身
				x000525_Tips( sceneId, selfId, "#{THD_190613_110}" )
				x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_111}" )
				return
			end
			--99件限制
			local nTodayNum = GetMissionDataEx(sceneId,selfId,MD_TAOHUADAO_JIAORENYI);
			if nTodayNum > 99 then --超过99件真的是太过分了
				x000525_Tips( sceneId, selfId, "#{THD_190613_133}" )
				x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_134}" )
				return
			end
			BeginAddItem(sceneId)
			AddItem( sceneId,38004033, 1 )
			if EndAddItem(sceneId,selfId) <= 0 then
				x000525_Tips( sceneId, selfId, "#{THD_190613_117}" )
				x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_118}" )
				return 
			end
			AddItemListToHuman(sceneId,selfId)
			x000525_Tips( sceneId, selfId, "#{THD_190613_131}" )
			x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_132}" )
			SetMissionDataEx(sceneId,selfId,MD_TAOHUADAO_JIAORENYI,nTodayNum + 1)
		else
			BeginUICommand(sceneId)
				UICommand_AddInt( sceneId,tonumber(targetId))
			EndUICommand(sceneId )
			DispatchUICommand(sceneId,selfId, 1000000135)
		end
	end
	return
end
--**********************************
-- 鲛人衣购买反馈
--**********************************
function x000525_BuyJiaoRenyi(sceneId,selfId,targetId)
	if targetId == nil then
		targetId = -1
	end
	if sceneId ~= x000525_g_TaoHuaDaoSceneID then
		x000525_Tips( sceneId, selfId, "#{THD_190613_105}" )
		return
	end
	if IsTeamFollow( sceneId, selfId ) == 1 then --是不是组队跟随
		x000525_Tips( sceneId, selfId, "#{THD_190613_108}" )
		x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_109}" )
		return 
	end
	if LuaFnIsModelOrMount( sceneId, selfId ) == 1 then --是不是变身
		x000525_Tips( sceneId, selfId, "#{THD_190613_110}" )
		x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_111}" )
		return
	end
	local nMoneySelf = GetMoneyJZ(sceneId,selfId) + GetMoney(sceneId,selfId)
	local nNeedMoney = 1;--一个铜钱吧
	if nMoneySelf < nNeedMoney then
		x000525_Tips( sceneId, selfId, "#{THD_190613_115}" )
		x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_116}" )
		return
	end
	--99件限制
	local nTodayNum = GetMissionDataEx(sceneId,selfId,MD_TAOHUADAO_JIAORENYI);
	if nTodayNum > 99 then --超过99件真的是太过分了
		x000525_Tips( sceneId, selfId, "#{THD_190613_133}" )
		x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_134}" )
		return
	end
	LuaFnCostMoneyWithPriority( sceneId, selfId,nNeedMoney) --扣钱
	BeginAddItem(sceneId)
	AddItem( sceneId,38004033, 1 )
	if EndAddItem(sceneId,selfId) <= 0 then
		x000525_Tips( sceneId, selfId, "#{THD_190613_117}" )
		x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_118}" )
		return 
	end
	AddItemListToHuman(sceneId,selfId)
	x000525_Tips( sceneId, selfId, "#{THD_190613_131}" )
	x000525_NotifyFailBox( sceneId, selfId, targetId, "#{THD_190613_132}" )
	SetMissionDataEx(sceneId,selfId,MD_TAOHUADAO_JIAORENYI,nTodayNum + 1)
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x000525_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--玩家屏幕中间提示
--**********************************
function x000525_Tips( sceneId, selfId, str )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end