x890096_g_ScriptId = 890096

--CallScriptFunction(890096,"GetGiftsForUI",sceneId,selfId,1256)

function x890096_GetGiftsForUI( sceneId, selfId, index,idbox,iop,targetId  )

    if sceneId == 77  then
	    x890096_Tips( sceneId, selfId,"地府禁止使用此功能")
		return
	end

	if index == nil or index <0 then
		return
	end
if index == 1555 then	
    CallScriptFunction(2086,"TransPort",sceneId,selfId,idbox,iop)	
	return
end
if index == 1855 then	
 	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 2017031008)	
	return
end
if index == 1928 then
local CheckLev ={30,50,70,90,100,105,108,110,112,115,119}
local JIANGLI ={200,300,500,5000,10000,20000,30000,40000,50000,80000,100000}
local UUUU = GetMissionData( sceneId, selfId, SHENG_JI_JIANGLI)	
local	lev	= GetLevel( sceneId, selfId )  --等级
local	nam	= LuaFnGetName( sceneId, selfId )--玩家名字

if idbox >= 1 and  idbox <= 11 then
 if idbox > 1 then
	if UUUU < idbox-1 then 
	    x890096_Tips( sceneId, selfId,"请先领取"..CheckLev[idbox-1].."级的奖励"..UUUU.."" )
        return
	    end
	end
	 if lev < CheckLev[idbox] then
	    x890096_Tips( sceneId, selfId,"你还没有"..CheckLev[idbox].."级不可以领取奖励" )
	 return
	 end
	 if idbox == 1 then	 
	 if lev < 30 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end
	 if idbox == 2 then	 
	 if lev < 50 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end
	 if idbox == 3 then	 
	 if lev < 70 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end
	 if idbox == 4 then	 
	 if lev < 90 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end
	 if idbox == 5 then	 
	 if lev < 100 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end
	 if idbox == 6 then	 
	 if lev < 105 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end
	 if idbox == 7 then	 
	 if lev < 108 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end	
	 if idbox == 8 then	 
	 if lev < 110 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end	
	 if idbox == 9 then	 
	 if lev < 112 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end	
	 if idbox == 10 then	 
	 if lev < 115 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end
	 if idbox == 11 then	 
	 if lev < 109 then	 
	    x890096_Tips( sceneId, selfId,"你在卡下试试？看老子封不封你？" )
	 return
	 end
	 end	 
	 if idbox <= UUUU then
	    x890096_Tips( sceneId, selfId,"你已经领取了奖励还来做什么" )
	 return
	 else
	    SetMissionData( sceneId, selfId, SHENG_JI_JIANGLI,idbox) --这个为通知 
	    YuanBao(sceneId, selfId, -1, 1, JIANGLI[idbox])	 
	    x890096_Tips( sceneId, selfId,"恭喜您，领取成功" )
	    BroadMsgByChatPipe(sceneId, selfId, "升级奖励系统：#Y恭喜玩家#G["..nam.."]#Y成功领取了#G["..CheckLev[idbox].."]#Y级升级奖励，获得#G["..JIANGLI[idbox].."]#Y点元宝，达到指定等级可以找#P大理（156，164）都大爽处领取。", 4)
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效
	 end
end

BeginUICommand( sceneId )
EndUICommand( sceneId )
DispatchUICommand( sceneId, selfId, 2015101902)
return
end	

if index == 262 then  --领取每日充值
CallScriptFunction(889853,"GetNewPrizes",sceneId,selfId,idbox)
return
end

if index == 263 then  --领取每日充值
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 201901519 )						--在线充值	
return
end

if index == 1086 then
	local JRLQ = GetMissionData( sceneId, selfId, BANGHUILINGQU)
	local renwu1 = GetMissionData( sceneId, selfId, GUIJIAN)
	local renwu2 = GetMissionData( sceneId, selfId, XINGYUN)	 
	local renwu3 = GetMissionData( sceneId, selfId, YANMO)	 
	local renwu4 = GetMissionData( sceneId, selfId, SHISANNIANG)	 
	local renwu5 = GetMissionData( sceneId, selfId, MINGJIANG)	 
	local renwu6 = GetMissionData( sceneId, selfId, FUDIMO)	 
	local renwu7 = GetMissionData( sceneId, selfId, MEIRICHONGZHI)	 
	local renwu8 = GetMissionData( sceneId, selfId, BANGZHAN)	
    local Guildpos = GetGuildPos(sceneId, selfId)	
	if Guildpos < 2 then
	x890096_Tips( sceneId, selfId,"请先加入帮会后再来吧！" )		
 	return
    end	
	if GetDayTime() <= GetMissionData( sceneId, selfId, BANGHUILINGQU) then   
	x890096_Tips( sceneId, selfId,"今天已经完成过了，请明天在来吧" )		
 	return
    end	
    if	renwu1~=1 or renwu2~=1 or renwu3~=1 or renwu4~=1 or renwu5~=1 or renwu6~=1 or renwu7~=1 or renwu8~=1 then
	BeginEvent(sceneId)
	AddText( sceneId, "当前任务完成情况：#r单独击败鬼剑"..renwu1.."/1#r参与幸运抽奖"..renwu2.."/1#r单独击败岩魔"..renwu3.."/1#r单独击败春十三娘"..renwu4.."/1#r单独击败冥将"..renwu5.."/1#r单独击败伏地魔"..renwu6.."/1#r充值任意金额"..renwu7.."/1#r参与帮战活动"..renwu8.."/1#r#G任务完成状况：#cFF0000未完成" )	
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)	
	return
    end	
	if Guildpos == 2 then --帮众
	YuanBao(sceneId, selfId, -1, 1, 5000)
    AddMoney( sceneId, selfId, 1500000 )	
	x890096_Tips( sceneId, selfId,"恭喜你成功完成了每日帮会任务【帮众】，获得了5000元宝和150金币" )	
	elseif Guildpos == 3 then  --精英
	YuanBao(sceneId, selfId, -1, 1, 6000)
    AddMoney( sceneId, selfId, 2000000 )	
	x890096_Tips( sceneId, selfId,"恭喜你成功完成了每日帮会任务【精英】，获得了6000元宝和200金币" )		
	elseif Guildpos == 4 then   --商人
	YuanBao(sceneId, selfId, -1, 1, 7000)
    AddMoney( sceneId, selfId, 3000000 )	
	x890096_Tips( sceneId, selfId,"恭喜你成功完成了每日帮会任务【商人】，获得了7000元宝和300金币" )		
	elseif Guildpos == 5 then  -- 公务
	YuanBao(sceneId, selfId, -1, 1, 8000)
    AddMoney( sceneId, selfId, 3500000 )	
	x890096_Tips( sceneId, selfId,"恭喜你成功完成了每日帮会任务【工务使/弘化使】，获得了8000元宝和350金币" )				
	elseif Guildpos == 6 then  -- 宏华
	YuanBao(sceneId, selfId, -1, 1, 8000)
    AddMoney( sceneId, selfId, 3500000 )	
	x890096_Tips( sceneId, selfId,"恭喜你成功完成了每日帮会任务【工务使/弘化使】，获得了8000元宝和350金币" )		
	elseif Guildpos == 7 then  --
	YuanBao(sceneId, selfId, -1, 1, 9000)
    AddMoney( sceneId, selfId, 4000000 )	
	x890096_Tips( sceneId, selfId,"恭喜你成功完成了每日帮会任务【内务使】，获得了9000元宝和400金币" )	
	elseif Guildpos == 8 then
	YuanBao(sceneId, selfId, -1, 1, 10000)
    AddMoney( sceneId, selfId, 4500000 )	
	x890096_Tips( sceneId, selfId,"恭喜你成功完成了每日帮会任务【副帮主】，获得了10000元宝和450金币" )	
	elseif Guildpos == 9 then
	YuanBao(sceneId, selfId, -1, 1, 12000)	
    AddMoney( sceneId, selfId, 5000000 )	
	x890096_Tips( sceneId, selfId,"恭喜你成功完成了每日帮会任务【帮主】，获得了12000元宝和500金币" )	
	end	
	SetMissionData( sceneId, selfId, GUIJIAN,0) 
	SetMissionData( sceneId, selfId, XINGYUN,0) 
	SetMissionData( sceneId, selfId, YANMO,0) 
	SetMissionData( sceneId, selfId, SHISANNIANG,0) 
	SetMissionData( sceneId, selfId, MINGJIANG,0) 
	SetMissionData( sceneId, selfId, FUDIMO,0) 
	SetMissionData( sceneId, selfId, MEIRICHONGZHI,0) 
	SetMissionData( sceneId, selfId, BANGZHAN,0) 	
	SetMissionData( sceneId, selfId, BANGHUILINGQU,GetDayTime()) 	
	BroadMsgByChatPipe(sceneId, selfId, "帮会每日任务：#Y恭喜玩家#G["..LuaFnGetName( sceneId, selfId ).."]#Y完成了帮会每日任务获得了大量元宝和金币奖励，只要拥有帮会的玩家都可以到#P大理帮会使者处领取任务。", 4)	
return
end	

if index == 1256 then 	
	local sj = {88,84,90,95,99,98,97,96,93,94,92,91}
	local i=random(1,12)
	local nHour	 = GetHour()--小时
	local nMinute = GetMinute()--分钟
	BeginEvent(sceneId)
	AddText( sceneId, "#I充值满300元即可超越当前全服#G"..sj[i].."%#I的玩家  统计时间为："..nHour.."点"..nMinute.."分" )	
	EndEvent(sceneId)
	DispatchEventList(sceneId, selfId, targetId)
	local g_Point = GetMissionData( sceneId, selfId, MD_PAY_LIMIT_DATA_1)
	local g_Pointlq = GetMissionData( sceneId, selfId, MD_PAY_LIMIT_DATA_2)	
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId,g_Point)
		UICommand_AddInt( sceneId, g_Pointlq)
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 89292101 )						--首次充值	
return
end		

if index == 1257 then
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 201901519 )						--在线充值	
return
end	
if index == 1300 then
	BeginUICommand( sceneId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 2015101902)						--升级奖励	
return
end	

if index == 1301 then
 CallScriptFunction(889853,"UpdateGetPrizeBtnState",sceneId,selfId)						--每日充值
return
end	

if index == 1302 then
        BeginUICommand(sceneId)
        UICommand_AddInt(sceneId, targetId)
        UICommand_AddString(sceneId, "CDK")
        EndUICommand(sceneId)
        DispatchUICommand(sceneId, selfId, 20170431)	
return
end	

if index == 1303 then
	BeginUICommand(sceneId)
      UICommand_AddInt( sceneId, selfId )	
	  UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, GUIJIAN))	
	  UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, XINGYUN))	 
	  UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, YANMO))	 
	  UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, SHISANNIANG))	 
	  UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, MINGJIANG))	 
	  UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, FUDIMO))	 
	  UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, MEIRICHONGZHI))	 
	  UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, BANGZHAN))		  
	  EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,  20171036)					--帮会每日任务	
return
end	

if index == 1400 then  --注入500W经验
	local cishu = GetMissionData( sceneId, selfId, ZHURU )			
if idbox == 1 then
	if GetDayTime() <= GetMissionData( sceneId, selfId, QINGKONG) then   
	x890096_Tips( sceneId, selfId,"今天已经注入或使用过3次了，请明天在来吧" )		
 	return
    end
    if GetExp(sceneId,selfId) < 10000000 then
	x890096_Tips( sceneId, selfId, "经验不足1000万,无法注入" )
	return	
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, 38800019) < 1 then
	x890096_Tips( sceneId, selfId, "需要[造化丹]1个" )	
	return
	end

	if  LuaFnDelAvailableItem(sceneId,selfId,38800019, 1) ~= 1 then
	x890096_Tips( sceneId, selfId, "[造化丹]扣取失败，请查看是否加锁了" )
	return
	end		
	LuaFnAddExp(sceneId,selfId,0-10000000)
	x890096_Tips( sceneId, selfId, "你消耗了1000万经验向造化丹内注入了500万经验" )	
    TryRecieveItem( sceneId, selfId, 38800020, 1 )
    LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效	
	SetMissionData( sceneId, selfId, ZHURU,cishu+1) 
    if cishu >= 2 then
	SetMissionData( sceneId, selfId, QINGKONG,GetDayTime()) 
	SetMissionData( sceneId, selfId, ZHURU,0) 	
	end
return	
end	

if idbox == 2 then
	if GetDayTime() <= GetMissionData( sceneId, selfId, QINGKONG) then   
	x890096_Tips( sceneId, selfId,"今天已经注入或使用过3次了，请明天在来吧" )		
 	return
    end
    if GetExp(sceneId,selfId) < 20000000 then
	x890096_Tips( sceneId, selfId, "经验不足2000万,无法注入" )
	return	
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, 38800019) < 1 then
	x890096_Tips( sceneId, selfId, "需要[造化丹]1个" )	
	return
	end

	if  LuaFnDelAvailableItem(sceneId,selfId,38800019, 1) ~= 1 then
	x890096_Tips( sceneId, selfId, "[造化丹]扣取失败，请查看是否加锁了" )
	return
	end		
	LuaFnAddExp(sceneId,selfId,0-20000000)
	x890096_Tips( sceneId, selfId, "你消耗了2000万经验向造化丹内注入了1000万经验" )	
    TryRecieveItem( sceneId, selfId, 38800021, 1 )
    LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效	
	SetMissionData( sceneId, selfId, ZHURU,cishu+1) 	
    if cishu >= 2 then
	SetMissionData( sceneId, selfId, QINGKONG,GetDayTime()) 
	SetMissionData( sceneId, selfId, ZHURU,0) 	
	end	
return	
end	

if idbox == 3 then
	if GetDayTime() <= GetMissionData( sceneId, selfId, QINGKONG) then   
	x890096_Tips( sceneId, selfId,"今天已经注入或使用过3次了，请明天在来吧" )		
 	return
    end
    if GetExp(sceneId,selfId) < 100000000 then
	x890096_Tips( sceneId, selfId, "经验不足1亿,无法注入" )
	return	
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, 38800019) < 1 then
	x890096_Tips( sceneId, selfId, "需要[造化丹]1个" )	
	return
	end

	if  LuaFnDelAvailableItem(sceneId,selfId,38800019, 1) ~= 1 then
	x890096_Tips( sceneId, selfId, "[造化丹]扣取失败，请查看是否加锁了" )
	return
	end		
	LuaFnAddExp(sceneId,selfId,0-100000000)
	x890096_Tips( sceneId, selfId, "你消耗了1亿经验向造化丹内注入了5000万经验" )	
    TryRecieveItem( sceneId, selfId, 38800022, 1 )
    LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效	
	SetMissionData( sceneId, selfId, ZHURU,cishu+1) 	
    if cishu >= 2 then
	SetMissionData( sceneId, selfId, QINGKONG,GetDayTime()) 
	SetMissionData( sceneId, selfId, ZHURU,0) 	
	end	
return	
end	

if idbox == 4 then
	if GetDayTime() <= GetMissionData( sceneId, selfId, QINGKONG) then   
	x890096_Tips( sceneId, selfId,"今天已经注入或使用过3次了，请明天在来吧" )		
 	return
    end
    if GetExp(sceneId,selfId) < 200000000 then
	x890096_Tips( sceneId, selfId, "经验不足2亿,无法注入" )
	return	
	end
	if LuaFnGetAvailableItemCount(sceneId, selfId, 38800019) < 1 then
	x890096_Tips( sceneId, selfId, "需要[造化丹]1个" )	
	return
	end

	if  LuaFnDelAvailableItem(sceneId,selfId,38800019, 1) ~= 1 then
	x890096_Tips( sceneId, selfId, "[造化丹]扣取失败，请查看是否加锁了" )
	return
	end		
	LuaFnAddExp(sceneId,selfId,0-200000000)
	x890096_Tips( sceneId, selfId, "你消耗了2亿经验向造化丹内注入了1亿经验" )	
    TryRecieveItem( sceneId, selfId, 38800023, 1 )
    LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效	
	SetMissionData( sceneId, selfId, ZHURU,cishu+1) 	
    if cishu >= 2 then
	SetMissionData( sceneId, selfId, QINGKONG,GetDayTime()) 
	SetMissionData( sceneId, selfId, ZHURU,0) 	
	end	
return	
end

return	
end	

end	

--*************************************************
--屏幕中间对话提示
--*************************************************
function x890096_Tips( sceneId, selfId,msg )
BeginEvent( sceneId )
		AddText( sceneId, msg)
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end