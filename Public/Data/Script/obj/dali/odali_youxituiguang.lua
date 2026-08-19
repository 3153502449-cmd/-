x999999_g_scriptId = 999999
ZhuoYue_scriptData = {
["A"]={10553101,1}, --重楼戒 3
["B"]={10553102,1}, --重楼玉 2
["C"]={10553100,1}, --重楼链 3
["D"]={10553108,1}, --重楼肩 30
["E"]={39000020,1}, --10元充值点 300
["F"]={39000021,1}, --20元充值点 150
["G"]={39000022,1}, --30元充值点 80
["H"]={39000023,1}, --50元充值点 40
["I"]={39000024,1}, --100元充值点 9
["J"]={39000025,1}, --200元充值点 6
["K"]={39000026,1}, --300元充值点 4
["L"]={39000027,1}, --500元充值点 3
["M"]={38000952,10}, --点金玉 70
["N"]={38000956,10}, --紫金石 40
["O"]={38000013,1}, --6级宝石兑换券 10
["P"]={38000012,1}, --5级宝石兑换券 40
["Q"]={38000011,1}, --4级宝石兑换券 60
["R"]={20502003,10}, --3级秘银 50
["S"]={20501003,10}, --3级棉布 50
["T"]={20310166,50}, --金蚕丝 50
}

--**********************************
--事件交互入口
--**********************************
function x999999_OnDefaultEvent(sceneId, selfId, targetId)

    BeginEvent(sceneId)
	AddText(sceneId,"")
    AddText(sceneId,"  #P欢迎来到方舟天龙，祝您游戏愉快！")
		--AddText(sceneId,"  #P推广#G5个#P天龙sf群获得新手大礼包!")
		AddText(sceneId,"  #G充值超过5000的玩家可直接领取名动大礼包！")
		AddText(sceneId,"  #P购买抽奖卡可在此激活抽奖卡！")
		AddText(sceneId,"  #G购买抽奖卡请联系客服！！！")
		AddText(sceneId,"  #Y本服客服QQ：#cFF0000202220020")
		--AddText(sceneId,"  #G无需激活码即可领取新手大礼包!")
		--AddText(sceneId,"  #G小提示：每个玩家只能获得一次重楼奖励")
    if LuaFnGetName( sceneId, selfId ) == "方舟天龙" then
        AddNumText(sceneId, x999999_g_scriptId, "添加生成key", 2, 1)
		--AddNumText(sceneId, x999999_g_scriptId, "清空key", 2, 3)
    end
    AddNumText(sceneId, x999999_g_scriptId, "    领取充值回馈", 2, 2)
	AddNumText(sceneId, x999999_g_scriptId, "    领取名动礼包", 5, 9999)
	AddNumText(sceneId, x999999_g_scriptId, "    激活抽奖卡号", 5, 1111 )
	AddNumText(sceneId, x999999_g_scriptId, "    清除宝宝附体", 6, 66)
	AddNumText(sceneId, x999999_g_scriptId, "    清除普攻进阶", 6, 77)
	AddNumText(sceneId, x999999_g_scriptId, "    点击修复经验", 6, 88)
	
    EndEvent(sceneId)
    DispatchEventList(sceneId, selfId, targetId)
end

--**********************************
--事件列表选中一项
--**********************************
function x999999_OnEventRequest(sceneId, selfId, targetId, eventId)
	if GetNumText() == 88 then
	    if  GetExp( sceneId, selfId ) >=0 then 
            x999999_tips( sceneId, selfId, "你的经验正常着呢" )
            return
        end
        BeginEvent( sceneId )
        for i = 0,1000  do
            AddExp(sceneId,selfId,GetExp(sceneId,selfId)*-1)
        end
        AddText(sceneId,"恭喜您，已经成功为你清空了经验！")
        EndEvent( sceneId )
        DispatchEventList( sceneId, selfId, -1 )
	end
    if GetNumText() == 77 then
       local menpai = GetMenPai(sceneId,selfId)	
       local jineng={281,311,341,371,401,431,461,491,521,0,190,160,963}	
        if menpai == 9 then
          x999999_tips( sceneId, selfId, "你还没有门派" )
          return
        end
        if jineng[menpai+1]  ==nil then 
           x999999_tips( sceneId, selfId, "联系GM" )
           return	
        end
        if HaveSkill( sceneId, selfId, jineng[menpai+1] ) ~= 1 then
           AddSkill(  sceneId, selfId, jineng[menpai+1])	
           x999999_tips( sceneId, selfId, "学习成功" )
        else
           x999999_tips( sceneId, selfId, "不要重复学习" )
        end
    end	
	if GetNumText() == 66 then
	  LuaFnCancelSpecificImpact(sceneId,selfId,1400)
      SetMissionData(sceneId, selfId, HETI_PETID, 0 )	
	end
	if GetNumText() == 1 then
		if LuaFnGetName( sceneId, selfId ) == "方舟天龙" then
	        x999999_scKey(sceneId, selfId)
		end
	end
    if GetNumText() == 2 then
		local nowYear = GetTodayYear();
		local nowMonth = GetTodayMonth();
		nowMonth=nowMonth+1;
		local nowDate = GetTodayDate();
		local nHour	 = GetHour()
		local nMinute = GetMinute()
		local nName = LuaFnGetName( sceneId, selfId )
		local nGuid = LuaFnGetGUID( sceneId, selfId)
		is_lingqu = GetMissionData(sceneId, selfId, IS_LING_KEY)
		if is_lingqu ~= 9 then
			--local BagIndex = TryRecieveItem( sceneId, selfId,10553109, 1 )
			--LuaFnItemBind( sceneId, selfId, BagIndex ) 
			--local BagIndex = TryRecieveItem( sceneId, selfId,10553112, 1 )
			--LuaFnItemBind( sceneId, selfId, BagIndex ) 
			--local BagIndex = TryRecieveItem( sceneId, selfId,10553100, 1 ) 
			--LuaFnItemBind( sceneId, selfId, BagIndex ) 
			--local BagIndex = TryRecieveItem( sceneId, selfId,10553101, 1 ) 
			--LuaFnItemBind( sceneId, selfId, BagIndex ) 
			--local BagIndex = TryRecieveItem( sceneId, selfId,10553101, 1 ) 
			--LuaFnItemBind( sceneId, selfId, BagIndex )
            --local BagIndex = TryRecieveItem( sceneId, selfId,10553102, 1 )  
			--LuaFnItemBind( sceneId, selfId, BagIndex )
            --local BagIndex = TryRecieveItem( sceneId, selfId,10553102, 1 ) 
            --LuaFnItemBind( sceneId, selfId, BagIndex )
			SetMissionData(sceneId, selfId,MD_SCTLAST_CHONGZHI_NUM,GetMissionData(sceneId, selfId,MD_SCTLAST_CHONGZHI_NUM)+100)
			SetMissionData(sceneId, selfId, IS_LING_KEY, 9)
			--x999999_tips(sceneId, selfId, "恭喜您获得1个推广大礼包!")
			x999999_tips(sceneId, selfId, "恭喜您获得100点充值，可在新手贺年华-充值超值赠领取所有奖励!")
			x999999_xrdhsj(sceneId, selfId, "时间["..nowYear.."-"..nowMonth.."-"..nowDate.." "..nHour..":"..nMinute.."]，角色名["..nName.."]，角色ID["..nGuid.."]")
			else
			x999999_tips(sceneId, selfId, "领取失败，或已经领取过了。")
		end
		
		
		--local level = GetLevel( sceneId, selfId )
		--if level>=30 then
		--	BeginUICommand(sceneId)
		--	UICommand_AddInt(sceneId, targetId)
		--	EndUICommand(sceneId)
		--	DispatchUICommand(sceneId, selfId, 20160831)
		--else
		--	x999999_tips(sceneId, selfId, "请提升等级至30级再来找我")
		--end
    end
	if GetNumText() == 1111 then
		BeginUICommand(sceneId)
        	UICommand_AddInt(sceneId, targetId)
		UICommand_AddString(sceneId, "CDK")
        	EndUICommand(sceneId)
        	DispatchUICommand(sceneId, selfId, 20200401)
	end
	
	if GetNumText() == 9999 then
		local g_LeiJiDianShu = 	GetMissionData(sceneId, selfId,MD_SCTLAST_CHONGZHI_NUM)
		if g_LeiJiDianShu < 5000 then
          	BeginEvent(sceneId)
		  AddText(sceneId,"您充值未满5000元，无法领取名动礼包!" )
		  EndEvent(sceneId)
		  DispatchEventList(sceneId,selfId,targetId)
		  return 0
	    end
		
		local nowYear = GetTodayYear();
		local nowMonth = GetTodayMonth();
		nowMonth=nowMonth+1;
		local nowDate = GetTodayDate();
		local nHour	 = GetHour()
		local nMinute = GetMinute()
		local nName = LuaFnGetName( sceneId, selfId )
		local nGuid = LuaFnGetGUID( sceneId, selfId)
		is_lingqu = GetMissionData(sceneId, selfId, IS_CHONGZHI_KEY)
		if is_lingqu ~= 9 then
			BeginAddItem(sceneId)
				AddItem( sceneId, 39900105,1) 
				AddItem( sceneId, 10553103,1)
				AddItem( sceneId, 10553104,2)
				AddItem( sceneId, 10553105,2)
				AddItem( sceneId, 10553110,1)
				AddItem( sceneId, 10553113,1)
			EndAddItem(sceneId,selfId)
			AddItemListToHuman(sceneId,selfId)
			SetMissionData(sceneId, selfId, IS_CHONGZHI_KEY, 9)
			x999999_tips(sceneId, selfId, "恭喜您获得1个名动大礼包!")
			x999999_czdlb(sceneId, selfId, "时间["..nowYear.."-"..nowMonth.."-"..nowDate.." "..nHour..":"..nMinute.."]，角色名["..nName.."]，角色ID["..nGuid.."]")
			else
			x999999_tips(sceneId, selfId, "领取失败，或已经领取过了。")
		end
		
    end
	
	if GetNumText() == 3 then
		if LuaFnGetName( sceneId, selfId ) == "方舟天龙" then
			x999999_clearKey(sceneId, selfId)
		end
    end
end


--生成key
function x999999_scKey(sceneId, selfId)
			x999999_clearKey(sceneId, selfId)
			for i = 0, 999 do
                x999999_scxt(sceneId, selfId)
            end
               x999999_tips(sceneId, selfId, "生成完毕。")

	
end

--清空key
function x999999_clearKey(sceneId, selfId)
	
	--清空临时值
	for i = 1, getn(gfxy_qjphb) do
       gfxy_qjphb[i].keyID = ""
    end
	
	--清空记事本
	local handle = openfile("../Server/Log1/key.txt", "w+")
    if nil ~= handle then
        write(handle, "")
        closefile(handle)
    end
	x999999_tips(sceneId, selfId, "清空完毕")
end

function x999999_scxt(sceneId, selfId)
    if gfxy_qjphb[1000].keyID ~= "" then
        x999999_tips(sceneId, selfId, "储存失败，已满。")
        return
    end
    local str = ""
    for i = 0, 2 do
        str = str .. strchar(random(97, 122)) .. random(9)
    end
    x999999_ccsj(sceneId, selfId, str)
end

function x999999_dhsj(sceneId, selfId, k1, k2, k3, k4, k5, k6)
    k1 = strchar(k1)
    k3 = strchar(k3)
    k5 = strchar(k5)
    local nkey = k1 .. k2 .. k3 .. k4 .. k5 .. k6
    local num = 0
    for i = 1, getn(gfxy_qjphb) do
        if gfxy_qjphb[i].keyID ~= "" and gfxy_qjphb[i].keyID == nkey then
            gfxy_qjphb[i].keyID = ""
            num = 1
            break
        end
    end
    if num == 1 then
       local nowYear = GetTodayYear();
		local nowMonth = GetTodayMonth();
		nowMonth=nowMonth+1;
		local nowDate = GetTodayDate();
		local nHour	 = GetHour()
		local nMinute = GetMinute()
		local nName = LuaFnGetName( sceneId, selfId )
		local nGuid = LuaFnGetGUID( sceneId, selfId)
        
        --local zd = 100000
        --ZengDian(sceneId, selfId, -1, 1, 100000)
		--x999999_tips(sceneId, selfId, "恭喜您获得"..zd.."点绑元")
		
		is_lingqu = GetMissionData(sceneId, selfId, IS_LING_KEY)
		
		if is_lingqu ~= 9 then
			
			local g_xingyun={10553100,10553101,10553102,10553109,10553112}
			for i =1 , getn (g_xingyun) do
	        g_Itm=g_xingyun[i]
			local BagIndex = TryRecieveItem( sceneId, selfId,g_Itm, 1 )    --按数量发放
            LuaFnItemBind( sceneId, selfId, BagIndex )
			end
			SetMissionData(sceneId, selfId, IS_LING_KEY, 9)
			x999999_tips(sceneId, selfId, "恭喜您获得神器重楼套!")
		end
        x999999_xrdhsj(sceneId, selfId, "时间["..nowYear.."-"..nowMonth.."-"..nowDate.." "..nHour..":"..nMinute.."]，角色名["..nName.."]，角色ID["..nGuid.."]，的激活码["..nkey.."]")
        x999999_tips(sceneId, selfId, "激活成功,您已获得推广奖励")
        --反卷每天只能送一次
        --local time = GetMissionData(sceneId, selfId, LOOK_TIME_ONE)
        --local nCurTime = LuaFnGetCurrentTime()
		--x999999_tips(sceneId, selfId, nCurTime.."||"..time)
        --local msg = "#cff66cc[激活码系统]:#P#b恭喜玩家#W[" .. nam .. "]#P，在#G洛阳(推广使者)，#P使用激活码兑换了#eaf0c14#Y[" .. yuanbao .. "]#P元宝";
        --if nCurTime - time > 60 * 60 * 12 then
            --送返券
        --end

    else
        x999999_tips(sceneId, selfId, "激活失败，或已经被使用。")
    end
end

function x999999_ccsj(sceneId, selfId, key)
    for i = 1, getn(gfxy_qjphb) do
        if gfxy_qjphb[i].keyID == "" then
            gfxy_qjphb[i].keyID = key
            break
        end
    end
    x999999_xrscsj(sceneId, selfId, key)
end

function x999999_xrscsj(sceneId, selfId, key)
    local handle = openfile("./ZY_DataBase/CDK/key.txt", "a+")
    if nil ~= handle then
        write(handle, key)
        write(handle, tostring("\n"))
        closefile(handle)
    end
end

function x999999_xrdhsj(sceneId, selfId, key)
    local handle = openfile("./ZY_DataBase/CDK/keydhlog.txt", "a+")
    if nil ~= handle then
        write(handle, key)
        write(handle, tostring("\n"))
        closefile(handle)
    end
end

function x999999_XuKaJiHuo1(sceneId, selfId, k1, k2, k3, k4, k5, k6)
	local ZhuoYue_min=6
	if LuaFnGetPropertyBagSpace( sceneId, selfId ) < ZhuoYue_min or LuaFnGetMaterialBagSpace(sceneId,selfId) < ZhuoYue_min then
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:背包道具栏和材料栏都空出"..ZhuoYue_min.."个位置", 0);
		return 0
	end
    k1 = strchar(k1)
    k2 = strchar(k2)
    k3 = strchar(k3)
    k4 = strchar(k4)
    k5 = strchar(k5)
    k6 = strchar(k6)
	
		if ZhuoYue_scriptData[k1]==nil then
			x999999_tips(sceneId, selfId, "无效卡号，或该卡已经被使用。") 
			return 
		end
	
    local num = 0
    local mak = 0
    local nkey = "TL" .. k1 .. k2 .. k3 .. k4 .. k5 .. k6
    local handle1 = openfile("./ZY_DataBase/CDK/688-CDK.txt", "r")
    local MyName111 = nkey
    if nil ~= handle1 then
        for i = 1, 100000 do
            local line = read(handle1, "*l")
            if line == nil then
                break
            end
            if line == MyName111 then
                num = 1
                break
            end
        end
        closefile(handle1)
    end
    local handle2 = openfile("./ZY_DataBase/CDK/688-CDKlog.txt", "r")
    local MyName222 = nkey
    if handle2 and nil ~= handle2 then
        for i = 1, 100000 do
            local line = read(handle2, "*l")
            if line == nil then
                break
            end
            if line == MyName222 then
                mak = 1
                break
            end
        end
        closefile(handle2)
    else
        mak = 1
    end
    if num == 1 and mak == 0 then
        local nam = GetName(sceneId, selfId)
        local handle3 = openfile("./ZY_DataBase/CDK/688-CDKlog.txt", "a+")
        if nil ~= handle3 then
            write(handle3, nkey)
            write(handle3, tostring("\n"))
            closefile(handle3)
        end
        x999999_tips(sceneId, selfId, "CDK激活成功！")
		for i=1,ZhuoYue_scriptData[k1][2] do
			LuaFnItemBind(sceneId, selfId, TryRecieveItem(sceneId, selfId, ZhuoYue_scriptData[k1][1], 1))
		end
		local strs= "获得了["..GetItemName( sceneId, ZhuoYue_scriptData[k1][1] ).."]"..ZhuoYue_scriptData[k1][2].."个"
		x999999_tips(sceneId, selfId, strs)
		x999999_LogForChouJiangKA(sceneId, selfId,strs)
		local PlayerName = LuaFnGetName( sceneId, selfId )
		local str = format( "#P玩家#cFF0000#{_INFOUSR%s}#P技痒难耐#P通过抽奖,获得了#cFF0000#["..GetItemName( sceneId, ZhuoYue_scriptData[k1][1] ).."]#Y"..ZhuoYue_scriptData[k1][2].."个!",PlayerName)
        BroadMsgByChatPipe( sceneId, selfId, str, 4 )
		
        LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 147, 0)
		ZhuoYue_999999XZ[selfId]=0
    else
        x999999_tips(sceneId, selfId, "无效卡号，或该卡已经被使用。"..num)
    end
end
function x999999_LogForChouJiangKA(sceneId, selfId,Point)
	local nowYear = GetTodayYear();
	local nowMonth = GetTodayMonth() + 1;
	local nowDate = GetTodayDate();
	local nHour	 = GetHour()
	local nMinute = GetMinute()
	local nName = LuaFnGetName( sceneId, selfId )
	local nGuid = LuaFnGetGUID( sceneId, selfId)
	local nGUILDName = LuaFnGetGuildName(sceneId, selfId)
	local handle = openfile("./ZY_DataBase/YuanBaoSystem/ChoujiangExchange.txt", "a+")
	if nil ~= handle then
		write(handle,format("Player:%s GUID:%s GUILD:%s \t内容:%s \tTime:%s",nName,nGuid,nGUILDName,Point,tostring(nowYear * 10000 + nowMonth * 100 + nowDate).." "..nHour..":"..nMinute))
		write(handle,tostring("\n"))
		closefile(handle)
	end
end
function x999999_czdlb(sceneId, selfId, key)
    local handle = openfile("./ZY_DataBase/CDK/czdlblog.txt", "a+")
    if nil ~= handle then
        write(handle, key)
        write(handle, tostring("\n"))
        closefile(handle)
    end
end

function x999999_tips(sceneId, selfId, Tip)
    BeginEvent(sceneId)
    AddText(sceneId, Tip)
    EndEvent(sceneId)
    DispatchMissionTips(sceneId, selfId)
end
