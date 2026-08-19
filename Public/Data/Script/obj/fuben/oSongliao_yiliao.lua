--宋辽大战[血战雁门关]
--医疗NPC in 宋辽战场
--逍遥子 QQ857904341
x502020_g_scriptId = 502020

--**********************************
--事件列表
--**********************************
function x502020_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
	AddText(sceneId,"  我这可以为你治疗")
		AddNumText(sceneId,x502020_g_scriptId, "恢复血气",6 ,1)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x502020_OnDefaultEvent( sceneId, selfId,targetId )
	x502020_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x502020_OnEventRequest( sceneId, selfId, targetId, eventId )
	local NPCName = GetName(sceneId,targetId)
	local nCamp = GetUnitCampID(sceneId, selfId,selfId )
	if NPCName == "辽营医师" and nCamp ~= 157 then
		x502020_NotifyFailBox(sceneId,selfId,targetId,"#{SLDZ_100805_75}")
		return
	end
	if NPCName == "宋营医师" and nCamp ~= 156 then
		x502020_NotifyFailBox(sceneId,selfId,targetId,"#{SLDZ_100805_75}")
		return
	end
	RestoreHp( sceneId, selfId )
	RestoreMp( sceneId, selfId )
	x502020_NotifyFailBox(sceneId,selfId,targetId,"你的气血已恢复，继续去战场杀敌吧！")
end
--**********************************
--消息提示
--**********************************
function x502020_MsgBox( sceneId, selfId, str )	
	BeginEvent( sceneId )
		AddText( sceneId, str )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x502020_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end



