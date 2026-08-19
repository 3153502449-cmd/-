--洛阳NPC
--抽奖
--普通
x002099_g_strGongGaoInfo = {
  "#Y恭喜玩家#cFF0000#{_INFOUSR%s}#Y的#G#{_INFOMSG%s}#Y更上一层楼。", 
  "#Y恭喜玩家#cFF0000#{_INFOUSR%s}#Y的#G#{_INFOMSG%s}#Y更上一层楼。", 
  "#Y恭喜玩家#cFF0000#{_INFOUSR%s}#Y的#G#{_INFOMSG%s}#Y更上一层楼。", 
  "#Y恭喜玩家#cFF0000#{_INFOUSR%s}#Y的#G#{_INFOMSG%s}#Y更上一层楼。", 
}
--**********************************
--事件交互入口
--**********************************
function x002099_OnDefaultEvent( sceneId, selfId,targetId )
	BeginEvent(sceneId)
		AddText( sceneId, "#cFF0000   武魂合成：必须是同等级同类型的两个武魂才可进行合成，合成后等级加一。学习属性攻击和减抗：只有9级武魂才能学习，需要破天箭20支！" )
		AddNumText( sceneId, x002099_g_ScriptId, "琉璃焰提升等级", 5, 500 )
		AddNumText( sceneId, x002099_g_ScriptId, "御瑶盘提升等级", 5, 600 )
		AddNumText( sceneId, x002099_g_ScriptId, "属性攻击减抗学习", 5, 700 )
		AddNumText( sceneId, x002099_g_ScriptId, "下次再来", 5, 4 )
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件列表选中一项
--**********************************
function x002099_OnEventRequest( sceneId, selfId, targetId, eventId)
	if GetNumText() == 500 then
		BeginEvent( sceneId )
		      AddText( sceneId, "#cFF0000   合成的武魂必须是同等级同类型，武魂在老三，凤凰陵墓几率爆出！" )
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰2级", 5, 20010)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰3级", 5, 20011)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰4级", 5, 20012)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰5级", 5, 20013)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰6级", 5, 20014)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰7级", 5, 20015)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰8级", 5, 20016)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰9级", 5, 20017)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )

	elseif GetNumText() == 600 then
		BeginEvent( sceneId )
		      AddText( sceneId, "#cFF0000   合成的武魂必须是同等级同类型，武魂在老三，凤凰陵墓几率爆出！" )
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘2级", 5, 20020)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘3级", 5, 20021)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘4级", 5, 20022)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘5级", 5, 20023)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘6级", 5, 20024)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘7级", 5, 20025)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘8级", 5, 20026)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘9级", 5, 20027)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )

	elseif GetNumText() == 700 then
		BeginEvent( sceneId )
		      AddText( sceneId, "#cFF0000   属性攻击和属性减抗：对象必须是9级武魂，需要破天箭20支，反贼头目几率爆出！" )
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰9级学习冰属性", 5, 20030)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰9级学习火属性", 5, 20031)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰9级学习玄属性", 5, 20032)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc琉璃焰9级学习毒属性", 5, 20033)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘9级学习冰属性", 5, 20034)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘9级学习火属性", 5, 20035)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘9级学习玄属性", 5, 20036)
		      AddNumText( sceneId, x892005_g_scriptId, "#c33ffcc御瑶盘9级学习毒属性", 5, 20037)
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )

	elseif GetNumText() == 20010 then
	       	local nStoneId0 = 10156001
	       	local nStoneId1 = 10156001
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10156001,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10156001,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554300, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20011 then
	       	local nStoneId0 = 10554300
	       	local nStoneId1 = 10554300
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554300,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554300,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554301, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20012 then
	       	local nStoneId0 = 10554301
	       	local nStoneId1 = 10554301
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554301,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554301,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554302, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20013 then
	       	local nStoneId0 = 10554302
	       	local nStoneId1 = 10554302
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554302,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554302,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554303, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20014 then
	       	local nStoneId0 = 10554303
	       	local nStoneId1 = 10554303
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554303,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554303,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554304, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20015 then
	       	local nStoneId0 = 10554304
	       	local nStoneId1 = 10554304
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554304,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554304,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554305, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20016 then
	       	local nStoneId0 = 10554305
	       	local nStoneId1 = 10554305
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554305,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554305,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554306, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20017 then
	       	local nStoneId0 = 10554306
	       	local nStoneId1 = 10554306
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554306,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554306,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554307, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20018 then
	       	local nStoneId0 = 10553221
	       	local nStoneId1 = 30503120
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=5 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10553221,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10553221, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20020 then
	       	local nStoneId0 = 10156002
	       	local nStoneId1 = 10156002
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10156002,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10156002,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554400, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20021 then
	       	local nStoneId0 = 10554400
	       	local nStoneId1 = 10554400
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554400,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554400,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554401, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20022 then
	       	local nStoneId0 = 10554401
	       	local nStoneId1 = 10554401
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554401,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554401,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554402, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20023 then
	       	local nStoneId0 = 10554402
	       	local nStoneId1 = 10554402
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554402,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554402,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554403, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20024 then
	       	local nStoneId0 = 10554403
	       	local nStoneId1 = 10554403
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554403,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554403,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554404, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20025 then
	       	local nStoneId0 = 10554404
	       	local nStoneId1 = 10554404
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554404,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554404,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554405, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20026 then
	       	local nStoneId0 = 10554405
	       	local nStoneId1 = 10554405
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554405,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554405,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554406, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20027 then
	       	local nStoneId0 = 10554406
	       	local nStoneId1 = 10554406
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=2 and c1 >=0 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554406,2)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,10554406,0)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554407, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20028 then
	       	local nStoneId0 = 10553164
	       	local nStoneId1 = 30503120
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=5 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10553164,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10553221, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end
	
	elseif GetNumText() == 20029 then
	       	local nStoneId0 = 10422016
	       	local nStoneId1 = 30503120
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=5 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10422016,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10422016, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20030 then
	       	local nStoneId0 = 10554307
	       	local nStoneId1 = 20310159
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=20 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554307,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20310159,20)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554308, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 20031 then
	       	local nStoneId0 = 10554307
	       	local nStoneId1 = 20310159
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=20 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554307,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20310159,20)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554309, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end
	elseif GetNumText() == 20032 then
	       	local nStoneId0 = 10554307
	       	local nStoneId1 = 20310159
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=20 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554307,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20310159,20)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554310, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end
	elseif GetNumText() == 20033 then
	       	local nStoneId0 = 10554307
	       	local nStoneId1 = 20310159
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=20 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554307,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20310159,20)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554311, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end
	elseif GetNumText() == 20034 then
	       	local nStoneId0 = 10554407
	       	local nStoneId1 = 20310159
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=20 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554407,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20310159,20)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554408, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end
	elseif GetNumText() == 20035 then
	       	local nStoneId0 = 10554407
	       	local nStoneId1 = 20310159
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=20 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554407,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20310159,20)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554409, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end
	elseif GetNumText() == 20036 then
	       	local nStoneId0 = 10554407
	       	local nStoneId1 = 20310159
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=20 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554407,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20310159,20)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554410, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end
	elseif GetNumText() == 20037 then
	       	local nStoneId0 = 10554407
	       	local nStoneId1 = 20310159
		local randtype = random(200)
		c0 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId0)
		c1 = LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId1)
		if c0 >=1 and c1 >=20 then
		if randtype <= 200 then
				BeginEvent( sceneId ) 
					LuaFnDelAvailableItem(sceneId,selfId,10554407,1)--删除物品
					LuaFnDelAvailableItem(sceneId,selfId,20310159,20)--删除物品
					local bagpos01 = TryRecieveItem( sceneId, selfId, 10554411, 1)--给予物品
				       local szItemTransfer = GetBagItemTransfer( sceneId, selfId, bagpos01 )
					x002099_ShowRandomSystemNotice( sceneId, selfId, szItemTransfer )
					strText = "#G恭喜恭喜，你成功了！"
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		else
			BeginEvent( sceneId ) 
				LuaFnDelAvailableItem(sceneId,selfId,30503120,5)--删除物品
				strText = "#G这不是我的错..."
				AddText( sceneId, strText )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end                     else
               	BeginEvent( sceneId ) 
					strText = "#G材料不够少来坑爹！"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
			end

	elseif GetNumText() == 4 then
		BeginUICommand( sceneId )
			UICommand_AddInt( sceneId, targetId )
			EndUICommand( sceneId )
		DispatchUICommand( sceneId, selfId, 1000 )
		return
	end
end
--**********************************
-- 对话窗口信息提示
--**********************************
function x002099_NotifyFailBox( sceneId, selfId, targetId, msg )
	BeginEvent( sceneId )
		AddText( sceneId, msg )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x002099_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

function x002099_ShowRandomSystemNotice( sceneId, selfId, strItemInfo )
	
	local PlayerName = GetName(sceneId,selfId)
	local nMsgIndex = random( 1, 4 )
	local str
	if nMsgIndex == 1 then
		str = format( x002099_g_strGongGaoInfo[1], PlayerName, strItemInfo )
	elseif nMsgIndex == 2 then
		str = format( x002099_g_strGongGaoInfo[2], PlayerName, strItemInfo )
	elseif nMsgIndex == 3 then
		str = format( x002099_g_strGongGaoInfo[3], PlayerName, strItemInfo )
	else
		str = format( x002099_g_strGongGaoInfo[4], PlayerName, strItemInfo )
	end
	BroadMsgByChatPipe( sceneId, selfId, str, 4 )
	
end

