--鬼谷
--问路脚本
x500072_g_scriptId = 500072

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500072_g_Signpost = {
	{ type=2, name="拜见掌门人", x=96, y=52, tip="王栩之", desc="#{GGZLR_160902_03}", eventId=-1 },
	{ type=2, name="加入鬼谷", x=99, y=56, tip="王禅一", desc="#{GGZLR_160902_06}", eventId=-1 },
	{ type=2, name="学习鬼谷战斗技能", x=92, y=55, tip="李继隆", desc="#{GGZLR_160902_09}", eventId=-1 },
	{ type=2, name="学习鬼谷生活技能", x=50, y=63, tip="张遗", desc="#{GGZLR_160902_12}", eventId=-1 },
	{ type=2, name="学习鬼谷生活辅助技能", x=41, y=140, tip="小仙儿", desc="#{GGZLR_160902_15}", eventId=-1 },
	{ type=2, name="购买坐骑", x=170, y=32, tip="苏芩", desc="#{GGZLR_160902_18}", eventId=-1 },
	{ type=2, name="鬼谷任务", x=100, y=64, tip="王玄风", desc="#{GGZLR_160902_21}", eventId=-1 },
	{ type=2, name="鬼谷传送人", x=126, y=68, tip="九日通", desc="#{GGZLR_160902_24}", eventId=-1 },
	{ type=2, name="阴阳天", x=152, y=154, tip="李继隆", desc="#{GGZLR_160902_27}", eventId=-1 },
	{ type=2, name="学习鬼谷轻功", x=88, y=111, tip="吴澎", desc="#{GGZLR_160902_30}", eventId=-1 },
}

--**********************************
--列举事件
--**********************************
function x500072_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500072_g_Signpost do
		AddNumText(sceneId, x500072_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500072_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500072_g_Signpost[GetNumText()]

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
