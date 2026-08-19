--洛阳NPC
--伊天彩
--普通

x000155_g_shoptableindex=155
x000110_g_scriptId = 000155
--**********************************
--事件交互入口
--**********************************
function x000155_OnDefaultEvent( sceneId, selfId,targetId )
    --SetMissionData(sceneId,selfId,MD_INFANT_MODE,2191)
	BeginEvent( sceneId )
		AddText( sceneId, "#{SZZH_170111_10}" )
		AddNumText( sceneId, x000110_g_scriptId, "关于人物时装工坊", 11, 0 )
		AddNumText( sceneId, x000110_g_scriptId, "人物时装工坊", 6, 1 )
		--
		AddNumText( sceneId, x000110_g_scriptId, "时装配饰工坊", 6, 2 )
		AddNumText( sceneId, x000110_g_scriptId, "#{ZNSZ_140718_17}", 6, 4 )
		AddNumText( sceneId, x000110_g_scriptId, "#{ZNSZ_140718_27}", 6, 3 )
		--
		AddNumText( sceneId, x000110_g_scriptId, "关于时装配饰工坊", 11, 5 )
		AddNumText( sceneId, x000110_g_scriptId, "#{ZNSZ_140718_18}", 11, 6 )
		AddNumText( sceneId, x000110_g_scriptId, "#{ZNSZ_140718_28}", 11, 7 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x000155_OnEventRequest( sceneId, selfId, targetId, eventId )

	if GetNumText() == 0 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{SZZH_170111_11}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	

	if GetNumText() == 1 then
		if LuaFnIsModelOrMount( sceneId, selfId ) == 1 then --是不是变身或在坐骑上
			x000155_NotifyTip( sceneId, selfId, "#{SZRSYH_120912_18}" )
			return 
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  0910281)
		return
	end
	if GetNumText() == 3 then
		if LuaFnIsModelOrMount( sceneId, selfId ) == 1 then --是不是变身或在坐骑上
			x000155_NotifyTip( sceneId, selfId, "#{SZRSYH_120912_18}" )
			return 
		end
		local nSex = x000155_GetInfantData(sceneId,selfId)
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, nSex )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  890985)
		return
	end
	
	if GetNumText() == 2 then
		if LuaFnIsModelOrMount( sceneId, selfId ) == 1 then --是不是变身或在坐骑上
			x000155_NotifyTip( sceneId, selfId, "#{WLMJ_130121_06}" )
			return 
		end
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, 0 )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId,  20091027)
		return
	end
	if GetNumText() == 4 then
			x000155_NotifyTip( sceneId, selfId, "功能暂未开放，后面持续开放" )
		return
	end
	
	if GetNumText() == 5 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{SZZH_170111_13}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 6 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{ZNSZ_140718_30}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
	if GetNumText() == 7 then
		BeginEvent(sceneId)						
			AddText(sceneId,"#{ZNSZ_140718_29}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end	
end
---//////当前子女数据读取
function x000155_GetInfantData(sceneId,selfId)
         local handle = openfile("./XYD_DataBase/Infant/"..LuaFnGetGUID(sceneId,selfId)..".txt", "r")
		 local Table = 0
		 if handle == nil then
		     return 0
		 else
		   for i = 1,1 do
		      local LineData = read(handle, "*l")
			  if LineData == nil then
			     break
			  end
			  if i == 1 then
			     local _,_,name,sex = strfind(LineData,"(.*)\t(.*)")
				 Table = tonumber(sex)				 
			  end			  		  
           end	
            closefile(handle)		   
		 end
   return Table
end
--**********************************
--醒目提示
--**********************************
function x000155_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end