--脚本号
x892390_g_scriptId = 892390

x892390_g_AllBoss = {35}
--##18是场景ID，参考SceneInfo.ini

--##这里是系统公告，根据分组ID发布公告，同一组BOSS只发布一次
x892390_g_BossSysMsgByGroupID={}
x892390_g_BossSysMsgByGroupID[1]={Msg="#cFF0000野外BOSS#W：#P江湖传闻#G琼州#P出现#G琼州鳄鱼#P的身影,请江湖侠义人士前去击杀,为民除害#P。#G[263,241] [258,197] [205,276] [195,215] [65,200] [252,60] [139,78] [165,102] [172,177] [108,107]",isSended=0}
x892390_g_AllBoss[35]=
{	
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=263,  PosY=241, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
    { ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=258,  PosY=197, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=205,  PosY=276, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=195,  PosY=215, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=65,  PosY=200, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=252,  PosY=60, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=139,  PosY=78, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=165,  PosY=102, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=172,  PosY=177, BaseAI=21, ExtAIScript=209, ScriptID=892390 },
	{ ID=55039, GroupId=1, Title="琼州·霸主#r#608", PosX=108,  PosY=107, BaseAI=21, ExtAIScript=209, ScriptID=892390 },

}

--##场景地图要加一个NPC，来触发脚本,如yannan_monster.ini，scripttimer是脚本回调时间，60000为60秒调用一次脚本
-- [monster142]
-- guid=9913082
-- type=0
-- pos_x=0
-- pos_z=0
-- dir=27
-- script_id=892390
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
function x892390_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nHour	 = GetHour()--小时
	local nMinute = GetMinute()--分钟
	
	if sceneId==35 then	
	 if (nHour==0 and nMinute==30)  or
	    (nHour==10 and nMinute==30)  or 
		(nHour==15 and nMinute==30)  or 
		(nHour==20 and nMinute==30)  then
			x892390_CreateMonster( sceneId )	--刷怪
		end
	end
	--AddGlobalCountNews( sceneId, nMinute )
	--取消时钟
	--SetCharacterTimer( sceneId, objId, 0 )
end

--**********************************
--刷BOSS
--**********************************
function x892390_CreateMonster( sceneId )
	--##重置公告标识
	--for j,msgData in x892390_g_BossSysMsgByGroupID do 
	--	msgData.isSended=0
	--end
	--刷怪前如果怪存在的话全部清空，再刷
	for i,data in x892390_g_AllBoss[sceneId] do
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
	for i,data in x892390_g_AllBoss[sceneId] do
		local MstId = LuaFnCreateMonster(sceneId, data.ID, data.PosX, data.PosY, data.BaseAI, data.ExtAIScript, data.ScriptID )
		SetCharacterTitle(sceneId, MstId, data.Title)
		--x892390_SysMsg( sceneId, data.GroupId )
		
		
		
	end

    AddGlobalCountNews( sceneId, x892390_g_BossSysMsgByGroupID[1].Msg )	
	
end

--**********************************
--系统公告
--**********************************
function x892390_SysMsg( sceneId, groupId )
	if x892390_g_BossSysMsgByGroupID[groupId].isSended==0 then
		--BroadMsgByChatPipe( sceneId, 0, x892390_g_BossSysMsgByGroupID[groupId].Msg, 4 )
		AddGlobalCountNews( sceneId, x892390_g_BossSysMsgByGroupID[groupId].Msg )
		x892390_g_BossSysMsgByGroupID[groupId].isSended=1
	end
end

--**********************************
--对话窗口信息提示
--**********************************
function x892390_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x892390_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--关闭对话框
--**********************************
function x892390_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end