--洛阳NPC
--歌伎
--普通

x000045_g_scriptId = 000045

--所拥有的事件ID列表
x000045_g_eventList={999900} --{999900}

-- 需要加怒气的特殊NPC
x000045_g_SpecialNPC = "龙霸天"
x000045_g_MonsterId = 45197

--治疗设定
--当玩家的等级在10级以下的时候，治疗不收费；
--大于等于10级以上收取的费用为：
--治疗费用＝（玩家最大生命值－当前生命值）×a+（玩家最大蓝值－当前蓝值）×b
--a、b在不同等级下的系数规定如下：等级、a系数、b系数
x000045_g_rat	=	{
	{"0~9",0,0},	{"10~19",0.0079375,0.02480469},
	{"20~29",0.018375,0.05742188},	{"30~39",0.0313125,0.09785157},
	{"40~49",0.04675,0.14609376},		{"50~59",0.0646875,0.20214845},
	{"60~69",0.085125,0.26601564},	{"70~79",0.1080625,0.33769533},
	{"80~89",0.1335,0.41718752},	  {"90~99",0.162,0.50625},
	{"100~109",0.3,0.8},	          {"110~119",0.352,0.935}, 
	{"120~129",0.408,1.08},	      {"130~139",0.468,1.235}, 
	{"140~149",0.532,1.4}	
	}

--**********************************
--事件列表
--**********************************
function x000045_UpdateEventList( sceneId, selfId, targetId )
		local	nam	= LuaFnGetName( sceneId, selfId )
		local  PlayerSex=GetSex(sceneId,selfId)
		if PlayerSex == 0 then
			PlayerSex = "姑娘"
		else
			PlayerSex = "少侠"
		end
	BeginEvent(sceneId)
		AddText( sceneId, "  我是小丫鬟，主子的事情我可不知道。" )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end

--**********************************
--事件交互入口
--**********************************
function x000045_OnDefaultEvent( sceneId, selfId,targetId )
	x000045_UpdateEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x000045_OnEventRequest( sceneId, selfId, targetId, eventId )

	--加血
	if key == 0 then
		if GetHp( sceneId, selfId ) == GetMaxHp( sceneId, selfId ) and
			 GetMp( sceneId, selfId ) == GetMaxMp( sceneId, selfId ) then
			BeginEvent( sceneId )
			AddText( sceneId, "  你现在很健康，不需要治疗！" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			
			--取消指定玩家身上的所有敌对可驱散驻留效果
			LuaFnDispelAllHostileImpacts( sceneId, selfId )
			return
		end
	
		if gld <= 0 then
			x000045_Restore_hpmp( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId )
			AddText( sceneId, "  你需要花费#{_MONEY"..gld.."}来恢复血和气，确定要治疗嘛？" )
			AddNumText( sceneId, x000045_g_scriptId, "是", -1, 1001 )
			AddNumText( sceneId, x000045_g_scriptId, "否", -1, 1000 )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end
	else
		for i, findId in x000045_g_eventList do
			if eventId == findId then
				CallScriptFunction( eventId, "OnDefaultEvent",sceneId, selfId, targetId, GetNumText() )	--GetNumText()是addnumtext中最后的变量
				return
			end
		end
	end
end

--**********************************
--接受此NPC的任务
--**********************************
function x000045_OnMissionAccept( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000045_g_eventList do
		if missionScriptId == findId then
			ret = CallScriptFunction( missionScriptId, "CheckAccept", sceneId, selfId )
			if ret > 0 then
				CallScriptFunction( missionScriptId, "OnAccept", sceneId, selfId )
			end
			return
		end
	end
end

--**********************************
--拒绝此NPC的任务
--**********************************
function x000045_OnMissionRefuse( sceneId, selfId, targetId, missionScriptId )
	--拒绝之后，要返回NPC的事件列表
	for i, findId in x000045_g_eventList do
		if missionScriptId == findId then
			x000045_UpdateEventList( sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--继续（已经接了任务）
--**********************************
function x000045_OnMissionContinue( sceneId, selfId, targetId, missionScriptId )
	for i, findId in x000045_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnContinue", sceneId, selfId, targetId )
			return
		end
	end
end

--**********************************
--提交已做完的任务
--**********************************
function x000045_OnMissionSubmit( sceneId, selfId, targetId, missionScriptId, selectRadioId )
	for i, findId in x000045_g_eventList do
		if missionScriptId == findId then
			CallScriptFunction( missionScriptId, "OnSubmit", sceneId, selfId, targetId, selectRadioId )
			return
		end
	end
end

--**********************************
--死亡事件
--**********************************
function x000045_OnDie( sceneId, selfId, killerId )
end

--**********************************
--恢复血和气
--**********************************
function x000045_Restore_hpmp( sceneId, selfId, targetId )
	RestoreHp( sceneId, selfId )
	RestoreMp( sceneId, selfId )
	
	local msg = ""
	-- 判断该npc是否是龙霸天
	if LuaFnGetName( sceneId, targetId ) == x000045_g_SpecialNPC then
		RestoreRage( sceneId, selfId )
		msg = "你的气血和怒气已经完全恢复。"
	else
		msg = "你的血和气已经恢复"
	end
	--取消指定玩家身上的所有敌对可驱散驻留效果
	LuaFnDispelAllHostileImpacts( sceneId, selfId )
	
	BeginEvent( sceneId )
		AddText( sceneId, msg );
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
	
	BeginUICommand( sceneId )
	UICommand_AddInt( sceneId, targetId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 1000 )
end

--**********************************
--计算恢复血和气费用
--**********************************
--当玩家的等级在10级以下的时候，治疗不收费；
--大于等于10级以上收取的费用为：
--治疗费用＝（玩家最大生命值－当前生命值）×a+（玩家最大蓝值－当前蓝值）×b
function x000045_CalcMoney_hpmp( sceneId, selfId )
  
  local PlayerMaxLevel = GetHumanMaxLevelLimit()
	local	level	= GetLevel( sceneId, selfId )
	if level < 10 then	--如果玩家等级<10，则不需要钱
		return 0
	elseif level > PlayerMaxLevel then
		level	= PlayerMaxLevel
	end

	local	rat		= x000045_g_rat[ floor(level/10) + 1 ]
	local hp		= GetHp( sceneId, selfId )
	local maxhp	= GetMaxHp( sceneId, selfId )
	local mp		= GetMp( sceneId, selfId )
	local maxmp	= GetMaxMp( sceneId, selfId )
	local	gld		= floor( (maxhp-hp) * rat[2] + (maxmp-mp) * rat[3] )
	if gld < 1 then
		gld				= 100
	end
	return gld
end





