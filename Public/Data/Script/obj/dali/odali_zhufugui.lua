--大理NPC
--祝富贵
--工资任务
--SUNYAN原创
--Q 857904341
--==============================
--- taskLevel: 1, Index: 1: 珍珑棋局		0/2	    --- 401001  --- 1100
---                      2: 一个都不能跑	0/2	    --- 050102  --- 2100
---                      3: 师门任务		0/40                --- 3100
---                      4: 聚宝盆领取		0/3                 --- 4111
---                      5: 幸运快活三		0/4                 --- 5100
---                      6: 挖藏宝图		0/2                 --- 6100
---                      7: 炼金任务		0/2                 --- 7111
---                      8: 一千零一个愿望	0/2                 --- 8100
---
--- taskLevel: 2, Index: 1: 楼兰寻宝		0/2     --- 401001  --- 1011
---                      2: 黄金之链		0/2     --- 050220  --- 2011
---                      3: 初战缥缈峰		0/2                 --- 3011
---                      4: 聚宝盆领取		0/3     --- 402052  --- 4111
---                      5: 讨伐燕子坞		0/4                 --- 5011
---                      6: 杀星			0/3     --- 402048  --- 6010
---                      7: 炼金任务		0/10                --- 7111
---                      8: 四绝庄			0/4                 --- 8011
---
--- taskLevel: 3, Index: 1: 楼兰寻宝		0/2     --- 808039  --- 1011
---                      2: 黄金之链		0/2     --- 050220  --- 2011
---                      3: 初战缥缈峰		0/4                 --- 3011
---                      4: 聚宝盆领取		0/3     --- 402052  --- 4111
---                      5: 讨伐燕子坞		0/4                 --- 5011
---                      6: 凤鸣王陵		0/4     --- 402048  --- 6001
---                      7: 炼金任务		0/15                --- 7111
---                      8: 四绝庄			0/4                 --- 8011
x002102_g_ScriptId = 002102
x002102_g_Type = {"初级","中级","高级"} 
x002102_g_MaxValueByInedx_New = {	
	[1] = { 2, 2, 40, 3,  4,  2,  2,  2 },     --- 第1等级上限 
    [2] = { 2, 2, 2,  3,  4,  3,  10,  4 },     --- 第2等级上限
    [3] = { 1, 1, 1,  1,  1, 1,  1,  1 },     --- 第3等级上限	
}
x002102_g_Salary_Num = {	
	[1] = 240,     --- 第1等级工资数量
    [2] = 280,     --- 第2等级工资数量
    [3] = 40000,     --- 第3等级工资红利数量	
}
x002102_g_Salary_Name = {
    [1] = {
		[1] = "珍珑棋局", --【OK】待测试
		[2] = "一个都不能跑",
		[3] = "师门任务", --【OK】
		[4] = "聚宝盆领取",
		[5] = "幸运快活三",--【OK】
		[6] = "挖藏宝图",
		[7] = "炼金任务",
		[8] = "一千零一个愿望",--【OK】
	},
	[2] = {
		[1] = "楼兰寻宝",
		[2] = "黄金之链",
		[3] = "初战缥缈峰",
		[4] = "聚宝盆领取",
		[5] = "讨伐燕子坞",
		[6] = "杀星",--【OK】
		[7] = "炼金任务",
		[8] = "四绝庄",
	},
	[3] = {
		[1] = "楼兰寻宝",
		[2] = "黄金之链",
		[3] = "初战缥缈峰",
		[4] = "珍珑棋局",
		[5] = "讨伐燕子坞",
		[6] = "凤鸣王陵",
		[7] = "杀星",
		[8] = "四绝庄",
	},
}
x002102_g_Salary_Type = {
    [1] = {
		[1] = 1,
		[2] = 2,
		[3] = 3,
		[4] = 4,
		[5] = 5,
		[6] = 6,
		[7] = 7,
		[8] = 8,
	},
	[2] = {
		[1] = 9,
		[2] = 10,
		[3] = 11,
		[4] = 4,
		[5] = 12,
		[6] = 13,
		[7] = 7,
		[8] = 15,
	},
	[3] = {
		[1] = 9,
		[2] = 10,
		[3] = 11,
		[4] = 1,
		[5] = 12,
		[6] = 14,
		[7] = 13,
		[8] = 15,
	},
}
--**********************************
--事件交互入口
--**********************************
function x002102_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText(sceneId,"#{GZGZ_120514_03}") --此处文案按照新的策划案改
		AddNumText( sceneId, x002102_g_ScriptId, "查看工资任务进度",6,2) --OK
		AddNumText( sceneId, x002102_g_ScriptId, "领取工资",6,3)  --OK
		--AddNumText( sceneId, x002102_g_ScriptId, "#G数据测试",6,4)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x002102_OnEventRequest(sceneId,selfId,targetId,eventId)
    local myLevel = GetLevel(sceneId, selfId)
	if myLevel < 35 then
	    x002102_NotifyTip( sceneId, selfId, "对不起，您的等级不足35级，尚无法领取工资任务！" )
		return
	end
	if GetNumText() == 2 then
	    x002102_OpenSalaryLayout(sceneId,selfId)
	end
	if GetNumText() == 3 then
	    x002102_PayLastSlay_NPC(sceneId,selfId)
	end
end
--**********************************
--增加工资任务点
--**********************************
function x002102_AddSalary(sceneId,selfId,nIndex,nType)
	if nIndex < 1 or nIndex > 8 then
	    return
	end
	if GetLevel(sceneId, selfId) < 35 then --这里缓解服务器压力用
	    return
	end
	local Time,nSLevel,SalyData,nYuanBao = x002102_GetHongLiData(sceneId,selfId)
	if x002102_g_Salary_Type[nSLevel][nIndex] ~= nType then --防止加错
	    return
	end
	SalyData[nIndex] = tonumber(SalyData[nIndex]) + 1
	x002102_SaveHongLiData(sceneId,selfId,Time,nSLevel,SalyData,nYuanBao)
	x002102_NotifyTip( sceneId, selfId, "您的工资任务："..x002102_g_Salary_Name[nSLevel][nIndex].."完成度增加了1点" )
end
--**********************************
--领取工资-场景线程用
--**********************************
function x002102_PayLastSlay_Auto(sceneId,selfId)
	--注意，此处要考虑自动领取的问题
	if GetLevel(sceneId, selfId) < 35 then --这里缓解服务器压力用
	    return
	end
	local Time,nSLevel,SalyData,nYuanBao = x002102_GetHongLiData(sceneId,selfId)
	local check = 0
	for i = 1,8 do
	    if SalyData[i] >= x002102_g_MaxValueByInedx_New[nSLevel][i] then
		    check = check + 1
		end
	end
	if check == 8 then --完成，立马结算
	    local SalaryNum = GetMissionData(sceneId,selfId,XYJ_HONGLI)
		if x002102_g_Salary_Num[nSLevel] ~= nil then
		    SalaryNum = SalaryNum + (x002102_g_Salary_Num[nSLevel]-tonumber(nYuanBao)) --这里切记
			--注意，工资任务结算在重置数据的时候已经写了
			--SetMissionData(sceneId,selfId,XYJ_HONGLI,SalaryNum)
			--x002102_NotifyTip( sceneId, selfId, "恭喜您完成了上周的工资任务！您获得了"..tostring(x002102_g_Salary_Num[nSLevel]).."点红利！再接再厉哦！")
			--LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 151, 0)
		else
			x002102_NotifyTip( sceneId, selfId, "您的工资红利数据异常，上周奖励未能结算！请联系雄霸天龙运营团队来解决此问题！")
			return
		end
	else
		--x002102_NotifyTip( sceneId, selfId, "对不起，上周你没能完成的工资任务，所以没能拿到红利奖励，继续加油哦！" )
	end
end
--**********************************
--领取工资-对外
--**********************************
function x002102_PayLastSlay_NPC(sceneId,selfId)
	--注意，此处要考虑自动领取的问题
	--备注：XYJ-12121919处已将下月工资等级判断写入数据库，所以此处无需再加，切记1
	local Time,nSLevel,SalyData,nYuanBao = x002102_GetHongLiData(sceneId,selfId)
	local check = 0
	for i = 1,8 do
	    if SalyData[i] >= x002102_g_MaxValueByInedx_New[nSLevel][i] then
		    check = check + 1
		end
	end
	if check == 8 then --完成，立马结算
	    local SalaryNum = GetMissionData(sceneId,selfId,XYJ_HONGLI)
		if x002102_g_Salary_Num[nSLevel] ~= nil then
		    SalaryNum = SalaryNum + (x002102_g_Salary_Num[nSLevel]-tonumber(nYuanBao)) --这里切记
			SetMissionData(sceneId,selfId,XYJ_HONGLI,SalaryNum)
			x002102_NotifyTip( sceneId, selfId, "恭喜您完成了每天的工资任务！您获得了"..tostring(x002102_g_Salary_Num[nSLevel]).."点红利！再接再厉哦！")
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 151, 0)
			
		else
			x002102_NotifyTip( sceneId, selfId, "您的工资红利数据异常，每天奖励未能结算！请联系雄霸天龙运营团队来解决此问题！")
			return
		end
	else
		--LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "对不起，上周你没能完成的工资任务，所以没能拿到红利奖励，继续加油哦！" )
		x002102_NotifyTip( sceneId, selfId, "对不起，今天你没能完成的工资任务，所以没能拿到红利奖励，继续加油哦！" )
	end
end
--**********************************
--打开客户端工资界面
--**********************************
function x002102_OpenSalaryLayout(sceneId,selfId)
	--工资任务等级
	--1
	--2
	--3
	--4
	--5
	--6
	--7
	--8
	local Time,nSLevel,SalyData,nYuanBao = x002102_GetHongLiData(sceneId,selfId)
--	local FinalData = tostring(Time)..","..tostring(nSLevel)..","
	local FinalData = ""
	for i = 1,8 do
	    FinalData = FinalData..tostring(SalyData[i])..","
	end
	FinalData = FinalData..tostring(nSLevel)
--	x002102_NotifyTip( sceneId, selfId, FinalData)
    BeginUICommand( sceneId )
	    UICommand_AddString( sceneId,FinalData)
	    EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,  20170605) 
end
--**********************************
--结算工资【内部使用】
--**********************************
function x002102_PayLastSlay(sceneId,selfId,nSLevel,SalyData,nYuanBao)
	--这里切记不能用ret
    --首先比较工资是否完成
	local check = 0
	for i = 1,8 do
	    if SalyData[i] >= x002102_g_MaxValueByInedx_New[nSLevel][i] then
		    check = check + 1
		end
	end
	if check == 8 then --完成，立马结算
	    local SalaryNum = GetMissionData(sceneId,selfId,XYJ_HONGLI)
		if x002102_g_Salary_Num[nSLevel] ~= nil then
		    SalaryNum = SalaryNum + (x002102_g_Salary_Num[nSLevel]-tonumber(nYuanBao)) --这里切记
			SetMissionData(sceneId,selfId,XYJ_HONGLI,SalaryNum)
			x002102_NotifyTip( sceneId, selfId, "恭喜您完成了今天的工资任务！您获得了"..tostring(x002102_g_Salary_Num[nSLevel]).."点红利！再接再厉哦！")
		else
			x002102_NotifyTip( sceneId, selfId, "您的工资红利数据异常，今天奖励未能结算！请联系雄霸天龙运营团队来解决此问题！")
			return
		end
	else
		CallScriptFunction(900016,"LuaFnNewWeek",sceneId, selfId)
--		LuaFnNewWeek(sceneId,selfId)
		LuaFnSendSystemMail( sceneId, GetName(sceneId,selfId), "对不起，今天你没能完成的工资任务，所以没能拿到红利奖励，继续加油哦！" )
		--x002102_NotifyTip( sceneId, selfId, "对不起，上周你没能完成的工资任务，所以没能拿到红利奖励，继续加油哦！" )
	end
end
--**********************************
--读取工资数据库
--**********************************
function x002102_GetHongLiData(sceneId,selfId)
    x002102_CreateDataBase(sceneId,selfId) --构建一次
	local myGuid = LuaFnGetGUID(sceneId, selfId)
	local savetxt = openfile("./XYD_DataBase/HongLi/HL"..tostring(myGuid)..".txt", "r")
	local Time,nYuanBao,nSLevel = 0,0,0
	local SalyData = {}
	if savetxt and nil ~= savetxt then
		local line1=read(savetxt, "*l")
		if line1==nil then
			return
		end
		Time = tonumber(line1)
		local line4=read(savetxt, "*l")
		if line4==nil then
			return
		end
		nSLevel = tonumber(line4)
		for i=1, 8  do
			local line2=read(savetxt, "*l")
			if line2==nil then
				return
			end
			SalyData[i] = tonumber(line2)
		end
		local line3=read(savetxt, "*l")
		if line3==nil then
			return
		end
		nYuanBao = tonumber(line3)
		closefile(savetxt)
	else
		x002102_NotifyTip(sceneId,selfId,"ERROR::ReadSQL Fail !!!  XYJ-HL-DATA")
		return
	end
	--这里需要校验一次周次数据，注意一周清除一次
	local nWeekCur = mod(GetWeekTime(),4)
	--x002102_NotifyTip(sceneId,selfId,"调试点2 "..nWeekCur)
	if nWeekCur ~= Time then --这也说明了一个问题，上周的工资需要结算一次了
	    Time = nWeekCur --同步时间
		x002102_PayLastSlay(sceneId,selfId,nSLevel,SalyData,nYuanBao) --结算工资
		local nLevel = GetLevel(sceneId, selfId) --这里划分工资等级 XYJ-12241919
		if nLevel >= 35 and nLevel <= 79 then
		    nSLevel = 1
		end
		if nLevel >= 80 and nLevel <= 89 then
		    nSLevel = 2
		end
		if nLevel >= 90 and nLevel <= 119 then
		    nSLevel = 3
		end
		for i=1,8 do
		    SalyData[i] = 0 --重置工资内容
		end
		nYuanBao = 0
		--x002102_NotifyTip(sceneId,selfId,"调试点1")
		x002102_SaveHongLiData(sceneId,selfId,Time,nSLevel,SalyData,nYuanBao) --写入文本记录 XYJ-12241821
	end
	return Time,nSLevel,SalyData,nYuanBao
end
--**********************************
--写工资数据
--**********************************
function x002102_SaveHongLiData(sceneId,selfId,Time,nSLevel,SalyData,nYuanBao)
	local Guid = LuaFnObjId2Guid(sceneId,selfId) ---得到ID
	local FinData = ""
	--这里不用再读取原有数据，在XYJ-12241821处的调用会完成全部传值
	FinData = tostring(Time).."\n"..tostring(nSLevel).."\n"
	for i = 1,8 do
	    FinData = FinData..SalyData[i].."\n"
	end
	FinData = FinData..nYuanBao.."\n"
	local 	Coldfile = openfile("./XYD_DataBase/HongLi/HL"..tostring(Guid)..".txt", "w")
	if Coldfile and nil ~= Coldfile then
		if FinData == nil or FinData == "" then
			return
		end
		write(Coldfile, FinData)
		closefile(Coldfile)
	else
		return 
	end
	return
end
--**********************************
--建立工资数据库
--**********************************
function x002102_CreateDataBase(sceneId,selfId)
	--数据结构  红利值用在存储点，此处不用做txt
	--日期 第几周
	--工资任务等级
	--1
	--2
	--3
	--4
	--5
	--6
	--7
	--8
	--目前存储的红利
	local Guid = LuaFnGetGUID(sceneId,selfId)
	local nLevel = GetLevel(sceneId, selfId) --这里划分工资等级 XYJ-12241919
	if nLevel >= 35 and nLevel <= 79 then
		nSLevel = 1
	end
	if nLevel >= 80 and nLevel <= 89 then
		nSLevel = 2
	end
	if nLevel >= 90 and nLevel <= 119 then
		nSLevel = 3
	end
	local DataStr ="0".."\n"..tostring(nSLevel).."\n"
    for i =1,10 do --此处注意
        DataStr = DataStr.."0".."\n"
    end
	local handle = openfile("./XYD_DataBase/HongLi/HL"..tostring(Guid)..".txt", "r")
	if handle == nil then
		local handle = openfile("./XYD_DataBase/HongLi/HL"..tostring(Guid)..".txt", "wb")
		if nil ~= handle  then
			write(handle,tostring(DataStr))
			closefile(handle)
		end
    end
end
--**********************************
--醒目提示
--**********************************
function x002102_Notify( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId )
end

--**********************************
--屏幕中间醒目提示
--**********************************
function x002102_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end