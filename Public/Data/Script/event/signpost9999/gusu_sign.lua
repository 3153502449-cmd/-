--姑苏
--问路脚本
x500070_g_scriptId = 500070

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500070_g_Signpost = {
	{ type=2, name="拜见掌门", x=69, y=109, tip="掌门", desc="#{GUSU_MENPAI_14}", eventId=-1 },
	{ type=2, name="加入慕容", x=48, y=144, tip="慕容杰", desc="#{GUSU_MENPAI_15}", eventId=-1 },
	{ type=2, name="学习慕容战斗技能", x=48, y=134, tip="学习慕容战斗技能", desc="#{GUSU_MENPAI_16}", eventId=-1 },
	{ type=2, name="学习慕容生活技能", x=127, y=30, tip="学习慕容生活技能", desc="#{GUSU_MENPAI_17}", eventId=-1 },
	{ type=2, name="学习慕容辅助技能", x=132, y=31, tip="学习慕容辅助技能", desc="#{GUSU_MENPAI_18}", eventId=-1 },
	--{ type=2, name="学习慕容骑乘技能", x=53, y=56, tip="学习骑乘技能", desc="#{GUSU_MENPAI_19}", eventId=-1 },
	{ type=2, name="购买坐骑", x=25, y=166, tip="购买坐骑", desc="#{GUSU_MENPAI_19}", eventId=-1 },
	{ type=2, name="慕容任务", x=69, y=125, tip="慕容任务", desc="#{GUSU_MENPAI_20}", eventId=-1 },
	{ type=2, name="慕容传送人", x=27, y=137, tip="慕容传送人", desc="#{GUSU_MENPAI_21}", eventId=-1 },
	{ type=2, name="藏书水阁", x=159, y=163, tip="藏书水阁", desc="#{GUSU_MENPAI_22}", eventId=-1 },
	{ type=2, name="学习慕容轻功", x=45, y=23, tip="慕容轻功传授人", desc="#{GUSU_MENPAI_23}", eventId=-1 },
}

--**********************************
--列举事件
--**********************************
function x500070_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500070_g_Signpost do
		AddNumText(sceneId, x500070_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500070_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500070_g_Signpost[GetNumText()]

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

end
