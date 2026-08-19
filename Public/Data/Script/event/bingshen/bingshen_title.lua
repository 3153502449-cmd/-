--兵圣奇阵称号系统
--2019-10-27 13:20:16 逍遥子
x894100_g_scriptId = 894100

--征南先锋印
x894100_g_XuanFuID = 20310184

--兑换需求
x894100_g_Cost = {1,15,45,90,150}
--称号id
x894100_g_TitleID = {239,240,241,101,102}
--不同等级的失败提示
x894100_g_FailMsg = {"兑换此称号需要#Y征南先锋印#W1个","兑换此称号需要#Y征南先锋印#W15个","兑换此称号需要#Y征南先锋印#W45个","兑换此称号需要#Y征南先锋印#W90个","兑换此称号需要#Y征南先锋印#W150个"}
--称号等级
x894100_g_TitleLvNum = 5;
--称号idx 程序用
x894100_g_TitleIndex = 19;


function x894100_ChangePiaoMiaoTitle(sceneId, selfId, targetId,titleLv)
	
	--DeleteTitle(sceneId,selfId,x894100_g_TitleIndex);
	--合法性检查
	if titleLv < 1 and titleLv > x894100_g_TitleLvNum then
		return
	end
	
	--角色现有称号	
	local HadTitleID = GetTitle(sceneId,selfId,x894100_g_TitleIndex)
	
	if (titleLv == 1) then
		--是否已有称号
		if (HadTitleID == x894100_g_TitleID[1]
				or HadTitleID == x894100_g_TitleID[2]
				or HadTitleID == x894100_g_TitleID[3]
				or HadTitleID == x894100_g_TitleID[4]
				or HadTitleID == x894100_g_TitleID[5]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, "#{PMF_REMINDINF_001}")	
			return
		end
	end
	
	if (titleLv == 2) then
		--是否已有称号
		if (HadTitleID == x894100_g_TitleID[2]
				or HadTitleID == x894100_g_TitleID[3]
				or HadTitleID == x894100_g_TitleID[4]
				or HadTitleID == x894100_g_TitleID[5]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, "#{PMF_REMINDINF_001}")	
			return
		end
		--是否有上一等级的称号
		if (HadTitleID ~= x894100_g_TitleID[1]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, x894100_g_FailMsg[titleLv])
			return
		end
	end
	
	if (titleLv == 3) then
		--是否已有称号
		if (HadTitleID == x894100_g_TitleID[3]
				or HadTitleID == x894100_g_TitleID[4]
				or HadTitleID == x894100_g_TitleID[5]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, "#{PMF_REMINDINF_001}")	
			return
		end
		--是否有上一等级的称号
		if (HadTitleID ~= x894100_g_TitleID[2]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, x894100_g_FailMsg[titleLv])
			return
		end
	end
	
	if (titleLv == 4) then
		--是否已有称号
		if (HadTitleID == x894100_g_TitleID[4]
				or HadTitleID == x894100_g_TitleID[5]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, "#{PMF_REMINDINF_001}")	
			return
		end
		--是否有上一等级的称号
		if (HadTitleID ~= x894100_g_TitleID[3]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, x894100_g_FailMsg[titleLv])
			return
		end
	end

	if (titleLv == 5) then
		--是否已有称号
		if (HadTitleID == x894100_g_TitleID[5]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, "#{PMF_REMINDINF_001}")	
			return
		end
		--是否有上一等级的称号
		if (HadTitleID ~= x894100_g_TitleID[4]) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, x894100_g_FailMsg[titleLv])
			return
		end
	end
	
	--检查物玄符量
	local checkRet = x894100_CheckXuanFu(sceneId,selfId,targetId,x894100_g_Cost[titleLv]);
	if (checkRet ~= 1) then
			x894100_NotifyFailBox(sceneId, selfId, targetId, x894100_g_FailMsg[titleLv])
			return
	end
	
	--扣除玄符
	local costRet = x894100_CostXuanFu(sceneId,selfId,targetId,x894100_g_Cost[titleLv]);
	if (costRet ~= 1) then
		x894100_NotifyFailBox(sceneId, selfId, targetId, "扣除物品失败！")
		return
	end
	
	--给予称号
	AwardTitle( sceneId, selfId, x894100_g_TitleIndex, x894100_g_TitleID[titleLv])
	--写audit日志 add by zhangguoxin 090226
	local guid = LuaFnObjId2Guid(sceneId, selfId);
	local LogInfo = format("LUAAUDIT_TITLE_GET,0X%08X,%d,",guid,x894100_g_TitleID[titleLv]);
	LuaFnAuditGeneralLog(LogInfo);
	--更新客户端
	DispatchAllTitle(sceneId,selfId)
	--设置当前称号
	SetCurTitle(sceneId,selfId,x894100_g_TitleIndex,x894100_g_TitleID[titleLv])
	--关闭对话框
	x894100_CloseWindow(sceneId,selfId, targetId)
	--发送公告
	x894100_SendNotice(sceneId, selfId, targetId,titleLv)
	--放特效
	LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 49, 0)
	--醒目提示
	x894100_MsgBox(sceneId, selfId,"#{PMF_090302_6}")
end

--发送公告
function x894100_SendNotice(sceneId, selfId, targetId,lv)

	--合法性检查
	if lv < 1 and lv > x894100_g_TitleLvNum then
		return
	end
	
	local strformat;
	
	if (lv == 1) then
		strformat	= "从#{_INFOUSR%s}手中接过1枚征南先锋印#W后，#G洛阳#Y兵圣使者#W大喜道“侠之大者，为国为民。阁下为保我朝安危勇破兵圣奇阵，乃真大侠也！我已奏明圣上，特将#G侠者仁心#W称号赐封于你，以示表彰。"
	end
	if (lv == 2) then
		strformat	= "从#{_INFOUSR%s}手中接过15枚征南先锋印#W后，#G洛阳#Y兵圣使者#W大喜道“侠之大者，为国为民。阁下为保我朝安危勇破兵圣奇阵，乃真大侠也！我已奏明圣上，特将#G杀阵行者#W称号赐封于你，以示表彰。"
	end
	if (lv == 3) then
		strformat	= "从#{_INFOUSR%s}手中接过45枚征南先锋印#W后，#G洛阳#Y兵圣使者#W大喜道“侠之大者，为国为民。阁下为保我朝安危勇破兵圣奇阵，乃真大侠也！我已奏明圣上，特将#G雄才伟略#W称号赐封于你，以示表彰。"
	end
	if (lv == 4) then
		strformat	= "从#{_INFOUSR%s}手中接过90枚征南先锋印#W后，#G洛阳#Y兵圣使者#W大喜道“侠之大者，为国为民。阁下为保我朝安危勇破兵圣奇阵，乃真大侠也！我已奏明圣上，特将#G先圣遗风#W称号赐封于你，以示表彰。"
	end

	if (lv == 5) then
		strformat	= "从#{_INFOUSR%s}手中接过150枚征南先锋印#W后，#G洛阳#Y兵圣使者#W大喜道“侠之大者，为国为民。阁下为保我朝安危勇破兵圣奇阵，乃真大侠也！我已奏明圣上，特将#G鬼谷无双#W称号赐封于你，以示表彰。"
	end
	
	local strText = format(strformat, GetName(sceneId,selfId))	
	BroadMsgByChatPipe(sceneId, selfId, strText, 4)
end

--检查物品
function x894100_CheckXuanFu(sceneId, selfId, targetId,num)
	if num <= 0 then
		return 0
	end
	
	local nCount =LuaFnGetAvailableItemCount(sceneId, selfId,x894100_g_XuanFuID)
	
	if (nCount < num) then
		return 0;
	end
	
	return 1;
end

--扣除物品
function x894100_CostXuanFu(sceneId, selfId, targetId,num)
	if num <= 0 then
		return 0
	end
	
	local ret1 = LuaFnDelAvailableItem(sceneId,selfId, x894100_g_XuanFuID, num)
	if (ret1 < 1) then
		return 0;
	end
	
	return 1;
end

--关闭对话框
function x894100_CloseWindow(sceneId,selfId, targetId)
	BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
end

--**********************************
--任务入口函数
--**********************************
function x894100_OnDefaultEvent( sceneId, selfId, targetId )
	local nNum = GetNumText()
	
	--第一层界面
	if (nNum == 10) then
		BeginEvent(sceneId)
			AddText(sceneId,"   主持兵圣奇阵的#R耶律连城#W，乃是辽皇亲封的征南先锋，若能从他手中抢得#Y征南先锋印#W作为破阵佐证，我便可奏明圣上，为您请得江湖功名。#r    $N少侠，您想用手中的#Y征南先锋印#W换得如下哪种功名呢？")
			AddNumText( sceneId, x894100_g_scriptId, "兑换称号侠者仁心", 6, 21 )
			AddNumText( sceneId, x894100_g_scriptId, "兑换称号杀阵行者", 6, 22 )
			AddNumText( sceneId, x894100_g_scriptId, "兑换称号雄才伟略", 6, 23 )
			AddNumText( sceneId, x894100_g_scriptId, "兑换称号先圣遗风", 6, 24 )
			AddNumText( sceneId, x894100_g_scriptId, "兑换称号鬼谷无双", 6, 25 )

		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	if (nNum == 200) then
		BeginEvent(sceneId)
			AddText(sceneId,"   主持兵圣奇阵的#R耶律连城#W，乃是辽皇亲封的征南先锋，若能从他手中抢得#Y征南先锋印#W作为破阵佐证，我便可奏明圣上，为您请得江湖功名。#r    $N少侠，您想用手中的#Y兵圣称号#W换得如下哪种属性呢？")
			AddNumText( sceneId, x894100_g_scriptId, "领取 侠者仁心 属性", 6, 210 )
			AddNumText( sceneId, x894100_g_scriptId, "领取 杀阵行者 属性", 6, 220 )
			AddNumText( sceneId, x894100_g_scriptId, "领取 雄才伟略 属性", 6, 230 )
			AddNumText( sceneId, x894100_g_scriptId, "领取 先圣遗风 属性", 6, 240 )
			AddNumText( sceneId, x894100_g_scriptId, "领取 鬼谷无双 属性", 6, 250 )

		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	--关于
	if (nNum == 11) then
		BeginEvent(sceneId)
			AddText(sceneId,"想要获取兵圣称号，必须到兵圣奇阵获取#Y征南先锋印。")
			AddText(sceneId,"兵圣称号属性为：#r#G侠者仁心：#r#cff99ff4属性攻击#cfff263+400     #cff99ff血上限#cfff263+20000#r#G杀阵行者：#r#cff99ff4属性攻击#cfff263+600     #cff99ff血上限#cfff263+30000#r#G雄才伟略：#r#cff99ff4属性攻击#cfff263+800     #cff99ff血上限#cfff263+50000")
			AddText(sceneId,"#G先圣遗风：#r#cff99ff4属性攻击#cfff263+1000    #cff99ff血上限#cfff263+70000#r#G鬼谷无双：#r#cff99ff4属性攻击#cfff263+1500    #cff99ff血上限#cfff263+100000")

		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	
	--第二层界面
	if (nNum == 21) then
		BeginEvent(sceneId)
			AddText(sceneId,"    若要获封称号，需要交予我#G1个#Y征南先锋印#W，以便我向圣上请功为你赐封，您确定要获封此称号吗?")
			AddNumText( sceneId, x894100_g_scriptId, "我要兑换", 6, 1 )
			AddNumText( sceneId, x894100_g_scriptId, "还是算了", 0, 100 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
	end
	
	if (nNum == 22) then
		BeginEvent(sceneId)
			AddText(sceneId,"    若要获封称号，需要交予我#G15个#Y征南先锋印#W，以便我向圣上请功为你赐封，您确定要获封此称号吗?")
			AddNumText( sceneId, x894100_g_scriptId, "我要兑换", 6, 2 )
			AddNumText( sceneId, x894100_g_scriptId, "还是算了", 0, 100 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
	end
	
	if (nNum == 23) then
		BeginEvent(sceneId)
			AddText(sceneId,"    若要获封称号，需要交予我#G45个#Y征南先锋印#W，以便我向圣上请功为你赐封，您确定要获封此称号吗?")
			AddNumText( sceneId, x894100_g_scriptId, "我要兑换", 6, 3 )
			AddNumText( sceneId, x894100_g_scriptId, "还是算了", 0, 100 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
	end
	
	if (nNum == 24) then
		BeginEvent(sceneId)
			AddText(sceneId,"    若要获封称号，需要交予我#G90个#Y征南先锋印#W，以便我向圣上请功为你赐封，您确定要获封此称号吗?")
			AddNumText( sceneId, x894100_g_scriptId, "我要兑换", 6, 4 )
			AddNumText( sceneId, x894100_g_scriptId, "还是算了", 0, 100 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
	end

	if (nNum == 25) then
		BeginEvent(sceneId)
			AddText(sceneId,"    若要获封称号，需要交予我#G150个#Y征南先锋印#W，以便我向圣上请功为你赐封，您确定要获封此称号吗?")
			AddNumText( sceneId, x894100_g_scriptId, "我要兑换", 6, 5 )
			AddNumText( sceneId, x894100_g_scriptId, "还是算了", 0, 100 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
	end

	if (nNum == 210) then
		local HadTitleID = GetTitle(sceneId,selfId,x894100_g_TitleIndex)
		if HadTitleID == x894100_g_TitleID[1] then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 31325, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 18, 0 )
			x894100_NotifyFailBox(sceneId, selfId, targetId, "领取成功！")	
		else
			BeginEvent(sceneId)
				AddText(sceneId,"    领取失败，请检查是否拥有此才称号！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
		end
	end
	
	if (nNum == 220) then
		local HadTitleID = GetTitle(sceneId,selfId,x894100_g_TitleIndex)
		if HadTitleID == x894100_g_TitleID[2] then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 31326, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 18, 0 )
			x894100_NotifyFailBox(sceneId, selfId, targetId, "领取成功！")	
		else
			BeginEvent(sceneId)
				AddText(sceneId,"    领取失败，请检查是否拥有此才称号！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
		end
	end
	
	if (nNum == 230) then
		local HadTitleID = GetTitle(sceneId,selfId,x894100_g_TitleIndex)
		if HadTitleID == x894100_g_TitleID[3] then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 31327, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 18, 0 )
			x894100_NotifyFailBox(sceneId, selfId, targetId, "领取成功！")	
		else
			BeginEvent(sceneId)
				AddText(sceneId,"    领取失败，请检查是否拥有此才称号！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
		end
	end

	if (nNum == 240) then
		local HadTitleID = GetTitle(sceneId,selfId,x894100_g_TitleIndex)
		if HadTitleID == x894100_g_TitleID[4] then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 31328, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 18, 0 )
			x894100_NotifyFailBox(sceneId, selfId, targetId, "领取成功！")	
		else
			BeginEvent(sceneId)
				AddText(sceneId,"    领取失败，请检查是否拥有此才称号！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
		end
	end

	if (nNum == 250) then
		local HadTitleID = GetTitle(sceneId,selfId,x894100_g_TitleIndex)
		if HadTitleID == x894100_g_TitleID[5] then
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 31329, 0 )
			LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, 18, 0 )
			x894100_NotifyFailBox(sceneId, selfId, targetId, "领取成功！")	
		else
			BeginEvent(sceneId)
				AddText(sceneId,"    领取失败，请检查是否拥有此才称号！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId,x894100_g_scriptId,0)
		end
	end
	
	if (nNum == 100) then
		--关闭对话框
		x894100_CloseWindow(sceneId,selfId, targetId)
	end
	
	--确认兑换
	if nNum >= 1 and nNum <= x894100_g_TitleLvNum then
		x894100_ChangePiaoMiaoTitle(sceneId, selfId, targetId,nNum)
	end
end

--**********************************
--列举事件
--**********************************
function x894100_OnEnumerate( sceneId, selfId, targetId )
	AddNumText( sceneId, x894100_g_scriptId, "兑换兵圣奇阵称号", 3, 10 )	
	-- AddNumText( sceneId, x894100_g_scriptId, "领取兵圣称号属性", 3, 200 )	
	-- AddNumText( sceneId, x894100_g_scriptId, "关于兑换兵圣奇阵称号", 11, 11 )	
end

--**********************************
--检测接受条件
--**********************************
function x894100_CheckAccept( sceneId, selfId )
	return 1
end

--**********************************
--接受
--**********************************
function x894100_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x894100_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x894100_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x894100_CheckSubmit( sceneId, selfId )
end

--**********************************
--送出宠物蛋的公告
--**********************************
function x894100_ShowSystemNotice( sceneId, selfId, strItemInfo,iIndex )
		
end

--**********************************
-- 对话窗口信息提示
--**********************************
function x894100_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--醒目信息提示
--**********************************
function x894100_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x894100_OnSubmit( sceneId, selfId, targetId, selectRadioId )
	
end

--**********************************
--杀死怪物或玩家
--**********************************
function x894100_OnKillObject( sceneId, selfId, objdataId ,objId )
	
end

--**********************************
--进入区域事件
--**********************************
function x894100_OnEnterArea( sceneId, selfId, zoneId )
	
end

--**********************************
--道具改变
--**********************************
function x894100_OnItemChanged( sceneId, selfId, itemdataId )
	
end