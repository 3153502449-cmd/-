--春花秋月
--2019-10-1 21:05:27 逍遥子
x808235_g_scriptId = 808235
x808235_g_XinFaID = 59
--**********************************
--回调本接口....
--**********************************
function x808235_OnImpactFadeOut(sceneId,selfId,impactId)
    if impactId == 259 then
		if GetHp( sceneId, selfId ) == 0 then		
			return		
		end
		local targetId = LuaFnGetTargetObjID(sceneId, selfId)
		if LuaFnIsObjValid(sceneId, targetId) ~= 1 then
		   return
		end
		if HaveXinFa(sceneId,selfId,x808235_g_XinFaID) < 1 then
		   return
		end
		local nXinFaLevel = LuaFnGetXinFaLevel(sceneId,selfId,x808235_g_XinFaID);
		if LuaFnUnitIsFriend(sceneId,selfId,targetId) == 1 then --友军
			nXinFaLevel = 1162 + (1173 - 1162) * floor(nXinFaLevel/129);
			if nXinFaLevel > 1173 then
				nXinFaLevel = 1173;
			end
			if nXinFaLevel < 1162 then
				nXinFaLevel = 1162
			end
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,targetId,nXinFaLevel,0)
			return
		end
		if LuaFnUnitIsEnemy(sceneId,selfId,targetId) == 1 then --敌军
			nXinFaLevel = 1150 + (1161 - 1150) * floor(nXinFaLevel/129);
			if nXinFaLevel > 1161 then
				nXinFaLevel = 1161;
			end
			if nXinFaLevel < 1150 then
				nXinFaLevel = 1150
			end
			LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,targetId,nXinFaLevel,0)
			return
		end
		BeginEvent(sceneId)
			AddText(sceneId,"请选择正确的目标！" )
		EndEvent(sceneId)
		DispatchMissionTips(sceneId,selfId)
	end
end

