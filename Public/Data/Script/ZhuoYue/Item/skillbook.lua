--使用配方的脚本

--脚本号
x338000_g_scriptId = 338000

x338000_g_SkillBooks = {}

-- ItemTable 号为索引

-- type: 书的类型，1 表示心法，2 表示技能
-- menpaiId: 学习的对应配方号
-- MP_SHAOLIN	= 0
-- MP_MINGJIAO	= 1
-- MP_GAIBANG	= 2
-- MP_WUDANG	= 3
-- MP_EMEI		= 4
-- MP_XINGSU	= 5
-- MP_DALI		= 6
-- MP_TIANSHAN	= 7
-- MP_XIAOYAO	= 8
-- MP_WUMENPAI	= 9
-- MP_GUSU	= 10
-- MP_TANGMEN	= 11

-- needLevel: 研读此书需要的相应人物级别， -1 表示没有要求
-- needXinfa: 研读此书需要的相应心法， -1 表示没有要求
-- needXinfaLevel: 研读此书需要相应心法的等级， -1 表示没有要求
-- specialEffectID: 特效号

-- 门派名称 #{_MENPAI" .. menpaiid .. "}
-- 物品名称 #{_ITEM" .. itemid .. "}
-- 心法名称 #{_XINFA" .. xinfaid .. "}
--{55,56,57,58,59,60,61,62,63,0,70,87,95}--各门派第7本
--**********************************************************
--下面是第七本心法35级  2019-9-23 12:32:24修正
--**********************************************************
x338000_g_SkillBooks[30308002] = { type = 1, id = 55, menpaiId = MP_SHAOLIN, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308003] = { type = 1, id = 56, menpaiId = MP_MINGJIAO, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308004] = { type = 1, id = 57, menpaiId = MP_GAIBANG, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308005] = { type = 1, id = 58, menpaiId = MP_WUDANG, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308006] = { type = 1, id = 59, menpaiId = MP_EMEI, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308007] = { type = 1, id = 60, menpaiId = MP_XINGSU, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308008] = { type = 1, id = 61, menpaiId = MP_DALI, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308009] = { type = 1, id = 62, menpaiId = MP_TIANSHAN, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308010] = { type = 1, id = 63, menpaiId = MP_XIAOYAO, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308098] = { type = 1, id = 70, menpaiId = MP_GUSU, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308274] = { type = 1, id = 87, menpaiId = MP_TANGMEN, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308281] = { type = 1, id = 95, menpaiId = MP_GUIGU, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
--2019-12-4 21:11:22 逍遥子桃花岛开放
x338000_g_SkillBooks[30308288] = { type = 1, id = 103, menpaiId = MP_TAOHUADAO, needLevel = 35, needXinfa = -1, needXinfaLevel = 1, specialEffectID = 18 }
--**********************************************************
--下面是第八本心法80级  2019-9-23 12:32:21 修正
--**********************************************************
x338000_g_SkillBooks[30308101] = { type = 1, id = 72, menpaiId = MP_SHAOLIN, needLevel = 80, needXinfa = 55, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308102] = { type = 1, id = 73, menpaiId = MP_MINGJIAO, needLevel = 80, needXinfa = 56, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308103] = { type = 1, id = 74, menpaiId = MP_GAIBANG, needLevel = 80, needXinfa = 57, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308104] = { type = 1, id = 75, menpaiId = MP_WUDANG, needLevel = 80, needXinfa = 58, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308105] = { type = 1, id = 76, menpaiId = MP_EMEI, needLevel = 80, needXinfa = 59, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308106] = { type = 1, id = 77, menpaiId = MP_XINGSU, needLevel = 80, needXinfa = 60, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308107] = { type = 1, id = 78, menpaiId = MP_DALI, needLevel = 80, needXinfa = 61, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308108] = { type = 1, id = 79, menpaiId = MP_TIANSHAN, needLevel = 80, needXinfa = 62, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308109] = { type = 1, id = 80, menpaiId = MP_XIAOYAO, needLevel = 80, needXinfa = 63, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308110] = { type = 1, id = 71, menpaiId = MP_GUSU, needLevel = 80, needXinfa = 70, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308278] = { type = 1, id = 88, menpaiId = MP_TANGMEN, needLevel = 80, needXinfa = 87, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308285] = { type = 1, id = 96, menpaiId = MP_GUIGU, needLevel = 80, needXinfa = 95, needXinfaLevel = 1, specialEffectID = 18 }
--2019-12-4 21:11:22 逍遥子桃花岛开放
x338000_g_SkillBooks[30308292] = { type = 1, id = 104, menpaiId = MP_TAOHUADAO, needLevel = 80, needXinfa = 103, needXinfaLevel = 1, specialEffectID = 18 }
--***********************************************************
--下面是45级要诀  2019-9-23 12:32:18修正
--***********************************************************
x338000_g_SkillBooks[30308045] = { type = 2, id = 182, menpaiId = MP_SHAOLIN, needLevel = 45, needXinfa = 55, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308070] = { type = 2, id = 209, menpaiId = MP_MINGJIAO, needLevel = 45, needXinfa = 56, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308060] = { type = 2, id = 234, menpaiId = MP_GAIBANG, needLevel = 45, needXinfa = 57, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308066] = { type = 2, id = 261, menpaiId = MP_WUDANG, needLevel = 45, needXinfa = 58, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308043] = { type = 2, id = 286, menpaiId = MP_EMEI, needLevel = 45, needXinfa = 59, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308067] = { type = 2, id = 313, menpaiId = MP_XINGSU, needLevel = 45, needXinfa = 60, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308068] = { type = 2, id = 339, menpaiId = MP_DALI, needLevel = 45, needXinfa = 61, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308071] = { type = 2, id = 366, menpaiId = MP_TIANSHAN, needLevel = 45, needXinfa = 62, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308069] = { type = 2, id = 392, menpaiId = MP_XIAOYAO, needLevel = 45, needXinfa = 63, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308099] = { type = 2, id = 417, menpaiId = MP_GUSU, needLevel = 45, needXinfa = 70, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308276] = { type = 2, id = 444, menpaiId = MP_TANGMEN, needLevel = 45, needXinfa = 87, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308283] = { type = 2, id = 470, menpaiId = MP_GUIGU, needLevel = 45, needXinfa = 95, needXinfaLevel = 1, specialEffectID = 18 }
--2019-12-4 21:13:01 逍遥子桃花岛开放
x338000_g_SkillBooks[30308289] = { type = 2, id = 505, menpaiId = MP_TAOHUADAO, needLevel = 45, needXinfa = 103, needXinfaLevel = 1, specialEffectID = 18 }

--***********************************************************
--下面是65级要诀  2019-9-23 12:32:13 修正
--***********************************************************
x338000_g_SkillBooks[30308011] = { type = 2, id = 184, menpaiId = MP_SHAOLIN, needLevel = 65, needXinfa = 55, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308012] = { type = 2, id = 208, menpaiId = MP_MINGJIAO, needLevel = 65, needXinfa = 56, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308013] = { type = 2, id = 236, menpaiId = MP_GAIBANG, needLevel = 65, needXinfa = 57, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308014] = { type = 2, id = 260, menpaiId = MP_WUDANG, needLevel = 65, needXinfa = 58, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308015] = { type = 2, id = 287, menpaiId = MP_EMEI, needLevel = 65, needXinfa = 59, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308016] = { type = 2, id = 312, menpaiId = MP_XINGSU, needLevel = 65, needXinfa = 60, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308017] = { type = 2, id = 338, menpaiId = MP_DALI, needLevel = 65, needXinfa = 61, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308018] = { type = 2, id = 365, menpaiId = MP_TIANSHAN, needLevel = 65, needXinfa = 62, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308019] = { type = 2, id = 391, menpaiId = MP_XIAOYAO, needLevel = 65, needXinfa = 63, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308100] = { type = 2, id = 418, menpaiId = MP_GUSU, needLevel = 65, needXinfa = 70, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308275] = { type = 2, id = 443, menpaiId = MP_TANGMEN, needLevel = 65, needXinfa = 87, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308282] = { type = 2, id = 469, menpaiId = MP_GUIGU, needLevel = 65, needXinfa = 95, needXinfaLevel = 1, specialEffectID = 18 }
--2019-12-4 21:14:17 逍遥子桃花岛开放
x338000_g_SkillBooks[30308290] = { type = 2, id = 506, menpaiId = MP_TAOHUADAO, needLevel = 65, needXinfa = 103, needXinfaLevel = 1, specialEffectID = 18 }
--***********************************************************
--下面是80级要诀  
--***********************************************************
--第七本 2019-9-23 12:35:56逍遥子
x338000_g_SkillBooks[30308075] = { type = 2, id = 183, menpaiId = MP_SHAOLIN, needLevel = 80, needXinfa = 55, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308091] = { type = 2, id = 210, menpaiId = MP_MINGJIAO, needLevel = 80, needXinfa = 56, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308089] = { type = 2, id = 235, menpaiId = MP_GAIBANG, needLevel = 80, needXinfa = 57, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308087] = { type = 2, id = 262, menpaiId = MP_WUDANG, needLevel = 80, needXinfa = 58, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308093] = { type = 2, id = 288, menpaiId = MP_EMEI, needLevel = 80, needXinfa = 59, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308088] = { type = 2, id = 314, menpaiId = MP_XINGSU, needLevel = 80, needXinfa = 60, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308076] = { type = 2, id = 340, menpaiId = MP_DALI, needLevel = 80, needXinfa = 61, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308092] = { type = 2, id = 367, menpaiId = MP_TIANSHAN, needLevel = 80, needXinfa = 62, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308090] = { type = 2, id = 393, menpaiId = MP_XIAOYAO, needLevel = 80, needXinfa = 63, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308154] = { type = 2, id = 419, menpaiId = MP_GUSU, needLevel = 80, needXinfa = 70, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308277] = { type = 2, id = 445, menpaiId = MP_TANGMEN, needLevel = 80, needXinfa = 87, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308284] = { type = 2, id = 471, menpaiId = MP_GUIGU, needLevel = 80, needXinfa = 95, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308291] = { type = 2, id = 507, menpaiId = MP_TAOHUADAO, needLevel = 65, needXinfa = 103, needXinfaLevel = 1, specialEffectID = 18 }

--第八本攻击 2019-9-23 12:38:04 逍遥子
x338000_g_SkillBooks[30308111] = { type = 2, id = 185, menpaiId = MP_SHAOLIN, needLevel = 80, needXinfa = 72, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308112] = { type = 2, id = 211, menpaiId = MP_MINGJIAO, needLevel = 80, needXinfa = 73, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308113] = { type = 2, id = 237, menpaiId = MP_GAIBANG, needLevel = 80, needXinfa = 74, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308114] = { type = 2, id = 263, menpaiId = MP_WUDANG, needLevel = 80, needXinfa = 75, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308115] = { type = 2, id = 289, menpaiId = MP_EMEI, needLevel = 80, needXinfa = 76, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308116] = { type = 2, id = 315, menpaiId = MP_XINGSU, needLevel = 80, needXinfa = 77, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308117] = { type = 2, id = 341, menpaiId = MP_DALI, needLevel = 80, needXinfa = 78, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308118] = { type = 2, id = 368, menpaiId = MP_TIANSHAN, needLevel = 80, needXinfa = 79, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308119] = { type = 2, id = 394, menpaiId = MP_XIAOYAO, needLevel = 80, needXinfa = 80, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308120] = { type = 2, id = 420, menpaiId = MP_GUSU, needLevel = 80, needXinfa = 71, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308279] = { type = 2, id = 446, menpaiId = MP_TANGMEN, needLevel = 80, needXinfa = 88, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308286] = { type = 2, id = 472, menpaiId = MP_GUIGU, needLevel = 80, needXinfa = 96, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308293] = { type = 2, id = 508, menpaiId = MP_TAOHUADAO, needLevel = 80, needXinfa = 104, needXinfaLevel = 1, specialEffectID = 18 }

--第八本强控 2019-9-23 12:40:18 逍遥子
x338000_g_SkillBooks[30308121] = { type = 2, id = 186, menpaiId = MP_SHAOLIN, needLevel = 80, needXinfa = 72, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308122] = { type = 2, id = 212, menpaiId = MP_MINGJIAO, needLevel = 80, needXinfa = 73, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308123] = { type = 2, id = 238, menpaiId = MP_GAIBANG, needLevel = 80, needXinfa = 74, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308124] = { type = 2, id = 264, menpaiId = MP_WUDANG, needLevel = 80, needXinfa = 75, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308125] = { type = 2, id = 290, menpaiId = MP_EMEI, needLevel = 80, needXinfa = 76, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308126] = { type = 2, id = 316, menpaiId = MP_XINGSU, needLevel = 80, needXinfa = 77, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308127] = { type = 2, id = 342, menpaiId = MP_DALI, needLevel = 80, needXinfa = 78, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308128] = { type = 2, id = 369, menpaiId = MP_TIANSHAN, needLevel = 80, needXinfa = 79, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308129] = { type = 2, id = 395, menpaiId = MP_XIAOYAO, needLevel = 80, needXinfa = 80, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308130] = { type = 2, id = 421, menpaiId = MP_GUSU, needLevel = 80, needXinfa = 71, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308280] = { type = 2, id = 447, menpaiId = MP_TANGMEN, needLevel = 80, needXinfa = 88, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308287] = { type = 2, id = 473, menpaiId = MP_GUIGU, needLevel = 80, needXinfa = 96, needXinfaLevel = 1, specialEffectID = 18 }
x338000_g_SkillBooks[30308294] = { type = 2, id = 509, menpaiId = MP_TAOHUADAO, needLevel = 80, needXinfa = 104, needXinfaLevel = 1, specialEffectID = 18 }
--落马箭
x338000_g_SkillBooks[30308055] = { type = 2, id = 37, menpaiId = -1, needLevel = 40, needXinfa = -1, needXinfaLevel = -1, specialEffectID = 18 }

x338000_g_TypeNames = {}
x338000_g_TypeNames[1] = "秘籍"
x338000_g_TypeNames[2] = "要诀"
x338000_g_TypeNames[3] = "进阶技能"

x338000_MenPaiName = {}
x338000_MenPaiName[10] = "慕容"
x338000_MenPaiName[11] = "唐门"
x338000_MenPaiName[12] = "鬼谷"
x338000_MenPaiName[13] = "桃花岛"
--**********************************
-- 
--**********************************

--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x338000_IsSkillLikeScript( sceneId, selfId )
	return 1
end

--**********************************
-- 返回1：已经取消对应效果，不再执行后续操作；返回0：没有检测到相关效果，继续执行。
--**********************************
function x338000_CancelImpacts( sceneId, selfId )
	return 0
end

--**********************************
-- 条件检测入口：返回1：条件检测通过，可以继续执行；返回0：条件检测失败，中断后续执行。
--**********************************
function x338000_OnConditionCheck( sceneId, selfId )
	-- 校验使用的物品
	if LuaFnVerifyUsedItem( sceneId, selfId ) ~= 1 then
		return 0
	end

	-- 找到相应条目
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId )
	local skillBook = x338000_g_SkillBooks[itemTblIndex]
	if not skillBook then
		return 0
	end

	-- 如果门派不相同
	local menpai = GetMenPai( sceneId, selfId )
	if -1~=skillBook.menpaiId then
		if menpai ~= skillBook.menpaiId then
			if skillBook.menpaiId < 9 then
				x338000_NotifyFailTips( sceneId, selfId, "你不是#{_MENPAI" .. skillBook.menpaiId .. "}弟子，不能学习该" .. x338000_g_TypeNames[skillBook.type] .. "。" )
			else
				x338000_NotifyFailTips( sceneId, selfId, "你不是"..x338000_MenPaiName[skillBook.menpaiId].."弟子，不能学习该" .. x338000_g_TypeNames[skillBook.type] .. "。" )
			end
			return 0
		end
	end

	if GetLevel( sceneId, selfId ) < skillBook.needLevel then
		x338000_NotifyFailTips( sceneId, selfId, "你还不能学习该" .. x338000_g_TypeNames[skillBook.type] .. "。" )
		return 0
	end

	if skillBook.needXinfa ~= -1 then
		local xinfaLevel = HaveXinFa( sceneId, selfId, skillBook.needXinfa )
		if xinfaLevel < 1 then
			x338000_NotifyFailTips( sceneId, selfId, "需要先学习心法：#{_XINFA" .. skillBook.needXinfa .. "}。" )
			return 0
		end

		if xinfaLevel < skillBook.needXinfaLevel then
			-- 需要测试这个地方，跨行而且没有分号
			x338000_NotifyFailTips( sceneId, selfId, "需要心法：#{_XINFA" .. skillBook.needXinfa .. "} ".. skillBook.needXinfaLevel .. " 级，当前 " .. xinfaLevel .. " 级。" )
			return 0
		end
	end

	if skillBook.type == 1 then					-- 心法
		if HaveXinFa( sceneId, selfId, skillBook.id ) > 0 then
			x338000_NotifyFailTips( sceneId, selfId, "你已经学会了该心法。" )
			return 0
		end
	elseif skillBook.type == 2 then				-- 要诀
		if HaveSkill( sceneId, selfId, skillBook.id ) == 1 then
			x338000_NotifyFailTips( sceneId, selfId, "你已经学会了该技能。" )
			return 0
		end
	end
    return 1
end

--**********************************
--消耗检测及处理入口，负责消耗的检测和执行：
--返回1：消耗处理通过，可以继续执行；返回0：消耗检测失败，中断后续执行。
--**********************************
function x338000_OnDeplete( sceneId, selfId )
	if LuaFnDepletingUsedItem( sceneId, selfId ) > 0 then
		return 1
	end

	return 0
end

--**********************************
--只会执行一次入口：
--聚气和瞬发技能会在消耗完成后调用这个接口（聚气结束并且各种条件都满足的时候），而引导
--技能也会在消耗完成后调用这个接口（技能的一开始，消耗成功执行之后）。
--返回1：处理成功；返回0：处理失败。
--注：这里是技能生效一次的入口
--**********************************
function x338000_OnActivateOnce( sceneId, selfId )
	-- 找到相应条目
	local itemTblIndex = LuaFnGetItemIndexOfUsedItem( sceneId, selfId )
	local skillBook = x338000_g_SkillBooks[itemTblIndex]
	if not skillBook then
		return 0
	end

	-- 学习
	if skillBook.type == 1 then					-- 心法
		if HaveXinFa( sceneId, selfId, skillBook.id ) > 0 then
			x338000_NotifyFailTips( sceneId, selfId, "你已经学会了该心法。" )
			return 0
		else
			AddXinFa( sceneId, selfId, skillBook.id )
			x338000_NotifyFailTips( sceneId, selfId, "恭喜您，成功学习心法：#{_ITEM"..itemTblIndex.."}" )
		end
	elseif skillBook.type == 2 then				-- 要诀
		if HaveSkill( sceneId, selfId, skillBook.id ) == 1 then
			x338000_NotifyFailTips( sceneId, selfId, "你已经学会了该技能。" )
			return 0
		else
			AddSkill( sceneId, selfId, skillBook.id )
			x338000_NotifyFailTips( sceneId, selfId, "恭喜您，成功学习要诀：#{_ITEM"..itemTblIndex.."}" )
		end
	end

	LuaFnSendSpecificImpactToUnit( sceneId, selfId, selfId, selfId, skillBook.specialEffectID, 0 )
	return 1
end

--**********************************
--引导心跳处理入口：
--引导技能会在每次心跳结束时调用这个接口。
--返回：1继续下次心跳；0：中断引导。
--注：这里是技能心跳时生效的入口
--**********************************
function x338000_OnActivateEachTick( sceneId, selfId )
	return 1
end

--**********************************
-- 醒目失败提示
--**********************************
function x338000_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end
