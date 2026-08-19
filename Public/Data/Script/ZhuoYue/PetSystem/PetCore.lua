--珍兽系统
--build 2019-7-26 09:03:38 逍遥子
--MD_PET_TEMP_HID = 512 --当前珍兽hid
--MD_PET_TEMP_LID = 513 --当前珍兽lid
--LuaFnSetPetData(sceneId,selfId,hid,nid,index,value)函数说明
--index 0 基础力量
--index 1 基础灵气
--index 2 基础体力
--index 3 基础定力
--index 4 基础身法
--index 5 DataID
--index 6 基础力量资质
--index 7 基础灵气资质
--index 8 基础体力资质
--index 9 基础定力资质
--index 10 基础身法资质
--index 11 根骨
--index 12 潜能点
--**********************************
x900009_g_ScriptId = 900009

--一下为珍兽附体技能属性配表
--技能ID	影响人物属性类型	考虑资质类型	技能系数	资质系数	资质影响系数	成长率影响系数
x900009_g_PetCurrentSkill = {
	[1305] = {6,6,26,2,110,290},
	[1306] = {6,6,34,2,110,290},
	[1307] = {6,6,44,2,110,290},
	[1308] = {6,6,58,2,110,290},
	[1309] = {6,6,75,2,110,290},
	[1310] = {6,6,98,2,110,290},
	[1311] = {6,6,128,2,110,290},
	[1312] = {6,6,166,2,110,290},
	[1313] = {9,6,26,2,110,290},
	[1314] = {9,6,34,2,110,290},
	[1315] = {9,6,44,2,110,290},
	[1316] = {9,6,58,2,110,290},
	[1317] = {9,6,75,2,110,290},
	[1318] = {9,6,98,2,110,290},
	[1319] = {9,6,128,2,110,290},
	[1320] = {9,6,166,2,110,290},
	[1321] = {12,6,26,2,110,290},
	[1322] = {12,6,34,2,110,290},
	[1323] = {12,6,44,2,110,290},
	[1324] = {12,6,58,2,110,290},
	[1325] = {12,6,75,2,110,290},
	[1326] = {12,6,98,2,110,290},
	[1327] = {12,6,128,2,110,290},
	[1328] = {12,6,166,2,110,290},
	[1329] = {15,6,26,2,110,290},
	[1330] = {15,6,34,2,110,290},
	[1331] = {15,6,44,2,110,290},
	[1332] = {15,6,58,2,110,290},
	[1333] = {15,6,75,2,110,290},
	[1334] = {15,6,98,2,110,290},
	[1335] = {15,6,128,2,110,290},
	[1336] = {15,6,166,2,110,290},
	[1337] = {7,1,16,2,110,290},
	[1338] = {7,1,20,2,110,290},
	[1339] = {7,1,27,2,110,290},
	[1340] = {7,1,35,2,110,290},
	[1341] = {7,1,46,2,110,290},
	[1342] = {7,1,59,2,110,290},
	[1343] = {7,1,77,2,110,290},
	[1344] = {7,1,101,2,110,290},
	[1345] = {10,1,16,2,110,290},
	[1346] = {10,1,20,2,110,290},
	[1347] = {10,1,27,2,110,290},
	[1348] = {10,1,35,2,110,290},
	[1349] = {10,1,46,2,110,290},
	[1350] = {10,1,59,2,110,290},
	[1351] = {10,1,77,2,110,290},
	[1352] = {10,1,101,2,110,290},
	[1353] = {13,1,16,2,110,290},
	[1354] = {13,1,20,2,110,290},
	[1355] = {13,1,27,2,110,290},
	[1356] = {13,1,35,2,110,290},
	[1357] = {13,1,46,2,110,290},
	[1358] = {13,1,59,2,110,290},
	[1359] = {13,1,77,2,110,290},
	[1360] = {13,1,101,2,110,290},
	[1361] = {16,1,16,2,110,290},
	[1362] = {16,1,20,2,110,290},
	[1363] = {16,1,27,2,110,290},
	[1364] = {16,1,35,2,110,290},
	[1365] = {16,1,46,2,110,290},
	[1366] = {16,1,59,2,110,290},
	[1367] = {16,1,77,2,110,290},
	[1368] = {16,1,101,2,110,290},
	[1393] = {22,3,297,2,108,288},
	[1394] = {22,3,386,2,108,288},
	[1395] = {22,3,502,2,108,288},
	[1396] = {22,3,652,2,108,288},
	[1397] = {22,3,848,2,108,288},
	[1398] = {22,3,1102,2,108,288},
	[1399] = {22,3,1433,2,108,288},
	[1400] = {22,3,1864,2,108,288},
	[1401] = {29,3,297,2,108,288},
	[1402] = {29,3,386,2,108,288},
	[1403] = {29,3,502,2,108,288},
	[1404] = {29,3,652,2,108,288},
	[1405] = {29,3,848,2,108,288},
	[1406] = {29,3,1102,2,108,288},
	[1407] = {29,3,1433,2,108,288},
	[1408] = {29,3,1864,2,108,288},
	[1369] = {0,3,899,2,180,600},
	[1370] = {0,3,1169,2,180,600},
	[1371] = {0,3,1520,2,180,600},
	[1372] = {0,3,1976,2,180,600},
	[1373] = {0,3,2569,2,180,600},
	[1374] = {0,3,3340,2,180,600},
	[1375] = {0,3,4342,2,180,600},
	[1376] = {0,3,5645,2,180,600},
	[1377] = {35,5,1295,2,26,78},
	[1378] = {35,5,1684,2,26,78},
	[1379] = {35,5,2189,2,26,78},
	[1380] = {35,5,2846,2,26,78},
	[1381] = {35,5,3700,2,26,78},
	[1382] = {35,5,4810,2,26,78},
	[1383] = {35,5,6254,2,26,78},
	[1384] = {35,5,8130,2,26,78},
	[1385] = {36,5,246,2,86,26},
	[1386] = {36,5,320,2,86,26},
	[1387] = {36,5,417,2,86,26},
	[1388] = {36,5,542,2,86,26},
	[1389] = {36,5,704,2,86,26},
	[1390] = {36,5,916,2,86,26},
	[1391] = {36,5,1191,2,86,26},
	[1392] = {36,5,1548,2,86,26},

}

--**********************************
--获取珍兽附体效果数据
--**********************************
function x900009_GetCurrentEffectData(sceneId,selfId)
	local nAttrTable = {
		[0] = 0,  --血上限
		[6] = 0, --冰攻击
		[7] = 0, --冰抗
		[9] = 0, --火攻击
		[10] = 0, --火抗
		[12] = 0, --玄攻击
		[13] = 0, --玄抗
		[15] = 0, --毒攻击
		[16] = 0, --毒抗
		[22] = 0, --外功防御
		[29] = 0, --内功防御
		[35] = 0, --命中
		[36] = 0, --闪避
	}
	local nAttrTable_JueXing = {
		[0] = 0,  --血上限
		[6] = 0, --冰攻击
		[7] = 0, --冰抗
		[9] = 0, --火攻击
		[10] = 0, --火抗
		[12] = 0, --玄攻击
		[13] = 0, --玄抗
		[15] = 0, --毒攻击
		[16] = 0, --毒抗
		[22] = 0, --外功防御
		[29] = 0, --内功防御
		[35] = 0, --命中
		[36] = 0, --闪避
	}
	--人物属性处理
	--技能ID	{影响人物属性类型	考虑资质类型	技能系数	资质系数	资质影响系数	成长率影响系数}
	--x900009_g_PetCurrentSkill
	local HetiPet = GetMissionData(sceneId, selfId, PET_HETI)
	if HetiPet == 0 then
		return nAttrTable[0],nAttrTable[6],nAttrTable[7],nAttrTable[9],nAttrTable[10],nAttrTable[12],nAttrTable[13],nAttrTable[15],nAttrTable[16],nAttrTable[22],nAttrTable[29],nAttrTable[35],nAttrTable[36]
	end
	local petGUID_H, petGUID_L = 0,0
	local nPetNum = LuaFnGetPetCount( sceneId, selfId )
	local nPetIndex = -1
	for i = 0,nPetNum -1 do
		petGUID_H, petGUID_L = LuaFnGetPetGUID(sceneId,selfId,i)
		if HetiPet == petGUID_L then
			nPetIndex = i
			break;
		end
	end
	if nPetIndex == -1 then
		return nAttrTable[0],nAttrTable[6],nAttrTable[7],nAttrTable[9],nAttrTable[10],nAttrTable[12],nAttrTable[13],nAttrTable[15],nAttrTable[16],nAttrTable[22],nAttrTable[29],nAttrTable[35],nAttrTable[36]
	end
	for i = 1,12 do
		local nSkillID = LuaFnGetPet_Skill(sceneId,selfId,nPetIndex,i)
		if x900009_g_PetCurrentSkill[nSkillID] ~= nil then
			local nFinalAdd = 0
			local nOriginalEffect = x900009_g_PetCurrentSkill[nSkillID][3]
			local nPerceptionType = x900009_g_PetCurrentSkill[nSkillID][2]
			--珍兽等级
			local nLevel = LuaFnGetPet_Level(sceneId,selfId,nPetIndex)
			--珍兽成长率 "普通","优秀","杰出","卓越","完美"
			local t_growLevel = LuaFnGetPetGrowRateByGUID(sceneId, selfId, petGUID_H, petGUID_L);
			if t_growLevel < 1 then
				t_growLevel = 1
			end
			--资质属性取得
			local nPerceptionPer = 0
			if nPerceptionType == 1 then
				local nStrPer = LuaFnGetPet_StrPerception(sceneId,selfId,nPetIndex);
				nPerceptionPer = nStrPer
			elseif nPerceptionType == 3 then
				local nConPer = LuaFnGetPet_ConPerception(sceneId,selfId,nPetIndex);
				nPerceptionPer = nConPer
			elseif nPerceptionType == 5 then
				local nDexPer = LuaFnGetPet_DexPerception(sceneId,selfId,nPetIndex);
				nPerceptionPer = nDexPer
			elseif nPerceptionType == 6 then
				local nStrPer = LuaFnGetPet_StrPerception(sceneId,selfId,nPetIndex);
				local nSprPer = LuaFnGetPet_SprPerception(sceneId,selfId,nPetIndex);
				nPerceptionPer = max(nStrPer,nSprPer)
			end
			--最后计算
			local nGrowAdd = x900009_g_PetCurrentSkill[nSkillID][6] --成长率系数
			local nPerceptionAdd = x900009_g_PetCurrentSkill[nSkillID][5] --成长率系数
			nFinalAdd = nOriginalEffect + ((nGrowAdd * (t_growLevel - 1))/10) + (((nPerceptionPer/1000) * nPerceptionAdd)/10)
			nFinalAdd = floor(nFinalAdd)
			nAttrTable[x900009_g_PetCurrentSkill[nSkillID][1]] = nAttrTable[x900009_g_PetCurrentSkill[nSkillID][1]] + nFinalAdd
		end
	end
	--通知客户端BUFF显示
	--这里临时通知引擎不支持了。

	if nAttrTable[0] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_11,nAttrTable[0])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_11,0)
	end
	if nAttrTable[6] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_1,nAttrTable[6])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_1,0)
	end
	if nAttrTable[7] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_5,nAttrTable[7])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_5,0)
	end
	if nAttrTable[9] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_2,nAttrTable[9])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_2,0)
	end
	if nAttrTable[10] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_6,nAttrTable[10])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_6,0)
	end
	if nAttrTable[12] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_3,nAttrTable[12])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_3,0)
	end
	if nAttrTable[13] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_7,nAttrTable[13])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_7,0)
	end
	if nAttrTable[15] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_4,nAttrTable[15])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_4,0)
	end
	if nAttrTable[16] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_8,nAttrTable[16])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_8,0)
	end
	if nAttrTable[22] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_14,nAttrTable[22])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_14,0)
	end
	if nAttrTable[29] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_15,nAttrTable[29])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_15,0)
	end
	if nAttrTable[35] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_12,nAttrTable[35])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_12,0)
	end
	if nAttrTable[36] > 0 then
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_13,nAttrTable[36])
	else
		SetMissionData(sceneId,selfId,MD_CURRENT_BUFF_13,0)
	end
	DispatchUICommand(sceneId,selfId,20180123)
	return nAttrTable[0],nAttrTable[6],nAttrTable[7],nAttrTable[9],nAttrTable[10],nAttrTable[12],nAttrTable[13],nAttrTable[15],nAttrTable[16],nAttrTable[22],nAttrTable[29],nAttrTable[35],nAttrTable[36]
	--
end

--**********************************
--检查是否为附体状态
--**********************************
function x900009_IsInPossession(sceneId,selfId)
	--1 为附体
	local HetiPet = GetMissionData(sceneId, selfId, PET_HETI)
	if HetiPet ~= 0 then
		return 1
	end
	return 0
end
function x900009_IsInPossessionEx(sceneId,selfId,hid,nid)
	--1 为附体
	local HetiPet = GetMissionData(sceneId, selfId, PET_HETI)
	if HetiPet == nid then
		return 1
	end
	return 0
end
--**********************************
--刷新数据回执
--**********************************
function x900009_PET_REFRESH(sceneId,selfId)
	DispatchUICommand(sceneId,selfId,201810283)
end

--**********************************
--技能触发
--**********************************
function x900009_OnImpactFadeOut( sceneId, selfId, ImpactId )
    if GetLevel(sceneId, selfId) < 45 then
        x900009_NotifyTip(sceneId, selfId, "#{FTWX_110511_13}")
        return
    end
    if ImpactId == 199 then
		--检查是不是在附体中
		if x900009_IsInPossession(sceneId,selfId) == 1 then
			x900009_PetCurrent(sceneId,selfId,3,0)
			return
		end
		local IDTemp = GetMissionData(sceneId,selfId,MD_PET_CURRENT_TEMP_GUID);
        if IDTemp ~= nil and IDTemp > 0 then
			x900009_PetCurrent(sceneId,selfId,1,IDTemp)
        else
			x900009_NotifyTip(sceneId, selfId, "#{ZSHT_BC_1008_02}")
        end
    else
       x900009_NotifyTip(sceneId, selfId, "#{ZSHT_BC_1008_02}")
    end
	x900009_NotifyTip(sceneId, selfId, "#{ZSHT_BC_1008_02}")
end

--**********************************
--珍兽附体·引导
--**********************************
function x900009_PetCurrent(sceneId,selfId,Index,PetGUID)
	if GetLevel(sceneId, selfId) < 45 then
		x900009_NotifyTip( sceneId, selfId, "#{FTWX_110511_13}" )
		return
	end
	local petGUID_H, petGUID_L = 0,0
	local nPetNum = LuaFnGetPetCount( sceneId, selfId )
	local nPetIndex = -1
	for i = 0,nPetNum -1 do
		petGUID_H, petGUID_L = LuaFnGetPetGUID(sceneId,selfId,i)
		if PetGUID == petGUID_L then
			nPetIndex = i
			break;
		end
	end
	--MD_PET_CURRENT_GUID 上次附体的珍兽ID
	local HetiPet = GetMissionData(sceneId, selfId, PET_HETI)
	if Index == 0 then
		--正在附体
		if HetiPet ~= 0 and PetGUID == HetiPet then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_06}" )
			return
		end
		--检查出战
		local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, selfId)
		if PetGUID == pgL then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_100809_02}" )
			return
		end
		--检查寿命
		local nPetLife = LuaFnGetPetLife(sceneId,selfId,petGUID_H, petGUID_L)
		if nPetLife == 0 then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_100809_05}" )
			return
		end
		--提醒延寿
		if nPetLife < 1000 then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_100809_03}" )
		end
		SetMissionData(sceneId,selfId,MD_PET_CURRENT_TEMP_GUID,PetGUID);
		--技能探测
		if HaveSkill(sceneId,selfId,147) < 0 then
			AddSkill(sceneId,selfId,147);
		end
		--LuaFnHumanUseSkill(sceneId,selfId,147,-1,-1,-1,-1)
	BeginUICommand(sceneId)
		UICommand_AddInt(sceneId,147)
		UICommand_AddString(sceneId,"ski13")
		EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId,2014092002)
	end
	if Index == 1 then --附体成功
--		x900009_NotifyTip( sceneId, selfId, "PetGUID "..PetGUID )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 198, 0);
        SetMissionData(sceneId, selfId,PET_HETI,PetGUID )
		SetMissionData(sceneId,selfId,MD_PET_CURRENT_GUID,PetGUID); --上次的ID存储
        x900009_NotifyTip( sceneId, selfId, "#{ZSHT_100809_04} ")
		x900009_GetCurrentEffectData(sceneId,selfId)
        SetMissionData(sceneId,selfId,MD_PET_CURRENT_TEMP_GUID,0);
        DispatchUICommand( sceneId, selfId, 201810282 )--刷新珍兽界面
		--显示附体 2019-9-29 15:53:21 逍遥子
		CallScriptFunction(889383,"CallUpPoss",sceneId,selfId,0)
		-- LuaFnRefreshHumanObject(sceneId,selfId,selfId)
	end
	if Index == 2 then --分离操作
	    local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, selfId)
		if PetGUID == pgL then
			x900009_NotifyTip( sceneId, selfId, "安全系统检测到您的数据异常，请重新登录！" )
			x900009_NotifyTip( sceneId, selfId, "如果登陆后问题仍无法解决，请联系《极致天龙》运营团队！" )
			return
		end
		if HetiPet == nil or HetiPet == 0 then
	        x900009_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_15}" )
			return
		end
		if HetiPet ~= PetGUID then
			x900009_NotifyTip( sceneId, selfId, "该珍兽并未附体" )
			return
	    end
		LuaFnCancelSpecificImpact(sceneId,selfId,198)
		SetMissionData(sceneId, selfId, PET_HETI, 0 )
		x900009_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_03}" )
        DispatchUICommand( sceneId, selfId, 201810282 )--刷新珍兽界面
		--关闭附体 2019-9-29 15:53:21 逍遥子
		CallScriptFunction(889383,"CallUpPoss",sceneId,selfId,1)
		-- LuaFnRefreshHumanObject(sceneId,selfId,selfId)
	end
	--技能分离操作
	if Index == 3 then
		if HetiPet == nil or HetiPet == 0 then
	        x900009_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_15}" )
			return
		end
		LuaFnCancelSpecificImpact(sceneId,selfId,198)
		SetMissionData(sceneId, selfId, PET_HETI, 0 )
		x900009_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_03}" )
        DispatchUICommand( sceneId, selfId, 201810282 )--刷新珍兽界面
		--关闭附体 2019-9-29 15:53:21 逍遥子
		CallScriptFunction(889383,"CallUpPoss",sceneId,selfId,1)
		-- LuaFnRefreshHumanObject(sceneId,selfId,selfId)
	end
	--技能附体操作 2019-9-22 13:22:15 逍遥子
	if Index == 4 then
		local nLastCurrGUID = GetMissionData(sceneId,selfId,MD_PET_CURRENT_GUID);
		if nLastCurrGUID == nil or nLastCurrGUID == 0 then
	        x900009_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_12}" )
			return
		end
		--遍历检查珍兽是否存在
		local petGUID_H, petGUID_L = 0,0
		local nPetNum = LuaFnGetPetCount( sceneId, selfId )
		local nPetIndex = -1
		for i = 0,nPetNum -1 do
			petGUID_H, petGUID_L = LuaFnGetPetGUID(sceneId,selfId,i)
			if nLastCurrGUID == petGUID_L then
				nPetIndex = i
				break;
			end
		end
		if nPetIndex == -1 then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_12}" )
			return
		end
		--正在附体
		if x900009_IsInPossession(sceneId,selfId) == 1 then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_BC_1008_06}" )
			return
		end
		--检查出战
		local pgH , pgL = LuaFnGetCurrentPetGUID(sceneId, selfId)
		if nLastCurrGUID == pgL then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_100809_02}" )
			return
		end
		--检查寿命
		local nPetLife = LuaFnGetPetLife(sceneId,selfId,petGUID_H, petGUID_L)
		if nPetLife == 0 then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_100809_05}" )
			return
		end
		--提醒延寿
		if nPetLife < 1000 then
			x900009_NotifyTip( sceneId, selfId, "#{ZSHT_100809_03}" )
		end
	end
end

function x900009_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end