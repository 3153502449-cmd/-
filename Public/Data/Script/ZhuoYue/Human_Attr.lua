--Q546528533 新属性结算部分
--脚本号
x888903_g_ScriptId = 888903

x888903_GetBase = {
	[0] = {{2539,761,761},{1269,380,380},{3809,825,825},{1904,571,571},{1500,650,650},{500,200,200}},
	[1] = {{3174,825,825},{1904,444,444},{2539,571,571},{1269,444,444},{1500,750,750},{1000,300,300}},
	[2] = {{2539,761,761},{1269,380,380},{3174,761,761},{1904,507,507},{2500,800,800},{1000,400,400}},
	[3] = {{1269,444,444},{3174,888,888},{1269,444,444},{2539,761,761},{1500,700,700},{500,250,250}},
	[4] = {{1269,380,380},{2539,761,761},{1269,507,507},{2539,825,825},{1500,750,750},{500,200,200}},
	[5] = {{1269,444,444},{3174,761,761},{1269,444,444},{3174,888,888},{1000,600,600},{500,300,300}},
	[6] = {{1904,634,634},{1904,634,634},{1904,634,634},{1904,634,634},{2500,900,900},{1000,300,300}},
	[7] = {{2539,888,888},{1904,761,761},{1904,698,698},{1904,444,444},{2500,800,800},{1000,344,300}},
	[8] = {{1904,444,444},{3174,761,761},{1904,507,507},{3174,825,825},{2500,750,750},{1000,300,300}},
	[9] = {{1269,444,444},{3174,888,888},{1269,698,698},{2539,507,507},{1500,750,750},{1000,400,350}},
	[10] = {{1269,444,444},{3174,888,888},{1269,698,698},{2539,507,507},{1500,750,750},{1000,400,350}},
	[11] = {{1269,444,444},{3174,825,825},{1269,444,444},{2539,888,888},{1500,850,850},{1000,334,300}},
	[12] = {{1269,444,444},{3174,825,825},{1269,444,444},{2539,890,890},{1500,780,780},{1000,350,350}},
	[13] = {{3174,825,825},{1904,444,444},{2539,571,571},{1269,444,444},{1500,750,750},{1000,300,300}},
	}

--**********************************
-- --对话窗口信息提示
--**********************************
function x888903_NotifyFailBox( sceneId, selfId,  msg )
	BeginEvent(sceneId)
	AddText(sceneId,msg)
	EndEvent(sceneId)
	DispatchMissionTips(sceneId,selfId)
end

function x888903_HumanSetAttr(sceneId,selfId)
	local nLevel = GetLevel(sceneId,selfId)
	local XIUlian={0,0,0,0,0,0,0,0,0,0,0}
	if nLevel>=70 then
	--for i=1,11 do
	--	XIUlian[i]=ceil(x888903_GetXiuLianAttr(sceneId,selfId,i))
	--end
	XIUlian[1] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,1) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,1))--力量
	XIUlian[2] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,2) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,2))--灵气
	XIUlian[3] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,3) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,3))--体力
	XIUlian[4] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,4) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,4))--定力
	XIUlian[5] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,5) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,5))--身法
	
	XIUlian[6] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,6) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,6))--外功攻击
	XIUlian[7] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,7) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,7))--内功攻击
	XIUlian[8] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,8) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,8))--外功防御
	XIUlian[9] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,9) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,9))--内功防御
	XIUlian[10] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,10) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,10))--命中
	XIUlian[11] = ceil(x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,11) * x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,11))--闪避
	
	end
    local MAX_HP,MAX_MP,LILIANG,LINGQI,TILI,DINGLI,SHENFA,WG ,WF,NG,NF, MISS,HIT,HUIXINGONG,HUIXINFANG,ICE_ATTR,FIRE_ATTR,LIGHT_ATTR,POSION_ATTR,ICE_DEC,FIRE_DEC,LIGHT_DEC,POSION_DEC,ICE_SUB_DEC,FIRE_SUB_DEC,LIGHT_SUB_DEC,POSION_SUB_DEC,ICE_SUB_LIMIT,FIRE_SUB_LIMIT,LIGHT_SUB_LIMIT,POSION_SUB_LIMIT,BASE_MOVESPEED_ADD,SUB_SG,SUB_FY,SUB_WK,SUB_SM,SUB_MB,SUB_FX,SUB_HS= 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	---武魂属性部分
	local kfsnStr,kfsnSpr,kfsnCon,kfsnInt,kfsnDex,kfsnIceAttr,kfsnFireAttr,kfsnLightAttr,kfsnPosionAttr,kfsnIceDec,kfsnFireDec,kfsnLightDec,kfsnPosionDec,kfsnIceSubDec,kfsnFireSubDec,kfsnLightSubDec,kfsnPosionSubDec,kfsnIceSubDecL,kfsnFireSubDecL,kfsnLightSubDecL,kfsnPosionSubDecL = 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	if nLevel >= 65 then
	   --x888903_WuHunXiaXian(sceneId,selfId)
	   kfsnStr,kfsnSpr,kfsnCon,kfsnInt,kfsnDex,kfsnIceAttr,kfsnFireAttr,kfsnLightAttr,kfsnPosionAttr,kfsnIceDec,kfsnFireDec,kfsnLightDec,kfsnPosionDec,kfsnIceSubDec,kfsnFireSubDec,kfsnLightSubDec,kfsnPosionSubDec,kfsnIceSubDecL,kfsnFireSubDecL,kfsnLightSubDecL,kfsnPosionSubDecL = CallScriptFunction( 900004, "ComputeKfs",sceneId, selfId )
	end
	local FTnAttrTable = {0,0,0,0,0,0,0,0,0,0,0,0,0}
	if nLevel >= 45 then
	   FTnAttrTable[1],FTnAttrTable[2],FTnAttrTable[3],FTnAttrTable[4],FTnAttrTable[5],FTnAttrTable[6],FTnAttrTable[7],FTnAttrTable[8],FTnAttrTable[9],FTnAttrTable[10],FTnAttrTable[11],FTnAttrTable[12],FTnAttrTable[13] = CallScriptFunction( 900009, "GetCurrentEffectData",sceneId, selfId )
	end
	local DW_Data = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}
	if nLevel >= 30 then
		--此处J后缀为减抗，D为抗性
	    DW_Data[1],DW_Data[2],DW_Data[3],DW_Data[4],DW_Data[5],DW_Data[6],DW_Data[7],DW_Data[8],DW_Data[9],DW_Data[10],DW_Data[11],DW_Data[12],DW_Data[13],DW_Data[14],DW_Data[15],DW_Data[16],DW_Data[17],DW_Data[18],DW_Data[19],DW_Data[20],DW_Data[21],DW_Data[22] = CallScriptFunction(900014, "GetDWAttrData", sceneId, selfId)
	end
	local TitleAttr = {}
	TitleAttr[1],TitleAttr[2],TitleAttr[3],TitleAttr[4],TitleAttr[5],TitleAttr[6],TitleAttr[7],TitleAttr[8],TitleAttr[9],TitleAttr[10],TitleAttr[11],TitleAttr[12],TitleAttr[13],TitleAttr[14],TitleAttr[15] = CallScriptFunction(892002, "GetTitleAttr", sceneId, selfId)
	local DressGetAttr = {}
	DressGetAttr[1],DressGetAttr[2],DressGetAttr[3],DressGetAttr[4],DressGetAttr[5],DressGetAttr[6],DressGetAttr[7],DressGetAttr[8],DressGetAttr[9],DressGetAttr[10],DressGetAttr[11],DressGetAttr[12],DressGetAttr[13],DressGetAttr[14],DressGetAttr[15] = x888903_GetDressAttr(sceneId,selfId)
	LuaFnXinFaGrade(sceneId,selfId) --心法评分
	LuaFnRefreshXiuLianScore(sceneId,selfId) -- 修炼评分

    ---VIP会员加成
    local vipxss,vipsh,viplev = x888903_GetVIPLevAttr(sceneId,selfId)
	local xHP = GetHp(sceneId,selfId)
	MAX_HP = MAX_HP + FTnAttrTable[1] + TitleAttr[1] + DressGetAttr[1] 
	if vipxss ~= 0 then
		--LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,4750+viplev,0)
		LuaFnCancelSpecificImpact(sceneId,selfId,4750+viplev)
	end
	if vipsh ~= 0 then
	    --LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,4700+viplev,0)
		LuaFnCancelSpecificImpact(sceneId,selfId,4700+viplev)
	end
	
	---所有属性计算部分
	MAX_MP = MAX_MP
	WG = WG+FTnAttrTable[11] + TitleAttr[10] + DressGetAttr[6] + XIUlian[6]
	WF = WF+FTnAttrTable[10] + TitleAttr[11] + DressGetAttr[7] + XIUlian[8]
	NG = NG + TitleAttr[12] + DressGetAttr[8] + XIUlian[7]
	NF = NF + TitleAttr[13] + DressGetAttr[9] + XIUlian[9]
	MISS = MISS+FTnAttrTable[13] + XIUlian[11]
	HIT = HIT+FTnAttrTable[12] + XIUlian[10]

	HUIXINGONG = HUIXINGONG
	HUIXINFANG = HUIXINFANG
    LILIANG = LILIANG + kfsnStr + DW_Data[1] + TitleAttr[14] + DressGetAttr[10] + DressGetAttr[15] + XIUlian[1]
	LINGQI  = LINGQI  + kfsnSpr + DW_Data[2] + TitleAttr[14] + DressGetAttr[11] + DressGetAttr[15] + XIUlian[2]
	TILI    = TILI    + kfsnCon + DW_Data[4] + TitleAttr[14] + DressGetAttr[12] + DressGetAttr[15] + XIUlian[3]
	DINGLI  = DINGLI  + kfsnInt + DW_Data[5] + TitleAttr[14] + DressGetAttr[13] + DressGetAttr[15] + XIUlian[4]
	SHENFA  = SHENFA  + kfsnDex + DW_Data[3] + TitleAttr[14] + DressGetAttr[14] + DressGetAttr[15] + XIUlian[5]
	
	---属性攻击
	ICE_ATTR = ICE_ATTR + kfsnIceAttr+FTnAttrTable[2] + DW_Data[6] + TitleAttr[2] + DressGetAttr[2] 
	FIRE_ATTR = FIRE_ATTR + kfsnFireAttr+FTnAttrTable[4] + DW_Data[7] + TitleAttr[4] + DressGetAttr[3] 
	LIGHT_ATTR = LIGHT_ATTR + kfsnLightAttr+FTnAttrTable[6] + DW_Data[8] + TitleAttr[6] + DressGetAttr[4] 
	POSION_ATTR = POSION_ATTR + kfsnPosionAttr+FTnAttrTable[8] + DW_Data[9] + TitleAttr[8] + DressGetAttr[5] 
	
	--属性抗性
	ICE_DEC = ICE_DEC + kfsnIceDec+FTnAttrTable[3] + DW_Data[14] + TitleAttr[3]
	FIRE_DEC = FIRE_DEC + kfsnFireDec+FTnAttrTable[5] + DW_Data[15] + TitleAttr[5]
	LIGHT_DEC = LIGHT_DEC + kfsnLightDec+FTnAttrTable[7] + DW_Data[16] + TitleAttr[7]
	POSION_DEC = POSION_DEC + kfsnPosionDec+FTnAttrTable[9] + DW_Data[17] + TitleAttr[9]
	
	--减抗
	ICE_SUB_DEC = ICE_SUB_DEC + kfsnIceSubDec + DW_Data[10] 
	FIRE_SUB_DEC = FIRE_SUB_DEC + kfsnFireSubDec + DW_Data[11] 
	LIGHT_SUB_DEC = LIGHT_SUB_DEC + kfsnLightSubDec + DW_Data[12] 
	POSION_SUB_DEC = POSION_SUB_DEC + kfsnPosionSubDec + DW_Data[13] 
	
	--减抗下限
	ICE_SUB_LIMIT = ICE_SUB_LIMIT + kfsnIceSubDecL
	FIRE_SUB_LIMIT = FIRE_SUB_LIMIT + kfsnFireSubDecL
	LIGHT_SUB_LIMIT = LIGHT_SUB_LIMIT + kfsnLightSubDecL
	POSION_SUB_LIMIT = POSION_SUB_LIMIT + kfsnPosionSubDecL
	
    ---所有属性写入部分
	SetMissionData(sceneId,selfId,SYS_MAX_HP,MAX_HP)
	SetMissionData(sceneId,selfId,SYS_MAX_MP,MAX_MP)
	SetMissionData(sceneId,selfId,SYS_LILIANG,LILIANG)
	SetMissionData(sceneId,selfId,SYS_LINGQI,LINGQI)
	SetMissionData(sceneId,selfId,SYS_TILI,TILI)
	SetMissionData(sceneId,selfId,SYS_DINGLI,DINGLI)
	SetMissionData(sceneId,selfId,SYS_SHENFA,SHENFA)
	SetMissionData(sceneId,selfId,SYS_WG,WG)
	SetMissionData(sceneId,selfId,SYS_WF,WF)
	SetMissionData(sceneId,selfId,SYS_NG,NG)
	SetMissionData(sceneId,selfId,SYS_NF,NF)
	SetMissionData(sceneId,selfId,SYS_MISS,MISS)
	SetMissionData(sceneId,selfId,SYS_HIT,HIT)
	SetMissionData(sceneId,selfId,SYS_HUIXINGONG,HUIXINGONG)
	SetMissionData(sceneId,selfId,SYS_HUIXINFANG,HUIXINFANG)
	SetMissionData(sceneId,selfId,SYS_ICE_ATTR,ICE_ATTR)
	-- AddGlobalCountNews( sceneId,ICE_ATTR);
	SetMissionData(sceneId,selfId,SYS_FIRE_ATTR,FIRE_ATTR)
	SetMissionData(sceneId,selfId,SYS_LIGHT_ATTR,LIGHT_ATTR)
	SetMissionData(sceneId,selfId,SYS_POSION_ATTR,POSION_ATTR)
	SetMissionData(sceneId,selfId,SYS_ICE_DEC,ICE_DEC)
	SetMissionData(sceneId,selfId,SYS_FIRE_DEC,FIRE_DEC)
	SetMissionData(sceneId,selfId,SYS_LIGHT_DEC,LIGHT_DEC)
	SetMissionData(sceneId,selfId,SYS_POSION_DEC,POSION_DEC)
	SetMissionData(sceneId,selfId,SYS_ICE_SUB_DEC,ICE_SUB_DEC)
	SetMissionData(sceneId,selfId,SYS_FIRE_SUB_DEC,FIRE_SUB_DEC)
	SetMissionData(sceneId,selfId,SYS_LIGHT_SUB_DEC,LIGHT_SUB_DEC)
	SetMissionData(sceneId,selfId,SYS_POSION_SUB_DEC,POSION_SUB_DEC)
	SetMissionData(sceneId,selfId,SYS_ICE_SUB_LIMIT,ICE_SUB_LIMIT)
	SetMissionData(sceneId,selfId,SYS_FIRE_SUB_LIMIT,FIRE_SUB_LIMIT)
	SetMissionData(sceneId,selfId,SYS_LIGHT_SUB_LIMIT,LIGHT_SUB_LIMIT)
	SetMissionData(sceneId,selfId,SYS_POSION_SUB_LIMIT,POSION_SUB_LIMIT)
	LuaFnRefreshEngine(sceneId,selfId)
	
    --LuaFnGetDayTimeisNew(sceneId,selfId)
	
	LuaFnRefreshEquipGemGrade_Core(sceneId,selfId)--刷新宝石评分
    LuaFnGetEquipGrade(sceneId,selfId,DW_Data[22])--DW_Data[22])	--刷新角色评分
	--x999994_RefreshSepcialDiaoWen(sceneId,selfId,DW_Data[18],DW_Data[19],DW_Data[20],DW_Data[21])--双极雕文记入
    --x888903_NotifyFailBox( sceneId, selfId,  "3" )
	
	
	--x888903_CESHIQU(sceneId, selfId)	---测试区专用
end

--**********************************
--测试区专用
--**********************************
function x888903_CESHIQU(sceneId, selfId)	
	if GetMoney(sceneId,selfId) < 100000000 then
		AddMoney(sceneId,selfId,10000000)
	end
	if ZengDian(sceneId,selfId,-1,3,-1 ) < 100000000 then 
		ZengDian(sceneId,selfId,-1,1, 10000000 )
	end
	if YuanBao(sceneId,selfId,-1,3,0) < 100000000 then
		YuanBao(sceneId,selfId,-1,1, 10000000 )
	end 
	chaxun=GetMissionData(sceneId,selfId,MD_CUMULATIVERECHARGE)
	if chaxun == 0 then
		SetMissionData(sceneId,selfId,MD_NewUserCard3,5000)
	end
end

--**********************************
--查看人物buff
--**********************************
function x888903_CCBUF(sceneId, selfId)	
local p = {}
		local u = 0 
		for i =1 ,50000 do 
		if  LuaFnHaveImpactOfSpecificDataIndex(sceneId, selfId, i) == 1 then 
		u = u + 1
		p[u]=i
		end
		end
	     local	str = ""
		 for j = 1, getn(p) do 
		str =str ..p[j]..","
		end
	x888903_NotifyFailBox( sceneId, selfId, "看看角色身上有多少个buff:"..u )		
	x888903_NotifyFailBox( sceneId, selfId, str )			
end
--**********************************
--会员系统
--**********************************
function x888903_GetVIPLevAttr(sceneId,selfId)
local vipchsh  ={1,2,3,4,5,6,7,8,9,10,11,13,15,22,30}
local vipchsx={1,2,3,4,5,6,8,10,13,16,20,25,30,37,45}
local vipjinE={30,50,100,200,300,500,800,1200,2000,3000,4000,5000,6500,8000,10000}
local vipcz  =GetMissionData(sceneId,selfId,MD_CUMULATIVERECHARGE)
local viplev = 0
for i= 1,getn(vipjinE) do
	if vipcz >=  vipjinE[i] then
		viplev=i
	end
end
if vipcz==0 then
	return 0,0,0
end

local vipxss =0
local vipsh = 0
if viplev >0 and viplev < 16 then
 vipxss = vipchsx[viplev]
 vipsh = vipchsh[viplev]
end
return vipxss,vipsh,viplev
end
--**********************************
--修炼系统
--**********************************
--function x888903_GetXiuLianAttr(sceneId,selfId,nType)
--	local ret = CallScriptFunction(990025, "GetXiuLianFinalAdd", sceneId, selfId,nType)
--	if ret ==0 then 
--		return 0
--	end 
--	local vbbb=	{0,1,2,3,4,5,7,6,8,10,9}
--	local innn = ceil(tonumber((ret/100)*LuaFnGetHumanAttrData(sceneId,selfId,vbbb[nType])/2))
--	return innn
--end

function x888903_LuaFnGetXiuLian_ADD(sceneId,selfId,nType)
	local ret = CallScriptFunction(990025, "GetXiuLianFinalAdd", sceneId, selfId,nType)
    return tonumber(ret)/100
end
function x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,nType)
    local Base = 0
	--力量
	if nType == 1 then
	    Base = CallScriptFunction(990025,"LuaFnGetHumanAttrData",sceneId,selfId,nType)
		return Base
	end
 	--灵气
	if nType == 2 then
	    Base = CallScriptFunction(990025,"LuaFnGetHumanAttrData",sceneId,selfId,nType)
		return Base
	end
 	--体力
	if nType == 3 then
	    Base = CallScriptFunction(990025,"LuaFnGetHumanAttrData",sceneId,selfId,nType)
		return Base
	end
 	--定力
	if nType == 4 then
	    Base = CallScriptFunction(990025,"LuaFnGetHumanAttrData",sceneId,selfId,nType)
		return Base
	end
 	--身法
	if nType == 5 then
	    Base = CallScriptFunction(990025,"LuaFnGetHumanAttrData",sceneId,selfId,nType)
		return Base
	end
	--其他
	if nType >= 6 then
	    local nTypeEx = nType - 5
	    local MenPai = GetMenPai(sceneId,selfId)
        local Lelvel = GetLevel(sceneId,selfId)
		local AddHuman = x888903_LuaFnGetHumanAttrData_XSZL(sceneId,selfId,nTypeEx)
		if MenPai == 9 then
		   return Base
		end
		if x888903_GetBase[MenPai] == nil then
		   return Base
		end
		Base = ceil(x888903_GetBase[MenPai][nTypeEx][2]/100 * Lelvel + x888903_GetBase[MenPai][nTypeEx][3]/100 * AddHuman) + x888903_GetBase[MenPai][nTypeEx][1]
		return Base 
	end
    return Base
end
--**********************************
--雕纹系统
--**********************************
function x999994_RefreshSepcialDiaoWen(sceneId,selfId,WangWu,MingXiang,YuJing,BaoNu) --双极雕纹效果
	for i = 31000,31039 do
		LuaFnCancelSpecificImpact(sceneId,selfId,i);
	end
	local nWangWuImpact = {31000,31001,31002,31003,31004,31005,31006,31007,31008,31009}
	local nMingXiangImpact = {31010,31011,31012,31013,31014,31015,31016,31017,31018,31019}
	local nYuJinImpact = {31020,31021,31022,31023,31024,31025,31026,31027,31028,31029}
	local nBaoNuImpact = {31030,31031,31032,31033,31034,31035,31036,31037,31038,31039}
    --忘无
    if WangWu ~= nil and nWangWuImpact[WangWu] ~= nil then
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,nWangWuImpact[WangWu], 0)
    end
    --冥想
	if MingXiang ~= nil and nMingXiangImpact[MingXiang] ~= nil then
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,nMingXiangImpact[MingXiang], 0)
    end
    --御劲
	if YuJing ~= nil and nYuJinImpact[YuJing] ~= nil then
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,nYuJinImpact[YuJing], 0)
    end
    --暴怒
    if BaoNu ~= nil and nBaoNuImpact[BaoNu] ~= nil then
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,nBaoNuImpact[BaoNu], 0)
    end
end
--**********************************
--装备评分计算
--**********************************
function LuaFnGetEquipGrade(sceneId,selfId,DW_Score)
	local 	nAttackPhysics = LuaFnGetBaseAttackPhysics(sceneId,selfId)-- 外功攻击
	local 	nDefencePhysics = LuaFnGetBaseDefencePhysics(sceneId,selfId)-- 外功防御
	local 	nDefenceMagic = LuaFnGetBaseDefenceMagic(sceneId,selfId)		-- 内功防御
	local 	nAttackMagic = LuaFnGetBaseAttackMagic(sceneId,selfId)	-- 内功攻击
	local 	nMiss = LuaFnGetBaseMiss(sceneId,selfId)-- 闪避
	local 	nHit = LuaFnGetBaseHit(sceneId,selfId)	-- 命中
	local 	nCriticalAttack = LuaFnGetBaseCriticalAttack(sceneId,selfId)-- 会心攻击
	local 	nCriticalDefence = LuaFnGetBaseCriticalDefence(sceneId,selfId)	-- 会心防御
	local 	nAttackCold = LuaFnGetBaseAttackCold(sceneId,selfId)-- 冰攻	
	local   nDefenceLight= LuaFnGetBaseAttackFire(sceneId,selfId)-- 火攻
	local 	AttackLight = LuaFnGetBaseAttackLight(sceneId,selfId)-- 玄功
	local   AttackPosion = LuaFnGetBaseAttackPosion(sceneId,selfId)	--毒攻
	local 	DefenceCold = LuaFnGetBaseDefenceCold(sceneId,selfId)-- 冰抗	
	local   DefenceFire= LuaFnGetBaseDefenceFire(sceneId,selfId)-- 火抗
	local 	DefenceLight = LuaFnGetBaseDefenceLight(sceneId,selfId)-- 毒抗
	local   DefencePosion = LuaFnGetBaseDefencePosion(sceneId,selfId)--玄抗
	local   Count_Equip = nAttackPhysics + nDefencePhysics +nDefenceMagic + nAttackMagic + nMiss + nHit +(nCriticalAttack*2) + (nCriticalDefence*2) 
			+ ((nAttackCold+nDefenceLight+AttackLight+AttackPosion+DefenceCold+DefenceFire+DefenceLight+DefencePosion)*2)
	--心法评分
	local nXinFaScoure = GetMissionData(sceneId,selfId,XINFA_SCORE)
	Count_Equip = Count_Equip + nXinFaScoure
	--宝石评分
	local GemGrade = GetMissionData(sceneId,selfId,GEM_GRADE) * 10
	--修炼评分
	local XiuLianGrade = GetMissionData(sceneId,selfId,XIULIAN_SCORE) * 5
	--强化评分
	local nEnchanceGrade = 0;
	for i = 100,118 do
		local nEnchanceLevel = LuaFnGetEquipEnhanceLevel(sceneId,selfId,i)
		if nEnchanceLevel > 0 and nEnchanceLevel <= 99 then
			nEnchanceGrade = nEnchanceGrade + nEnchanceLevel * 9
		end
	end	
	--装备星级评分
	local nQualGrade = 0;
	for i = 100,118 do
		local nQual = LuaFnGetItmQual(sceneId,selfId,i)
		if nQual > 0 and nQual <= 9 then
			nQualGrade = nQualGrade + nQual * 110
		end
	end	
	--雕纹评分DW_Score
	Count_Equip = Count_Equip + GemGrade + XiuLianGrade + ceil(DW_Score/100) + nQualGrade + nEnchanceGrade--雕纹记录
	Count_Equip = ceil(Count_Equip)
	SetMissionData(sceneId,selfId,XYJ_EQUIP_GRADE,Count_Equip)
	
	
	--刷新历史评分
	if GetMissionData(sceneId,selfId,XYJ_EQUIP_GRADE_HISTORY) < Count_Equip then
		SetMissionData(sceneId,selfId,XYJ_EQUIP_GRADE_HISTORY,Count_Equip)
	end
	DispatchUICommand(sceneId,selfId, 2019050601) --通知客户端刷新了

	LuaFnSendSpecificImpactToUnit(sceneId,selfId,selfId,selfId,57,0) --乾坤壶
end


--============================================
--刷新宝石评分数据
--============================================
function LuaFnRefreshEquipGemGrade_Core(sceneId,selfId)
	local Grade = 0
    for i = 100,118 do
	    if i ~= 102 and i ~= 108 then 
			local _,Data = LuaFnGetItemCreator(sceneId, selfId, i)
			if Data ~= nil and Data ~= "" then
			    local pos1,pos2,Data = strfind(Data,"&BS(%d%d%d)") 
				if pos1 ~= nil and pos2 ~= nil then 
					if Data ~= nil then 
						Grade = Grade + tonumber(Data)
					end
				end
			end
		end
	end
	-- local _,nData = LuaFnGetItemCreator(sceneId, selfId, 100)
	-- x888903_NotifyFailBox( sceneId, selfId,  nData )
	SetMissionData(sceneId,selfId,GEM_GRADE,Grade)
end
--============================================
--刷新心法评分数据
--============================================
function LuaFnXinFaGrade(sceneId,selfId)
	local XinFaData = {
		[0] = {1,2,3,4,5,6,55,72},
		[1] = {7,8,9,10,11,12,56,73},
		[2] = {13,14,15,16,17,18,57,74},
		[3] = {19,20,21,22,23,24,58,75},
		[4] = {25,26,27,28,29,30,59,76},
		[5] = {31,32,33,34,35,36,60,77},
		[6] = {37,38,39,40,41,42,61,78},
		[7] = {43,44,45,46,47,48,62,79},
		[8] = {49,50,51,52,53,54,63,80},
		[9] = {0,0,0,0,0,0,0,0},
	    [10] = {64,65,66,67,68,69,70,71},
        [11] = {81,82,83,84,85,86,87,88},
		[12] = {89,90,91,92,93,94,95,96},--新增鬼谷
    }
	local MenPaiID = GetMenPai(sceneId,selfId)
	local Data_ACTION_ADD = {2,6,6,3,3,6,8,1} --心法评分分数
	local Data_ACTION_GRADE = 0 --心法评分
    local XinFaLevel = {}
	for i = 1,8 do
        if HaveXinFa(sceneId,selfId,XinFaData[MenPaiID][i]) > 0 then
            XinFaLevel[i] = LuaFnGetXinFaLevel(sceneId,selfId,XinFaData[MenPaiID][i])
			Data_ACTION_GRADE = Data_ACTION_GRADE + XinFaLevel[i]*Data_ACTION_ADD[i]
        end
    end	
	SetMissionData(sceneId,selfId,XINFA_SCORE,Data_ACTION_GRADE)
end
--============================================
--得到时装属性。
--============================================
function x888903_GetDressAttr(sceneId,selfId)
     local nDress = LuaFnGetItemTableIndexByIndex(sceneId,selfId,102)
	 local ShuXing = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}--我就不麻烦了，我把一样的属性写一块
	 local Attr = {34680,120,120,120,120,4720,4660,4720,4660,250,250,250,250,130,180}--这里写时装的属性，我这暂时定一个吧，后面有人要做多属性 可以联系Q546528533
	 if nDress <= 0 then
	    return ShuXing[1],ShuXing[2],ShuXing[3],ShuXing[4],ShuXing[5],ShuXing[6],ShuXing[7],ShuXing[8],ShuXing[9],ShuXing[10],ShuXing[11],ShuXing[12],ShuXing[13],ShuXing[14],ShuXing[15]
	 end  
     local _,nData = LuaFnGetItemCreator(sceneId, selfId, 102)
	 if nData ~= nil then--字符存在的情况也分两种，有属性和没属性
	    local Test_1,Test_2 = strfind(nData,"&SZSX")
		if Test_1 == nil and Test_2 == nil then
		   return ShuXing[1],ShuXing[2],ShuXing[3],ShuXing[4],ShuXing[5],ShuXing[6],ShuXing[7],ShuXing[8],ShuXing[9],ShuXing[10],ShuXing[11],ShuXing[12],ShuXing[13],ShuXing[14],ShuXing[15]
		else
		   return Attr[1],Attr[2],Attr[3],Attr[4],Attr[5],Attr[6],Attr[7],Attr[8],Attr[9],Attr[10],Attr[11],Attr[12],Attr[13],Attr[14],Attr[15]
		end
	 else
	    return ShuXing[1],ShuXing[2],ShuXing[3],ShuXing[4],ShuXing[5],ShuXing[6],ShuXing[7],ShuXing[8],ShuXing[9],ShuXing[10],ShuXing[11],ShuXing[12],ShuXing[13],ShuXing[14],ShuXing[15]
	 end	
end
--============================================
--刷新修炼评分数据
--============================================
function LuaFnRefreshXiuLianScore(sceneId,selfId)
    CallScriptFunction(990025, "RefreshXiuLianScore", sceneId, selfId)
end
--============================================
--武魂下限给buff
--============================================
function x888903_WuHunXiaXian(sceneId,selfId)
    local item = LuaFnGetItemTableIndexByIndex(sceneId,selfId,110)
	if item ==10156001 or item == 10156003 then
	   LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,3316, 0)
	   else
	   LuaFnCancelSpecificImpact(sceneId,selfId,3316)
	end
	if item ==10156002 or item == 10156004 then
	   LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId,3315, 0)
	   else
	   LuaFnCancelSpecificImpact(sceneId,selfId,3315)
	end
	
end
--============================================
--还没找到原因，加入门派不能使用技能，必须小退，这里做个提示吧
--============================================
function x888903_PlayerJoinMenPai(sceneId,selfId,targetId)
    local MenPaiBUFF = {225,226,233,234,289,290,297,298,374,375,383,384,442,443,451,452,504,505,511,512,567,568,785,786,643,644,650,651,701,702,709,710,752,753,763,764,833,839,893,894,900,901,1156,1151}

    local JiNeng = {2,0,1,22,21,34,35,147,148,510,104,105,106,107,108,109,110,111,112}
    for i = 1,getn(JiNeng) do
        if HaveSkill(sceneId,selfId,JiNeng[i]) < 1 then
	       AddSkill(sceneId,selfId,JiNeng[i])
	    end
    end 
    for i= 19900,24999  do
	    LuaFnCancelSpecificImpact(sceneId, selfId, i)
	end
   Msg2Player(  sceneId, selfId,"@*;npcpaopao;"..selfId..";2035",MSG2PLAYER_PARA )
		----新手技能刷新白给 
end
