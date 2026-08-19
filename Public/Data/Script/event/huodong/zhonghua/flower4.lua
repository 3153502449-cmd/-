--花苗（成熟）

--脚本号
x335704_g_ScriptId = 335704


--**********************************
--特殊交互:条件判断
--**********************************
function x335704_OnActivateConditionCheck( sceneId, selfId, activatorId )

     local myGUID = LuaFnGetLifeTimeAttrRefix_AttackPhysics( sceneId, selfId )  ---原来的ID       
     local selfGuid = LuaFnObjId2Guid(sceneId, activatorId) ---通过人物的selfid得到guid
     local oldtime = LuaFnGetLifeTimeAttrRefix_DefencePhysics( sceneId, selfId ) ---时间     
     local nowtime = LuaFnGetCurrentTime() --得到现在的时间
     local restime = oldtime - nowtime   --得到盗采的倒计时

    if restime <= 0  then       	
	      BeginEvent(sceneId)
	      AddText(sceneId,"时间过了，谁都可以盗采了哦")
	      EndEvent(sceneId)
	      DispatchMissionTips(sceneId,activatorId)
	   return 1
	 end   	

   if myGUID == selfGuid  then
	    BeginEvent(sceneId)
		AddText(sceneId,"你是鲜花主人，请采集！")
		EndEvent(sceneId)
	    DispatchMissionTips(sceneId,activatorId)
	    return 1	 
    end
    BeginEvent(sceneId)
	AddText(sceneId,"    你不是鲜花主人，请在#G"..restime.."#W秒后再来采摘！")
    EndEvent(sceneId)
	DispatchMissionTips(sceneId,activatorId)
        --DispatchEventList(sceneId,activatorId)
    return 0

end

--**********************************
--特殊交互:消耗和扣除处理
--**********************************
function x335704_OnActivateDeplete( sceneId, selfId, activatorId )

	local strText = "采集间隔时间3秒"
	BeginEvent(sceneId)
	      AddText(sceneId,strText)
	      EndEvent(sceneId)
	DispatchMissionTips(sceneId,activatorId)
	return 1
end

--**********************************
--特殊交互:聚气类成功生效处理
--**********************************
function x335704_OnActivateEffectOnce( sceneId, selfId, activatorId )
    LuaFnDeleteMonster(sceneId, selfId)
	local rand = random(10)
	--Sunyan 20181201 降低获得几率
    if rand==1 or rand==5 or rand==6 or rand==7 then
	   FlowerId = 30505263
	elseif rand==2 or rand==8 or rand==10 then
	   FlowerId = 30505262
	elseif rand==3 or rand==9 then
	   FlowerId = 30505264 --大波斯菊
	elseif rand==4 then
	   FlowerId = 30505265 --波斯蓝
	end
    if FlowerId == 30505262 then
	    local playerName = GetName(sceneId,activatorId)
    	local strText = format("#B#{_INFOUSR%s}#W在#c00ffff大理#W采摘了#ccc33cc[#{_ITEM30505262}]#W，还没有参加每日种花活动的小伙伴们速度了！！",playerName ) 
	    BroadMsgByChatPipe(sceneId, selfId, strText, 4)
    end
	LuaFnSendSpecificImpactToUnit(sceneId, activatorId, activatorId, activatorId, 18, 0)
	TryRecieveItem( sceneId, activatorId, FlowerId, 1 )		
	BeginEvent(sceneId)
	AddText(sceneId, "恭喜您采收成功，您得到一个[#{_ITEM"..FlowerId.."}]");
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,activatorId)
	XiaoYaoZhi(sceneId,selfId,0,5);
	return 1
end

--**********************************
--特殊交互:引导类每时间间隔生效处理
--**********************************
function x335704_OnActivateEffectEachTick( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互开始时的特殊处理
--**********************************
function x335704_OnActivateActionStart( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互撤消时的特殊处理
--**********************************
function x335704_OnActivateCancel( sceneId, selfId, activatorId )
	return 1
end

--**********************************
--特殊交互:交互中断时的特殊处理
--**********************************
function x335704_OnActivateInterrupt( sceneId, selfId, activatorId )
	local strText = "您中断了采集，请重新采集"
	BeginEvent(sceneId)
	      AddText(sceneId,strText)
	      EndEvent(sceneId)
	DispatchMissionTips(sceneId,activatorId)
	return 1
end
