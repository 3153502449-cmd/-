--慕容NPC
--慕容杰
--普通

x002139_g_scriptId =002139
x002139_g_eventList={228905,229009,808004,229012}
--**********************************
--事件交互入口
--**********************************
function x002139_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"  看这位少侠不凡，想加入我慕容世家门派吗，我负责收慕容新弟子！")
		local mp = GetMenPai(sceneId, selfId)
        local Vigor = GetHumanMaxVigor(sceneId,selfId) 
		if mp == 9 and Vigor < 25000 then 
			AddNumText(sceneId, x002139_g_scriptId, "加入门派",6,0)
		end
		AddNumText(sceneId, x002139_g_scriptId, "门派介绍",8,1)
		AddNumText(sceneId, x002139_g_scriptId, "如何学习门派技能",8,6)		--指路到技能学习人
		for i, eventId in x002139_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
--事件列表选中一项
--**********************************
function x002139_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x002139_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_GUSU )
			return
		end
	end

	if GetNumText()==0	then

		x002139_g_MenPai = GetMenPai(sceneId, selfId)
		if x002139_g_MenPai == 10 then
			BeginEvent(sceneId)
				AddText(sceneId, "你又来消遣为师了，你已是我慕容弟子，还拜什么师呢。")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		if x002139_g_MenPai ~= 9 then
			BeginEvent(sceneId)
				AddText(sceneId,"你已是别的门派的高徒了，我们不收你。")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		BeginEvent(sceneId)
			AddText(sceneId, "#{GUSU_MENPAI_25}")
			AddNumText(sceneId, x002139_g_scriptId, "我确定要拜入慕容世家",6,3)
			AddNumText(sceneId, x002139_g_scriptId, "我暂时还不想拜入门派",8,4)
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
				AddText(sceneId,"少侠还是等到10级之后再来拜师学艺吧！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			x002139_g_MenPai = GetMenPai(sceneId, selfId)
			if x002139_g_MenPai == 10 then
				BeginEvent(sceneId)
					AddText(sceneId, "你又来消遣为师了，你已是我慕容世家的弟子，还拜什么师呢。")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			--返回值为9表示无门派
			elseif x002139_g_MenPai==9	then
			    
				LuaFnJoinMenpai(sceneId, selfId, targetId, 10)
				-- 设置初始的Npc关系值
				CallScriptFunction( 200099, "InitRelation", sceneId, selfId )

				-- 把相关的心法设置为10级别  64,67,68
				LuaFnSetXinFaLevel(sceneId,selfId,64,30)
				LuaFnSetXinFaLevel(sceneId,selfId,65,30)
				LuaFnSetXinFaLevel(sceneId,selfId,66,30)
                LuaFnSetXinFaLevel(sceneId,selfId,67,30)
                LuaFnSetXinFaLevel(sceneId,selfId,68,30)
                LuaFnSetXinFaLevel(sceneId,selfId,69,30)
				BeginEvent(sceneId)
	  				AddText(sceneId,"你已经加入慕容世家！");
	  			EndEvent(sceneId)
	  			DispatchMissionTips(sceneId,selfId)
				--给玩家发信,告诉他到哪里打怪,怎样赚钱
				LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "#{LevelMail_menpai_10}" )
				
				--门派奖励召集令
				for i=1, 20 do
					TryRecieveItem( sceneId, selfId, 30501001, 1 )
				end
				x002139_MsgBox( sceneId, selfId, "得到20枚门派召集令。" )
					if TryRecieveItem( sceneId, selfId, 10124340, 1 ) >= 0 then
						str		= "#Y你获得了"..GetItemName( sceneId, 10124340 ).."。"
						x002139_MsgBox( sceneId, selfId, str )
					end

				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnMsg2Player( sceneId, selfId,"你已经加入慕容世家！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 163, 0)
					CallScriptFunction( 228905, "OnDefaultEvent",sceneId, selfId, targetId )
				else
					LuaFnMsg2Player( sceneId, selfId,"你已经加入慕容世家！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 163, 0)
					CallScriptFunction( 228905, "OnDefaultEvent",sceneId, selfId, targetId )
				end
			else
				BeginEvent(sceneId)
					AddText(sceneId,"你已是别的门派的高徒了，我们不收你。")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end
		end
	elseif	GetNumText()==1	then
		BeginEvent(sceneId)
			AddText(sceneId, "#{OBJ_gusu_0001}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	--指路
	if GetNumText()==6 then
		BeginEvent(sceneId)
			AddText(sceneId, "慕容青山（48，134）可以教给你我派战斗技能，他就在我附近。")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, 48, 134, "慕容青山" )
		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x002139_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002139_g_eventList do
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
function x002139_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x002139_g_eventList do
		if missionScriptId == findId then
			x002139_OnDefaultEvent( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x002139_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x002139_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x002139_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x002139_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x002139_OnDie( sceneId, selfId, killerId )
end

--**********************************
--消息提示
--**********************************
function x002139_MsgBox( sceneId, selfId, str )
	Msg2Player( sceneId, selfId, str, MSG2PLAYER_PARA )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

