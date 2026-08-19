--绑定的花种30505260
--不绑定的花种30505268--这个废弃掉，脚本不针对他
--花肥30505261
--******************
--    种花系统
--     Sunyan
--  无存储位占用
--   QQ857904341
--******************
--大理阿里种花任务
x002100_g_ScriptId	= 002100
x002107_g_MissionId = 1453
x002117_g_MissionId = 1451
x002091_g_MissionId = 1450
x002106_g_MissionId = 1452
x002108_g_MissionId = 1454
x002109_g_MissionId = 1455
--************************************************************************
--事件列表
--************************************************************************
function x002100_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{SDJZH_091106_05}")
		AddNumText( sceneId, x002100_g_ScriptId, "领取花种",6,10 )
		AddNumText( sceneId, x002100_g_ScriptId, "获得更多花肥和花种",6,99 )
		--AddNumText( sceneId, x002100_g_ScriptId, "数据测试",6,1 )
		AddNumText( sceneId, x002100_g_ScriptId, "关于种花",11,15 )		 
	EndEvent( sceneId )
    DispatchEventList( sceneId, selfId, targetId )
end

--**************************************************************************
--事件列表选中一项
--**************************************************************************
function x002100_OnEventRequest( sceneId, selfId, targetId, eventId )
	local key = GetNumText()
	if key == 1 then
		--x002100_NotifyFailBox( sceneId, selfId, targetId, x002100_GetGrowFlowerData(sceneId,selfId) )
	end
	if key == 10 then
	    local FreeSpace = LuaFnGetPropertyBagSpace( sceneId, selfId )	  
	    if FreeSpace < 4  then
	        x002100_MsgBox(sceneId, selfId,targetId,"    请保证道具栏不少于4个空位" )
	        return
	    end
	    local level = GetLevel( sceneId, selfId )
	    if level < 30 then
	        x002100_MsgBox(sceneId, selfId,targetId,"    你的等级不足30级无法领取种花任务" )
		    return
	    end
	    local Time = GetTime2Day()
	    local TimeData,TimeData2 = x002100_GetGrowFlowerData(sceneId,selfId)
	    if Time == tonumber(TimeData) then 
	        x002100_MsgBox(sceneId, selfId,targetId,"    每天只能领取1次花种，想获得更多的花种，就点击获得更多花肥和花种吧！" )
		    return
	    end
        for i = 1,3 do  --获得3颗花种
            TryRecieveItem( sceneId, selfId, 30505260, 1)  
        end
        for i = 1,10 do --获得10个花肥
            TryRecieveItem( sceneId, selfId, 30505261, 1)  
        end
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0)  --来个炫酷特效
	    --SetMissionData(sceneId,selfId,MD_ZHONGHUA_TIME,Time)
		x002100_SaveGrowFlowerData(sceneId,selfId,Time,TimeData2)
	    x002100_MsgBox(sceneId, selfId,targetId,"恭喜你获得三颗鲜花的种子和10个花肥" )
	    local playerName = GetName(sceneId,selfId)
    	local strText = format("#G#{_INFOUSR%s}#W正在#c00ffff大理[185,65]#cff99ff阿里#W处询问着种花的经验，阿里竟然慷慨的送给他三颗#G鲜花的种子！",playerName ) 
	    BroadMsgByChatPipe(sceneId, selfId, strText, 4)
	end
	if key == 99 then
		BeginEvent(sceneId)	   
			AddText(sceneId,"   你可以通过副本或者从元宝商店购得#G鲜花的种子")
		EndEvent(sceneId)    --赋值结束
		DispatchEventList( sceneId, selfId, targetId )
--		local PlayerName = GetName( sceneId, selfId )
--		local PlayerSex = GetSex( sceneId, selfId )
--		if PlayerSex == 0 then
--			PlayerSex = "姑娘"
--		else
--			PlayerSex = "少侠"
--		end
--		BeginEvent(sceneId)
--		AddText( sceneId, "#{SDHDRW_091109_01}")
--		AddNumText( sceneId, x002100_g_ScriptId, "百花缘", 3, 501)
--			if IsHaveMission(sceneId,selfId,1450) > 0 or IsHaveMission(sceneId,selfId,1451) > 0 or IsHaveMission(sceneId,selfId,1452) > 0
--			    or IsHaveMission(sceneId,selfId,1453) > 0 or IsHaveMission(sceneId,selfId,1454) > 0 or IsHaveMission(sceneId,selfId,1455) > 0 then
--			    AddNumText( sceneId, x002100_g_ScriptId, "取消领取的任务", 6, 513 )
--			end
--		--AddNumText( sceneId, x002100_g_ScriptId, "关于花种任务", 11, 512)
--		--AddNumText( sceneId, x002100_g_ScriptId, "离开……", 9, 500 )
--		EndEvent(sceneId)
--		DispatchEventList(sceneId,selfId,targetId)
    end
    if nNumText==500  then
	-- 关闭窗口
        BeginUICommand(sceneId)
        EndUICommand(sceneId)
        DispatchUICommand(sceneId,selfId, 1000)
        return
    end

	if key==513  then
		for i = 1450,1455 do
		   DelMission( sceneId, selfId, i )
		end
		local TimeData,TimeData2 = x002100_GetGrowFlowerData(sceneId,selfId)
		local TimeData2 = tostring(LuaFnGetCurrentTime()+900)
		x002100_SaveGrowFlowerData(sceneId,selfId,TimeData,TimeData2)
		--SetMissionData(sceneId,selfId,MD_XIANHUAZHONGZI,)
		BeginEvent(sceneId)	   
			AddText(sceneId,"  #gFF83FA你的任务已经删除成功！")
		EndEvent(sceneId)    --赋值结束
		DispatchEventList( sceneId, selfId, targetId )
		return
	end

	if key==501  then
		local TimeData,TimeData2 = x002100_GetGrowFlowerData(sceneId,selfId)
		if tonumber(TimeData2) > LuaFnGetCurrentTime() then 
			BeginEvent(sceneId)	   
				AddText(sceneId,"  你刚刚放弃了任务，需要#G"..GetMissionData(sceneId,selfId,MD_XIANHUAZHONGZI)-LuaFnGetCurrentTime().."#W秒之后才能再次截取百花缘任务。")
			EndEvent(sceneId)    --赋值结束
			DispatchEventList( sceneId, selfId, targetId )
			return
        end
		local PlayerLevel  = GetLevel(sceneId, selfId)
		local PlayerName = GetName( sceneId, selfId )
		local PlayerSex = GetSex( sceneId, selfId )
		if PlayerSex == 0 then
			PlayerSex = "姑娘"
		else
			PlayerSex = "少侠"
		end
		if PlayerLevel < 20 then
			BeginEvent(sceneId)
				AddText( sceneId, "    #R"..PlayerName..PlayerSex..":" )
			AddText( sceneId, "    #G你级别不到20级，20级后才能领取种花任务！#r#Y    快去升级后再来吧。" )
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		--********************************判断是否已有任务
		if  IsHaveMission(sceneId,selfId,x002117_g_MissionId) > 0  or IsHaveMission(sceneId,selfId,x002091_g_MissionId) > 0  or IsHaveMission(sceneId,selfId,x002106_g_MissionId) > 0  or IsHaveMission(sceneId,selfId,x002107_g_MissionId) > 0  or IsHaveMission(sceneId,selfId,x002108_g_MissionId) > 0  or IsHaveMission(sceneId,selfId,x002109_g_MissionId) > 0  then
		--如果已接此任务 
			if IsHaveMission(sceneId,selfId,x002117_g_MissionId) > 0 then
				--发送任务需求的信息
				BeginEvent(sceneId)
				AddText(sceneId,x002117_g_MissionName)
				AddText(sceneId,x002117_g_MissionContinue)
				for i, item in x002117_g_DemandItem do
					AddItemDemand( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x002117_g_MoneyBonus )
				EndEvent( )
				bDone = x002117_CheckSubmit( sceneId, selfId )
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x002117_g_ScriptId,x002117_g_MissionId,bDone)
			end	
			if  IsHaveMission(sceneId,selfId,x002091_g_MissionId) > 0 then
				BeginEvent(sceneId)
				AddText(sceneId,x002091_g_MissionName)
				AddText(sceneId,x002091_g_MissionContinue)
				for i, item in x002091_g_DemandItem do
					AddItemDemand( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x002091_g_MoneyBonus )
				EndEvent( )
				bDone = x002091_CheckSubmit( sceneId, selfId )
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x002091_g_ScriptId,x002091_g_MissionId,bDone)
			end
			if  IsHaveMission(sceneId,selfId,x002106_g_MissionId) > 0 then
				BeginEvent(sceneId)
				AddText(sceneId,x002106_g_MissionName)
				AddText(sceneId,x002106_g_MissionContinue)
				for i, item in x002106_g_DemandItem do
					AddItemDemand( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x002106_g_MoneyBonus )
				EndEvent( )
				bDone = x002106_CheckSubmit( sceneId, selfId )
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x002106_g_ScriptId,x002106_g_MissionId,bDone)
			end	
			if  IsHaveMission(sceneId,selfId,x002107_g_MissionId) > 0 then
				BeginEvent(sceneId)
				AddText(sceneId,x002107_g_MissionName)
				AddText(sceneId,x002107_g_MissionContinue)
				for i, item in x002107_g_DemandItem do
					AddItemDemand( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x002107_g_MoneyBonus )
				EndEvent( )
				bDone = x002107_CheckSubmit( sceneId, selfId )
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x002107_g_ScriptId,x002107_g_MissionId,bDone)
			end	
			if  IsHaveMission(sceneId,selfId,x002108_g_MissionId) > 0 then
				BeginEvent(sceneId)
				AddText(sceneId,x002108_g_MissionName)
				AddText(sceneId,x002108_g_MissionContinue)
				for i, item in x002108_g_DemandItem do
					AddItemDemand( sceneId, item.id, item.num )
				end
				AddMoneyBonus( sceneId, x002108_g_MoneyBonus )
				EndEvent( )
				bDone = x002108_CheckSubmit( sceneId, selfId )
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x002108_g_ScriptId,x002108_g_MissionId,bDone)
			end	
			if  IsHaveMission(sceneId,selfId,x002109_g_MissionId) > 0 then
						 local strText = format("    #P你见到要拜访的名人了吗？     #r#Y你可以点击Alt+Q查看任务目标。")
				BeginEvent(sceneId)
				AddText(sceneId,x002109_g_MissionName)
							 AddText(sceneId, strText)
				AddMoneyBonus( sceneId, x002109_g_MoneyBonus )
				EndEvent( )
				bDone = x002109_CheckSubmit( sceneId, selfId )
				DispatchMissionDemandInfo(sceneId,selfId,targetId,x002109_g_ScriptId,x002109_g_MissionId,bDone)
			end
			--满足任务接收条件
		else 
			odds = random( 60000 )
			if odds>=0 and odds<=10000 then
				nRet_rw=1
			elseif odds>=10001 and odds<=20000  then
				nRet_rw=2
			elseif odds>=20001 and odds<=30000  then
				nRet_rw=3
			elseif odds>=30001 and odds<=40000  then
				nRet_rw=4
			elseif odds>=40001 and odds<=50000  then
				nRet_rw=5
			elseif odds>=50001 and odds<=60000  then
				nRet_rw=6
			end
		 --********************************************
			if nRet_rw==1 then 
				x002100_MY_ZH=002091
			elseif nRet_rw==2 then
				x002100_MY_ZH=002120
			elseif nRet_rw==3 then
				x002100_MY_ZH=002109
			elseif nRet_rw==4 then
				x002100_MY_ZH=002110
			elseif nRet_rw==5 then
				x002100_MY_ZH=002111
			elseif nRet_rw==6 then
				x002100_MY_ZH=002112
			end
			CallScriptFunction( x002100_MY_ZH, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end	--**********************************           
	end
    if key == 15 then
	    BeginEvent( sceneId )
		    AddText( sceneId, "#{SDJZH_091106_29}")
	    EndEvent( sceneId )
	    DispatchEventList( sceneId, selfId, targetId )	
	end	
end	
--**********************************
--存储种植存储数据库
--**********************************
function x002100_SaveGrowFlowerData(sceneId,selfId,status1,status2)
	x002100_CreateGrowFlowerData(sceneId,selfId)
	local Guid = LuaFnObjId2Guid(sceneId,selfId) ---得到ID
	local FinData = ""
	FinData = status1.."\n"..status2.."\n"
	local 	Coldfile = openfile("./XYD_DataBase/DataCenter/GROWF"..tostring(Guid)..".txt", "w")
	if Coldfile and nil ~= Coldfile then
		if FinData == nil or FinData == "" then
			return -3  ---写入文件错误
		end
		write(Coldfile, FinData)
		closefile(Coldfile)
	else
		return -4  ---打开文件错误
	end
	return---返回成功
end
--**********************************
--读取种植存储数据库
--**********************************
function x002100_GetGrowFlowerData(sceneId,selfId)
	--daytime 
	x002100_CreateGrowFlowerData(sceneId,selfId)
	local myGuid = LuaFnGetGUID(sceneId, selfId)
	local savetxt = openfile("./XYD_DataBase/DataCenter/GROWF"..tostring(myGuid)..".txt", "r")
	local Data = {}
	if savetxt and nil ~= savetxt then
		local line1=read(savetxt, "*l")  --R
		if line1==nil then
			return
		end
		local line2=read(savetxt, "*l")  --R
		if line2==nil then
			return
		end
		Data[1] = line1
		Data[2] = line2
		closefile(savetxt)
	else
		x990009_NotifyTip(sceneId,selfId,"ERROR::ReadSQL Fail !!!  XYJ-QD-002")
		return
	end
	return Data[1],Data[2]
end
--**********************************
--建立种植存储数据库
--**********************************
function x002100_CreateGrowFlowerData(sceneId,selfId)
	--记录每日领取花种
	--领取花种的时间
	local Guid = LuaFnGetGUID(sceneId,selfId)
	local DataStr =""
    for i =1,2 do 
        DataStr = DataStr.."0".."\n"
    end
	local handle = openfile("./XYD_DataBase/DataCenter/GROWF"..tostring(Guid)..".txt", "r")
	if handle == nil then
		local handle = openfile("./XYD_DataBase/DataCenter/GROWF"..tostring(Guid)..".txt", "wb")
		if nil ~= handle  then
			write(handle,tostring(DataStr))
			closefile(handle)
		end
    end 
end
--**************************************************************************
--对话
--**************************************************************************
function x002100_MsgBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--print(nRet_rw)
--接受此NPC的任务
--**********************************

function x002100_OnMissionAccept( sceneId, selfId, targetId, x002100_MY_ZH )
	local ret1 = CallScriptFunction( x002100_MY_ZH, "CheckAccept", sceneId, selfId, targetId )
	if ret1 > 0 then
		CallScriptFunction( x002100_MY_ZH, "OnAccept", sceneId, selfId, targetId, x002100_MY_ZH ) --任务脚本ID，场景ID，玩家角色ID，目标ID
	end
	return
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x002100_OnMissionRefuse( sceneId, selfId, targetId, x002100_MY_ZH )
    x002100_UpdateEventList( sceneId, selfId, targetId )
	return
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002100_OnMissionContinue( sceneId, selfId, targetId, x002100_MY_ZH )
	CallScriptFunction( x002100_MY_ZH, "OnContinue", sceneId, selfId, targetId )
	return
end

--**********************************
--提交已做完的任务
--**********************************
function x002100_OnMissionSubmit( sceneId, selfId, targetId, x002100_MY_ZH, selectRadioId )
	CallScriptFunction( x002100_MY_ZH, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
	return
end

--**********************************
--死亡事件
--**********************************
function x002100_OnDie( sceneId, selfId, killerId )
end

--**********************************
--对话窗口信息提示
--**********************************
function x002100_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
