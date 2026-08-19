--桃花岛NPC-君还珠
--2019-11-15 18:44:13 逍遥子

x000604_g_scriptId = 000604
x000604_g_eventList={223900,808004}
--**********************************
--事件交互入口
--**********************************
function x000604_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local mp = GetMenPai(sceneId, selfId)
		if mp ~= 13 then
			AddText(sceneId,"#{THD_190613_10}")
		else
			AddText(sceneId,"#{THD_190613_09}")
		end
		if mp == 9 then 
			AddNumText(sceneId, x000604_g_scriptId, "加入门派",6,0)
		end
		AddNumText(sceneId, x000604_g_scriptId, "门派介绍",8,1)
		AddNumText(sceneId, x000604_g_scriptId, "如何学习门派技能",8,6)		--指路到技能学习人
		for i, eventId in x000604_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x000604_OnEventRequest( sceneId, selfId, targetId, eventId )
	for i, findId in x000604_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_TAOHUADAO )
			return
		end
	end

	if GetNumText()==0	then
		local x000604_g_MenPai = GetMenPai(sceneId, selfId)
		if x000604_g_MenPai == 13   then
			return
		end
		
		if x000604_g_MenPai ~= 9 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{THDRZ_190613_38}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		BeginEvent(sceneId)
			AddText(sceneId, "#{THDRZ_190613_40}")
			AddNumText(sceneId, x000604_g_scriptId, "#{THDRZ_190613_41}",6,3)
			AddNumText(sceneId, x000604_g_scriptId, "#{THDRZ_190613_42}",8,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		 
		return
	end
	
	if GetNumText()==4	then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end

	if GetNumText()==3	then
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 2 then
			BeginEvent(sceneId)
				AddText(sceneId,"  整理一下背包，需要有两个空位置，我会有奖励给你！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif GetLevel( sceneId, selfId ) < 10 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{THDRZ_190613_39}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			local x000604_g_MenPai = GetMenPai(sceneId, selfId)
			if x000604_g_MenPai==9	then
				AddText(sceneId,"那么从现在开始，你就是我桃花岛的门下弟子了。")
				LuaFnJoinMenpai(sceneId, selfId, targetId, 13)

				-- 设置初始的Npc关系值
				CallScriptFunction( 200099, "InitRelation", sceneId, selfId )

				-- 把相关的心法设置为10级别  19,22,23
				LuaFnSetXinFaLevel(sceneId,selfId,97,30)
				LuaFnSetXinFaLevel(sceneId,selfId,98,30)
				LuaFnSetXinFaLevel(sceneId,selfId,99,30)
				LuaFnSetXinFaLevel(sceneId,selfId,100,30)
				LuaFnSetXinFaLevel(sceneId,selfId,101,30)
				LuaFnSetXinFaLevel(sceneId,selfId,102,30)

				BeginEvent(sceneId)
	  				AddText(sceneId,"#{THDRZ_190613_34}");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,selfId)
				--给玩家发信,告诉他到哪里打怪,怎样赚钱
--				LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{LevelMail_menpai_9}" )
				
				--门派奖励召集令
				BeginAddItem(sceneId)
					AddItem( sceneId,30501001, 20 )
				EndAddItem(sceneId,selfId)
				AddItemListToHuman(sceneId,selfId)
				x000604_MsgBox( sceneId, selfId, "得到20个门派召集令。" )

				if TryRecieveItem( sceneId, selfId, 10124396, 1 ) >= 0 then
					x000604_MsgBox( sceneId, selfId, "#{THDRZ_190613_35}" )
				end
				
				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnMsg2Player( sceneId, selfId,"#{THDRZ_190613_34}",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 163, 0)
					CallScriptFunction( 223900, "OnDefaultEvent",sceneId, selfId, targetId )
				else
					LuaFnMsg2Player( sceneId, selfId,"#{THDRZ_190613_34}",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 163, 0)
					CallScriptFunction( 223900, "OnDefaultEvent",sceneId, selfId, targetId )
				end
			else
				BeginEvent(sceneId)
					AddText(sceneId,"#{THDRZ_190613_38}")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end
		end
	elseif	GetNumText()==1	then
		BeginEvent(sceneId)
			AddText(sceneId, "#{THDRZ_190613_51}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	--指路
	if GetNumText()==6 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{THD_190613_35}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, 207, 66, "燕返" )
		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000604_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000604_g_eventList do
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
function x000604_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000604_g_eventList do
		if missionScriptId == findId then
			x000604_OnDefaultEvent( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000604_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000604_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000604_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000604_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000604_OnDie( sceneId, selfId, killerId )
end

--**********************************
--消息提示
--**********************************
function x000604_MsgBox( sceneId, selfId, str )
	Msg2Player( sceneId, selfId, str, MSG2PLAYER_PARA )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
