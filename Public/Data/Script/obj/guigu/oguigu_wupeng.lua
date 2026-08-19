--普通

x080005_g_ScriptId = 080005

--**********************************
--事件交互入口
--**********************************
function x080005_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{XMPGG_160823_62}")
		AddNumText(sceneId, x080005_g_ScriptId, "学习鬼谷轻功",12,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x080005_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText()==0	then
		
		if GetMenPai(sceneId, selfId) == 12 then
			if	HaveSkill( sceneId, selfId, 102)<0	then
				-- 扣钱
				if GetMoney(sceneId, selfId)+GetMoneyJZ(sceneId, selfId) < STUDY_MENPAI_QINGGONG_SPEND  then
					BeginEvent(sceneId)
						AddText(sceneId,"  您身上的现金不足1#-15，因此无法学习本门轻功。")
					EndEvent(sceneId)
					DispatchEventList(sceneId,selfId,targetId)
					return
				end
				-- 扣钱
				LuaFnCostMoneyWithPriority(sceneId,selfId,STUDY_MENPAI_QINGGONG_SPEND)
				
				AddSkill( sceneId, selfId, 102 )
				DelSkill( sceneId, selfId, 34 )
				BeginEvent(sceneId)
					AddText(sceneId,"恭喜你学会本门的轻功，希望为本门的发扬光大继续努力。")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			else
				BeginEvent(sceneId)
					AddText(sceneId,"你不是已经学会了吗？")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
			end
		elseif GetMenPai(sceneId, selfId) == 12 then
			BeginEvent(sceneId)
				AddText(sceneId,"学习鬼谷轻功需要先加入鬼谷门派！")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		else
			BeginEvent(sceneId)
				AddText(sceneId,"你不是本门派的弟子，我是不能教你鬼谷的轻功的")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	end	
end

--**********************************
--接受此NPC的任务
--**********************************
function x080005_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x080005_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
end

--**********************************
--继续（已经接了任务）
--**********************************
function x080005_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
end

--**********************************
--提交已做完的任务
--**********************************
function x080005_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
end

--**********************************
--死亡事件
--**********************************
function x080005_OnDie( sceneId, selfId, killerId )
end
