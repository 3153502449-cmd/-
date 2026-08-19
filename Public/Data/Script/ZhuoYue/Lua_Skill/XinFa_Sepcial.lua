--心法系统
--逍遥子 2019-8-4 12:58:58 重构
---===================================================
x990011_g_scriptId = 990011
x990011_g_XinFa = {
	[0] = {1,2,3,4,5,6,55,72},
	[1] = {7,8,9,10,11,12,56,73},
	[2] = {13,14,15,16,17,18,57,74},
	[3] = {19,20,21,22,23,24,58,75},
	[4] = {25,26,27,28,29,30,59,76},
	[5] = {31,32,33,34,35,36,60,77},
	[6] = {37,38,39,40,41,42,61,78},
	[7] = {43,44,45,46,47,48,62,79},
	[8] = {49,50,51,52,53,54,63,80},
    [10] = {64,65,66,67,68,69,70,71},
	[11] = {81,82,83,84,85,86,87,88},
	[12] = {89,90,91,92,93,94,95,96},--鬼谷
	[13] = {97,98,99,100,101,102,103,104},--桃花岛
}
x990011_g_EightXinFa = {71,72,73,74,75,76,77,78,79,80,88,96,103,104}
--第八本心法升级
function x990011_AddXinFa_Eight( sceneId, selfId, XinFaID ,Money, EXP) --第八本心法
	--x990011_NotifyTip( sceneId, selfId, "调试点" )
	--return
	local MenPaiID = GetMenPai(sceneId, selfId)
	--这里要进行一次再筛查 ,用数组
	if HaveXinFa(sceneId,selfId,XinFaID) <= 0 then
		if LuaFnGetXinFaLevel(sceneId,selfId,XinFaID) < 1 then
	        return
		end
	end
	local check = 0
	for i=1,getn(x990011_g_EightXinFa) do
	    if x990011_g_EightXinFa[i] == XinFaID then
		    check = check + 1
		end
	end
	if check == 0 or check > 1 then --此处待验证
	    x990011_NotifyTip( sceneId, selfId, XinFaID)
	    x990011_NotifyTip( sceneId, selfId, "服务器数据异常，请联系GM运营团队！ ERR-XF-02" )
		return
	end
	local nLevel = LuaFnGetXinFaLevel(sceneId, selfId, XinFaID)
	local nLevel = nLevel + 1
	if nLevel >= 250 then
		x990011_NotifyTip( sceneId, selfId, "#{GMDataPool_Info_Xinfo_Level_Is_Top}" )
        return
	end

	local nExp = GetExp(sceneId, selfId)
	if nExp < EXP then
	    x990011_NotifyTip( sceneId, selfId, "经验不足。" )
        return
	end
    local ret = LuaFnCostMoneyWithPriority(sceneId, selfId, Money)
    if ret ==-1 then
        x990011_NotifyTip( sceneId, selfId, "金钱不足。" )
        return
    end	
	--LuaFnCostMoneyWithPriority (sceneId,selfId,Money)
	LuaFnSetXinFaLevel(sceneId,selfId,XinFaID,nLevel)
    LuaFnAddExp( sceneId, selfId, -EXP)
	x990011_NotifyTip( sceneId, selfId, "心法升级成功！" )
	DispatchUICommand( sceneId, selfId, 201812202)
	return
end
--普通心法升级
function x990011_AddXinFa( sceneId, selfId, XinFaID,Money, EXP)
	local MenPaiID = GetMenPai(sceneId, selfId)
	if x990011_g_XinFa[MenPaiID] == nil then
	    x990011_NotifyTip( sceneId, selfId, "服务器数据异常，请联系GM运营团队！ ERR-XF-02" )
		return
	end
	local check = 0
	for i=1,8 do
	    if x990011_g_XinFa[MenPaiID][i] == XinFaID then
		    check = check + 1
		end
	end
	if check == 0 or check > 1 then
	    x990011_NotifyTip( sceneId, selfId, "服务器数据异常，请联系GM运营团队！ ERR-XF-01" )
		return
	end
	local nLevel = LuaFnGetXinFaLevel(sceneId, selfId, XinFaID)
	local nLevel = nLevel + 1
	if nLevel > 119 then
		x990011_NotifyTip( sceneId, selfId, "#{GMDataPool_Info_Xinfo_Level_Is_Top}" )
        return
	end

	local nExp = GetExp(sceneId, selfId)
	if nExp < EXP then
	    x990011_NotifyTip( sceneId, selfId, "经验不足。" )
        return
	end
    local ret = LuaFnCostMoneyWithPriority(sceneId, selfId, Money)
    if ret ==-1 then
        x990011_NotifyTip( sceneId, selfId, "金钱不足。" )
        return
    end	
	--LuaFnCostMoneyWithPriority (sceneId,selfId,Money)
	LuaFnSetXinFaLevel(sceneId,selfId,XinFaID,nLevel)
    LuaFnAddExp( sceneId, selfId, -EXP)
	x990011_NotifyTip( sceneId, selfId, "心法升级成功！" )
	DispatchUICommand( sceneId, selfId, 201812202)
	return
end
--**********************************
--醒目提示
--**********************************
function x990011_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end