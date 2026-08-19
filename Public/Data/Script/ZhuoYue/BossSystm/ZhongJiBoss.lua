--脚本号
x892380_g_scriptId = 892380

x892380_g_AllBoss = {5}
--##18是场景ID，参考SceneInfo.ini

--##这里是系统公告，根据分组ID发布公告，同一组BOSS只发布一次
x892380_g_BossSysMsgByGroupID={}
x892380_g_BossSysMsgByGroupID[1]={Msg="#cFF0000终极怪物，六道魔尊降临#G镜湖#cFF0000顿时火光四起，电闪雷鸣，#G六道魔尊#cFF0000携带了#G重楼#cFF0000。杀死他后有机会获得奖励，当然，六道魔尊杀戮成性，请玩家整个帮会前往！",isSended=0}
x892380_g_AllBoss[5]=
{	
	{ ID=55028, GroupId=1, Title="六道·魔尊#r#611", PosX=108,  PosY=149, BaseAI=27, ExtAIScript=290, ScriptID=892380 },

}

--##场景地图要加一个NPC，来触发脚本,如yannan_monster.ini，scripttimer是脚本回调时间，60000为60秒调用一次脚本
-- [monster142]
-- guid=9913082
-- type=0
-- pos_x=0
-- pos_z=0
-- dir=27
-- script_id=892380
-- respawn_time=1800000
-- base_ai=3
-- scripttimer=60000		
-- group_id=-1
-- team_id=-1
-- patrol_id=-1
-- shop0=-1
-- shop1=-1
-- shop2=-1
-- shop3=-1
-- ReputationID=-1
--**********************************
--刷怪逻辑
--**********************************
function x892380_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nHour	 = GetHour()--小时
	local nMinute = GetMinute()--分钟
	
	if sceneId==5 then	--##玄海01:20 04:20 07:20 10:20 13:20 16:20 19:20 22:20 
		if (nHour==21 and nMinute==45) then --##21点半和12点半刷雁南的怪
			x892380_CreateMonster( sceneId )	--刷怪
		end
	end
end

--**********************************
--刷BOSS
--**********************************
function x892380_CreateMonster( sceneId )
	--##重置公告标识
	--for j,msgData in x892380_g_BossSysMsgByGroupID do 
	--	msgData.isSended=0
	--end
	--刷怪前如果怪存在的话全部清空，再刷
	for i,data in x892380_g_AllBoss[sceneId] do
		local nMonsterNum = GetMonsterCount(sceneId)
		for i=0, nMonsterNum-1 do
			local MonsterId = GetMonsterObjID(sceneId,i)
			local MosDataID = GetMonsterDataID( sceneId, MonsterId )
			if MosDataID == data.ID then
				--清怪
				LuaFnDeleteMonster(sceneId, MonsterId)
			end		
		end
	end
	--刷怪
	for i,data in x892380_g_AllBoss[sceneId] do
		local MstId = LuaFnCreateMonster(sceneId, data.ID, data.PosX, data.PosY, data.BaseAI, data.ExtAIScript, data.ScriptID )
		SetCharacterTitle(sceneId, MstId, data.Title)
	end

    AddGlobalCountNews( sceneId, x892380_g_BossSysMsgByGroupID[1].Msg )	
	
end
function x892380_OnDie( sceneId, selfId, killerId )
	
	local playerName = GetName( sceneId, killerId )
	local playerID = killerId
	local objType = GetCharacterType( sceneId, selfId )
	if objType == 3 then --如果是宠物的话，把这个ID设置成主人ID
		playerID = GetPetCreator( sceneId, killerId )
		playerName = GetName( sceneId, playerID )
	end
	
	local num = LuaFnGetCopyScene_HumanCount( sceneId )
	local mems = {}
	for i = 0, num - 1 do
		mems[i] = LuaFnGetCopyScene_HumanObjId( sceneId, i )
		if LuaFnIsObjValid( sceneId, mems[i] ) == 1 and LuaFnIsCanDoScriptLogic( sceneId, mems[i] ) == 1 and LuaFnIsCharacterLiving( sceneId, mems[i] ) == 1 then					-- 不在场景的不做此操作
			if  mems[i] ~= killerID  and  GetLevel( sceneId, mems[i] )>=89  then
				TryRecieveItem( sceneId, mems[i],39000020, 1 )
				BeginEvent(sceneId)
					AddText(sceneId, "获得了 10元充值点")
				EndEvent(sceneId)
				DispatchMissionTips(sceneId, mems[i])
			end	
		end
	end
	
	ItemID ={10553101,10553102,10553100,10553110,10553108}
	i=random(1,5)
	local BagIndex = TryRecieveItem( sceneId, playerID,ItemID[i], 1 ) 
	
	if BagIndex ~= -1 then 
		local szTransfer = GetBagItemTransfer( sceneId,playerID,BagIndex) 
		local msg = format("#cFF0000束河古镇:#P在经过一番激烈的战斗,#{_INFOUSR%s}脱颖而出,最后一击斩获了#Y #{_INFOMSG%s}#P！#P。",playerName,szTransfer)
		AddGlobalCountNews( sceneId, msg )
	end
 
end
--**********************************
--系统公告
--**********************************
function x892380_SysMsg( sceneId, groupId )
	if x892380_g_BossSysMsgByGroupID[groupId].isSended==0 then
		AddGlobalCountNews( sceneId, x892380_g_BossSysMsgByGroupID[groupId].Msg )
		x892380_g_BossSysMsgByGroupID[groupId].isSended=1
	end
end

--**********************************
--对话窗口信息提示
--**********************************
function x892380_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x892380_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--关闭对话框
--**********************************
function x892380_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end