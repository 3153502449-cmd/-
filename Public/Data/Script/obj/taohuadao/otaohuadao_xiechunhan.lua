--桃花岛NPC-谢春寒
--2019-11-15 18:27:43 逍遥子
--脚本号
x000520_g_scriptId = 000520
x000520_g_SkillID = 103
--**********************************
--事件列表
--**********************************
function x000520_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nMenPaiID = GetMenPai(sceneId,selfId);
		if nMenPaiID == 13 then
			AddText(sceneId,"#{THD_190613_17}");
			if HaveSkill(sceneId,selfId,x000520_g_SkillID) ~= 1 then
				AddNumText(sceneId, x000520_g_scriptId, "#{THD_190613_48}", 6, 1)
			end
		else
			AddText(sceneId,"#{THD_190613_18}");
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000520_OnDefaultEvent( sceneId, selfId,targetId )
	x000520_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000520_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	if sign == 1 then
		local nMenPaiID = GetMenPai(sceneId,selfId);
		if nMenPaiID ~= 13 then
			return
		end
		if HaveSkill( sceneId, selfId, x000520_g_SkillID ) < 0	then
			-- 检查钱
			if GetMoney(sceneId, selfId)+GetMoneyJZ(sceneId, selfId) < STUDY_MENPAI_QINGGONG_SPEND  then
				BeginEvent(sceneId)
					AddText(sceneId,"  您身上的现金不足1#-15，因此无法学习本门轻功。")
				EndEvent(sceneId)
				DispatchEventList(sceneId,selfId,targetId)
				return
			end
			-- 扣钱
			LuaFnCostMoneyWithPriority(sceneId,selfId,STUDY_MENPAI_QINGGONG_SPEND)
			AddSkill( sceneId, selfId, x000520_g_SkillID )
			DelSkill( sceneId, selfId, 34 )
			BeginEvent(sceneId)
				AddText(sceneId,"  恭喜你学会本门的轻功，希望为本门的发扬光大继续努力。")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	end
	return
end