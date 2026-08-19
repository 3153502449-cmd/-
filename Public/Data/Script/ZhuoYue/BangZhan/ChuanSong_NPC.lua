----------------------------
-------进入帮战NPC ，入口NPC  by 卓越QQ：314696597
----------------------------
x889633_g_scriptId = 889633
x889633_g_BZscriptId = 889630  ---帮战脚本

cs_int = { {390,256,157},{390,160,256},{390,60,160},{390,160,55} } --- 一共四组坐标
BZsceneId = 390
x889630_g_Back_scene,x889630_g_Back_X ,x889630_g_Back_Z =0,91,177   -------出副本的场景坐标
--**********************************
--
--**********************************
function x889633_OnDefaultEvent( sceneId, selfId,targetId)
	 
	if sceneId ==BZsceneId then
		BeginEvent(sceneId)
		AddText( sceneId, " 帮战之地，是非多 ，经常遇到打到头破血流之人，老夫实在不忍心，与于占地为王，开了这间诊所，你懂的，不给钱，我是不会给你治疗的！" )		
		--AddNumText(sceneId,x889633_g_scriptId,"满血满怒",6,11)
		AddNumText(sceneId,x889633_g_scriptId,"返回洛阳",6,14)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)		
	else
		local kss,ksf,jiss,jisf = CallScriptFunction( x889633_g_BZscriptId, "shjjianret",sceneId)  ---调用脚本
		BeginEvent(sceneId)
		AddText( sceneId, "  #P每日帮战时间为：#G"..kss.."时"..ksf.."分#P开始至#G"..jiss.."时"..jisf.."分#P结束" )  
		AddText( sceneId, "  本帮战精心制作，最多支持四个帮会争夺，玩法跟官方雄霸和凤凰争霸相似，结束后，胜利帮会成员每人将会获得大量绑元奖励")
	
		AddNumText(sceneId,x889633_g_scriptId,"进入帮战战场",10,0)
		AddNumText(sceneId,x889633_g_scriptId,"帮战奖励说明",11,3)
		AddNumText(sceneId,x889633_g_scriptId,"帮战规则说明",11,4)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	end
end
 
function x889633_OnEventRequest( sceneId, selfId, targetId, eventId)
	local myxz = GetNumText()
	if myxz == 0 then
		local isok,duojiukaishi,yikaishiTime,duojiujieshu,yiguotime = CallScriptFunction( x889633_g_BZscriptId, "GetTimer",sceneId)  ---调用脚本
		local guildid = GetHumanGuildID(sceneId,selfId)
		local GuildName = LuaFnGetGuildName(sceneId, selfId)
		if isok == 0 then
			if  yiguotime== -1 then 				
			x889633_BoxTip( sceneId, selfId, targetId,"非活动时间,帮战还未开始，距离帮战开启时间还有#G"..duojiukaishi.."分钟")
			elseif  duojiukaishi== -1 then 
			x889633_BoxTip( sceneId, selfId, targetId,"非活动时间,今天的帮战在#G"..yiguotime.."#W分钟前已经打完了")					
			end
			return
		end
		----判断帮会
		if  GuildName == ""  or  guildid == -1  then
			x889633_BoxTip( sceneId, selfId, targetId,"必须要有一个帮会才能进入帮战！！")
			return
		end
		local zhuzu,key = x889633_chazhaoTxt(sceneId,selfId)
		if key ~= -1 then
			if  zhuzu[key].guildId == guildid then
				local cskey = zhuzu[key].guildPos
				NewWorld( sceneId, selfId ,cs_int[cskey][1], cs_int[cskey][2],cs_int[cskey][3] )
			end
		elseif getn(zhuzu) == 4 then
			x889633_BoxTip( sceneId, selfId, targetId,"参与帮战的帮会已满，下次请早")
			return
		else
			local zhuzucdu = getn(zhuzu)+1
			x889633_SetText(sceneId,selfId,2,0,zhuzucdu )
			NewWorld( sceneId, selfId ,cs_int[zhuzucdu][1], cs_int[zhuzucdu][2],cs_int[zhuzucdu][3] )
		end
	elseif  myxz == 11 then
	RestoreHp( sceneId, selfId )
	RestoreMp( sceneId, selfId )
	RestoreRage( sceneId, selfId)
	x889633_tips(sceneId,selfId,"您已经回复好所有战斗力" )	
	elseif  myxz == 14 then
		BeginEvent(sceneId)
		AddText( sceneId, "确定要返回，不留恋一会吗？" )
		AddText( sceneId, "#G注意：重进战场将清空个人战绩" )
		AddNumText(sceneId,x889633_g_scriptId,"确定不废话",6,15)
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif  myxz == 15 then
		x889633_tips(sceneId,selfId,"一路走好！" )
		NewWorld( sceneId, selfId ,x889630_g_Back_scene,x889630_g_Back_X,x889630_g_Back_Z )	

    elseif  myxz == 3 then	
		 local ji1,ji2,ji3,ji4 = CallScriptFunction( x889633_g_BZscriptId, "jiangliret",sceneId)  ---调用脚本
	     BeginEvent(sceneId)
          AddText( sceneId, "帮战结束由系统自动发放奖励" )
		  AddText( sceneId, "请注意系统提示，查收奖励" )
		  AddText( sceneId, "#cFF0000注意：#r#G战场#cFF0000个人积分为零#G的玩家将不获得任何奖励(主要指小混混)#r" )
          AddText( sceneId, "#Y胜利帮会第一名每人奖励"..ji1.."绑元#r" )
		  AddText( sceneId, "#Y胜利帮会第二名每人奖励"..ji2.."绑元#r" )
		  AddText( sceneId, "#Y胜利帮会第三名每人奖励"..ji3.."绑元#r" )
		  AddText( sceneId, "#Y胜利帮会第四名每人奖励"..ji4.."绑元#r" )
         
         EndEvent(sceneId)
         DispatchEventList(sceneId,selfId,targetId)			
	elseif  myxz == 4 then	
	     BeginEvent(sceneId)
          --AddText( sceneId, "#cFF0000本系统由添加#r" )
          AddText( sceneId, "#Y本系统仿官方雄霸和凤凰争霸赛制作而成#r" )
          AddText( sceneId, "#Y每杀一个人加5点积分，每打掉一个水晶加50点积分#r" )
          AddText( sceneId, "#Y有人杀人，有水晶就打水晶，弱势帮努力打水晶也有可能获第一名#r" )
          AddText( sceneId, "#Y增加刷小号判断，具体怎么判断我不会说，脱装备刷已成过去!" ) 
         EndEvent(sceneId)
         DispatchEventList(sceneId,selfId,targetId)			
	end
	
end
--**********************************
--
--**********************************
function x889633_BoxTip( sceneId, selfId, targetId,txt)
	BeginEvent(sceneId)
	AddText( sceneId, txt )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

---------------帮战排行-------------------
function x889633_BZpaiming(sceneId)
	local shuzu = x889633_readTxt(sceneId)
	if shuzu[1] == nil then
		return shuzu , -1
	end
	
	for i = 1, getn(shuzu) do
		for j = 1, i do
			if shuzu[i].guildJiFen > shuzu[j].guildJiFen  then
				local temp ={}
                temp[1] = shuzu[i]
				shuzu[i] = shuzu[j]
				shuzu[j] = temp[1]
			end
		end
	end
	return shuzu , 1
end

-------------------------------------------------------------
function x889633_chazhaoTxt(sceneId,selfId)
	local guildId = GetHumanGuildID(sceneId,selfId)
	local shuzu  = x889633_readTxt(sceneId)
	if shuzu[1] == nil then
		return shuzu , -1
	end
	local key = 0
	for i=1 ,getn(shuzu)  do
		if shuzu[i].guildId == guildId then
			key = i
			return shuzu,key
		end
	end
	return shuzu , -1
end
function x889633_SetText(sceneId,selfId,biaozhi,jifen,pos )-------参数，
	----GuildName 帮名 guildId 帮ID  guildJiFen 帮积分 guildPos 帮位置
	local guildId = GetHumanGuildID(sceneId,selfId)
	local GuildName = LuaFnGetGuildName(sceneId, selfId)
	local allguild,key =x889633_chazhaoTxt(sceneId,selfId)
	if key ~= -1 then
		if biaozhi ==1 then
			allguild[key].guildJiFen =allguild[key].guildJiFen+jifen
		elseif biaozhi ==2 then
			allguild[key].guildPos = pos
		end
	end
	
	---------------------------首次
	if  key == -1 then
		 
		local guildJF,guildPs = 0,0
		if biaozhi == 1 then
			guildJF = jifen
		elseif 	biaozhi == 2 then
			guildPs = pos
		end
		if allguild[1] == nil then
			 
			allguild[1] = { GuildName=GuildName ,guildId=guildId ,guildJiFen=guildJF,guildPos=guildPs }
		else
			allguild[getn(allguild)+1] = { GuildName=GuildName ,guildId=guildId,guildJiFen=guildJF,guildPos=guildPs }
		end
		
	end
	---------------------------------
	local mystring = ""
	local xuhuannumber = getn(allguild)
	for i = 1,xuhuannumber do
		if i ~= xuhuannumber then
			mystring = mystring..allguild[i].GuildName.."\n"..allguild[i].guildId.."\n"..allguild[i].guildJiFen.."\n"..allguild[i].guildPos.."\n"
		else
			mystring = mystring..allguild[i].GuildName.."\n"..allguild[i].guildId.."\n"..allguild[i].guildJiFen.."\n"..allguild[i].guildPos
		end
	end
	
	local Coldfile = openfile("./ZY_DataBase/BangZhan/bangzhan.txt", "w")
	if Coldfile and nil ~= Coldfile then
		if mystring == nil then
			mystring = ""
		end
		write(Coldfile, mystring)
		closefile(Coldfile)
	end
	return 1 ---返回成功
end

function x889633_readTxt(sceneId)
	local savetxt = openfile("./ZY_DataBase/BangZhan/bangzhan.txt", "r")
	local Myall = {}
	if savetxt and nil ~= savetxt then
		for i=1, 20  do
			local line1=read(savetxt, "*l")
			if line1==nil then
				break
			end
			local line2=read(savetxt, "*l")
			if line2==nil then
				break
			end
			local line3=read(savetxt, "*l")
			if line3==nil  then
				break
			end
			local line4=read(savetxt, "*l")
			if line4==nil  then
				break
			end
			Myall[i] = {GuildName = line1, guildId = tonumber(line2),guildJiFen = tonumber(line3),guildPos = tonumber(line4)}
		end
		closefile(savetxt)
	else		 
		AddGlobalCountNews(sceneId,"帮战系统 文档bangzhan.txt不存在或打开失败")
		return
	end
	
	return Myall
end


function x889633_tips(sceneId,selfId,text )
	BeginEvent(sceneId)
	AddText( sceneId, text)
	EndEvent(sceneId)
	DispatchMissionTips( sceneId, selfId )
end

--------------清空文档------------
function x889633_qingkong(sceneId )
	local Coldfile = openfile("./ZY_DataBase/BangZhan/bangzhan.txt", "w")
	if Coldfile and nil ~= Coldfile then
		local mystring = ""
		write(Coldfile, mystring)
		closefile(Coldfile)
	end
	
end
