-- 大理NPC
-- 破凡

x002932_g_scriptId = 002932

--**********************************
--事件交互入口
--**********************************
function x002932_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		AddText( sceneId, "#{SXRW_090119_043}" )
		AddNumText( sceneId, x002932_g_scriptId, "#{SXRW_090119_044}", 6, 1 )
		AddNumText( sceneId, x002932_g_scriptId, "#{SXRW_090119_045}", 6, 2 )
		AddNumText( sceneId, x002932_g_scriptId, "#{SXRW_090119_046}", 11, 3 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--事件列表选中一项
--**********************************
function x002932_OnEventRequest( sceneId, selfId, targetId, eventId)
	local nType = GetNumText();
	if nType == 1 then
		BeginEvent( sceneId )
			--260 263
			AddNumText( sceneId, x002932_g_scriptId, "#{SXRW_090119_047}", 3, 10 )
			AddNumText( sceneId, x002932_g_scriptId, "#{SXRW_090119_048}", 3, 11 )
			AddNumText( sceneId, x002932_g_scriptId, "#{SXRW_090119_098}", 3, 12 )
			AddNumText( sceneId, x002932_g_scriptId, "#{SXRW_090119_099}", 3, 13 )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif nType == 2 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SXRW_090119_055}")
			local nBossDataTab = {}
			for i = 1,6 do
				local nBossData = GetMissionDataEx(sceneId,selfId,230 + i);
				nBossDataTab[i * 2] = nBossData;
				nBossDataTab[i * 2 - 1] = nBossData;
			end
--			AddGlobalCountNews( sceneId,"nBossDataTab "..nBossDataTab[1])
			--次数显示
			for i = 0,11 do
				local nBossData = 0;
				if mod((i + 1),2) == 0 then
					nBossData = floor(nBossDataTab[i + 1]/10000);
				else
					nBossData = mod(nBossDataTab[i + 1],10000);
				end
				AddText(sceneId," #P#{SXRW_090119_0"..tostring(56 + i).."}"..nBossData)
			end
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif nType == 3 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{SXRW_090119_109}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif nType >= 10 and nType <= 13 then
		local nIsHave = LuaFnCheckIsHaveTitleByIndex(sceneId, selfId,260 + mod(nType,10))
		if nIsHave == 1 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SXRW_090119_049}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		local nNeedConunt = {1,10,50,200};
		--nNeedConunt[mod(nType,10) + 1]
		local nBossDataTab = {}
		for i = 1,6 do
			local nBossData = GetMissionDataEx(sceneId,selfId,230 + i);
			nBossDataTab[i * 2] = nBossData;
			nBossDataTab[i * 2 - 1] = nBossData;
		end
		local nCantGet = 0;
		for i = 1,12 do
			if nBossDataTab[i] < nNeedConunt[mod(nType,10) + 1] then
				nCantGet = 1;
				break;
			end
		end
		if nCantGet == 1 then
			BeginEvent(sceneId)
				AddText(sceneId,"#{SXRW_090119_050}"..tostring(nNeedConunt[mod(nType,10) + 1]).."#{SXRW_090119_051}")
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
			return
		end
		LuaFnAwardTitleEx(sceneId, selfId,260 + mod(nType,10),-1)
		LuaFnSetCurTitleEx(sceneId,selfId,260 + mod(nType,10))
	end
end