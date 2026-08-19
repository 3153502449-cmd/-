--唐门
--问路脚本
x500071_g_scriptId = 500071

-- 问路类型 type: 1 为二级菜单, 2 为直接问路
x500071_g_Signpost = {
	{ type=2, name="拜见掌门", x=66, y=29, tip="掌门", desc="#{XMPTM_130123_81}", eventId=-1 },
	{ type=2, name="加入唐门", x=78, y=35, tip="唐亦风", desc="#{XMPTM_130123_84}", eventId=-1 },
	{ type=2, name="学习唐门战斗技能", x=38, y=75, tip="唐岳冲", desc="#{XMPTM_130123_87}", eventId=-1 },
	{ type=2, name="学习唐门生活技能", x=40, y=142, tip="唐门姥姥", desc="#{XMPTM_130123_90}", eventId=-1 },
	{ type=2, name="学习唐门辅助技能", x=41, y=140, tip="唐若兮", desc="#{XMPTM_130123_93}", eventId=-1 },
	{ type=2, name="购买坐骑", x=170, y=32, tip="唐楮机", desc="#{XMPTM_130123_96}", eventId=-1 },
	{ type=2, name="唐门任务", x=100, y=64, tip="唐清秋", desc="#{XMPTM_130123_99}", eventId=-1 },
	{ type=2, name="唐门传送人", x=126, y=68, tip="唐予诚", desc="#{XMPTM_130123_102}", eventId=-1 },
	{ type=2, name="演武场", x=152, y=154, tip="唐暮翔", desc="#{XMPTM_130123_105}", eventId=-1 },
	{ type=2, name="学习唐门轻功", x=88, y=111, tip="唐春", desc="#{XMPTM_130123_108}", eventId=-1 },
}

--**********************************
--列举事件
--**********************************
function x500071_OnEnumerate( sceneId, selfId, targetId )
	for i, signpost in x500071_g_Signpost do
		AddNumText(sceneId, x500071_g_scriptId, signpost.name, -1, i)
	end
end

--**********************************
--任务入口函数
--**********************************
function x500071_OnDefaultEvent( sceneId, selfId, targetId )
	signpost = x500071_g_Signpost[GetNumText()]

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
