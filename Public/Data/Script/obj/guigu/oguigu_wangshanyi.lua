--鬼谷NPC
--掌门人
--王禅一
--普通

x080002_g_scriptId = 080002
x080002_g_eventList={228911,808004}
--**********************************
--事件交互入口
--**********************************
function x080002_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"       我鬼谷门下弟子多为惊采绝艳之辈。若要入我门墙，除天资聪慧，亦要心胸豁达。#r      身为鬼谷四大长老之首，这弟子#G拜师#W之事宜，老夫自会慎重以待。")
		local mp = GetMenPai(sceneId, selfId)
        local nVigor=GetHumanMaxVigor(sceneId,selfId) 
		if mp == 9 and nVigor < 25000 then 
			AddNumText(sceneId, x080002_g_scriptId, "加入门派",6,0)
		end
		AddNumText(sceneId, x080002_g_scriptId, "门派介绍",8,1)
		AddNumText(sceneId, x080002_g_scriptId, "如何学习门派技能",8,6)		--指路到技能学习人
		for i, eventId in x080002_g_eventList do
			CallScriptFunction( eventId, "OnEnumerate",sceneId, selfId, targetId )
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end


--**********************************
--事件列表选中一项
--**********************************
function x080002_OnEventRequest( sceneId, selfId, targetId, eventId )

	for i, findId in x080002_g_eventList do
		if eventId == findId then
			CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, MP_GUIGU )
			return
		end
	end

	if GetNumText()==0 then

		x080002_g_MenPai = GetMenPai(sceneId, selfId)
        local nVigor = GetHumanMaxVigor(sceneId,selfId) 
		if x080002_g_MenPai == 12   then
			BeginEvent(sceneId)
				AddText(sceneId, "你又来消遣为师了，你已是我鬼谷弟子，还拜什么师呢。")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		
		if x080002_g_MenPai ~= 9 then
			BeginEvent(sceneId)
				AddText(sceneId,"你已是别的门派的高徒了，我们不收你。")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end

		BeginEvent(sceneId)
			AddText(sceneId, "#{GGXS_160621_37}")
			AddNumText(sceneId, x080002_g_scriptId, "#{GGXS_160621_38}",6,3)
			AddNumText(sceneId, x080002_g_scriptId, "#{GGXS_160621_39}",8,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		 
		return
	end
	
	if GetNumText()==4 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end

	if GetNumText()==3 then
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 2 then
			BeginEvent(sceneId)
				AddText(sceneId,"  整理一下背包，需要有两个空位置，我会有奖励给你！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif GetLevel( sceneId, selfId ) < 10 then
			BeginEvent(sceneId)
				AddText(sceneId,"你还是等到10级之后再来拜师学艺吧！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			x080002_g_MenPai = GetMenPai(sceneId, selfId)
			if x080002_g_MenPai == 12 then
				BeginEvent(sceneId)
					AddText(sceneId, "你又来消遣为师了，你已是我鬼谷弟子，还拜什么师呢。")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			--返回值为9表示无门派
	        elseif x080002_g_MenPai == 9 then
				LuaFnJoinMenpai(sceneId, selfId, targetId, 12)

				-- 设置初始的Npc关系值
				CallScriptFunction( 200099, "InitRelation", sceneId, selfId )

				-- 把相关的心法设置为10级别  49,52,53
				LuaFnSetXinFaLevel(sceneId,selfId,89,30)
				LuaFnSetXinFaLevel(sceneId,selfId,90,30)
				LuaFnSetXinFaLevel(sceneId,selfId,91,30)
				LuaFnSetXinFaLevel(sceneId,selfId,92,30)
				LuaFnSetXinFaLevel(sceneId,selfId,93,30)
				LuaFnSetXinFaLevel(sceneId,selfId,94,30)
				
				BeginEvent(sceneId)
					AddText(sceneId,"你已经加入鬼谷！");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				
				--门派奖励召集令
				for i=1, 20 do
					TryRecieveItem( sceneId, selfId, 30501001, 1 )
				end
				x080002_MsgBox( sceneId, selfId, "得到20枚门派召集令。" )

				if TryRecieveItem( sceneId, selfId, 10124385, 1 ) >= 0 then
					str		= "#Y你获得了"..GetItemName( sceneId, 10124385 ).."。"
					x080002_MsgBox( sceneId, selfId, str )
				end

				if	LuaFnGetSex( sceneId, selfId)==0	then
					LuaFnMsg2Player( sceneId, selfId,"你已经加入鬼谷！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 168, 0)
					CallScriptFunction( 225900, "OnDefaultEvent",sceneId, selfId, targetId )
				else
					LuaFnMsg2Player( sceneId, selfId,"你已经加入鬼谷！",MSG2PLAYER_PARA)
					LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 168, 0)
					CallScriptFunction( 225900, "OnDefaultEvent",sceneId, selfId, targetId )
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
			AddText(sceneId, "#{XMPGG_160524_03}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	--指路
	if GetNumText()==6 then
		BeginEvent(sceneId)
			AddText(sceneId, "#{GGXS_160621_116}")
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, 92, 55, "李继隆" )
		return
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x080002_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x080002_g_eventList do
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
function x080002_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x080002_g_eventList do
		if missionScriptId == findId then
			x080002_OnDefaultEvent( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x080002_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x080002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x080002_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x080002_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x080002_OnDie( sceneId, selfId, killerId )
end

--**********************************
--消息提示
--**********************************
function x080002_MsgBox( sceneId, selfId, str )
	Msg2Player( sceneId, selfId, str, MSG2PLAYER_PARA )
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

