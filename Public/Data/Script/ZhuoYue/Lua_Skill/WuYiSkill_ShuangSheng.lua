--武意·双生
--2019-11-2 11:39:29 逍遥子
--加成在底层限制，识别BUFF 25484-25493
x808245_g_scriptId = 808245
--**********************************
--技能释放效果
--**********************************
function x808245_StartWuYiShuangSheng(sceneId,selfId,targetId)
	if LuaFnIsObjValid(sceneId, targetId) ~= 1 then
        return
    end
	if LuaFnIsObjValid(sceneId, targetId) ~= 1 or LuaFnIsCanDoScriptLogic(sceneId,targetId) ~= 1 then
		return 2
	end
	local objType = GetCharacterType( sceneId, targetId )
	if objType == 1 then
		if GetMissionData(sceneId,selfId,WUYI_SKILL_ITEM) > LuaFnGetCurrentTime() then
			return
		end
		local nSelfScore = GetMissionData(sceneId,selfId,XYJ_EQUIP_GRADE_HISTORY)
		local nTarScore = GetMissionData(sceneId,targetId,XYJ_EQUIP_GRADE_HISTORY)
		if floor(nTarScore * 0.8) < nSelfScore then
			x808245_NotifyTip( sceneId, selfId, "对方历史评分过高，无效技能" )
			return
		end
		--BUFF赋予
		local nWuYiLevel = floor(mod(GetMissionData(sceneId,selfId,WUYI_SKILL_DE),10^6)/10^4)
		if nWuYiLevel == 0 then
			nWuYiLevel = 1;
		end
		local nImpact = 25483 + nWuYiLevel
		--命中记录
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId,nImpact,0)
		LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, targetId,nImpact, 0 )
		--时间记录
		SetMissionData(sceneId,selfId,WUYI_SKILL_ITEM,LuaFnGetCurrentTime()+300)
	else
		x808245_NotifyTip( sceneId, selfId, "对方非人，无效技能" )
	end
end
--**********************************
--醒目提示
--**********************************
function x808245_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
