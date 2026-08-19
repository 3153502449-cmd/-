--脚本号
x892388_g_scriptId = 892388

x892388_g_AllBoss = {21}
--##18是场景ID，参考SceneInfo.ini

--##这里是系统公告，根据分组ID发布公告，同一组BOSS只发布一次
x892388_g_BossSysMsgByGroupID={}
x892388_g_BossSysMsgByGroupID[1]={Msg="#cFF0000野外BOSS#W：#P江湖传闻#G辽西#P出现#G辽西悍匪#P的身影,请江湖侠义人士前去击杀,为民除害#P。#G[68,264] [63,236] [56,186] [168,268] [80,100] [103,59] [154,168] [224,64] [247,122] [268,203]",isSended=0}
x892388_g_AllBoss[21]=
{	
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=68,  PosY=264, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
    { ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=70,  PosY=234, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=56,  PosY=186, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=168,  PosY=268, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=80,  PosY=100, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=103,  PosY=59, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=154,  PosY=168, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=224,  PosY=64, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=247,  PosY=122, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },
	{ ID=55037, GroupId=1, Title="辽西·霸主#r#607", PosX=268,  PosY=203, BaseAI=21, ExtAIScript=-1, ScriptID=892388 },

}

--##场景地图要加一个NPC，来触发脚本,如yannan_monster.ini，scripttimer是脚本回调时间，60000为60秒调用一次脚本
-- [monster142]
-- guid=9913082
-- type=0
-- pos_x=0
-- pos_z=0
-- dir=27
-- script_id=892388
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
function x892388_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nHour	 = GetHour()--小时
	local nMinute = GetMinute()--分钟
	
	if sceneId==21 then	
	 if  nMinute==55  then 
			x892388_CreateMonster( sceneId )	--刷怪
		end
	end
	--AddGlobalCountNews( sceneId, nMinute )
	--取消时钟
	--SetCharacterTimer( sceneId, objId, 0 )
end

--**********************************
--刷BOSS
--**********************************
function x892388_CreateMonster( sceneId )
	--##重置公告标识
	--for j,msgData in x892388_g_BossSysMsgByGroupID do 
	--	msgData.isSended=0
	--end
	--刷怪前如果怪存在的话全部清空，再刷
	for i,data in x892388_g_AllBoss[sceneId] do
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
	for i,data in x892388_g_AllBoss[sceneId] do
		local MstId = LuaFnCreateMonster(sceneId, data.ID, data.PosX, data.PosY, data.BaseAI, data.ExtAIScript, data.ScriptID )
		SetCharacterTitle(sceneId, MstId, data.Title)
		--x892388_SysMsg( sceneId, data.GroupId )
		
		
		
	end

    AddGlobalCountNews( sceneId, x892388_g_BossSysMsgByGroupID[1].Msg )	
	
end

--**********************************
--系统公告
--**********************************
function x892388_SysMsg( sceneId, groupId )
	if x892388_g_BossSysMsgByGroupID[groupId].isSended==0 then
		--BroadMsgByChatPipe( sceneId, 0, x892388_g_BossSysMsgByGroupID[groupId].Msg, 4 )
		AddGlobalCountNews( sceneId, x892388_g_BossSysMsgByGroupID[groupId].Msg )
		x892388_g_BossSysMsgByGroupID[groupId].isSended=1
	end
end

--**********************************
--对话窗口信息提示
--**********************************
function x892388_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x892388_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--关闭对话框
--**********************************
function x892388_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end