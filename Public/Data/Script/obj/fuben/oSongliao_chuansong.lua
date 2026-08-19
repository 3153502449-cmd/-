--宋辽大战[血战雁门关]
--传送 in 宋辽战场
--逍遥子 QQ857904341

--脚本号
x502021_g_scriptId = 502021

--**********************************
--事件列表
--**********************************
function x502021_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"  我可以带你回城")
		AddNumText( sceneId, x502021_g_scriptId, "确定回到苏州",6 ,1  )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x502021_OnDefaultEvent( sceneId, selfId,targetId )
	x502021_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x502021_OnEventRequest( sceneId, selfId, targetId, eventId )
	local NPCName = GetName(sceneId,targetId)
	local nCamp = GetUnitCampID(sceneId, selfId,selfId )
	if NPCName == "大辽传送人" and nCamp ~= 157 then
		x502021_NotifyFailBox(sceneId,selfId,targetId,"你不是我辽营战士，我不能为你服务！")
		return
	end
	if NPCName == "大宋传送人" and nCamp ~= 156 then
		x502021_NotifyFailBox(sceneId,selfId,targetId,"你不是我宋营战士，我不能为你服务！")
		return
	end
	CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, 1,294,241, 10 )	
end

--**********************************
--对话界面
--**********************************
function x502021_MsgBox( sceneId, selfId, str )	
	BeginEvent( sceneId )
	AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x502021_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end