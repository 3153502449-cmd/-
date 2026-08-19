--中冲剑
--2019-10-1 20:25:56 逍遥子
x808240_g_scriptId = 808240;
x808240_ImpactList = {
{672,673,674,675},
{1102,1103,1104,1105},
{1106,1107,1108,1109},
{1110,1111,1112,1113}
};
--增抗
x808240_ImpactListAdd = {1664,1665,1666,1667};
x808240_XinFaIndex = 61;
--**********************************
--事件交互入口
--**********************************
function x808240_OnImpactFadeOut( sceneId, selfId, impactId )
	if GetHp( sceneId, selfId ) == 0 then
		return
	end
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
	if LuaFnIsObjValid(sceneId, targetId) ~= 1 then
	   return
	end
	if HaveXinFa(sceneId,selfId,x808240_XinFaIndex) < 1 or GetMenPai(sceneId,selfId) ~= MP_DALI then  --不是天龙寺
	   return
	end
    local nXinFaLevel = 1
    if impactId == 671 then
        nXinFaLevel = floor(LuaFnGetXinFaLevel(sceneId,selfId,x808240_XinFaIndex)/40) + 1;
        if nXinFaLevel < 1 or nXinFaLevel > 3 then
           nXinFaLevel = 3
        end
    elseif impactId == 32634 then
        nXinFaLevel = 4
    end
    local nRet = random(4)
    LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, targetId, x808240_ImpactList[nXinFaLevel][nRet], 100 )
	--中冲剑秘法护壁 2019-10-19 23:22:20 逍遥子
	local objType = GetCharacterType( sceneId, targetId )
	if objType == 1 then
		if HaveSkill(sceneId,targetId,888) == 1 then
			nRet = random(1,100)
			if nRet <= 20 then
				nRet = random(4)
				LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, targetId, x808240_ImpactListAdd[nRet], 0 )
			end
		end
	end
end
--**********************************
--醒目提示
--**********************************
function x808240_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end