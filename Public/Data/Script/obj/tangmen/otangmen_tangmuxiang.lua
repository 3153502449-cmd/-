--唐门NPC
--唐暮翔
--普通

x017512_g_scriptId = 017512

--**********************************
--事件交互入口
--**********************************
function x017512_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"唐家堡的演武场中收集了天下各派的武功秘籍，难易繁杂皆有，但最近频遭窃书贼困扰，你要进去查看一番吗？")
		AddNumText(sceneId,x017512_g_scriptId,"擒拿窃贼",10,0)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x017512_OnEventRequest( sceneId, selfId, targetId, eventId )
	if	GetNumText()==0	then
		if	GetLevel( sceneId, selfId) < 80  then	
			BeginEvent( sceneId )
			local strText = "#{XMPTM_130123_39}"
			AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList(sceneId,selfId,targetId)
		else
			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, 328,170,163)
		end
	end
end