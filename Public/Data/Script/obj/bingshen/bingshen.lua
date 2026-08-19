--兵圣奇阵
--2019-10-27 13:02:36 逍遥子二开
--脚本号
x894062_g_ScriptId = 894062
--所拥有的事件ID列表
x894062_g_eventList={894100,895063,894063} --小兵圣开放 2019-11-7 19:29:41 逍遥子
--**********************************
--事件列表
--**********************************
function x894062_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		for i, eventId in x894062_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
		AddText(sceneId,"#{BSQZ_101223_01}")
		AddNumText( sceneId, x894062_g_ScriptId, "#{BSQZ_101223_04}", 11, 500 )
		AddNumText( sceneId, x894062_g_ScriptId, "#{MPJJ_XT_110705_21}", 6, 501 )
		AddNumText( sceneId, x894062_g_ScriptId, "#{MPJJ_XT_110705_22}", 11, 502 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件交互入口
--**********************************
function x894062_OnDefaultEvent( sceneId, selfId,targetId )
	x894062_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x894062_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x894062_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId )
			return
		end
	end
	local nNumText = GetNumText()
	if nNumText == 500  then
		BeginEvent(sceneId)
		    AddText(sceneId,"#{BSQZ_101223_09}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
	if nNumText == 501  then--开始兑换
       local MenPaiDress = {
	   [0]=10124322,[1]=10124323,[2]=10124324,
	   [4]=10124325,[3]=10124326,[5]=10124327,
	   [7]=10124328,[8]=10124329,[6]=10124330}  
	   local nHaveItem = LuaFnGetAvailableItemCount(sceneId,selfId,30110000)
	   local str = ""
	   if nHaveItem < 20 then
	     if nHaveItem < 1 then
		    str = "#{MPJJ_XT_110705_18}"
	     end
	     if nHaveItem >= 1 and nHaveItem < 20 then
		    str = "#{MPJJ_XT_110705_19}" 
	     end
		 x894062_ToPlayerMsg(sceneId,selfId,targetId,str)
		 return
	   end 
	   local ret = LuaFnDelAvailableItem(sceneId,selfId,30110000,20)
	   if ret ~= 1 then
	      return
	   end
	   TryRecieveItem(sceneId,selfId,MenPaiDress[GetMenPai(sceneId,selfId)],1)
	   AddGlobalCountNews(sceneId,"#P兵圣孙武有云：故其疾如风，其徐如林，侵略如火，不动如山，难知如阴，动如雷霆！#{_INFOUSR"..GetName(sceneId,selfId).."}#P终于领会到其中深意，连续多日在#G兵圣奇阵#W中获得#Y辽阵情报#P，今日#G楼兰（211，176）#Y高阳#P特将珍藏多年的#Y门派进阶时装#P赠予情报收集者，以表其立下的赫赫战功！")
	end
	if nNumText == 502  then
		BeginEvent(sceneId)
		AddText(sceneId,"#{MPJJ_XT_110705_23}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end
function x894062_ToPlayerMsg(sceneId,selfId,targetId,Msg)
		BeginEvent(sceneId)
		AddText(sceneId,Msg)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)	  
end
--**********************************
--接受此NPC的任务
--**********************************
function x894062_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x894062_g_eventList do
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
function x894062_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x894062_g_eventList do
		if missionScriptId == findId then
			x894062_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x894062_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x894062_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x894062_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )

end

--**********************************
--死亡事件
--**********************************
function x894062_OnDie( sceneId, selfId, killerId )
	
end
