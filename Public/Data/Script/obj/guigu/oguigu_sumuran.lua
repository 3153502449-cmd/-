--鬼谷NPC
--鬼谷
--普通

x080004_g_scriptId = 080004

--**********************************
--事件交互入口
--**********************************
function x080004_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{XMPGG_160823_56}")
		AddNumText(sceneId,x080004_g_scriptId,"击退山匪",10,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x080004_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId)<90  then	
			BeginEvent( sceneId )
			local strText = "要想击退山匪，需得具备一定的本领，少侠你尚未达到#G90级#W，还是先去别处历练一番再来吧。"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 719,100,165)
		end
	end
end
