--宋辽大战[血战雁门关]
--刘博 in 休息室
--逍遥子 QQ857904341
x502019_g_ScriptId = 502019

x502019_g_BaoHuBUFF = 95 --宋辽保护BUFF
x502019_g_StartHumanNum = 2--60 --宋辽开始最少人数
x502019_g_StartHumanNum_OverTimer = 20 --超时后开始的最少人数
x502019_g_Campagin_Time ={{20,30},{22,10}} --战场时间设定
--**********************************
--事件交互入口
--**********************************
function x502019_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{SLDZ_100805_29}")
		AddNumText( sceneId, x502019_g_ScriptId, "#{SLDZ_100805_76}", 6, 2 ) --查看人数
		AddNumText( sceneId, x502019_g_ScriptId, "#{SLDZ_100805_77}", 6, 3 ) --取消保护
		AddNumText( sceneId, x502019_g_ScriptId, "#{SLDZ_100805_32}", 9, 1 ) --退出
		AddNumText( sceneId, x502019_g_ScriptId, "#{SLDZ_100805_30}", 11, 4 )
		AddNumText( sceneId, x502019_g_ScriptId, "#{SLDZ_100805_31}", 11, 5 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)	
end
--**********************************
--事件列表选中一项
--**********************************
function x502019_OnEventRequest( sceneId, selfId, targetId, eventId)
	local Operation = GetNumText()
	if Operation == 1 then
		MonsterTalk(sceneId, -1, "雁门关前哨","#H"..GetName(sceneId,selfId).."#H不战而退，中途逃离了宋辽战场。")
		LuaFnCancelSpecificImpact(sceneId,selfId,x502019_g_BaoHuBUFF) 
		NewWorld(sceneId,selfId,1,random(292,296),random(239,243))
		return 
	end
	if Operation == 2 then
		local nNowDate = date("%H:%M:%S");
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		BeginEvent(sceneId)	
			AddText( sceneId, "#W当前服务器时间：#G"..nNowDate.."")
			AddText( sceneId, "#W当前雁门关前哨人数：#G"..nHumanCount.."")
			AddText( sceneId, "#G提示：雁门关前哨每满60人会开启一个宋辽战场副本。报名截止时间为20：30，届时如果前哨内人数达到20人以上，将开启最后一个宋辽战场副本。")
		DispatchEventList(sceneId,selfId,targetId)
		return 
	end
	if Operation == 3 then
		BeginEvent(sceneId)	   
			AddText( sceneId, "#{SLDZ_100805_79}")
			AddNumText( sceneId, x502019_g_ScriptId, "我确定取消保护", 9, 100 )
			AddNumText( sceneId, x502019_g_ScriptId, "还是算了", 9, 101 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return 
	end
	if Operation == 4 then
		x502019_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_33}" )
		return
	end
	if Operation == 5 then
		x502019_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_34}" )
	end
	if Operation == 100 then
		LuaFnCancelSpecificImpact(sceneId,selfId,x502019_g_BaoHuBUFF) 
		x502019_NotifyFailTips( sceneId, selfId, "#{SLDZ_100805_120}" )
		return 
	end
	if Operation == 101 then
		BeginUICommand(sceneId)
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 1000)
		return 
	end
end
--**********************************
--休息室场景判断
--此处挂在休息室刘博OBJ，每10S回调一次
--**********************************
function x502019_OnCharacterTimer( sceneId, objId, dataId, uTime )
--	MonsterTalk(sceneId, -1, "雁门关前哨","x502019_OnSceneTimer")
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)  
	if nHumanCount < 1 then
		return
	end	
	local is_InTime,nOverTime = 1,1--x502019_GetCampaginTimer(sceneId) 调试，运营请解除屏蔽
	if is_InTime == 1 then
		if nHumanCount >= x502019_g_StartHumanNum then
			x502019_StartSLDZ(sceneId,x502019_g_StartHumanNum)       
		elseif nOverTime == 0 and nHumanCount >= x502019_g_StartHumanNum_OverTimer then
			x502019_StartSLDZ(sceneId,x502019_g_StartHumanNum_OverTimer)
		end    		
	else
		local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
		for i = 1,nHumanCount do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
			x502019_NotifyFailTips(sceneId,nHumanId,"#{SLDZ_100805_42}")--H雁门关前哨即将关闭，下次请及早报名。
		end
		if nOverTime == 0 and nHumanCount < x502019_g_StartHumanNum_OverTimer then
			MonsterTalk(sceneId, -1, "雁门关前哨","#{SLDZ_100805_41}")--H由于报名时间太晚，团队人数不足20人，无法开启战场。
		end
		x502019_GoAwayAllPeople(sceneId)
	end
end
--*********************************
--休息室人员清空
--*********************************
function x502019_GoAwayAllPeople(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
    for i = 1,nHumanCount do   
        local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1) 
        LuaFnCancelSpecificImpact(sceneId,nHumanId,x502019_g_BaoHuBUFF) 
        NewWorld( sceneId, nHumanId,1,random(292,296),random(239,243)) 
    end
end
--**********************************
--开始宋辽战场
--这里默认是将全部的小朋友传到战场上去
--**********************************
function x502019_StartSLDZ(sceneId)
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	for i = 1,nHumanCount do
		local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
		if GetLevel(sceneId, nHumanId) < 80 or LuaFnHasTeam( sceneId, nHumanId ) ~= 0 or LuaFnGetDRideFlag(sceneId, nHumanId) ~= 0 then
			--这些是全部不知道怎么进来的
			LuaFnCancelSpecificImpact(sceneId,nHumanId,x502019_g_BaoHuBUFF) 
			NewWorld( sceneId, nHumanId,1,294,241)
			MonsterTalk(sceneId, -1, "雁门关前哨","#G"..GetName(sceneId,nHumanId).."#H不知为何混进了雁门关前哨，已被系统驱逐！")
		else
		SetMissionDataEx(sceneId, nHumanId, MD_SONGLIAO_TEMP_DATA,0) 
		end
	end
	local nLederId = LuaFnGetCopyScene_HumanObjId(sceneId,0)
	--创建副本
	CallScriptFunction(502011, "MakeCopyScene",sceneId,nLederId)
end
--**********************************
--活动时间判断
--**********************************
function x502019_GetCampaginTimer(sceneId)
	--is_InTime,nOverTime
	--x502019_g_Campagin_Time
	local nStartTime = x502019_g_Campagin_Time[1][1] *60 + x502019_g_Campagin_Time[1][2]
	local nEndTime = x502019_g_Campagin_Time[2][1] *60 + x502019_g_Campagin_Time[2][2]
	local nNowTime = floor(mod((LuaFnGetCurrentTime()+28800),86400)/60)
	local is_InTime,nOverTime = 0,0
	if  nStartTime <= nNowTime and   nEndTime >= nNowTime  then
		is_InTime = 1
		nOverTime = nEndTime - nNowTime 
	end
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x502019_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x502019_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end