--宋辽大战[血战雁门关]
--刘博
--逍遥子 QQ857904341
x502023_g_ScriptId = 502023
x502023_g_ChessBoxID = 40004570
x502023_liangli_wpid ={10415541,10414541,10421541}
x502023_g_LiuBoItem = {10415541,10414541,10421541 }      ----兑换的六博装备ID,肩，腕，带
x502023_YBcanshu = 10
x502023_JYcanshu = 100000
--**********************************
--事件交互入口
--**********************************
function x502023_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#{LBZB_100805_01}" )
		-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_02}", 6, 1 )
		-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_03}", 6, 2 )
		-- AddNumText( sceneId, x502023_g_ScriptId, "“宋辽积分”兑换装备", 6, 3 )
--		AddNumText( sceneId, x502023_g_ScriptId, "积分兑换奖励", 6, 4 ) --这里功能和称号和总奖励冲突
		--宋辽称号兑换
		-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_05}", 6, 8 )
		--六博装备
		AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_80}", 6, 5 )
		AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_81}", 6, 6 )
		--六博装备
		-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_06}", 11, 7 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x502023_OnEventRequest( sceneId, selfId, targetId, eventId)
	local Operation = GetNumText()
	if Operation == 1 then --宋辽大战报名
		local nWeek = GetTodayWeek()
		if nWeek ~= 2 and nWeek ~= 5 then
			x502023_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_08}" )--时间不对
			--return
		end
		local nHour = mod(GetQuarterTime(),100);
		if nHour < 80 or nHour > 82 then
			x502023_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_08}" )--时间不对
			--return
		end
		if GetLevel(sceneId,selfId) < 80 then
			x502023_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_09}" )--你的等级不足80级，请尽快达到80级后再来参与。
			return
		end
		local nHasTeam = LuaFnHasTeam(sceneId, selfId);
		if nHasTeam and nHasTeam == 1 then
			x502023_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_10}" )--报名前，请先退出当前队伍或团队。
			return
		end
		local nHasRide_Two = LuaFnGetDRideFlag(sceneId, selfId);
		if nHasRide_Two and nHasRide_Two == 1 then
			x502023_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_11}" )--报名前，请先退出多人骑乘状态。
			return
		end
		local nTime = GetMissionData(sceneId,selfId,MD_SONGLIAO_TIME)
		local nToday = GetTime2Day()
		if nToday == nTime then
			x502023_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_12}" )--你今天已经参加过宋辽大战
			--return
		end
		if LuaFnGetAvailableItemCount(sceneId, selfId,x502023_g_ChessBoxID) < 1 then
			if LuaFnGetTaskItemBagSpace(sceneId,selfId) < 2 then --是不是有足够的空间
				x502023_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_13}" )--你的任务栏空间不足
				return
			end
			TryRecieveItem(sceneId,selfId,x502023_g_ChessBoxID,1)
			x502023_NotifyFailTips( sceneId, selfId, "#{SLDZ_100805_14}" )--H你获得道具：六博棋盒。道具存放在任务栏。
		end
		SetMissionData(sceneId,selfId,MD_SONGLIAO_TIME,nToday)--记录下今天的时间
		NewWorld(sceneId,selfId,550,random(28,32),random(28,32))--去休息室了
	end
	if Operation == 7 then
		x502023_NotifyFailBox( sceneId, selfId, targetId, "#{SLDZ_100805_07}" )
		return
	end
	if Operation == 5 then
		--升级
		BeginUICommand(sceneId)
			UICommand_AddInt( sceneId,targetId)
	    EndUICommand(sceneId)
	    DispatchUICommand(sceneId,selfId, 5020232)
		return
	end
	if Operation == 6 then
		--升星
		BeginUICommand(sceneId)
			UICommand_AddInt( sceneId,targetId)
	    EndUICommand(sceneId)
	    DispatchUICommand(sceneId,selfId, 5020231)
		return
	end
	if Operation == 2 then  ----------领取宋辽大战奖励，目前能领经验，后期加入坐标
		x502023_OnSongLiaojiangli( sceneId, selfId, targetId )		
	elseif  GetNumText() == 4 then ----------宋辽积分换奖励,目前能换赠点，后期加入能换称号
		x502023_OnJiFenjiangli( sceneId, selfId, targetId )
	elseif GetNumText() == 3 then
		BeginEvent(sceneId)
			AddText(sceneId,"兑换六博装备需要一个#G100#W宋辽积分！")
--			AddText(sceneId,"兑换出的装备属性随机！")
			AddNumText( sceneId, x502023_g_ScriptId, "兑换六博护肩", 6, 101 )
			AddNumText( sceneId, x502023_g_ScriptId, "兑换六博护腕", 6, 102 )
			AddNumText( sceneId, x502023_g_ScriptId, "兑换六博腰带", 6, 103 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	elseif GetNumText() == 101 then
		x502023_DuiHuan( sceneId, selfId,targetId ,x502023_g_LiuBoItem[1] )
	elseif GetNumText() == 102 then
		x502023_DuiHuan( sceneId, selfId,targetId ,x502023_g_LiuBoItem[2] )
	elseif GetNumText() == 103 then
		x502023_DuiHuan( sceneId, selfId,targetId ,x502023_g_LiuBoItem[3] )
	end
	--宋辽称号兑换
	if Operation == 8 then
		BeginEvent(sceneId)
		    AddText(sceneId,"    参与宋辽大战，单场次积分获得第一名的玩家既可领取此称号。为期一天！")
			-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_22}", 6, 201 )
			-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_23}", 6, 202 )
			-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_24}", 6, 203 )
			-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_25}", 6, 204 )
			-- AddNumText( sceneId, x502023_g_ScriptId, "#{SLDZ_100805_26}", 6, 205 )
			AddNumText( sceneId, x502023_g_ScriptId, "震八方雁门无双", 6, 206 )
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
	if Operation >= 201 and Operation <= 206 then
		x502023_ExchangeAgname( sceneId, selfId, targetId,Operation )
		return
	end
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x502023_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x502023_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--兑换六博
--**********************************
function x502023_DuiHuan( sceneId, selfId ,targetId, LiuboNum )
	local LiuBoQiHe = LuaFnGetAvailableItemCount(sceneId,selfId,40004570)
	local nChess_A =GetMissionData(sceneId,selfId,MD_CHESS_SONG)
	local nChess_B=GetMissionData(sceneId,selfId,MD_CHESS_LIAO)
	local DaojuNum = LuaFnGetPropertyBagSpace(sceneId, selfId)
	if LiuBoQiHe < 1  then
		x502023_NotifyFailBox( sceneId, selfId,targetId, "#{SLDZ_100805_19}" )
		return
	end
	if DaojuNum < 2 then
		x502023_NotifyFailBox( sceneId, selfId,targetId, "#{SLDZ_100805_20}" )
		return
	end
	if nChess_A ~= 1222225 or nChess_B ~= 1222225 then
		x502023_NotifyFailBox( sceneId, selfId,targetId, "#{SLDZ_100805_19}" )
		return
	end
	DelItem( sceneId, selfId, 40004570, 1 )
	local NewLiuboNum = LiuboNum+random(0,3)
	SetMissionData(sceneId,selfId,MD_CHESS_SONG,0)
	SetMissionData(sceneId,selfId,MD_CHESS_LIAO,0)
	local pos = TryRecieveItem( sceneId, selfId, NewLiuboNum, 1)
	if pos >=0 then
		x502023_NotifyFailBox( sceneId, selfId,targetId, "  恭喜你，成功兑换#G#{_ITEM"..NewLiuboNum.."}#W一件！" )
	end
end
-----------------------胜利阵营奖励事件---------------------------
function x502023_OnSongLiaojiangli( sceneId, selfId, targetId )
	local sl_paiming = GetMissionData( sceneId, selfId, MD_SONGLIAO_PAIMING) 
	local winner = GetMissionData( sceneId, selfId, MD_SONGLIAOLQ2)  -----领取结果
	local nowday = GetTime2Day()
	if winner == nowday then
		x502023_NotifyFailBox( sceneId, selfId, targetId,"你少来忽悠我，你已经领过奖励了，领奖日期是#G"..winner.."#W，我都记着的呢，少来忽悠我，别以为我好欺负，小孩一边玩去")
		return
	end
	if sl_paiming == 0 then
		x502023_NotifyFailBox( sceneId, selfId, targetId,"#{SLDZ_100805_15}")
		return
	end
	-------------先清空--------------
	SetMissionData( sceneId, selfId, MD_SONGLIAO_PAIMING,0)
	local curDayTime = GetTime2Day()
	SetMissionData( sceneId, selfId, MD_SONGLIAOLQ2,curDayTime)
	-------------先给经验--------------
	local GetExp=GetLevel( sceneId, selfId )*x502023_JYcanshu
	LuaFnAddExp( sceneId,selfId,GetExp)
	--要给别的奖励在这里给，赢方的
	if sl_paiming < 1 or sl_paiming > 3 then
		x502023_NotifyFailBox( sceneId, selfId, targetId,"成功领取胜利方奖励")
		return
	end
	-------------------
	if sl_paiming == 1 or  sl_paiming == 2  or  sl_paiming == 3 then
		if x502023_liangli_wpid[sl_paiming]~=nil  then
			local pos = TryRecieveItem(sceneId,selfId, x502023_liangli_wpid[sl_paiming] , 1 )
			if pos >=0 then
				x502023_NotifyFailBox( sceneId, selfId, targetId,"领取成功，并额外获得#G[#{_ITEM"..x502023_liangli_wpid[sl_paiming] .."}]#W一件！")
				local message = format("#W恭喜玩家#{_INFOUSR%s}在宋辽大战比赛中取得"..str.."第"..sl_paiming.."名#W的好成绩，获得额外特别奖励", GetName(sceneId, selfId) );
				BroadMsgByChatPipe(sceneId, selfId, message, 4);
				return
			end
		end
	end
	x502023_NotifyFailBox( sceneId, selfId, targetId,"领取奖励成功")
end


-------------------积分奖励事件-----------------
function x502023_OnJiFenjiangli( sceneId, selfId, targetId )
	local jifen = GetMissionData( sceneId, selfId, MD_SONGLIAO_JIFEN)
	local mykill = GetMissionData( sceneId, selfId, MD_SONGLIAOLQ1)
	if mykill == GetTime2Day() then
		x502023_NotifyFailBox( sceneId, selfId, targetId,"#{SLDZ_100805_15}")
		return
	end
	
	if jifen == 0 then
		x502023_NotifyFailBox( sceneId, selfId, targetId,"已经兑换完积分了！")
		return
	end
	
	local jiangliyuanbao = jifen*x502023_YBcanshu
	local curDayTime = GetTime2Day()
	SetMissionData( sceneId, selfId, MD_SONGLIAO_JIFEN,0)
	SetMissionData( sceneId, selfId, MD_SONGLIAOLQ1,curDayTime)
	YuanBao(sceneId,selfId,targetId,1,jiangliyuanbao)
	x502023_NotifyFailBox( sceneId, selfId, targetId,"此次宋辽大战，您的积分为:"..jifen.."分#r领取#G"..jiangliyuanbao.."元宝#W,顺便说句，奖励钱多钱少没大关系，关键是大家玩的乐呵，#G玩的开心才是最重要的！")
end
--**********************************
--宋辽兑换称号
--**********************************
function x502023_ExchangeAgname( sceneId, selfId, targetId,nIndex )
	nIndex = nIndex - 200
	--以下赶时间，快写
	if nIndex >= 1 and nIndex <= 5 then
		local nWinTime = GetMissionData(sceneId,selfId,MD_SONGLIAO_WINNUM) --胜利次数[新增接口]
		local nNeedWinTime = 0 --需要的胜利次数
		if nIndex == 1 then
			nNeedWinTime = 1
		elseif nIndex == 2 then
			nNeedWinTime = 10
		elseif nIndex == 3 then
			nNeedWinTime = 20
		elseif nIndex == 4 then
			nNeedWinTime = 50
		elseif nIndex == 5 then
			nNeedWinTime = 100
		end
		if nWinTime < nNeedWinTime then
			x502023_NotifyFailBox( sceneId, selfId, targetId,"    你还需在宋辽大战获得"..nNeedWinTime.."次胜利才能得到此称号！")
			return
		end
		local nIsHave = LuaFnCheckIsHaveTitleByIndex(sceneId, selfId,312 + nIndex)
		if nIsHave == 1 then
			x502023_NotifyFailBox( sceneId, selfId, targetId,"    您已拥有此称号，无需再次领取。")
			return
		end
		LuaFnAwardTitleEx(sceneId, selfId,312 + nIndex,-1)
		LuaFnSetCurTitleEx(sceneId,selfId,312 + nIndex)
	end
	--震八方雁门无双特写
	if nIndex == 6 then
		local nPaiMing = GetMissionData(sceneId,selfId,MD_SONGLIAO_PAIMING)
		if nPaiMing ~= 1 then
			x502023_NotifyFailBox( sceneId, selfId, targetId,"#{SLDZ_100805_221}")
			return
		end
		local nIsHave = LuaFnCheckIsHaveTitleByIndex(sceneId, selfId,377)
		if nIsHave == 1 then
			x502023_NotifyFailBox( sceneId, selfId, targetId,"#{SLDZ_100805_223}")
			return
		end
		LuaFnAwardTitleEx(sceneId, selfId,377,-1)
		LuaFnSetCurTitleEx(sceneId,selfId,377)
		x502023_NotifyFailBox( sceneId, selfId,targetId, "#{SLDZ_100805_222}" )
	end
end