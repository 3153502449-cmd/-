--桃花岛NPC-兰庭生
--2019-11-15 20:38:35 逍遥子
--脚本号
x000523_g_scriptId = 000523
--动态对话
--THD_190613_135
--THD_190613_136
--THD_190613_137
--THD_190613_138
--THD_190613_139
--THD_190613_140
--**********************************
--动态对话
--**********************************
function x000523_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nTalkIndex = random(135,140)
	LuaFnNpcChat(sceneId, objId, 1, "#{THD_190613_"..tostring(nTalkIndex).."}")
end
--**********************************
--事件列表
--**********************************
function x000523_UpdateEventList( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{THD_190613_90}");
		AddNumText(sceneId, x000523_g_scriptId, "#{THD_190613_91}",-1,0)
		AddNumText(sceneId, x000523_g_scriptId, "#{THD_190613_92}",-1,1)
		AddNumText(sceneId, x000523_g_scriptId, "#{THD_190613_93}",-1,2)
		AddNumText(sceneId, x000523_g_scriptId, "#{THD_190613_94}",-1,3)
		AddNumText(sceneId, x000523_g_scriptId, "#{THD_190613_95}",-1,4)
		AddNumText(sceneId, x000523_g_scriptId, "#{THD_190613_96}",-1,5)
		
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000523_OnDefaultEvent( sceneId, selfId,targetId )
	x000523_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000523_OnEventRequest( sceneId, selfId, targetId, eventId )
	local sign = GetNumText()
	if sign == 0 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THD_190613_97}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif sign == 1 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THD_190613_98}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif sign == 2 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THD_190613_99}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif sign == 3 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THD_190613_100}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif sign == 4 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THD_190613_101}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif sign == 5 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{THD_190613_102}");
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	return
end