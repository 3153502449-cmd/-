-- created by 左春伟

x001089_g_ScriptId = 001089; --脚本号
x001089_g_name	="云四合";

--传送目标
x001089_g_transfer_target =
{
	[1] = {x = 27, z = 23, scene_num = 62}, 		--后花园
}

-- 收费金额
x001089_g_transfer_cost = 500000; -- 50金交子

--**********************************
--事件交互入口
--**********************************
function x001089_OnDefaultEvent( sceneId, selfId, targetId )
	x001089_UpdateEventList( sceneId, selfId, targetId );
end

--**********************************
--事件列表
--**********************************
function x001089_UpdateEventList( sceneId, selfId, targetId )
	BeginEvent(sceneId);
		AddText( sceneId, "#{SFCS_80828_02}" );
		AddNumText(sceneId, x001089_g_ScriptId, "后花园", 9, 1);
	EndEvent()
	DispatchEventList(sceneId, selfId, targetId);
end

--**********************************
--事件列表选中一项
--**********************************
function x001089_OnEventRequest( sceneId, selfId, targetId, eventId )
	--跑商相关
	if GetItemCount(sceneId, selfId, 40002000)>=1  then
		BeginEvent( sceneId )
			AddText( sceneId, "  你身上有银票，正在跑商！我不能帮助你。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--队伍相关
	if GetTeamId(sceneId,selfId)>=0 and 
		IsTeamFollow(sceneId, selfId)==1 and
		LuaFnIsTeamLeader(sceneId,selfId)==1 then
		BeginEvent( sceneId )
			AddText( sceneId, "  非常抱歉，由于路途太过遥远，我们这里运输能力有限，所以不接受组队传送，请您离开队伍单独前来吧！" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return
	end
	--漕运相关
	if IsHaveMission(sceneId,selfId,4021) > 0 then
		BeginEvent(sceneId)
			AddText(sceneId, "  你有漕运货舱在身，我们驿站不能为你提供传送服务。")
		EndEvent()
		DispatchEventList(sceneId, selfId, targetId)
		return
	end
	--
	local id = GetNumText();
	if id >=1 and id <= 6 then
		BeginEvent(sceneId)
			--"本次传送收取50金交子，你要传送吗？"
			AddText(sceneId, "#{FFCS_081210_1}")
			if id == 1 then	
				AddNumText(sceneId, x001089_g_ScriptId, "确定", 0, 11);
			elseif id == 2 then
				AddNumText(sceneId, x001089_g_ScriptId, "确定", 0, 21);
			elseif id == 3 then
				AddNumText(sceneId, x001089_g_ScriptId, "确定", 0, 31);
			elseif id == 4 then
				AddNumText(sceneId, x001089_g_ScriptId, "确定", 0, 41);
			elseif id == 5 then
				AddNumText(sceneId, x001089_g_ScriptId, "确定", 0, 51);
			elseif id == 6 then
				AddNumText(sceneId, x001089_g_ScriptId, "确定", 0, 61);
			end
			AddNumText(sceneId, x001089_g_ScriptId, "取消", 0, 100);
		EndEvent()
		DispatchEventList(sceneId, selfId, targetId);
	elseif id == 100 then
		BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
		EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )		
	else
		local index = floor(id/10);
		--楼兰75级限制
		if index == 4 then
			if GetLevel(sceneId, selfId) < 75 then
				BeginEvent(sceneId)
					AddText(sceneId, "  你的等级不到75，无法传送。")
				EndEvent()
				DispatchEventList(sceneId, selfId, targetId)
				return
			end
			--同骑带小号限制
			if LuaFnGetDRideFlag(sceneId, selfId) == 1 then
				local objId = LuaFnGetDRideTargetID(sceneId, selfId);
				if objId ~= -1 and GetLevel(sceneId, objId) < 75 then
					BeginEvent(sceneId)
						AddText(sceneId, "#{SRCS_090203_1}")
					EndEvent()
					DispatchEventList(sceneId, selfId, targetId)
					return					
				end
			end
		end
		--[tx44121]bug这里没有设置最低级别，导致低级别可通过双骑乘进高级别场景
		local minLevel = 10
		if index == 4 then
			minLevel = 75
		end
		if LuaFnGetDRideFlag(sceneId, selfId) == 1 then
			local objId = LuaFnGetDRideTargetID(sceneId, selfId);
			if objId ~= -1 and GetLevel(sceneId, objId) < minLevel then
			  local Tip = format("#{CQTS_90227_1}%d#{CQTS_90227_2}", minLevel)					
				x001089_NotifyFailTips( sceneId, selfId, targetId, Tip )
				return					
			end
		end	
    --[/tx44121]
    		
		local pos_x = x001089_g_transfer_target[index]["x"];
		local pos_z = x001089_g_transfer_target[index]["z"];
		local scene_num = x001089_g_transfer_target[index]["scene_num"];

		local nMoneyJZ = GetMoneyJZ (sceneId, selfId)
		local nMoney = GetMoney (sceneId, selfId)

		--钱够吗？
		if (nMoneyJZ + nMoney) >= x001089_g_transfer_cost then 
				
			-- 收费
			-- 使用带优先级的金钱消耗函数					
			if LuaFnCostMoneyWithPriority (sceneId, selfId, x001089_g_transfer_cost) == -1 then
				BeginEvent(sceneId)
					AddText(sceneId, "收费失败！");
				EndEvent()
				DispatchMissionTips(sceneId, selfId)
				return
			else
  			CallScriptFunction((400900), "TransferFunc",sceneId, selfId, scene_num, pos_x, pos_z, minLevel); 
			end

		-- 钱不够
		else
			BeginEvent(sceneId)
				AddText(sceneId, "金钱不足");
			EndEvent()
			DispatchEventList(sceneId, selfId, targetId)
			return

		end
	end	
end
--**********************************
-- 屏幕中间信息提示
--**********************************
function x001089_NotifyFailTips( sceneId, selfId, targetId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
