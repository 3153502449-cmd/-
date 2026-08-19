--萧如蔚
--2019-11-7 18:53:08 逍遥子二开
x895068_g_scriptId = 895068

--**********************************
--事件交互入口
--**********************************
function x895068_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"      天堂有路君不走，地狱无门送上来！")
		AddNumText( sceneId, x895068_g_scriptId, "#c00ff00战斗", 10, 200)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x895068_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 200 then
		BeginEvent(sceneId)
			AddText(sceneId,"  兄弟连心，其利断金，点击我上面的兄弟，我们才能同时和你们战斗！")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end
