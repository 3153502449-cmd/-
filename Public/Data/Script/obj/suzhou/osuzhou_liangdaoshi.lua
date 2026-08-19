--脚本号
x001086_g_scriptId = 001086 
x001086_g_beginTime1 = 19 * 60 + 30;
x001086_g_endTime1 = 22 * 60 ;

--所拥有的事件ID列表
x001086_g_eventList={808131} --808133 808134

--**********************************
--事件列表
--**********************************
function x001086_UpdateEventList( sceneId, selfId,targetId )
    local  PlayerName=GetName(sceneId,selfId)
	local  PlayerSex=GetSex(sceneId,selfId)

	if PlayerSex == 0 then
		PlayerSex = "姑娘"
	else
		PlayerSex = "少侠"
	end
	BeginEvent(sceneId)
	AddText(sceneId,"    每到仲夏大侠们是否酷热难耐？我梁道士自有消暑的良方。不知道#G"..PlayerName..PlayerSex.."#W找我有何事？")
	AddNumText(sceneId,x001086_g_scriptId,"许愿果兑换奖励",6,300)  --许愿果兑换奖励
	AddNumText(sceneId,x001086_g_scriptId,"#{SQXY_09061_6}",11,9991)  --关于1001个愿望
	for i, eventId in x001086_g_eventList do
		CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
	end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x001086_OnDefaultEvent( sceneId, selfId,targetId )
	x001086_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001086_OnEventRequest( sceneId, selfId, targetId, eventId )

	if LuaFnGetMaterialBagSpace(sceneId,selfId) < 1 and LuaFnGetPropertyBagSpace(sceneId,selfId) < 1 then
		BeginEvent( sceneId ) 
		     strText = "    道具栏和材料栏至少需要1个空位！"
		     AddText( sceneId, strText )
		   EndEvent( sceneId )
		   DispatchEventList( sceneId, selfId, targetId )
	return
        end

	if	GetNumText() == 300	then
	        BeginEvent(sceneId)
		AddText( sceneId, "  #W7个#G许愿果#W兑换#G至尊强化精华#W一个#r  #W20个#G许愿果#W兑换#G红宝石(9级)#W一个#r #r  请确保你的背包道具栏和材料栏至少有一个空位。" )
		AddNumText( sceneId, x001086_g_scriptId, "兑换至尊强化精华", 6, 321 )
		AddNumText( sceneId, x001086_g_scriptId, "兑换红宝石(3级)", 6, 351 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end

	if  GetNumText() == 321	then	
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, 20502010)
        if c0 >=7 then
			BeginEvent( sceneId ) 
			LuaFnDelAvailableItem(sceneId,selfId,20502010,7)--删除许愿果
			local bagpos01 = TryRecieveItem( sceneId, selfId, 38000571, 1)--给予至尊强化
			local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
			x001086_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer,c0 )
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			strText = "    #Y恭喜你，获得#b#G天罡强化精华！"
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
			local bagpos01 = TryRecieveItem( sceneId, selfId, 50313004, 1)--给予红宝石
			local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
			x001086_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer ,c0)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)
			strText = "    #Y恭喜你，获得#b#G红宝石(9级)！"
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
	if GetNumText() == 9991 then
		BeginEvent( sceneId )
		    AddText( sceneId, "#{SQXY_09061_39}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end

	if GetNumText() == 9992 then
		BeginEvent( sceneId )
		    AddText( sceneId, "#{XCHQ_90609_5}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end

	if GetNumText() == 9993 then
		BeginEvent( sceneId )
		    AddText( sceneId, "#{ZXCM_090602_40}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	end

	for i, findId in x001086_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
end
--**********************************
--全球公告系统
--**********************************
function x001086_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer ,nNum)
	local strText = "#{SQXY_09061_29}".."#{_INFOUSR"..GetName(sceneId,selfId).."}".."#{SQXY_09061_30}#{SQXY_09061_31}"..nNum.."个#G许愿果".."#{SQXY_09061_33}".."#{_INFOMSG"..szItemTransfer.."}".."#{SQXY_09061_34}"
	AddGlobalCountNews( sceneId,strText)
end
--**********************************
--接受此NPC的任务
--**********************************
function x001086_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001086_g_eventList do
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
function x001086_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x001086_g_eventList do
		if missionScriptId == findId then
			x001086_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x001086_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x001086_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x001086_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x001086_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x001086_OnDie( sceneId, selfId, killerId )
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x001086_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
