--太湖NPC
--许愿树
--普通
x004112_g_scriptId = 004112
--**********************************
--事件交互入口
--**********************************
function x004112_OnDefaultEvent( sceneId, selfId,targetId )
	local nTodayNum = LuaFnGetWorldGlobalData(WG_XuYuanShuNum)
	BeginEvent(sceneId)
		AddText(sceneId,"#{SQXY_09061_37}"..nTodayNum.."#{SQXY_09061_38}")
		AddNumText(sceneId, x004112_g_scriptId,"#{SQXY_09061_6}", 11, 1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x004112_OnEventRequest( sceneId, selfId, targetId, eventId )
	local Operation = GetNumText()
	if Operation == 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SQXY_09061_10}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end