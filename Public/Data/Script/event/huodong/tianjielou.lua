--天劫楼  
--除恶天劫楼
--逍遥子重写 QQ857904341
--脚本号
x808138_g_ScriptId  = 808138

--接受任务NPC属性
x808138_g_Position_X=70
x808138_g_Position_Z=81
x808138_g_AccomplishNPC_Name="付劫生"

--任务号
x808138_g_MissionId = 1711

--目标NPC
x808138_g_Name	="付劫生"

--任务归类
x808138_g_MissionKind = 1

x808138_g_MissionLevel = 10

--是否是精英任务
x808138_g_IfMissionElite = 0

x808138_g_MissionRound = 9
--任务是否已经完成
x808138_g_IsMissionOkFail = 0		--变量的第0位

--任务需要杀死的怪
x808138_g_DemandKill ={{id=13800,num=20}}		--变量第1位
--x808138_g_DemandKill ={{name="天劫楼恶人",num=20}}

--以上是动态**************************************************************

--任务文本描述
x808138_g_MissionName="除恶天劫楼"
x808138_g_MissionInfo="#{TJL_090714_03}" --任务描述
x808138_g_MissionTarget="#{TJL_090714_04}"	--任务目标
x808138_g_ContinueInfo="#{TJL_090714_05}"	--未完成任务的npc对话
x808138_g_MissionComplete=" 大侠为天下百姓而奋力除恶，实在令人倾佩！"	--完成任务npc说话的话
x808138_g_SignPost = {x = 70, z = 81, tip = "付劫生"}
--任务奖励

x808138_g_MoneyBonus = 100000

x808138_g_DemandTrueKill ={{name="天劫楼恶人",num=20}}

--MisDescEnd
--**********************************
--任务入口函数
--**********************************
function x808138_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
    local nRound = GetMissionData(sceneId,selfId,MD_MURENXIANG_HUAN)
    if nRound < 20 then 
		--如果已接此任务
		if IsHaveMission(sceneId,selfId,x808138_g_MissionId) > 0 then
		--发送任务需求的信息
			BeginEvent(sceneId)
				AddText(sceneId,x808138_g_MissionName)
				AddText(sceneId,x808138_g_ContinueInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x808138_g_MissionTarget)
				AddMoneyBonus( sceneId, x808138_g_MoneyBonus )
			EndEvent()
			bDone = x808138_CheckSubmit( sceneId, selfId )
			DispatchMissionDemandInfo(sceneId,selfId,targetId,x808138_g_ScriptId ,x808138_g_MissionId,bDone)
        --满足任务接收条件
        elseif x808138_CheckAccept(sceneId,selfId) > 0 then
			--发送任务接受时显示的信息
			BeginEvent(sceneId)
				AddText(sceneId,x808138_g_MissionName)
				AddText(sceneId,x808138_g_MissionInfo)
				AddText(sceneId,"#{M_MUBIAO}")
				AddText(sceneId,x808138_g_MissionTarget)
				AddMoneyBonus( sceneId, x808138_g_MoneyBonus )
			EndEvent( )
			DispatchMissionInfo(sceneId,selfId,targetId,x808138_g_ScriptId ,x808138_g_MissionId)
        end
    elseif nRound >= 20 then
        BeginEvent(sceneId)
			AddText(sceneId,x808138_g_MissionName)
			AddText(sceneId,"#{TJL_090714_02}")
        EndEvent(sceneId )
		DispatchEventList(sceneId,selfId,targetId)
    end
end

--**********************************
--列举事件
--**********************************
function x808138_OnEnumerate( sceneId, selfId, targetId )

    --如果已接此任务
    if IsHaveMission(sceneId,selfId,x808138_g_MissionId) > 0 then
		AddNumText(sceneId,x808138_g_ScriptId ,x808138_g_MissionName,2,-1);
		--满足任务接收条件
	elseif x808138_CheckAccept(sceneId,selfId) > 0 then
		AddNumText(sceneId,x808138_g_ScriptId ,x808138_g_MissionName,1,-1);
	end
end

--**********************************
--检测接受条件
--**********************************
function x808138_CheckAccept( sceneId, selfId )
	--需要9级才能接
	if GetLevel( sceneId, selfId ) >= 30 then
		return 1
	else
		return 0
	end

end

--**********************************
--接受
--**********************************
function x808138_OnAccept( sceneId, selfId )
	--加入任务到玩家列表
	local nRound = GetMissionData(sceneId,selfId,MD_MURENXIANG_HUAN)
	AddMission( sceneId,selfId, x808138_g_MissionId, x808138_g_ScriptId , 1, 0, 0 )		--添加任务
	misIndex = GetMissionIndexByID(sceneId,selfId,x808138_g_MissionId)			--得到任务的序列号
	SetMissionByIndex(sceneId,selfId,misIndex,0,0)						--根据序列号把任务变量的第0位置0
	SetMissionByIndex(sceneId,selfId,misIndex,1,0)						--根据序列号把任务变量的第1位置0
	Msg2Player(  sceneId, selfId,"#Y接受任务：除恶天劫楼",MSG2PLAYER_PARA )
	CallScriptFunction( SCENE_SCRIPT_ID, "AskTheWay", sceneId, selfId, sceneId, x808138_g_SignPost.x, x808138_g_SignPost.z, x808138_g_SignPost.tip )

end

--**********************************
--放弃
--**********************************
function x808138_OnAbandon( sceneId, selfId )
	--删除玩家任务列表中对应的任务
    DelMission( sceneId, selfId, x808138_g_MissionId )
	CallScriptFunction( SCENE_SCRIPT_ID, "DelSignpost", sceneId, selfId, sceneId, x808138_g_SignPost.tip )
end

--**********************************
--继续
--**********************************
function x808138_OnContinue( sceneId, selfId, targetId )
	--提交任务时的说明信息
    BeginEvent(sceneId)
		AddText(sceneId,x808138_g_MissionName)
		AddText(sceneId,x808138_g_MissionComplete)
		AddMoneyBonus( sceneId, x808138_g_MoneyBonus )
    EndEvent( )
    DispatchMissionContinueInfo(sceneId,selfId,targetId,x808138_g_ScriptId ,x808138_g_MissionId)
end

--**********************************
--检测是否可以提交
--**********************************
function x808138_CheckSubmit( sceneId, selfId )
	local bRet = CallScriptFunction( SCENE_SCRIPT_ID, "CheckSubmit", sceneId, selfId, x808138_g_MissionId )

	misIndex = GetMissionIndexByID(sceneId,selfId,x808138_g_MissionId)
    num = GetMissionParam(sceneId,selfId,misIndex,1)
    if num == x808138_g_DemandTrueKill[1].num then
			return 1
		end
	return 0
end

--**********************************
--提交
--**********************************
function x808138_OnSubmit( sceneId, selfId, targetId,selectRadioId )
    if x808138_CheckSubmit( sceneId, selfId, selectRadioId ) == 1 then
		ret = 1
        local nRound = GetMissionData(sceneId,selfId,MD_MURENXIANG_HUAN)
		local nLevel=GetLevel( sceneId, selfId)
		local nGuLanYuNum = 0
		if nLevel >= 30 and nLevel <= 39 then
			local nExpStart = 700
			local nMoneyStart = 4000
			local nAdd_Level = 100
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 1
		elseif nLevel>=40 and nLevel<=49 then
			local nExpStart = 900
			local nMoneyStart = 5000
			local nAdd_Level = 100
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 1
		elseif nLevel>=50 and nLevel<=59 then
			local nExpStart = 3000
			local nMoneyStart = 6000
			local nAdd_Level = 100
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 2
		elseif nLevel>=60 and nLevel<=69 then
			local nExpStart = 3500
			local nMoneyStart = 7000
			local nAdd_Level = 100
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 3
		elseif nLevel>=70 and nLevel<=79 then
			local nExpStart = 6900
			local nMoneyStart = 8000
			local nAdd_Level = 6000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 4
		elseif nLevel>=80 and nLevel<=89 then
			local nExpStart = 9900
			local nMoneyStart = 9000
			local nAdd_Level = 7000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 4
		elseif nLevel>=90 and nLevel<=99 then
			local nExpStart = 11200
			local nMoneyStart = 10000
			local nAdd_Level = 8000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 5
		elseif nLevel>=100 and nLevel<=109 then
			local nExpStart = 25000
			local nMoneyStart = 15000
			local nAdd_Level = 9000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 5
		elseif nLevel>=110 and nLevel<=119 then
			local nExpStart = 30000
			local nMoneyStart = 20000
			local nAdd_Level = 10000
			ExpJiangLi = nExpStart + nAdd_Level * (nRound + 1)
			--x808138_g_MoneyBonus = nMoneyStart + nAdd_Level * (nRound + 1)
			nGuLanYuNum = 5
		end
		if nRound + 1 == 10 then --最后一环之奖励
			ExpJiangLi = ExpJiangLi * 2.5
			x808138_g_MoneyBonus = x808138_g_MoneyBonus * 1.5
			if LuaFnGetMaterialBagSpace( sceneId, selfId ) < 1 then
				BeginEvent(sceneId)
					AddText(sceneId,"背包已满,无法完成任务");
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
		end
		--添加任务奖励
		if ret > 0 then
			if nRound + 1 == 10 then
				for i = 1,nGuLanYuNum do
					--local nPos = TryRecieveItem( sceneId, selfId, 20700004, 1)
					--LuaFnItemBind( sceneId, selfId, nPos )
				end
			end
			ZengDian(sceneId,selfId,-1,1,500 );
			AddMoney(sceneId,selfId,x808138_g_MoneyBonus );
			LuaFnAddExp( sceneId, selfId,ExpJiangLi)
			ret = DelMission( sceneId, selfId, x808138_g_MissionId )
			if ret > 0 then
				MissionCom( sceneId, selfId, x808138_g_MissionId )
				SetMissionData(sceneId,selfId,MD_MURENXIANG_HUAN,nRound+1)
				Msg2Player(  sceneId, selfId,"#Y完成任务：除恶天劫楼",MSG2PLAYER_PARA )
				BeginEvent(sceneId)
					AddText(sceneId,format("任务完成，当前为第%d环",nRound+1));
				EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
			end
		else
			--任务奖励没有加成功
			BeginEvent(sceneId)
			strText = "背包已满,无法完成任务"
			AddText(sceneId,strText);
			EndEvent(sceneId)
			DispatchMissionTips(sceneId,selfId)
		end
    end
end

--**********************************
--杀死怪物或玩家
--**********************************
function x808138_OnKillObject( sceneId, selfId, objdataId ,objId)
	
	if GetName(sceneId,objId) == x808138_g_DemandTrueKill[1].name	  then
		-- 获得所有人
		local num = GetMonsterOwnerCount(sceneId,objId)
		for j=0,num-1  do
			local humanObjId = GetMonsterOwnerID(sceneId,objId,j)
			
			-- 看有没有这个任务
			if IsHaveMission(sceneId, humanObjId, x808138_g_MissionId) > 0 then
				local misIndex = GetMissionIndexByID(sceneId,humanObjId,x808138_g_MissionId)
				local nNum = GetMissionParam(sceneId,humanObjId,misIndex,1)

	 			if nNum < x808138_g_DemandTrueKill[1].num then
	 				if nNum == x808138_g_DemandTrueKill[1].num - 1 then
	 					SetMissionByIndex(sceneId,humanObjId,misIndex,0,1)
	 				end
					SetMissionByIndex(sceneId,humanObjId,misIndex,1,nNum+1)
					BeginEvent(sceneId)
						strText = format("已杀死天劫楼恶人%d/20", GetMissionParam(sceneId,humanObjId,misIndex,1) )
						AddText(sceneId,strText);
					EndEvent(sceneId)
					DispatchMissionTips(sceneId,humanObjId)
	 			end
			end
		end
	end
end

--**********************************
--进入区域事件
--**********************************
function x808138_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x808138_OnItemChanged( sceneId, selfId, itemdataId )
end
