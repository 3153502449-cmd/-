--脚本号
x892382_g_scriptId = 892382

x892382_g_AllBoss = {8}
--##18是场景ID，参考SceneInfo.ini

--##这里是系统公告，根据分组ID发布公告，同一组BOSS只发布一次
x892382_g_BossSysMsgByGroupID={}
x892382_g_BossSysMsgByGroupID[1]={Msg="#cFF0000野外BOSS#W：#P江湖传闻#G敦煌#P出现#G敦煌狼王#P的身影,请江湖侠义人士前去击杀,为民除害#P。#G[243,173] [222,82] [146,65] [149,113] [99,122] [123,184] [126,146] [176,220] [215,248] [57,266]",isSended=0}
x892382_g_AllBoss[8]=
{	
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=243,  PosY=173, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
    { ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=222,  PosY=82, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=146,  PosY=65, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=149,  PosY=113, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=99,  PosY=122, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=123,  PosY=184, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=126,  PosY=146, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=176,  PosY=220, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=215,  PosY=248, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },
	{ ID=55031, GroupId=1, Title="敦煌·霸主#r#601", PosX=57,  PosY=266, BaseAI=21, ExtAIScript=-1, ScriptID=892382 },

}

--##场景地图要加一个NPC，来触发脚本,如yannan_monster.ini，scripttimer是脚本回调时间，60000为60秒调用一次脚本
-- [monster142]
-- guid=9913082
-- type=0
-- pos_x=0
-- pos_z=0
-- dir=27
-- script_id=892382
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
function x892382_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nHour	 = GetHour()--小时
	local nMinute = GetMinute()--分钟
	
	if sceneId==8 then	
	 if  nMinute==5  then 
			x892382_CreateMonster( sceneId )	--刷怪
		end
	end
	--AddGlobalCountNews( sceneId, nMinute )
	--取消时钟
	--SetCharacterTimer( sceneId, objId, 0 )
end

--**********************************
--刷BOSS
--**********************************
function x892382_CreateMonster( sceneId )
	--##重置公告标识
	--for j,msgData in x892382_g_BossSysMsgByGroupID do 
	--	msgData.isSended=0
	--end
	--刷怪前如果怪存在的话全部清空，再刷
	for i,data in x892382_g_AllBoss[sceneId] do
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
	for i,data in x892382_g_AllBoss[sceneId] do
		local MstId = LuaFnCreateMonster(sceneId, data.ID, data.PosX, data.PosY, data.BaseAI, data.ExtAIScript, data.ScriptID )
		SetCharacterTitle(sceneId, MstId, data.Title)
		--x892382_SysMsg( sceneId, data.GroupId )
		
		
		
	end

    AddGlobalCountNews( sceneId, x892382_g_BossSysMsgByGroupID[1].Msg )	
	
end

--**********************************
--系统公告
--**********************************
function x892382_SysMsg( sceneId, groupId )
	if x892382_g_BossSysMsgByGroupID[groupId].isSended==0 then
		--BroadMsgByChatPipe( sceneId, 0, x892382_g_BossSysMsgByGroupID[groupId].Msg, 4 )
		AddGlobalCountNews( sceneId, x892382_g_BossSysMsgByGroupID[groupId].Msg )
		x892382_g_BossSysMsgByGroupID[groupId].isSended=1
	end
end

--**********************************
--对话窗口信息提示
--**********************************
function x892382_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x892382_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--关闭对话框
--**********************************
function x892382_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end