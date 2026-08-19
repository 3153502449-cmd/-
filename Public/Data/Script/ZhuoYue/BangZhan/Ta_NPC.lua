
x889631_g_scriptId = 889631
x889631_g_BZscriptId = 889630
function x889631_OnDefaultEvent( sceneId, selfId,targetId)
	local mycamp = GetUnitCampID(sceneId, selfId, selfId)
	if mycamp == GetUnitCampID(sceneId, targetId, targetId) then 
	BeginEvent(sceneId)
	AddText( sceneId, "  #P放心，我会保护好你们的，谁过来，我就送他一个字#G ”死“ " )
		AddNumText(sceneId,x889631_g_scriptId,"查看帮派排名",6,12)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	else
	BeginEvent(sceneId)
	AddText( sceneId, "  #P战场守卫自动开启到您的复活点附近 ，开启后，我就会保护我们帮了。 #r #G注意：战场守卫每个帮只能开启一个，建议开启复活点的守卫！" )
		--AddNumText(sceneId,x889631_g_scriptId,"开启战场守卫",6,13)
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
	end
	
end

function x889631_OnEventRequest( sceneId, selfId, targetId, eventId)
	local myxz = GetNumText()
	if  myxz == 12 then
		local shuzu ,key = x889631_BZpaiming(sceneId)
		if key== -1 then
			x889631_BoxTip( sceneId, selfId, targetId,"暂无排行")
			return
		else
			local bcount = getn(shuzu)
			local isok,duojiukaishi,yikaishiTime,duojiujieshu,yiguotime = CallScriptFunction( x889631_g_BZscriptId, "GetTimer",sceneId)
			local a = "姓名:"..GetName(sceneId,selfId).."  离结束还有:#G"..duojiujieshu.."#W 分钟"
			local b = "参战帮数:#G"..bcount.."#W个#r#cFF0000温馨提示:中途退出将清空个人战绩#r"
			local c = "            #Y帮战排行#r"
			local d = "个人积分:#G"..GetMissionData( sceneId, selfId, MF_BZ_JIFEN).."分"
			local e = "个人连斩:#G"..GetMissionData( sceneId, selfId, MF_BZ_LIANZHAN).."人"
			local f = "总杀人数:#G"..GetMissionData( sceneId, selfId, MF_BZ_MYKILL).."人#r"
			BeginEvent(sceneId)
			AddText( sceneId, a )
			AddText( sceneId, b )
			AddText( sceneId, d )
			AddText( sceneId, e )
			AddText( sceneId, f )
			AddText( sceneId, c )
			for i= 1  ,bcount do
				if shuzu[1].guildJiFen <1 then					 
					AddText( sceneId, "#b目前战斗正在激烈进行，大家都没有得分所以没有排名！ " )
					break
				end
				
				if i ==1 then
					AddText( sceneId,"#b第#cFF0000"..i.."#W名:#cFF0000"..shuzu[1].GuildName.."  #W积分#G："..shuzu[1].guildJiFen)
				elseif i==2 then
					AddText( sceneId,"第#cff66cc"..i.."#W名#cff6633:"..shuzu[2].GuildName.."    #W积分#G："..shuzu[2].guildJiFen)
				elseif i==3 then
					AddText( sceneId,"第#cff6633"..i.."#W名#cff6633:"..shuzu[3].GuildName.."    #W积分#G："..shuzu[3].guildJiFen)
				elseif i==4 then
					AddText( sceneId,"第#G"..i.."#W名:"..shuzu[4].GuildName.." #w积分#G："..shuzu[4].guildJiFen)
				end

			end
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	elseif  myxz == 13 then  -----战场守卫塔
		if x889631_creatTa( sceneId, selfId, targetId) ==1 then 
		x889631_BoxTip( sceneId, selfId, targetId,"守卫开启成功！敌帮过来，将被秒杀！")	
		end
	end
	
end

function x889631_creatTa( sceneId, selfId, targetId)
	local nMonsterNum = GetMonsterCount(sceneId)
	local targetDataID = GetMonsterDataID(sceneId, targetId )
	local mycamp = GetUnitCampID(sceneId, selfId, selfId)
	for i=1,nMonsterNum do
		local MonsterId = GetMonsterObjID(sceneId,i-1)
		local MonsetrCamp = GetUnitCampID(sceneId, MonsterId, MonsterId)
		local MosDataID = GetMonsterDataID(sceneId, MonsterId )
		if MosDataID == targetDataID and  MonsetrCamp == mycamp  then
			x889631_BoxTip( sceneId, selfId, targetId,"贵帮守卫已开启，无法重复开启！")
			return -1
		end
	end
	
	SetUnitCampID(sceneId, targetId, targetId,mycamp)
	local GuildName = LuaFnGetGuildName(sceneId, selfId)
	SetCharacterName( sceneId,targetId,GuildName.."帮的守卫塔")	
	return 1
end

---------------帮战排行-------------------
function x889631_BZpaiming(sceneId)
	local shuzu = x889631_readTxt(sceneId)
	if shuzu[1] == nil then
		return shuzu , -1
	end
	local cdnum = getn(shuzu)
	if cdnum == 1 then 
	    return shuzu , 1	
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

function x889631_readTxt(sceneId)
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


function x889631_tips(sceneId,selfId,text )
	BeginEvent(sceneId)
	AddText( sceneId, text)
	EndEvent(sceneId)
	DispatchMissionTips( sceneId, selfId )
end
function x889631_BoxTip( sceneId, selfId, targetId,txt)
	BeginEvent(sceneId)
	AddText( sceneId, txt )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end











