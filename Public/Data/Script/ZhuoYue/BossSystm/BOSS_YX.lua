--脚本号
x892386_g_scriptId = 892386

x892386_g_AllBoss = {27}
--##18是场景ID，参考SceneInfo.ini

--##这里是系统公告，根据分组ID发布公告，同一组BOSS只发布一次
x892386_g_BossSysMsgByGroupID={}
x892386_g_BossSysMsgByGroupID[1]={Msg="#cFF0000野外BOSS#W：#P江湖传闻#G玉溪#P出现#G玉溪石人#P的身影,请江湖侠义人士前去击杀,为民除害#P。#G[84,70] [108,94] [140,132] [210,66] [215,117] [124,187] [80,156] [187,233] [265,211] [200,200]",isSended=0}
x892386_g_AllBoss[27]=
{	
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=84,  PosY=70, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
    { ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=108,  PosY=94, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=140,  PosY=132, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=210,  PosY=66, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=215,  PosY=117, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=124,  PosY=187, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=80,  PosY=156, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=187,  PosY=233, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=265,  PosY=211, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },
	{ ID=55035, GroupId=1, Title="玉溪·霸主#r#605", PosX=200,  PosY=200, BaseAI=21, ExtAIScript=-1, ScriptID=892386 },

}

--##场景地图要加一个NPC，来触发脚本,如yannan_monster.ini，scripttimer是脚本回调时间，60000为60秒调用一次脚本
-- [monster142]
-- guid=9913082
-- type=0
-- pos_x=0
-- pos_z=0
-- dir=27
-- script_id=892386
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
function x892386_OnCharacterTimer( sceneId, objId, dataId, uTime )
	local nHour	 = GetHour()--小时
	local nMinute = GetMinute()--分钟
	
	if sceneId==27 then	
	 if  nMinute==35  then 
			x892386_CreateMonster( sceneId )	--刷怪
		end
	end
	--AddGlobalCountNews( sceneId, nMinute )
	--取消时钟
	--SetCharacterTimer( sceneId, objId, 0 )
end

--**********************************
--刷BOSS
--**********************************
function x892386_CreateMonster( sceneId )
	--##重置公告标识
	--for j,msgData in x892386_g_BossSysMsgByGroupID do 
	--	msgData.isSended=0
	--end
	--刷怪前如果怪存在的话全部清空，再刷
	for i,data in x892386_g_AllBoss[sceneId] do
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
	for i,data in x892386_g_AllBoss[sceneId] do
		local MstId = LuaFnCreateMonster(sceneId, data.ID, data.PosX, data.PosY, data.BaseAI, data.ExtAIScript, data.ScriptID )
		SetCharacterTitle(sceneId, MstId, data.Title)
		--x892386_SysMsg( sceneId, data.GroupId )
		
		
		
	end

    AddGlobalCountNews( sceneId, x892386_g_BossSysMsgByGroupID[1].Msg )	
	
end

--**********************************
--系统公告
--**********************************
function x892386_SysMsg( sceneId, groupId )
	if x892386_g_BossSysMsgByGroupID[groupId].isSended==0 then
		--BroadMsgByChatPipe( sceneId, 0, x892386_g_BossSysMsgByGroupID[groupId].Msg, 4 )
		AddGlobalCountNews( sceneId, x892386_g_BossSysMsgByGroupID[groupId].Msg )
		x892386_g_BossSysMsgByGroupID[groupId].isSended=1
	end
end

--**********************************
--对话窗口信息提示
--**********************************
function x892386_MsgBox( sceneId, selfId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, -1 )
end


--**********************************
--醒目提示
--**********************************
function x892386_NotifyTip( sceneId, selfId, Msg )
	BeginEvent( sceneId )
		AddText( sceneId, Msg )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--关闭对话框
--**********************************
function x892386_CloseMe(sceneId, selfId)
	BeginUICommand(sceneId)
	EndUICommand(sceneId)
	DispatchUICommand(sceneId,selfId, 1000)
end