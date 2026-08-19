--元宝 NPC
--注意本脚本含有随身元宝相关功能，请一定参照现有的例子进行修改。

x181000_g_scriptId 	= 181000
x181000_g_buyrate 	= 1

x181000_g_shoptableindex=120
x181000_g_zengdianshop=121


x181000_g_buyact	 	= 2		--兑换元宝
x181000_g_ticketact = 3		--兑换元宝票
x181000_g_zdianact	= 4		--赠点商店
x181000_g_gotodali	= 5		--返回洛阳

x181000_g_normalzdianshop	= 6		--普通增点商店
x181000_g_lv1zdianshop	= 7			--一级材料
x181000_g_lv2zdianshop	= 8			--二级材料
x181000_g_lv3zdianshop	= 9			--三级材料
x181000_g_lv4zdianshop	= 10		--四级材料
x181000_g_lv5zdianshop	= 11		--五级材料
x181000_g_lv6zdianshop	= 12		--六级材料
x181000_g_lv7zdianshop	= 13		--七级材料
x181000_g_lv8zdianshop	= 14		--八级材料
x181000_g_lv9zdianshop	= 15		--九级材料
x181000_g_lv10zdianshop	= 16		--十级材料
x181000_g_newprize	= 17		--查看中奖
x181000_g_YuanBaoIntro	= 18	--元宝介绍

x181000_g_leave			= 20	--离开
x181000_g_return		= 21	--返回(主菜单)
x181000_g_Item ={10553108,39000052,30008067,30505800,30505800,30505800,30505800,30505800}
--**********************************
--事件交互入口
--**********************************
function x181000_OnDefaultEvent( sceneId, selfId, targetId )	
	BeginEvent( sceneId )
		local strText = "    有钱能使鬼推磨，虽然江湖当中以武力为上，但是有了增点可能会使原来很多比较难办的事情变得简单起来，您想做些什么呢？"
		AddText( sceneId, strText )
		 AddNumText( sceneId, x181000_g_scriptId, "将点数兑换成元宝", 2, 2)
		if IsEnableYuanBaoPiao() == 1 then
			 AddNumText( sceneId, x181000_g_scriptId, "将元宝兑换成元宝票", 2, 3)
		end
        AddNumText( sceneId, x181000_g_scriptId, "领取累计充值奖励", 2, 4)
		AddNumText( sceneId, x181000_g_scriptId, "领取每日充值奖励", 2, 5)
		AddNumText( sceneId, x181000_g_scriptId, "领取89级新手奖励", 2, 8899)
		--AddNumText( sceneId, x181000_g_scriptId, "周卡月卡奖励领取", 2, 6)

	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	Msg2Player(  sceneId, selfId,"@*;npcpaopao;211;2033",MSG2PLAYER_PARA )
end

--**********************************
--事件列表选中一项
--**********************************
function x181000_OnEventRequest( sceneId, selfId, targetId, eventId )
	if GetNumText() == 2 then
	    LuaFnSetGlobalDataString(sceneId,selfId,"AskPointType",1)
		--先询问自己的剩余点数
		CallScriptFunction( PRIZE_SCRIPT_ID, "AskPoint", sceneId, selfId )
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			UICommand_AddInt( sceneId, x181000_g_buyrate*1000)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 2001 )
	end
    if	GetNumText() == 3 then
		local _yes = LuaFnOpenPWBox(sceneId,selfId);
		if(_yes~=1)then
			local nYuanBao = YuanBao(sceneId,selfId,targetId,3,0)
			BeginUICommand( sceneId )
				UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
			DispatchUICommand( sceneId, selfId, 2002 )
		end
	end
    if GetNumText() == 4 then
	   CallScriptFunction(892002,"Scripttransitcenter",sceneId,selfId,12)
	end
	if GetNumText() == 5 then
		DispatchUICommand(sceneId,selfId, 8898532)
	end
	if GetNumText() == 6 then
	   LuaFnGetAskPoint(sceneId,selfId)
    end
	if GetNumText() == 8899 then
		if GetLevel(sceneId, selfId) < 89 then
			x181000_tips( sceneId, selfId, "你的等级还不到89级，不能领取此奖励！")
			return
		end
		
		XS_lingqu = GetMissionData(sceneId, selfId, MD_XINSHOU89)
		if XS_lingqu == 9 then
			x181000_tips( sceneId, selfId, "每个角色只能领取一次。")
		end
		
		local nowYear = GetTodayYear();
		local nowMonth = GetTodayMonth();
		nowMonth=nowMonth+1;
		local nowDate = GetTodayDate();
		local nHour	 = GetHour()
		local nMinute = GetMinute()
		local nName = LuaFnGetName( sceneId, selfId )
		local nGuid = LuaFnGetGUID( sceneId, selfId)
		if XS_lingqu ~= 9 then
			
			for i = 1,8 do
				BindBagIndex =TryRecieveItem(sceneId,selfId,x181000_g_Item[i],1)
				if LuaFnGetItemBindStatus(sceneId,selfId,BindBagIndex) ~= 1 then
					LuaFnItemBind(sceneId,selfId,BindBagIndex)
				end
			end
			
			ZengDian(sceneId,selfId,-1,1,100000)
			SetMissionData(sceneId, selfId, MD_XINSHOU89, 9)
			LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 152, 0)	--成功时人物效果
			x181000_tips(sceneId, selfId, "恭喜您获得领取89级奖励：重楼肩、玄灵丹、5000交子票、新莽神符1级5个、10W绑定元宝!")
			x181000_tglb(sceneId, selfId, "时间:["..nowYear.."-"..nowMonth.."-"..nowDate.." "..nHour..":"..nMinute.."]，角色名:["..nName.."]，角色ID:["..nGuid.."]，领取了:[100点充值点数]")
			else
			x181000_tips(sceneId, selfId, "领取失败，或已经领取过了。")
		end
    end


end
function x181000_DuiHuan_GN( sceneId, selfId, indexx)--这个使用的时候别忘记修改

     if indexx < 0 or indexx > 12 then
        return
     end

     if indexx == 1 then
        --if GetMissionData( sceneId, selfId, MD_SCTLAST_CHONGZHI_NUM) <= 0 then
        --    if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 2 then
        --       x181000_g_Str_Tips(sceneId, selfId,"请将道具栏空出至少两个位置")
       --        return
       --     end
       -- end

		CallScriptFunction( PRIZE_SCRIPT_ID, "AskPoint", sceneId, selfId )
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, selfId )
			UICommand_AddInt( sceneId, x181000_g_buyrate*1000)
			UICommand_AddInt(sceneId,0)
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 2001 )
		
	return
     end
end
--**********************************
--客户端购买元宝接口
--**********************************
function x181000_BuyYuanbao( sceneId, selfId, nYuanBao )   
	if nYuanBao and nYuanBao >= 1200 then
		if LuaFnGetMaterialBagSpace(sceneId, selfId) <= 0 and GetMissionFlag(sceneId, selfId, MF_GEM_PRIZE_FLAG) == 0 then
			BeginEvent(sceneId);
			AddText(sceneId, "#{CZSBS_81218_3}");
			EndEvent(sceneId);
			DispatchMissionTips(sceneId, selfId);
			return
		end
	end
	--购买元宝
	if nYuanBao then
		if nYuanBao > 0 and nYuanBao <= 10000 then
		    LuaFnSetGlobalDataString(sceneId,selfId,"BuyYuanbaoType",1)
			CallScriptFunction( PRIZE_SCRIPT_ID, "AskYuanBao", sceneId, selfId, nYuanBao, nYuanBao*x181000_g_buyrate*1000)		
			if GetMissionData(sceneId,selfId,MD_NewUserCard3) >= nYuanBao then--增加一层验证
			  LuaFnSetGlobalDataString(sceneId,selfId,"BuyYuanbaoCard",nYuanBao)
			end  
		end
	end
end

--**********************************
--按需来弹出商店，分为随身商店和NPC商店
--**********************************
function x181000_NewDispatchShopItem(sceneId,selfId,targetId,shopId)
	if targetId >= 0 then
		DispatchShopItem( sceneId, selfId,targetId, shopId )
	else
		DispatchNoNpcShopItem( sceneId, selfId, shopId )
	end
end
--**********************************
--对话窗口信息提示
--**********************************
function x181000_tips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end
--**********************************
--弹出信息
--**********************************
function x181000_tglb(sceneId, selfId, key)
    local handle = openfile("./ZY_DataBase/YuanBaoSystem/XinShou89.txt", "a+")
    if nil ~= handle then
        write(handle, key)
        write(handle, tostring("\n"))
        closefile(handle)
    end
end
