-- 苏州NPC
-- 任肇
-- 一般

-- 脚本号
x001087_g_ScriptId = 001087

--**********************************
--事件交互入口
--**********************************
function x001087_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{ZXD_20080312_01}" )
		AddNumText( sceneId, x001087_g_ScriptId, "#{ZXD_20120406_10}", 6, 1 )
		AddNumText( sceneId, x001087_g_ScriptId, "#{BXYH_171216_01}", 6, 2 )
		AddNumText( sceneId, x001087_g_ScriptId, "#{ZXD_20120406_11}", 11, 3 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x001087_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 1 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{function_help_077}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return	
	elseif GetNumText() == 3 then
		BeginEvent( sceneId )
			AddText( sceneId, "#{ZXD_20120406_08}" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
end
