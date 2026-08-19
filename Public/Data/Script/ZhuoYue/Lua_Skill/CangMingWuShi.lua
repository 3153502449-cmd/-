--金翅翎羽
--沧溟五式
--2019-9-21 12:58:46 逍遥子
--**********************************
--技能触发
--**********************************
function x808244_OnActive( sceneId, selfId, nSkillID )
	--获取对象信息
	local targetId = LuaFnGetTargetObjID(sceneId, selfId)
    if LuaFnIsObjValid(sceneId, targetId) ~= 1 then
        return
    end
	--对象条件过滤
	if GetHp( sceneId, selfId ) == 0  or GetHp( sceneId, targetId ) == 0 or selfId == targetId or (LuaFnUnitIsFriend(sceneId, selfId, targetId) == 1 ) then
		return
	end
	--检查金翅翎羽状态
	local nDarkID = LuaFnGetItemTableIndexByIndex( sceneId, selfId, 117)
	if nDarkID ~= 10155008 then
        x808244_MsgBox( sceneId, selfId, "#{AQJJ_160127_154}" ) 
        return
    end
	--淬毒状态检查
	local nDarkItemData = GetMissionData(sceneId,selfId,EQUIP_ANQI_DATA_1)
	if mod(nDarkItemData,10) == 0 then
		x808244_MsgBox( sceneId, selfId, "你装备的金翅翎羽尚未淬毒，不能使用暗器连击" ) 
		return
	end
	--启动技能
	if nSkillID == 120 then
		--清空连击五式的冷却时间
		for i = 204,208 do
			LuaFnSetSkillCoolDownByCoolDwonId(sceneId,selfId,i,0)
		end
		BeginUICommand(sceneId)
			UICommand_AddInt(sceneId,756)
		EndUICommand(sceneId)
	    DispatchUICommand(sceneId,selfId,1000000117)
		return
	end
	--连击招式数据获取
	local nDarkData = GetMissionData(sceneId,selfId,EQUIP_ANQI_DATA_2);
	local nAttrType = {}
	for i = 1,5 do
		nAttrType[i] = mod(floor(nDarkData/(10 ^ (i - 1))),10)
	end
	local _,cuiduPersent = Lua_GetLYDarkStarAddDataInBag(Lua_GetLYDarkQual(sceneId,selfId))
	--沧溟五式
	local nSkillIndex = {757,758,759,760}
	local nBasePersent = {10,12,15,20,30}
	if nSkillID >= 756 and nSkillID <= 760 then
		local nImpactIndex = nSkillID - 755
		--攻击释放
		local nPersent = nBasePersent[nImpactIndex] + cuiduPersent
		nPersent = nPersent * 20
		local nType = nAttrType[nImpactIndex]
		LuaFnSetCangMinWuShiDamage(sceneId,selfId,targetId,nType,nPersent);
		--释放技能
		if nSkillID ~= 760 then
			BeginUICommand(sceneId)
				UICommand_AddInt(sceneId,nSkillIndex[nImpactIndex])
			EndUICommand(sceneId)
			DispatchUICommand(sceneId,selfId,1000000117)
		end
		return
	end
end
--**********************************
--获取暗器星级
--**********************************
function Lua_GetLYDarkQual(sceneId,selfId)
	return floor(GetMissionData(sceneId,selfId,336)/10000000);
end
--**********************************
--金翅翎羽星级影响
--**********************************
function Lua_GetLYDarkStarAddDataInBag(nStarNum)
	local skillPersent,cuiduPersent = 0,0
	if nStarNum ~= nil and nStarNum >= 1 and nStarNum <= 9 then
		local nDarkStarAdd = {0,0,0,0,10,20,30,50,50};
		skillPersent = nDarkStarAdd[nStarNum]
		cuiduPersent = nDarkStarAdd[nStarNum]
	end
	return skillPersent,cuiduPersent
end
--**********************************
--屏幕中间提示
--**********************************
function x808244_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

