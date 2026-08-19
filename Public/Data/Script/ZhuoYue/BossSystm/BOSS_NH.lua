--脚本号
x892389_g_scriptId = 892389

x892389_g_AllBoss = {34}
--##18是场景ID，参考SceneInfo.ini

--##这里是系统公告，根据分组ID发布公告，同一组BOSS只发布一次
x892389_g_BossSysMsgByGroupID={}
x892389_g_BossSysMsgByGroupID[1]={Msg="#cFF0000野外BOSS#W：#P江湖传闻#G南海#P出现#G南海恶霸#P的身影,请江湖侠义人士前去击杀,为民除害#P。#G[31,81] [63,135] [128,234] [164,257] [221,192] [160,103] [200,61] [211,239] [135,160] [116,61]",isSended=0}
x892389_g_AllBoss[34]=
{	
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=31,  PosY=81, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
    { ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=63,  PosY=135, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=128,  PosY=234, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=164,  PosY=257, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=221,  PosY=192, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=160,  PosY=103, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=200,  PosY=61, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=211,  PosY=239, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=135,  PosY=160, BaseAI=21, ExtAIScript=209, ScriptID=892389 },
	{ ID=55038, GroupId=1, Title="南海·霸主#r#609", PosX=116,  PosY=61, BaseAI=21, ExtAIScript=209, ScriptID=892389 },

}

--##场景地图要加一个NPC，来触发脚本,如yannan_monster.ini，scripttimer是脚本回调时间，60000为60秒调用一次脚本
-- [monster142]
-- guid=9913082
-- type=0
-- pos_x=0
-- pos_z=0
-- dir=27
-- script_id=892389
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
function x892389_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nHour	 = GetHour()--小时
	local nMinute = GetMinute()--分钟
	
	if sceneId==34 then	
	 if (nHour==8 and nMinute==0)  or
	    (nHour==13 and nMinute==0)  or 
		(nHour==18 and nMinute==0)  or 
		(nHour==22 and nMinute==30)  then 
			x892389_CreateMonster( sceneId )	--刷怪
		end
	end
	--AddGlobalCountNews( sceneId, nMinute )
	--取消时钟
	--SetCharacterTimer( sceneId, objId, 0 )
end

--**********************************
--刷BOSS
--**********************************
function x892389_CreateMonster( sceneId )
	--##重置公告标识
	--for j,msgData in x892389_g_BossSysMsgByGroupID do 
	--	msgData.isSended=0
	--end
	--刷怪前如果怪存在的话全部清空，再刷
	for i,data in x892389_g_AllBoss[sceneId] do
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
	for i,data in x892389_g_AllBoss[sceneId] do
		local MstId = LuaFnCreateMonster(sceneId, data.ID, data.PosX, data.PosY, data.BaseAI, data.ExtAIScript, data.ScriptID )
		SetCharacterTitle(sceneId, MstId, data.Title)
		--x892389_SysMsg( sceneId, data.GroupId )
		
		
		
	end

    AddGlobalCountNews( sceneId, x892389_g_BossSysMsgByGroupID[1].Msg )	
	
end

--**********************************
--系统公告
--**********************************
function x892389_SysMsg( sceneId, groupId )
	if x892389_g_BossSysMsgByGroupID[groupId].isSended==0 then
		--BroadMsgByChatPipe( sceneId, 0, x892389_g_BossSysMsgByGroupID[groupId].Msg, 4 )
		AddGlobalCountNews( sceneId, x892389_g_BossSysMsgByGroupID[groupId].Msg )
		x892389_g_BossSysMsgByGroupID[groupId].isSended=1
	end
end

--**********************************
--对话窗口信息提示
--**********************************
function x892389_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x892389_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--关闭对话框
--**********************************
function x892389_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end