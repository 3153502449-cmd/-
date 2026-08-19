--脚本号 脚本总控调用  极致功能全写这
x892002_g_scriptId = 892002
-------------------------------------宝石转换相关变量
x892002_g_Cost_YuanBao = {}			
x892002_g_Cost_YuanBao[5] = {4200,12600}
x892002_g_Cost_YuanBao[6] = {19200,57600}
x892002_g_Cost_YuanBao[7] = {96000,288000}
x892002_g_Cost_YuanBao[8] = {382000,1152000}
x892002_g_Cost_YuanBao[9] = {500,1500}
-----------------------------------------
--**********************************
--累计登陆奖励物品
--**********************************
x892002_g_LandReward_Gifts = {
	[1] = 	{ 
			{GiftItemID = 30008067, num = 1,}, {GiftItemID = 39000010, num = 1,}, 
			},
	[2] =	{	
			{GiftItemID = 10156001, num = 1,},{GiftItemID = 10156002, num = 1,},{GiftItemID = 20502007, num = 5,}, 
			},
	[3] =   {
			{GiftItemID = 30008067, num = 1,},{GiftItemID = 39000014, num = 1,},{GiftItemID = 20501007, num = 5,},{GiftItemID = 38000011, num = 1,}, -- 真元精珀
			},
	[4] =   {
			{GiftItemID = 10553108, num = 1,},{GiftItemID = 20502007, num = 5,},{GiftItemID = 20501007, num = 5,},{GiftItemID = 38000011, num = 1,}, -- 精金石*30
			},
	[5] =   {
			{GiftItemID = 30008067, num = 2,},{GiftItemID = 38000952, num = 5,},{GiftItemID = 20501007, num = 10,},{GiftItemID = 38000012, num = 1,}, -- 3级红宝石
			},
	[6] =   {
			{GiftItemID = 30008067, num = 2,},{GiftItemID = 38000956, num = 5,},{GiftItemID = 20501007, num = 10,},{GiftItemID = 38000013, num = 1,}, -- 玄灵丹*2
			},
}
--**********************************
--累计充值奖励物品
--**********************************
x892002_g_PrzieReward_Gifts = {
	[1] = 	{ 
			{GiftItemID = 38000011, num = 1,}, {GiftItemID =10156001, num = 1,}, {GiftItemID =10156002, num = 1,}, {GiftItemID =20501007, num = 5,}, 
			},
	[2] =	{	
			{GiftItemID = 38000011, num = 1,},{GiftItemID = 30505800, num = 2,},{GiftItemID = 20502007, num = 5,}, 
			},
	[3] =   {
			{GiftItemID = 38000011, num = 1,},{GiftItemID = 30505800, num = 3,},{GiftItemID = 20501007, num = 10,},
			},
	[4] =   {
			{GiftItemID = 38000011, num = 1,},{GiftItemID = 30505801, num = 5,},{GiftItemID = 20502007, num = 10,},
			},
	[5] =   {
			{GiftItemID = 38000012, num = 1,},{GiftItemID = 10553108, num = 1,},{GiftItemID = 20501007, num = 10,},
			},
			---第二重
	[6] =   {
			{GiftItemID = 38000012, num = 1,},{GiftItemID = 30505801, num = 5,},{GiftItemID = 20501007, num = 10,},{GiftItemID = 20502007, num = 10,}, 
			},
	[7] = 	{ 
			{GiftItemID = 38000012, num = 1,}, {GiftItemID =10155002, num = 1,},{GiftItemID = 39999901, num = 10,},{GiftItemID = 20501007, num = 10,}, 
			},
	[8] =	{	
			{GiftItemID = 38000012, num = 1,},{GiftItemID = 30505802, num = 5,},{GiftItemID = 38000952, num = 10,},{GiftItemID = 20502007, num = 10,}, 
			},
	[9] =   {
			{GiftItemID = 38000013, num = 1,},{GiftItemID = 30505802, num = 10,},{GiftItemID = 38000952, num = 10,},{GiftItemID = 20310113, num = 20,}, 
			},
	[10] =   {
			{GiftItemID = 10553101, num = 1,},{GiftItemID = 39000035, num = 3,},{GiftItemID = 38000956, num = 5,},{GiftItemID = 38000952, num = 5,},
			},
			--第三重
	[11] =   {
			{GiftItemID = 39000035, num = 10,},{GiftItemID = 30505803, num = 20,},{GiftItemID = 38000956, num = 5,},{GiftItemID = 38000952, num = 10,}, 
			},
	[12] =   {
			{GiftItemID = 30505804, num = 20,},{GiftItemID = 38000956, num = 5,},{GiftItemID = 38000952, num = 10,},{GiftItemID = 38000641, num = 1,},
			},
	[13] =   {
			{GiftItemID = 10553102, num = 1,},{GiftItemID = 30505805, num = 10,},{GiftItemID = 38000956, num = 5,},{GiftItemID = 38000952, num = 10,},
			},
	[14] =   {
			{GiftItemID = 10553110, num = 1,},{GiftItemID = 30505805, num = 10,},{GiftItemID = 38000956, num = 10,},{GiftItemID = 38000641, num = 2,}, 
			},
	[15] =   {
			{GiftItemID = 10553100, num = 1,},{GiftItemID = 30505806, num = 10,},{GiftItemID = 38000956, num = 10,},{GiftItemID = 38000641, num = 3,}, 
			},
}
--**********************************
--每日充值
--**********************************
x892002_g_PayReward_Prize = {[1] = 10,[2] = 30,[3] = 50,[4] = 100,}--每日充值对应的充值数
x892002_g_myitemlist = {	--每日充值对应的奖品。
    [1] = 	{ 
			{GiftItemID =20501003, num = 2,}, {GiftItemID =20502003, num = 2,}, 
			},
	[2] =	{	
			{GiftItemID = 20501003, num = 5,}, {GiftItemID =20502003, num = 5,}, {GiftItemID =30700241, num = 2,},  
			},
	[3] =   {
			{GiftItemID = 30008067, num = 1,},{GiftItemID = 38000952, num = 5,},{GiftItemID = 20501003, num = 10,}, {GiftItemID =20502003, num = 10,},  
			},
	[4] =   {
			{GiftItemID = 30008067, num = 2,},{GiftItemID = 38000952, num = 5,},{GiftItemID = 38000956, num = 5,}, {GiftItemID = 39999901, num = 5,}, 
			},
}

x892002_g_nTitleTable = {
[233] = {10,0,723,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--缥缈之锋芒初现
[234] = {20,0,1410,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--缥缈之豪情无双
[235] = {50,0,2066,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--缥缈之战无不胜
[236] = {100,0,4180,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--缥缈之我意纵横
[255] = {150,0,5637,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--缥缈之唯我独尊
[239] = {10,48,7,0,415,-1,-1,-1,-1,-1,-1,-1,-1},--侠者仁心
[240] = {20,48,13,0,838,-1,-1,-1,-1,-1,-1,-1,-1},--杀阵行者
[241] = {50,48,19,0,1230,-1,-1,-1,-1,-1,-1,-1,-1},--雄才伟略
[101] = {100,48,38,0,2508,-1,-1,-1,-1,-1,-1,-1,-1},--先圣遗风
[102] = {150,48,58,0,5508,-1,-1,-1,-1,-1,-1,-1,-1},--鬼谷无双
[131] = {10,19,62,26,62,-1,-1,-1,-1,-1,-1,-1,-1},--平贼士兵
[132] = {30,19,127,26,127,-1,-1,-1,-1,-1,-1,-1,-1},--平贼队长
[133] = {50,19,249,26,249,-1,-1,-1,-1,-1,-1,-1,-1},--平贼统领
[134] = {70,19,364,26,364,-1,-1,-1,-1,-1,-1,-1,-1},--荡寇将军
[135] = {90,19,738,26,738,-1,-1,-1,-1,-1,-1,-1,-1},--荡寇元帅
[136] = {100,20,10,27,10,-1,-1,-1,-1,-1,-1,-1,-1},--比武大会状元
[137] = {100,20,7,27,7,-1,-1,-1,-1,-1,-1,-1,-1},--比武大会榜眼
[138] = {100,20,5,27,5,-1,-1,-1,-1,-1,-1,-1,-1},--比武大会探花
[229] = {10,48,5,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--剿匪义士
[230] = {50,48,6,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--破匪侠士
[231] = {100,48,7,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--镇匪英侠
[232] = {150,48,8,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1},--天下匪见愁
[237] = {10,7,5,10,5,13,5,16,5,-1,-1,-1,-1},--剿匪游击将军
[238] = {20,7,6,10,6,13,6,16,6,-1,-1,-1,-1},--剿匪破虏将军
[119] = {50,7,7,10,7,13,7,16,7,-1,-1,-1,-1},--剿匪车骑将军
[120] = {100,7,8,10,8,13,8,16,8,-1,-1,-1,-1},--剿匪大将军
[116] = {200,0,5637,48,20,6,10,9,10,12,10,15,10},--震八方雁门无双
[121] = {500,0,3637,48,15,6,5,9,5,12,5,15,5},--凤凰古城的霸主
}

function x892002_Scripttransitcenter( sceneId, selfId,nType,arg1,arg2,arg3,arg4,arg5 )
	
         ---打开武魂界面
		 if nType == 1 then
		    CallScriptFunction( 900004, "OpenWuHun",sceneId,selfId)
		    return
		 end
         ---打开修炼界面
		 if nType == 2 then
		    CallScriptFunction( 990025, "XIULIAN",sceneId,selfId,1)
		    return
		 end	
         ---周卡月卡界面		 
		 if nType == 3 then
		    x892002_WeekAdnMonth(sceneId,selfId)
		    return
		 end
         ---周卡月卡购买		 
		 if nType == 4 then
		    x892002_BuyWeekAdnMonth(sceneId,selfId,arg1)
		    return
		 end
         ---周卡月卡每日奖励领取。		 
		 if nType == 5 then
		    x892002_GetWeekAdnMonthGift(sceneId,selfId,arg1)
		    return
		 end
		 ---打开网页统一调用地址
		 if nType == 6 then
		    x892002_OpenLinkWeb(sceneId,selfId,arg1)
		    return
		 end
		 ---奖励领取UI调用部分（累计登陆）
		 if nType == 7 then
		    x892002_LeiJiLoginGame(sceneId,selfId)
		    return
		 end		
	     if nType == 9 then --万能传送界面	
            CallScriptFunction(890096,"xunzhaocy",sceneId,selfId,arg1,arg2)	
	        return
         end	
		 if nType == 12 then--累计充值界面
			local ii=0
		    local DDGCZCX = {10,30,50,80,100,200,300,500,800,1000,1500,2000,3000,4000,5000}
		    local g_Point = GetMissionData( sceneId, selfId, MD_CUMULATIVERECHARGE) 
		    local g_Pointlq = GetMissionData( sceneId, selfId, MD_CUMULATIVEREBUTTN)	
			for i = 1 , getn(DDGCZCX) do
			    if g_Point >= DDGCZCX[i]  then
					ii = ii+1
				end
			end
		    BeginUICommand( sceneId )
		    	UICommand_AddInt( sceneId,ii)
		    	UICommand_AddInt( sceneId,g_Pointlq)
		    	EndUICommand( sceneId )
		    DispatchUICommand( sceneId, selfId, 89292101 )						
	    	    return
		 end
         if nType == 13 then--CDK抽奖
		    BeginUICommand(sceneId)
            UICommand_AddInt(sceneId, targetId)
            UICommand_AddString(sceneId, "CDK")
            EndUICommand(sceneId)
            DispatchUICommand(sceneId, selfId, 20170431)	
            return
		 end
         if nType == 14 then--帮会工资任务
			local dayCount = GetMissionData( sceneId, selfId, MD_SHITUZONGDONGYUAN_PRIZE_COUNT )
		    local curDayTime = GetTime2Day()
			if curDayTime == floor( dayCount / 100) then
		       duobaost= dayCount - curDayTime * 100
            end
		    BeginUICommand(sceneId)
		    UICommand_AddInt( sceneId, selfId )	
	        UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, PAOPAO))	
	        UICommand_AddInt( sceneId, floor(GetMissionData(sceneId,selfId,MD_XINGYUN_DATA)/100000))	 
	        UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, MD_MURENXIANG_HUAN))--天劫楼	 
	        UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, HETI_PETID))--1001	 
	        UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, FANZEI))	
	        UICommand_AddInt( sceneId, duobaost)	--夺宝 
	        UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, MD_EVERDATPAY))--每日	 
	        UICommand_AddInt( sceneId, GetMissionData( sceneId, selfId, BANGZHAN))		  
	        EndUICommand( sceneId )
	        DispatchUICommand( sceneId, selfId,  20171036)					--帮会每日任务	
            return
		 end
		 if nType == 20 then--累计登陆领奖
		    x892002_GetLoginGift(sceneId,selfId,arg1)
		    return
		 end		 		 
		 if nType == 22 then--每日充值领奖
		    x892002_DayGetPrizeGift(sceneId,selfId,arg1)
		    return
		 end
		 if nType == 21 then--累计充值领奖
		    x892002_GetPrizeGift(sceneId,selfId,arg1)
		    return
		 end		 
		 if nType == 23 then--称号记录系统。		    
			if arg1 == 0 then
			   return
			end
			SetMissionData(sceneId,selfId,MD_CURRETITLE,arg2*1000+arg1)			
		    return
		 end		 
		 if nType == 24 then--攻略传送执行。
             x892002_TodayCampaignList_GoToScene(sceneId,selfId,arg1)
			return
		 end	
		 if nType == 25 then--属性时装修复，后面开服的可以删除掉
		    x892002_DressRest(sceneId,selfId,arg1)
		    return
		 end		 
		 if nType == 26 then--属性时装修复，后面开服的可以删除掉
		    x892002_ZhuanYiDressAttr(sceneId,selfId,arg1,arg2)
		    return
		 end		 
		 if nType == 27 then--属性坐骑进阶
		   x892002_NotifyTip( sceneId, selfId, "属性转移成功。" )
		     x892002_RidaLevelUP(sceneId,selfId,arg1)
		    return
		 end
		 if nType == 28 then --帮派工资任务
			local dayCount = GetMissionData( sceneId, selfId, MD_SHITUZONGDONGYUAN_PRIZE_COUNT )
		    local curDayTime = GetTime2Day()
		    if curDayTime == floor( dayCount / 100) then
		       duobaost= dayCount - curDayTime * 100
            end
		 	 local JRLQ = GetMissionData( sceneId, selfId, BANGHUILINGQU)
		 	 local renwu1 = GetMissionData( sceneId, selfId, PAOPAO)
		 	 local renwu2 = floor(GetMissionData(sceneId,selfId,MD_XINGYUN_DATA)/100000)	 
		 	 local renwu3 = GetMissionData( sceneId, selfId, MD_MURENXIANG_HUAN)	 
		 	 local renwu4 = GetMissionData( sceneId, selfId, HETI_PETID)	 
		 	 local renwu5 = GetMissionData( sceneId, selfId, FANZEI)	 
		 	 local renwu6 = duobaost
		 	 local renwu7 = GetMissionData( sceneId, selfId, MD_EVERDATPAY)	 
		 	 local renwu8 = GetMissionData( sceneId, selfId, BANGZHAN)	
    	 	 local Guildpos = GetGuildPos(sceneId, selfId)	
		 if Guildpos < 2 then
		 	 x892002_NotifyTip( sceneId, selfId,"请先加入帮会后再来吧！" )		
 		 	 return
    	 end	
		 if GetDayTime() <= GetMissionData( sceneId, selfId, BANGHUILINGQU) then   
		 	 x892002_NotifyTip( sceneId, selfId,"今天已经完成过了，请明天在来吧" )		
 		 	 return
    	 end	
    	 if	renwu1~=1 or renwu2~=1 or renwu3~=1 or renwu4~=1 or renwu5~=1 or renwu6~=1 or renwu7~=1 or renwu8~=1 then
		 	 BeginEvent(sceneId)
		 	 AddText( sceneId, "当前任务完成情况：#r一个都不能跑"..renwu1.."/1#r参与幸运抽奖"..renwu2.."/1#r除恶天劫楼"..renwu3.."/1#r一千零一个愿望"..renwu4.."/1#r剿灭造反恶贼"..renwu5.."/1#r师徒夺宝练"..renwu6.."/1#r充值任意金额"..renwu7.."/1#r参与帮战活动"..renwu8.."/1#r#G任务完成状况：#cFF0000未完成" )	
		 	 EndEvent(sceneId)
		 	 DispatchEventList(sceneId, selfId, targetId)	
		 	 return
   	  	 end	
		 	
			 ZengDian(sceneId, selfId, -1, 1, 10000)	
    	 	 AddMoney( sceneId, selfId, 4000000 )	
		 	 x892002_NotifyTip( sceneId, selfId,"恭喜你成功完成了帮会工资任务" )	

		 	 SetMissionData( sceneId, selfId, PAOPAO,0) 
		 	 SetMissionData( sceneId, selfId, MD_XINGYUN_DATA,0) 
		 	 SetMissionData( sceneId, selfId, MD_MURENXIANG_HUAN,0) 
		 	 SetMissionData( sceneId, selfId, HETI_PETID,0) 
		 	 SetMissionData( sceneId, selfId, FANZEI,0) 
		 	 SetMissionData( sceneId, selfId, MD_SHITUZONGDONGYUAN_PRIZE_COUNT,0) 
		 	 SetMissionData( sceneId, selfId, MD_EVERDATPAY,0) 
		 	 SetMissionData( sceneId, selfId, BANGZHAN,0) 	
		 	 SetMissionData( sceneId, selfId, BANGHUILINGQU,GetDayTime()) 	
		 	 BroadMsgByChatPipe(sceneId, selfId, "帮会每日任务：#Y恭喜玩家#G["..LuaFnGetName( sceneId, selfId ).."]#Y完成了帮会每日任务获得了大量元宝和金币奖励，只要拥有帮会的玩家都可以到#P大理帮会使者处领取任务。", 4)	
    	 	return
    	end		 		 
end
--*******************************
--属性坐骑进阶。
--*******************************
function x892002_RidaLevelUP(sceneId,selfId,arg1)
         x892002_NotifyTip( sceneId, selfId, "属性转移成功。" )
         ---初步设计,&ZQ %w %w %w%w%w %w %w %w  ---品阶，类型（随机神品、魔品、仙品、凡品）、坐骑等级（100级）、坐骑技能三个（按类型 技能不同）技能就固定三个吧。懒得去写太多了
		 local nData = "&ZQ(%w)(%w)(%w%w%w)(%w)(%w)(%w)"
		 local Skill = {"A","B","C"}
		 local ChuShiData = "&ZQ1"..random(1,4).."001000"
		 local EquipType = LuaFnGetBagEquipType(sceneId,selfId, arg1)
		 local ItemNum = {10,20,30,40,50,60,70,80,100}
		 local needItem = 0
		 local nFideStr = ""
		 local nLevel,nType,nRideLevel,Skill1,Skill2,Skill3 = "","","","","",""
		 if EquipType ~= 8 then
		     x892002_NotifyTip( sceneId, selfId, "此处只能提供坐骑进阶。" )
		    return
		 end		 
         ---检测道具是否够用，这里分为9个等级			   
         local EquipStr = LuaFnGetItemCreator(sceneId,selfId,arg1)
		 if EquipStr ~= nil then--这里可能有宝石评分，前面没有坐骑不能打宝石的限制，这里就留一手吧，以后谁要删除就删除吧
		    local Test1,Test2 = strfind(EquipStr,"&ZQ")
			if Test1 ~= nil and Test2 ~= nil then
			    _,_,nLevel,nType,nRideLevel,Skill1,Skill2,Skill3 = strfind(EquipStr,nData)
	            needItem = ItemNum[tonumber(nLevel)]
				nFideStr = "&ZQ"..tonumber(nLevel)+1 ..nType..nRideLevel..Skill1..Skill2..Skill3
				if tonumber(nLevel) == 7 then
				   nFideStr = "&ZQ"..tonumber(nLevel)+1 ..nType..nRideLevel..Skill[random(1,4)]..Skill2..Skill3
				end
				if tonumber(nLevel) == 8 then
				   nFideStr = "&ZQ"..tonumber(nLevel)+1 ..nType..nRideLevel..Skill1..Skill[random(1,4)]..Skill3
				end
				if tonumber(nLevel) == 9 then
				   nFideStr = "&ZQ"..tonumber(nLevel)+1 ..nType..nRideLevel..Skill1..Skill2..Skill[random(1,4)]
				end
			else
	        needItem = ItemNum[1]
            nFideStr =  ChuShiData			
			end
		 else
			needItem = ItemNum[1]
			nFideStr =  ChuShiData
		 end
        x892002_NotifyTip( sceneId, selfId, "属性转移成功。" )	   		 
        BroadMsgByChatPipe( sceneId, selfId,nFideStr, 4 )		 
end
--*******************************
--属性时装转移。
--*******************************
function x892002_ZhuanYiDressAttr(sceneId,selfId,arg1,arg2)
	   if GetMissionData(sceneId,selfId,MD_CUMULATIVERECHARGE) < 2000 then
	      return
	   end
       local _,nData = LuaFnGetItemCreator(sceneId, selfId, arg1)--需要看出两种情况
       local _,nData_1 = LuaFnGetItemCreator(sceneId, selfId, arg2)--需要看出两种情况
       if nData == nil then
	      return
	   end
	   local Test_1,Test_2 = strfind(nData,"&SZSX")
	   if Test_1 == nil and Test_2 == nil then
	      x892002_NotifyTip( sceneId, selfId, "该时装非属性时装。" )
	      return
	   end
	   if nData_1 ~= nil then
	      LuaFnSetEquipItemCreatorEx(sceneId,selfId,arg2,nData_1.."&SZSX")--增加新时装的字符
		  else
		  LuaFnSetEquipItemCreatorEx(sceneId,selfId,arg2,"&SZSX")--增加新时装的字符
	   end
	   local Test_Data = gsub(nData,"&SZSX","")
	   LuaFnSetEquipItemCreatorEx(sceneId,selfId,arg1,Test_Data)--去除旧时装的字符
	   x892002_NotifyTip( sceneId, selfId, "属性转移成功。" )	   
end
--*******************************
--属性时装修复。	临时
--*******************************
function x892002_DressRest(sceneId,selfId,arg1)
       local nEquipID = LuaFnGetItemTableIndexByIndex(sceneId,selfId,arg1)
	   local nStr = ""
	   if nEquipID < 10124404 or nEquipID > 10124417 then
	      x892002_NotifyTip( sceneId, selfId, "该时装非属性时装无法重置。" )
	      return
	   end
	   if GetMissionData(sceneId,selfId,MD_CUMULATIVERECHARGE) < 2000 then
	      return
	   end
	   local _,nData = LuaFnGetItemCreator(sceneId, selfId, arg1)--需要看出两种情况
	   if nData ~= nil then
	   local Test_1,Test_2 = strfind(nData,"&SZSX")
	    if Test_1 ~= nil and Test_2 ~= nil then
	      x892002_NotifyTip( sceneId, selfId, "该时装属性已重置过了，不要重复操作。" )
	      return
	    end
		--有字符，但是属性不存在
		  LuaFnSetEquipItemCreatorEx(sceneId,selfId,arg1,nData.."&SZSX")
		  LuaFnRewashEquipAttr(sceneId,selfId,arg1)
	   else--无字符直接写
	      LuaFnSetEquipItemCreatorEx(sceneId,selfId,arg1,"&SZSX")
          LuaFnRewashEquipAttr(sceneId,selfId,arg1)		  
	   end	   
	   x892002_NotifyTip( sceneId, selfId, "时装属性已更新" )
end
--*******************************
--攻略传送执行。	
--*******************************
function x892002_TodayCampaignList_GoToScene(sceneId,selfId,arg1)
         --通过安全级别区分场景，能打架肯定不能让远程传
		 local nSafeLevel = LuaFnGetSceneSafeLevel(sceneId)
		 local sceneType = LuaFnGetSceneType(sceneId)
         if nSafeLevel ~= 10000 then
		    x892002_NotifyTip( sceneId, selfId, "快捷功能只能在安全场景和非副本场景中使用。" )
		    return
		 end
         if sceneType == 1 then
		    x892002_NotifyTip( sceneId, selfId, "快捷功能只能在安全场景和非副本场景中使用。" )
		    return
		 end
         local SceneTable = 
		 {
		 {2,173,145},--1
		 {1,178,129},--2
		 {6,166,146},--3
		 {2,169,122},--4
		 {-1,"当日为漕运日，所有漕运收益翻倍",-1},--5
		 {1,192,137},--6
		 {186,162,127},--7
		 {2,264,127},--8
		 {1,130,228},--9
		 {39,113,219},--10
		 {39,113,219},--11
		 {-1,"随机发生在九大门派",-1},--12
		 {32,156,171},--13
		 {1,187,129},--14
		 {20,147,110},--15
		 {-1,"随机发生在太湖、嵩山、镜湖、无量山、剑阁、敦煌",-1},--16
		 {25,63,258},--17
		 {158,142,112},--18
		 {39,142,78},--19
		 {158,172,34},--20
		 {1,175,145},--21
		 {186,162,75},--22
		 {158,233,225},--23
		 {2,51,149},--24
		 {5,277,46},--25
		 {-1,"发生在自己的帮会城市",-1},--26
		 {2,51,149},--27
		 {186,209,175},--28
		 {5,200,51},--29
		 {186,292,67},--30		 
		 {1,63,162},--31		 
		 {2,50,175},--32		 
		 {2,75,92},--33		 
		 {2,131,79},--34		 
		 {186,189,221},--35		 
		 {1,187,147},--36		 
		 {1,292,67},--37		 
		 {420,202,213},--38		 
		 {5,277,46},--39		 
		 {1,173,131},--40		 
		 {-1,"前往自己帮会进行领取跑商任务",131},--41		 
		 {1,189,169},--42		 
		 {-1,"前往夜西湖进行采集",169},--43		 
		 {4,70,119},--44		 
		 }
		 if SceneTable[arg1][1] == -1 then
		    x892002_NotifyTip( sceneId, selfId, SceneTable[arg1][2] )
		    return
		 end
		 -- SetLevel(sceneId,selfId,119)
		 CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, SceneTable[arg1][1], SceneTable[arg1][2], SceneTable[arg1][3],30 )
end
--*******************************
--称号阅历属性。
--*******************************
function x892002_GetTitleYueliData(sceneId,selfId)
 	local nYueliAttrTab = {
	{10,19,45,26,45},
	{50,0,257,0,0},
	{100,48,1,0,0},
	{150,19,91,26,91},
	{200,0,516,0,0},
	{250,48,2,0,0},
	{300,19,182,26,182},
	{350,0,1033,0,0},
	{400,48,3,0,0},
	{450,19,182,26,182},
	{500,0,1033,0,0},
	{550,48,3,0,0},
	{600,19,182,26,182},
	{650,0,1033,0,0},
	{700,48,3,0,0},
	{750,19,182,26,182},
	{800,0,1033,0,0},
	{850,48,3,0,0},
	{900,19,182,26,182},
	{950,0,1033,0,0},
	{1000,48,3,0,0},
	{1050,19,182,26,182},
	{1100,0,1033,0,0},
	{1150,48,3,0,0},
	{1200,19,182,26,182},
	{1250,0,1033,0,0},
	{1300,48,3,0,0},
	{50000,48,3,0,0},
	}
	local nAttrTable_Self = {
	[0] = 0,  --血上限
	[19] = 0, --外功攻击
	[26] = 0, --内功攻击
	[48] = 0, --所有属性
	}
	local ZongYueLi = floor(GetMissionData(sceneId,selfId,MD_CURRETITLE)/1000)
	local nLevel = 0
    local nMaxYueli = nYueliAttrTab[getn(nYueliAttrTab)][1]
	if ZongYueLi >= nMaxYueli then
		ZongYueLi = nMaxYueli
	else
		if ZongYueLi ~= 0 then
			for i = 1,getn(nYueliAttrTab) do
				if nYueliAttrTab[i][1] > ZongYueLi then
					nLevel = i - 1
					break
				end
			end
		end
	end	
	for i = 1,nLevel  do
		if nYueliAttrTab[i][3] > 0 then
			nAttrTable_Self[nYueliAttrTab[i][2]] = nAttrTable_Self[nYueliAttrTab[i][2]] + nYueliAttrTab[i][3]
		end
		if nYueliAttrTab[i][5] > 0 then
			nAttrTable_Self[nYueliAttrTab[i][4]] = nAttrTable_Self[nYueliAttrTab[i][4]] + nYueliAttrTab[i][5]
		end
	end	
	return nAttrTable_Self[0],nAttrTable_Self[19],nAttrTable_Self[26],nAttrTable_Self[48]
end
--*******************************
--称号属性获取。
--*******************************
function x892002_GetTitleAttr(sceneId,selfId)
         local MyTitle =  mod(GetMissionData(sceneId,selfId,MD_CURRETITLE),1000)
		 local YueLiAttr = {}
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
			[19] = 0, --外功攻击
			[20] = 0, --基础外功攻击
			[26] = 0, --内功攻击
			[27] = 0, --基础内功攻击
			[46] = 0, --身法
			[48] = 0, --所有属性
		 } 		 
		 if MyTitle == 0 then
		    return nAttrTable[0],nAttrTable[6],nAttrTable[7],nAttrTable[9],nAttrTable[10],nAttrTable[12],nAttrTable[13],nAttrTable[15],nAttrTable[16],nAttrTable[19],nAttrTable[20],nAttrTable[26],nAttrTable[27],nAttrTable[46],nAttrTable[48]
		 end
		 if x892002_g_nTitleTable[MyTitle] ~= nil then
		    if x892002_g_nTitleTable[MyTitle] ~= nil then
		       if x892002_g_nTitleTable[MyTitle][2] ~= -1 then
			      nAttrTable[x892002_g_nTitleTable[MyTitle][2]] = x892002_g_nTitleTable[MyTitle][3]
		       end
		       if x892002_g_nTitleTable[MyTitle][4] ~= -1 then
			      nAttrTable[x892002_g_nTitleTable[MyTitle][4]] = x892002_g_nTitleTable[MyTitle][5]
		       end
		       if x892002_g_nTitleTable[MyTitle][6] ~= -1 then
			      nAttrTable[x892002_g_nTitleTable[MyTitle][6]] = x892002_g_nTitleTable[MyTitle][7]
		       end
		       if x892002_g_nTitleTable[MyTitle][8] ~= -1 then
			      nAttrTable[x892002_g_nTitleTable[MyTitle][8]] = x892002_g_nTitleTable[MyTitle][9]
		       end
		       if x892002_g_nTitleTable[MyTitle][10] ~= -1 then
			      nAttrTable[x892002_g_nTitleTable[MyTitle][10]] = x892002_g_nTitleTable[MyTitle][11]
		       end
		       if x892002_g_nTitleTable[MyTitle][12] ~= -1 then
			      nAttrTable[x892002_g_nTitleTable[MyTitle][12]] = x892002_g_nTitleTable[MyTitle][13]
		       end
	        end
			 YueLiAttr[0],YueLiAttr[19],YueLiAttr[26],YueLiAttr[48] = x892002_GetTitleYueliData(sceneId,selfId)
			--阅历+称号属性计算
			nAttrTable[0] = nAttrTable[0] + YueLiAttr[0]
			nAttrTable[19] = nAttrTable[19] + YueLiAttr[19]
			nAttrTable[26] = nAttrTable[26] + YueLiAttr[26]
			nAttrTable[48] = nAttrTable[48] + YueLiAttr[48]	
			return nAttrTable[0],nAttrTable[6],nAttrTable[7],nAttrTable[9],nAttrTable[10],nAttrTable[12],nAttrTable[13],nAttrTable[15],nAttrTable[16],nAttrTable[19],nAttrTable[20],nAttrTable[26],nAttrTable[27],nAttrTable[46],nAttrTable[48]
		 else
		    return nAttrTable[0],nAttrTable[6],nAttrTable[7],nAttrTable[9],nAttrTable[10],nAttrTable[12],nAttrTable[13],nAttrTable[15],nAttrTable[16],nAttrTable[19],nAttrTable[20],nAttrTable[26],nAttrTable[27],nAttrTable[46],nAttrTable[48]
		 end
end
--*******************************
--每日充值领奖
--*******************************
function x892002_DayGetPrizeGift(sceneId,selfId,arg1)
         local MyDatPrize = GetMissionData(sceneId,selfId,MD_EVERDATPAY)
		 local Button = GetMissionData(sceneId,selfId,MD_EVERDATPAYBUTTN)
		 local ButtonReq = {}
		 local value = {1,10,100,1000}
		 for i = 1,4 do
		     ButtonReq[5-i] = mod(floor(Button/value[i]),10)
		 end	
         if MyDatPrize < x892002_g_PayReward_Prize[arg1] then
		    x892002_NotifyTip( sceneId, selfId, "今日充值点数不足领取。" )
		    return
		 end	 
         if ButtonReq[arg1] == 2 then
		    x892002_NotifyTip( sceneId, selfId, "该奖励已领取，无法重复领取。"..Button )
		    return
		 end
		 --空间判断
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 5 then
			x892002_NotifyTip( sceneId, selfId, "道具栏不足5个" )
		   return 
		end
		if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 5 then
			x892002_NotifyTip( sceneId, selfId, "材料栏不足5个" )
			return
		end
		 --处理奖品发送
		  BeginAddItem(sceneId)
		  for i = 1,getn(x892002_g_myitemlist[arg1]) do
	        AddItem( sceneId,x892002_g_myitemlist[arg1][i].GiftItemID, x892002_g_myitemlist[arg1][i].num )
		  end	
	     EndAddItem(sceneId,selfId)
	     AddItemListToHuman(sceneId,selfId)		 
		 ButtonReq[arg1] = 2
		 local nButtnData = tostring(ButtonReq[1])..tostring(ButtonReq[2])..tostring(ButtonReq[3])..tostring(ButtonReq[4])
		 SetMissionData(sceneId,selfId,MD_EVERDATPAYBUTTN,nButtnData)
	     local nMsg = ""
		 for i = 1,getn(x892002_g_myitemlist[arg1]) do
		      nMsg = nMsg.."#G"..x892002_g_myitemlist[arg1][i].num.."#cff0000个#G"..GetItemName(sceneId,x892002_g_myitemlist[arg1][i].GiftItemID)
		 end
		 LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效
		 BroadMsgByChatPipe(sceneId, selfId,format( "#cff0000豪情一掷满江湖。恭喜少侠#{_INFOUSR%s}获赠每日豪礼"..nMsg.."#cff0000，真是羡煞旁人。",GetName(sceneId,selfId)), 4)
		 DispatchUICommand(sceneId,selfId, 88985321)
end

--PS.需要重新回头看下累计充值和那个累计登陆领奖。
--*******************************
--累计充值领奖
--*******************************
function x892002_GetPrizeGift(sceneId,selfId,btnId)
         local ButtnTip = GetMissionData(sceneId,selfId,MD_CUMULATIVEREBUTTN)
		 local MyPrize = GetMissionData(sceneId,selfId,MD_CUMULATIVERECHARGE)
		 local isokTime = {10,30,50,80,100,200,300,500,800,1000,1500,2000,3000,4000,5000}
		 local DangCiName = {"一重豪礼","二重豪礼","三重豪礼","四重豪礼","五重豪礼","一重豪礼","二重豪礼","三重豪礼","四重豪礼","五重豪礼","一重豪礼","二重豪礼","三重豪礼","四重豪礼","五重豪礼",}
		 if MyPrize < isokTime[btnId] then
		    x892002_NotifyTip( sceneId, selfId, "累计充值不足"..isokTime[btnId].."元，无法领取" )
		    return
		 end
		if btnId == ButtnTip then
		    x892002_NotifyTip( sceneId, selfId, "您已领取过了" )
		    return
	    end
		if btnId -1 ~= ButtnTip then
		    x892002_NotifyTip( sceneId, selfId, "请先领取"..DangCiName[btnId-1] )
		    return
	    end 
		 --空间判断
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 5 then
			x892002_NotifyTip( sceneId, selfId, "道具栏不足5个" )
		   return 
		end
		if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 5 then
			x892002_NotifyTip( sceneId, selfId, "材料栏不足5个" )
			return
		end
		for i = 1,getn(x892002_g_PrzieReward_Gifts[btnId]) do
		      for k = 1,x892002_g_PrzieReward_Gifts[btnId][i].num do
			     local Pos = TryRecieveItem(sceneId,selfId,x892002_g_PrzieReward_Gifts[btnId][i].GiftItemID,1)
				 LuaFnItemBind(sceneId,selfId,Pos)
			  end
			--if btnId==12 then
			--   local ret, petGUID_H, petGUID_L = LuaFnCreatePetToHuman(sceneId, selfId, 3317, 1, 0);
			--   LuaFnSetPetData(sceneId,selfId,petGUID_H,petGUID_L,6,random(2000,2200))
			--   LuaFnSetPetData(sceneId,selfId,petGUID_H,petGUID_L,7,random(2000,2200))
			--   LuaFnSetPetData(sceneId,selfId,petGUID_H,petGUID_L,8,3100)
			--   LuaFnSetPetData(sceneId,selfId,petGUID_H,petGUID_L,9,random(2000,2200))
			--   LuaFnSetPetData(sceneId,selfId,petGUID_H,petGUID_L,10,random(2000,2200))
			--   x892002_NotifyTip( sceneId, selfId, "你获得了一只龙龟,请切换场景" )
			--end
		end
		  local nMsg = ""
		  for i = 1,getn(x892002_g_PrzieReward_Gifts[btnId]) do
		      nMsg = nMsg.."#G"..x892002_g_PrzieReward_Gifts[btnId][i].num.."#P个"..GetItemName(sceneId,x892002_g_PrzieReward_Gifts[btnId][i].GiftItemID)
		  end
          LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效
          BroadMsgByChatPipe(sceneId, selfId, format( "#P少侠#{_INFOUSR%s}尽显豪侠风范，参与#Y充值超值赠#P活动，获得#G"..DangCiName[btnId].."#P："..nMsg.."。",GetName(sceneId,selfId)), 4)	  
		  SetMissionData(sceneId,selfId,MD_CUMULATIVEREBUTTN,GetMissionData(sceneId,selfId,MD_CUMULATIVEREBUTTN)+1)
		  x892002_Scripttransitcenter( sceneId, selfId,12 )
	
end

--*******************************
--累计领奖
--*******************************
function x892002_GetLoginGift(sceneId,selfId,btnId)
         local ButtnTip = GetMissionData(sceneId,selfId,MD_DAILYLOGINGIFT)
		 local StartGame = GetMissionData(sceneId,selfId,MD_STARTGAMETIME)
		 local isokTime = {1,3,5,8,12,18}
		 local ButtnTese = {}
		 local value = {1,10,100,1000,10000,100000}
		 for i = 1,6 do
		    ButtnTese[7-i] = mod(floor(ButtnTip/value[i]),10)
		 end		 
		 if GetTime2Day() - StartGame + 1 < isokTime[btnId] then
		    x892002_NotifyTip( sceneId, selfId, "登陆天数不足"..isokTime[btnId].."天，无法领取" )
		    return
		 end
		 if ButtnTese[btnId] == 1 then
		    x892002_NotifyTip( sceneId, selfId, "已经领取，无法重复领取。" )
		    return
		 end
		if LuaFnGetPropertyBagSpace( sceneId, selfId ) < 5 then
			x892002_NotifyTip( sceneId, selfId, "道具栏不足5个" )
		   return 
		end
		if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 5 then
			x892002_NotifyTip( sceneId, selfId, "材料栏不足5个" )
			return
		end		 
		 ButtnTese[btnId] = 1
		 local nButtnData = tostring(ButtnTese[1])..tostring(ButtnTese[2])..tostring(ButtnTese[3])..tostring(ButtnTese[4])..tostring(ButtnTese[5])..tostring(ButtnTese[6])
		 SetMissionData(sceneId,selfId,MD_DAILYLOGINGIFT,tonumber(nButtnData))
		 x892002_LeiJiLoginGame(sceneId,selfId)
		 --处理奖品发送
		  for i = 1,getn(x892002_g_LandReward_Gifts[btnId]) do
		     for k = 1,x892002_g_LandReward_Gifts[btnId][i].num do
			    local nPos = TryRecieveItem(sceneId,selfId,x892002_g_LandReward_Gifts[btnId][i].GiftItemID,1)
				LuaFnItemBind(sceneId,selfId,nPos)
			 end
		  end
          LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效
          BroadMsgByChatPipe(sceneId, selfId, format( "#{_INFOUSR%s}#H锲而不舍连续登陆了#G"..isokTime[btnId].."天#H，终于领取了丰富的奖励。",GetName(sceneId,selfId)), 4)	  
end	 
--*******************************
--累计登陆。
--*******************************
function x892002_LeiJiLoginGame(sceneId,selfId)
         local StartGame = GetMissionData(sceneId,selfId,MD_STARTGAMETIME)
		 local ButtnTip = GetMissionData(sceneId,selfId,MD_DAILYLOGINGIFT)
		 local ButtnTese = {}
		 local value = {1,10,100,1000,10000,100000}
		 for i = 1,6 do
		    ButtnTese[7-i] = mod(floor(ButtnTip/value[i]),10)
		 end
		 BeginUICommand(sceneId)
		 UICommand_AddInt( sceneId,GetTime2Day() - StartGame + 1 )
		 UICommand_AddInt( sceneId,ButtnTese[1])
		 UICommand_AddInt( sceneId,ButtnTese[2])
		 UICommand_AddInt( sceneId,ButtnTese[3])
		 UICommand_AddInt( sceneId,ButtnTese[4])
		 UICommand_AddInt( sceneId,ButtnTese[5])
		 UICommand_AddInt( sceneId,ButtnTese[6])
		 EndUICommand(sceneId )
		 DispatchUICommand(sceneId,selfId, 8925031)
end
--*******************************
--打开网页统一调用
--*******************************
function x892002_OpenLinkWeb(sceneId,selfId,arg1)
         --1 充值
		 local WebLink = {
		[1] = "https://shop441211842.taobao.com/",
		[2] = "https://shop441211842.taobao.com/",
		}
		 BeginUICommand(sceneId)
		 UICommand_AddString( sceneId,WebLink[arg1])
		 EndUICommand(sceneId )
		 DispatchUICommand(sceneId,selfId, 20151126)         
end

--*******************************
--推荐升级地图弹出窗口//累了 就弄到40级吧
--*******************************
function x892002_TuiJianLevelUpScene(sceneId,selfId)
         local MyLevel = GetLevel(sceneId,selfId)
         local nTese_1 = {16,20,25,35,40}
		 local nTest_2 = 0
		 for i = 1,getn(nTese_1) do
		    if MyLevel == nTese_1[i] then
			   nTest_2 = i
			end
		 end
		 if nTest_2 == 0 then
		    return
		 end
		 BeginUICommand(sceneId)
		 UICommand_AddString( sceneId,"   #G您的等级已到达"..MyLevel.."级，是否直接传送至下一个升级地图前往升级呢？")
		 EndUICommand(sceneId )
		 DispatchUICommand(sceneId,selfId, 20200504)
end
function x892002_GoTuiJianLevelUpScene(sceneId,selfId)
         local MyLevel = GetLevel(sceneId,selfId)
         local nTest_1 = {[16]={123,65,65},[20]={168,86,39},[25]={170,102,152},[35]={156,65,65},[40]={159,65,65},[45]={123,65,65},
		                  [50]={123,65,65},[55]={123,65,65},[60]={123,65,65},[65]={123,65,65},[70]={123,65,65},[75]={123,65,65},[80]={123,65,65},
		                  [85]={123,65,65},[90]={123,65,65},[95]={123,65,65},[100]={123,65,65},[105]={123,65,65},[110]={123,65,65},[115]={123,65,65},
		 } 
		 CallScriptFunction( (400900), "TransferFunc", sceneId, selfId, nTest_1[MyLevel][1], nTest_1[MyLevel][2], nTest_1[MyLevel][3] )
end

--*******************************
--宝石转换功能（直接用蝎子的）
--*******************************
function x892002_GemChange(sceneId,selfId,nIndex,GemSel)

local costYuanbao = 99999
local LockOrNot = 0

if nIndex == nil or (nIndex < 30 or nIndex > 59) or GemSel == nil then
   return
end

if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 2 then
   x892002_NotifyTip( sceneId, selfId, "请保持材料栏至少2个空位" )
   return	
end

local OldGemId = LuaFnGetItemTableIndexByIndex(sceneId,selfId,nIndex)

--判断首位是不是宝石
if floor(OldGemId/10^7) ~= 5 then
   x892002_NotifyTip( sceneId, selfId, "仅可放入宝石"..OldGemId )
   return
end

if floor(GemSel/10^7) ~= 5 then
   x892002_NotifyTip( sceneId, selfId, "ERRO!" )
   return
end


--判断几级宝石
if floor(mod(OldGemId,10^6)/10^5) < 5 then
   x892002_NotifyTip( sceneId, selfId, "最低可支持5级宝石转换" )
   return
end

if floor(mod(GemSel,10^6)/10^5) < 5 then
   x892002_NotifyTip( sceneId, selfId, "ERRO" )
   return
end

if floor(mod(OldGemId,10^6)/10^5) ~= floor(mod(GemSel,10^6)/10^5) then
   return
end

   costYuanbao = x892002_g_Cost_YuanBao[floor(mod(GemSel,10^6)/10^5)][1]

--剔除晶石
if floor(mod(OldGemId,1000)/100) ~= 0 or floor(mod(GemSel,1000)/100) ~= 0 then
   x892002_NotifyTip( sceneId, selfId, "暂不支持冥晶石，请拆解后再来" )
   return
end


--如果是晶石
--这里要先判断产物是不是晶石。没必要先判断源石，产物更值钱！
if mod(GemSel,10^5) == 21001 or mod(GemSel,10^5) == 21002 or mod(GemSel,10^5) == 21003 or mod(GemSel,10^5) == 21004 then
   if mod(OldGemId,10^5) ~= 21001 and mod(OldGemId,10^5) ~= 21002 and mod(OldGemId,10^5) ~= 21003 and mod(OldGemId,10^5) ~= 21004 then
   x892002_NotifyTip( sceneId, selfId, "ERRO" )
   return
   end
   costYuanbao = x892002_g_Cost_YuanBao[floor(mod(OldGemId,10^6)/10^5)][2]
end
 
--如果是纯净石头
--同样是先判断产物
if mod(GemSel,10000) == 2005 or mod(GemSel,10000) == 2006 or mod(GemSel,10000) == 2007 or mod(GemSel,10000) == 2008 then
   if mod(OldGemId,10000) ~= 2005 and mod(OldGemId,10000) ~= 2006 and mod(OldGemId,10000) ~= 2007 and mod(OldGemId,10000) ~= 2008 then
   x892002_NotifyTip( sceneId, selfId, "ERRO" )
   return
   end
end

--前面判断都通过，剩下的没啥正经石头，一个价，客户端是否被修改，毫无意义
local yuanItem = GetBagItemTransfer( sceneId, selfId, nIndex )
if LuaFnGetItemBindStatus(sceneId,selfId,nIndex) ==1 then
   LockOrNot = 1
end

--判断元宝
local myYuanbao = YuanBao(sceneId,selfId,targetId,3,0)
  if myYuanbao < costYuanbao then
    x892002_NotifyTip( sceneId, selfId,"您元宝不足"..costYuanbao.."点" )	
  return
  end	

--删除宝石
if  LuaFnEraseItem(sceneId,selfId,nIndex) ~= 1 then
   x892002_NotifyTip( sceneId, selfId, "源宝石删除失败了，骚年！" )
   return
end

--扣钱+二次判断
    local strun =  YuanBao(sceneId,selfId,targetId,2,costYuanbao)	
    if strun ~= 0 then
	x892002_NotifyTip( sceneId, selfId,"您元宝不足"..costYuanbao.."点" )	
	return
    end

--删除成功，给宝石
   x892002_NotifyTip( sceneId, selfId, "转换成功，您获得了#{_ITEM"..GemSel.."}" )
   local pos = TryRecieveItem( sceneId, selfId, GemSel, 1 )
   local transfer = GetBagItemTransfer(sceneId,selfId,pos)
   if LockOrNot ~= 0 then
	LuaFnItemBind( sceneId, selfId, pos )
   end
   LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 148, 0) --特效

--上电视
    local str = ""
    str = format( "#{_INFOUSR%s}#H在洛阳#R彭怀玉#H处花费#W"..costYuanbao.."点元宝#H将#{_INFOMSG%s1}#H转换成了#{_INFOMSG%s2}#H。",GetName(sceneId,selfId),yuanItem,transfer)
    BroadMsgByChatPipe( sceneId, selfId,str, 4 )
	
end


function x892002_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end