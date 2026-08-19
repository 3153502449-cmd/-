--苏州NPC
--欧冶于
--神器炼魂
--普通
x001085_g_ScriptId = 001085
--**********************************
--事件交互入口
--**********************************
function x001085_OnDefaultEvent( sceneId, selfId,targetId )

	BeginEvent(sceneId)
		AddText(sceneId,"#{SQSJ_0708_08}")
		AddNumText(sceneId,x001085_g_ScriptId,"神器进阶",6,0)
		AddNumText(sceneId,x001085_g_ScriptId,"神器炼魂",6,1)
		--AddNumText(sceneId,x001085_g_ScriptId,"神器重洗",6,2)
		AddNumText(sceneId,x001085_g_ScriptId,"#{ZBCZ_140618_01}",6,3)
		--AddNumText(sceneId, x001085_g_ScriptId,"关于神器炼魂",11,22);
		--AddNumText(sceneId, x001085_g_ScriptId,"#{ZBCZ_140618_02}",11,23);
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x001085_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nOperaiton = GetNumText()
    if GetNumText() == 0 then
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 20150511 )
	end
	if GetNumText() == 1 then
		local nMenPaiID = GetMenPai(sceneId,selfId)
		if nMenPaiID== -1 or nMenPaiID==9 then
		BeginEvent(sceneId)
		AddText(sceneId,"请加入门派后再来!")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
			return
		end
		BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,targetId);
		UICommand_AddInt(sceneId,0);
		EndUICommand(sceneId)
		DispatchUICommand(sceneId,selfId, 19831114 )
	end
	if GetNumText() == 2 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 2 )
        UICommand_AddInt( sceneId, targetId)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  20200605)
	end	
	if GetNumText() == 3 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, 3 )
        UICommand_AddInt( sceneId, targetId)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  20200605)
	end		
	if GetNumText() == 22 then
		BeginEvent(sceneId)
		   AddText(sceneId,"#{SQSJ_0708_01}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 23 then
		BeginEvent(sceneId)
		   AddText(sceneId,"#{ZBCZ_140618_39}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end