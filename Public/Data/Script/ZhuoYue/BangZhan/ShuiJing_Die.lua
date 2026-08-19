x889632_g_scriptId = 889632
------  MD_BZ_JF 设置为个人帮战积分
function x889632_OnDefaultEvent(sceneId, selfId,targetId)
	local targetGampID = GetUnitCampID(sceneId, targetId, targetId )
	local mmyGampID = GetUnitCampID(sceneId, selfId, selfId )
	if targetGampID == mmyGampID then 
		BeginEvent( sceneId )
		AddText( sceneId,"请保护好我！")
		EndEvent( sceneId )
		DispatchEventList(sceneId,selfId,targetId)
	else 
	    BeginEvent( sceneId )
		AddText( sceneId,"打掉我你就有积分了！")
		EndEvent( sceneId )
		DispatchEventList(sceneId,selfId,targetId)
	end
end	

function x889632_OnDie( sceneId, dieID, killId )
	--杀死怪物的是宠物则获取其主人的名字....
	local killerId = -1
	local objType = GetCharacterType( sceneId, killId )
	if objType == 3 then
		killerId = GetPetCreator( sceneId, killId )
	elseif objType ==1 then
		killerId = killId
	else
		x889632_CtreateSJ( sceneId, dieID,-1 )
		return
	end
	
	if LuaFnIsObjValid( sceneId, killerId ) ~= 1 and LuaFnIsCanDoScriptLogic( sceneId, killerId ) ~= 1 then
		x889632_CtreateSJ( sceneId, dieID,-1 )
		return
	end
	
	local SJ_JF = 50  ---打掉一个水晶的积分	
	-----给帮派加积分
	CallScriptFunction( 889633, "SetText",sceneId,killerId,1,SJ_JF)  ---调用脚本
	-----给个人加积分
	local MyJF = GetMissionData( sceneId, killerId, MF_BZ_JIFEN)
	SetMissionData( sceneId, killerId, MF_BZ_JIFEN,MyJF+SJ_JF)
	-----刷新水晶和公告
	x889632_CtreateSJ( sceneId,dieID,killerId )
end


-----死亡，水晶创造脚本
function x889632_CtreateSJ( sceneId,dieID,killerId )
	local Xpos,Zpos = GetWorldPos(sceneId,dieID)
	local MosDataID = GetMonsterDataID( sceneId, dieID )
	if killerId == -1 then
		LuaFnCreateMonster( sceneId, MosDataID, Xpos, Zpos, 7 ,-1 , x889632_g_scriptId )
	else
		local MobjID = LuaFnCreateMonster( sceneId, MosDataID, Xpos, Zpos, 7 ,-1 , x889632_g_scriptId )
		if MobjID~=nil and MobjID >0 then
			local mmyGampID = GetUnitCampID(sceneId, killerId, killerId )
			 
			local GuildName = LuaFnGetGuildName(sceneId, killerId)
			SetUnitCampID(sceneId, MobjID, MobjID,mmyGampID)
			SetCharacterTitle( sceneId,MobjID,GuildName.."帮派占领的水晶")
		end
	end
	
	x889632_GongGao( sceneId,dieID, killerId ) --公告
end
-------------公告系统--------------
function x889632_GongGao( sceneId,dieID,killerId)
	local Xpos,Zpos = GetWorldPos(sceneId,dieID)
	local str
	local GuildID = -1
	if killerId== -1 then
		str = "坐标["..Xpos.." ,"..Zpos.."],水晶已经刷新！"
	else
		local GuildName = LuaFnGetGuildName(sceneId, killerId)
		GuildID = GetHumanGuildID(sceneId,killerId)
		local selfName = GetName(sceneId,killerId)		
		str = "坐标["..Xpos.." ,"..Zpos.."],水晶已被["..GuildName.."]帮派占领！"
		local sMessage = format("@*;SrvMsg;GLD:#W本帮主力#R%s#W在帮战中已经打掉坐标["..Xpos.." ,"..Zpos.."]的水晶,本帮积分增加50点！", selfName);	
	    BroadMsgByChatPipe(sceneId, killerId, sMessage,6); --6 是帮呗
	end
	local nHumanCount = LuaFnGetCopyScene_HumanCount(sceneId)
	if nHumanCount >=1 then
		for i=1, nHumanCount do
			local nHumanId = LuaFnGetCopyScene_HumanObjId(sceneId, i-1)
			if LuaFnIsObjValid( sceneId, nHumanId ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, nHumanId ) == 1 then
				if GuildID == GetHumanGuildID(sceneId,nHumanId) then 
                local selfName =GetName(sceneId,killerId)					
				BeginEvent( sceneId )
				if nHumanId==killerId then
				AddText( sceneId,"您打掉一座水晶,本帮积分增加50点,个人积分增加50点")	
				else
				AddText( sceneId,"我帮英雄["..selfName.."]已经打掉坐标["..Xpos.." ,"..Zpos.."]的水晶,本帮积分增加50点")	
				end	
				EndEvent( sceneId )
				DispatchMissionTips( sceneId, nHumanId )
				else
				BeginEvent( sceneId )
				AddText( sceneId,str)
				EndEvent( sceneId )
				DispatchMissionTips( sceneId, nHumanId )
				end 
			end
		end
	end
end
