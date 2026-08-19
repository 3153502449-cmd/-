--桃花岛NPC-李长吉
--2019-10-9 16:18:02 逍遥子
--问路
--脚本号
x000511_g_scriptId = 000511
-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x000511_g_Signpost = {
	{ type=2, name="#{THD_190613_30}", x=159, y=65, tip="掌门", desc="#{THD_190613_31}", eventId=-1 },
	{ type=2, name="#{THD_190613_32}", x=194, y=96, tip="君还珠", desc="#{THD_190613_33}", eventId=-1 },
	{ type=2, name="#{THD_190613_34}", x=188, y=79, tip="学习桃花岛战斗技能", desc="#{THD_190613_35}", eventId=-1 },
	{ type=2, name="#{THD_190613_36}", x=115, y=85, tip="学习桃花岛生活技能", desc="#{THD_190613_37}", eventId=-1 },
	{ type=2, name="#{THD_190613_38}", x=113, y=87, tip="学习桃花岛辅助技能", desc="#{THD_190613_39}", eventId=-1 },
	{ type=2, name="#{THD_190613_40}", x=124, y=143, tip="购买坐骑", desc="#{THD_190613_41}", eventId=-1 },
	{ type=2, name="#{THD_190613_42}", x=159, y=78, tip="桃花岛任务", desc="#{THD_190613_43}", eventId=-1 },
	{ type=2, name="#{THD_190613_44}", x=224, y=182, tip="桃花岛传送人", desc="#{THD_190613_45}", eventId=-1 },
	{ type=2, name="#{THD_190613_48}", x=188, y=73, tip="桃花岛轻功传授人", desc="#{THD_190613_49}", eventId=-1 },
}
--**********************************
--事件列表
--**********************************
function x000511_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		local nMenPaiID = GetMenPai(sceneId,selfId);
		if nMenPaiID == 13 then
			AddText(sceneId,"#{THD_190613_01}");
		else
			AddText(sceneId,"#{THD_190613_02}");
		end
		for i, signpost in x000511_g_Signpost do
			AddNumText(sceneId, x000511_g_scriptId, signpost.name, -1, i)
		end
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000511_OnDefaultEvent( sceneId, selfId,targetId )
	x000511_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000511_OnEventRequest( sceneId, selfId, targetId, eventId )
	local signpost = x000511_g_Signpost[GetNumText()]
	if signpost.type == 1 then
		BeginEvent(sceneId)
			AddText(sceneId, signpost.name .. "：")
			CallScriptFunction( signpost.eventId, "OnEnumerate", sceneId, selfId, targetId )
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	elseif signpost.type == 2 then
		CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, signpost.x, signpost.y, signpost.tip )

		BeginEvent(sceneId)
			AddText(sceneId, signpost.desc)
		EndEvent(sceneId)
		DispatchEventList(sceneId, selfId, targetId)
	end
	return
end
--**********************************
--接受此NPC的任务
--**********************************
function x000511_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )

end
--**********************************
--拒绝此NPC的任务
--**********************************
function x000511_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )

end
--**********************************
--继续（已经接了任务）
--**********************************
function x000511_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )

end
--**********************************
--提交已做完的任务
--**********************************
function x000511_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )

end
--**********************************
--死亡事件
--**********************************
function x000511_OnDie( sceneId, selfId, killerId )
	
end
