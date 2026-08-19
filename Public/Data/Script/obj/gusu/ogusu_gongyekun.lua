--慕容NPC
--公冶坤
--普通

x002130_g_scriptId = 002130

--**********************************
--事件交互入口
--**********************************
function x002130_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{GUSU_MENPAI_27}")
		AddNumText(sceneId,x002130_g_scriptId,"去击退窃贼！",10,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x002130_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId) < 80  then	
			BeginEvent( sceneId )
			local strText = "#{XMPTM_130123_39}"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 329,158,155)
		end
	end
end