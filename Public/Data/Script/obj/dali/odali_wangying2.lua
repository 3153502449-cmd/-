-- 领奖NPC

x002025_g_scriptId = 002025
x002025_g_MaxBagSize	= 60
x002025_g_shoptableindex=235
--奖励标记
x002025_g_flag = {

    [80]	= MF_LINGQUYUANBAO80,
    [90]	= MF_LINGQUYUANBAO90,
    [100]	= MF_LINGQUYUANBAO100,
    [110]	= MF_LINGQUYUANBAO110,
    [120]	= MF_LINGQUYUANBAO120,
    
}
x002025_g_Title		={}
x002025_g_Title[1] = "初级师傅"

--**********************************
--事件交互入口
--**********************************
function x002025_OnDefaultEvent( sceneId, selfId, targetId )
	BeginEvent( sceneId )
		strText = "#G介绍：#r#W玩家在清理背包的时候请先将#G包裹栏#W跟#G材料栏#W里的重要物品放入旁边的仓库管理员，再点击清理否则物品被清理自行负责.#r#G推荐：#W本服独创个性称号玩家免费领取,让你更有个性。"		
		AddText( sceneId, strText )
	      --AddNumText( sceneId, x002025_g_scriptId, "#gffff00领取迅雷指南", 1, 870 )
		--AddNumText( sceneId, x002025_g_scriptId, "#gffff00《内测无限领取元宝》#W", 5, 102 )
		--AddNumText( sceneId, x002025_g_scriptId, "#gffff00《内测无限升级》#W", 5, 103 )
             --AddNumText( sceneId, x002025_g_scriptId, "#G免费领取#Y赠点", 5, 106 )
             AddNumText( sceneId, x002025_g_scriptId, "#G气血满怒#W治疗", 5, 860 )
             AddNumText( sceneId, x002025_g_scriptId, "#G包裹废品#W清理", 5, 301 )
	      --AddNumText( sceneId, x002025_g_ScriptId, "#G全属光环#Y领取",5,840 )
             AddNumText( sceneId, x002025_g_scriptId, "#G领取个性#W称号", 5, 501 )
             --AddNumText( sceneId, x002025_g_scriptId, "#G超级变身#W有趣", 5, 850 )
             --AddNumText( sceneId, x002025_g_ScriptId, "#G特效风火轮#gffff00(加速10%)",5,800 )
             --AddNumText( sceneId, x002025_g_ScriptId, "#G特效海之蓝#gffff00(加速10%)",5,810 )
             --AddNumText( sceneId, x002025_g_ScriptId, "#G特效子母绿#gffff00(加速10%)",5,820 )
             --AddNumText( sceneId, x002025_g_ScriptId, "#G特效胭脂雪#gffff00(加速10%)",5,830 )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end

--**********************************
--事件列表选中一项
--**********************************
function x002025_OnEventRequest( sceneId, selfId, targetId, eventId )
	elseif GetNumText() == 301 then

		BeginEvent( sceneId )
			AddText( sceneId, "#Y欢迎使用【背包清理】,#cFF0000使用该功能后,物品包裹和材料包裹中所有物品将被全部清除!#Y请确认身上重要物品是否已存仓库." )
			AddNumText( sceneId, x002025_g_ScriptId, "#G确认清理包裹", 5, 302 )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	elseif GetNumText() == 302 then
		local ClearCount = 0
		for i = 0, x002025_g_MaxBagSize - 1 do
			if LuaFnEraseItem(sceneId, selfId, i) > 0 then
				ClearCount = ClearCount + 1
			end
		end
		x002025_NotifyFailTips(sceneId, selfId, "#Y一共有#effc9d8#cf30768"..ClearCount.."#Y格装备被清理")

      elseif GetNumText() == 450 then

			DispatchShopItem( sceneId, selfId,targetId, x002025_g_shoptableindex )
	elseif GetNumText() == 800 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 14017, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"领取光环成功，祝您游戏快乐，万事如意。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 810 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 14018, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"领取光环成功，祝您游戏快乐，万事如意。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)

	elseif GetNumText() == 820 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 14019, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"领取光环成功，祝您游戏快乐，万事如意。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)

	elseif GetNumText() == 830 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 14020, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"领取光环成功，祝您游戏快乐，万事如意。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)

       elseif GetNumText() == 850 then
             	BeginEvent( sceneId )
		AddText( sceneId, "#cFF0000介绍：#Y请选择您喜欢变身模型，让你看起来与众不同。" )
		AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y兔爷",7,8501 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y玉兔",7,8502 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y黑熊",7,8503 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y灯谜",7,8504 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y圣诞树",7,8505 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y大铃铛",7,8506 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y糖果盒",7,8507 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y粉红熊",7,8508 )
		--AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y小狐仙",7,8509 )
		--AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y大笨熊",7,8510 )
		--AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y功夫熊猫",7,8511 )
		--AddNumText( sceneId, x002025_g_ScriptId, "#G超级变身#W--#Y超人熊猫",7,8512 )
    	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

	elseif GetNumText() == 8501 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 4878, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8502 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 4867, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8503 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 4828, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8504 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5723, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8505 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 4863, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8506 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 4864, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8507 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 4865, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8508 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 4866, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8509 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5710, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8510 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5006, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8511 then
             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5708, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
	elseif GetNumText() == 8512 then
              LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 5709, 0)
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"变身成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)

      elseif GetNumText() == 860 then
              x002025_Restore_hpmp( sceneId, selfId, targetId )
		LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"治疗成功，独家天龙私服祝您游戏愉快。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)

      elseif GetNumText() == 870 then
	       if GetItemCount(sceneId, selfId, 39910008) < 10 then
                 TryRecieveItem( sceneId, selfId, 10305007, 10)

		   LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 18, 0)
		   BeginEvent(sceneId)
		   AddText(sceneId,"领取成功，独家天龙私服祝您游戏愉快。")
		   EndEvent(sceneId)
		   DispatchEventList(sceneId,selfId,targetId)
              else
               	BeginEvent( sceneId ) 
					strText = "你包裹已经有指南了,不要消遣本NPC了!"
					AddText( sceneId, strText )					
				EndEvent( sceneId )
               	DispatchEventList( sceneId, selfId, targetId )
	        end

      elseif GetNumText() == 104 then

             LuaFnSendSpecificImpactToUnit(sceneId, selfId, selfId, selfId, 30150, 0)
		BeginEvent(sceneId)
		AddText(sceneId,"领取光环成功，自身属性加强了。谢谢你对天龙的支持。")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
       elseif GetNumText() == 501 then
             	BeginEvent( sceneId )
		AddText( sceneId, "#cFF0000介绍：#Y请选择您喜欢的个性称号，让你看起来与众不同。" )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000不狠站不稳﹏",7,1500 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000の神马都浮云",7,1501 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000_____疯子",7,1502 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000请止步、禁区。",7,1503 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000﹏你旳笑慌乱了我旳骄傲〃",7,1504 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000透过骨zI里的霸气 ▍",7,1505 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000小情兽feel﹏",7,1506 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000请原谅我的痴心妄想//",7,1507 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000公告：此人伤不起゛",7,1508 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000●﹎мé埘尙引领潮流゛",7,1509 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000这年头感情全是走私货︶",7,1510 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000嫁谁不好就嫁给我吧い",7,1511 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000爷单身1`却潇洒_",7,1512 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF0000极品 ≤zha1-男≥",7,1513 )
		AddNumText( sceneId, x002025_g_ScriptId, "#G称号-#cFF000033心66狗77饭88妹",7,1514 )
    	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )

	elseif GetNumText() == 1500 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000不狠站不稳﹏" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000不狠站不稳﹏#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
	
	elseif GetNumText() == 1501 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000の神马都浮云" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000の神马都浮云#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		
	elseif GetNumText() == 1502 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000_____疯子" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000_____疯子#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		
	elseif GetNumText() == 1503 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000请止步、禁区" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000请止步、禁区#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		
	elseif GetNumText() == 1504 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000﹏你旳笑慌乱了我旳骄傲" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000﹏你旳笑慌乱了我旳骄傲#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		
	elseif GetNumText() == 1505 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000透过骨zI里的霸气 ▍" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000透过骨zI里的霸气 ▍#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1506 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000小情兽feel﹏" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000小情兽feel﹏#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1507 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000请原谅我的痴心妄想//" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000请原谅我的痴心妄想//#G称号" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1508 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000公告：此人伤不起゛" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000公告：此人伤不起゛#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1509 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000●﹎мé埘尙引领潮流゛" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000●﹎мé埘尙引领潮流゛#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1510 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000这年头感情全是走私货︶" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000这年头感情全是走私货︶#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1511 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000嫁谁不好就嫁给我吧い" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000嫁谁不好就嫁给我吧い#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1512 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000爷单身1`却潇洒_" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000爷单身1`却潇洒_#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1513 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF0000极品 ≤zha1-男≥" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF0000极品 ≤zha1-男≥#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
	elseif GetNumText() == 1514 then
		LuaFnAwardSpouseTitle( sceneId, selfId, "#cFF000033心66狗77饭88妹" )
		DispatchAllTitle( sceneId, selfId )
		BeginEvent( sceneId )
			AddText( sceneId, "#G恭喜，您成功领取了#cFF000033心66狗77饭88妹#G称号。" )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
			
      elseif GetNumText() == 106 then
	local	lev	= GetLevel( sceneId, selfId )
	if lev < 30 then
		BeginEvent( sceneId )
		AddText( sceneId, "#b#Y 对不起,你的级别不足#G30#W级，请#G30#W级后再来领取免费增点! " )
		EndEvent( sceneId )
		DispatchEventList( sceneId, selfId, targetId )
		return -1
	end
          --local CurTime = GetHourTime()
        local CurTime = mod(GetQuarterTime(),100);
		local iTime = GetMissionData( sceneId, selfId, MF_LINGQUYUANBAOEXP1 )
		if iTime+2 >= CurTime then
			BeginEvent( sceneId )
			AddText( sceneId, "尊敬的玩家，您1小时内只能领取一次10000赠点。" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
			return
		else
           for i = 0,0 do
          --AddExp(sceneId,selfId,700000)
	      local result =	ZengDian(sceneId,selfId,targetId,1,10000)
	             local str = format("#Y免费赠点#cff99cc：#effc9d8#cf30768#b#W#{_INFOUSR%s}#cff99cc在#G洛阳#cff99cc免费领取NPC。#W领取了#cFF0000 10000 赠点,#W所有玩家1个小时可以领取一次！", GetName(sceneId,selfId) )
	             BroadMsgByChatPipe(sceneId, selfId, str, 4)
               end

			
			SetMissionData(sceneId, selfId, MF_LINGQUYUANBAOEXP1, CurTime)
			BeginEvent( sceneId )
				AddText( sceneId, "领取成功，您成功的领取了10000赠点。一个小时之后可以再次领取哦！" )
			EndEvent( sceneId )
			DispatchEventList( sceneId, selfId, targetId )
		end


             elseif GetNumText() == 107 then
                
-- 千佛莲灯的ID
	       local nStoneId = 30505022
            if LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId)>=5 then
                        BeginEvent( sceneId ) 
			LuaFnDelAvailableItem(sceneId,selfId,nStoneId,5)
			TryRecieveItem( sceneId, selfId, 30505156, 1 )
                        AddText( sceneId, "领取成功，请到升级NPC哪儿进行升级！" )
 
                    EndEvent( sceneId )
              DispatchEventList( sceneId, selfId, targetId )

                    else
                BeginEvent( sceneId ) 
			
	       AddText( sceneId, "请搜集够5千佛莲灯物品再来兑换,129级之后请用回梦石或者帮贡找NPC进行升级" )
               EndEvent( sceneId )

           DispatchEventList( sceneId, selfId, targetId )
  
               end 
          elseif GetNumText() == 108 then
                
-- 千佛莲灯的ID
	       local nStoneId = 30505155
            if LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId)>=6 then
                        BeginEvent( sceneId ) 
			LuaFnDelAvailableItem(sceneId,selfId,nStoneId,6)
			TryRecieveItem( sceneId, selfId, 30505156, 1 )
                       TryRecieveItem( sceneId, selfId, 30505156, 1 )
                       TryRecieveItem( sceneId, selfId, 30505156, 1 )
                        TryRecieveItem( sceneId, selfId, 30505156, 1 )
                        TryRecieveItem( sceneId, selfId, 30505156, 1 )
                        AddText( sceneId, "领取成功，请到升级NPC哪儿进行升级！" )
 
                    EndEvent( sceneId )
              DispatchEventList( sceneId, selfId, targetId )

                    else
                BeginEvent( sceneId ) 
			
	       AddText( sceneId, "请搜集够6千天尽沙物品再来兑换5个回梦石,129级之后请用回梦石找NPC进行升级" )
               EndEvent( sceneId )

           DispatchEventList( sceneId, selfId, targetId )
  
               end 
elseif GetNumText() == 109 then
local cityguildid = GetCityGuildID(sceneId, selfId)
if cityguildid ~=-1 then
AddText( sceneId, "对不起！你还没有加入帮派,而且帮派要有城市,要不哪来的帮贡点啊" )
		return
	end
	      local    bg = CityGetAttr( sceneId, selfId, GUILD_CONTRIB_POINT )

            if bg >= 50  then
                        BeginEvent( sceneId ) 
			CityChangeAttr( sceneId, selfId, GUILD_CONTRIB_POINT, -100 )
			TryRecieveItem( sceneId, selfId, 30008019, 1 )
                   
                        AddText( sceneId, "领取特赦令成功" )
 
                    EndEvent( sceneId )
              DispatchEventList( sceneId, selfId, targetId )

                    else
                BeginEvent( sceneId ) 
			
	       AddText( sceneId, "请刷帮贡到100点才能进行兑换,请到100点后再来兑换" )
               EndEvent( sceneId )

           DispatchEventList( sceneId, selfId, targetId )
  
               end 

elseif GetNumText() == 110 then
    local cityguildid = GetCityGuildID(sceneId, selfId)
if cityguildid ~=-1 then
AddText( sceneId, "对不起！你还没有加入帮派,而且帮派要有城市,要不哪来的帮贡点啊" )
		return
	end            


	      local    bg = CityGetAttr( sceneId, selfId, GUILD_CONTRIB_POINT )

              local nStoneId = 30505156
            if LuaFnGetAvailableItemCount(sceneId, selfId, nStoneId)>=10 then
                        BeginEvent( sceneId ) 
			CityChangeAttr( sceneId, selfId, GUILD_CONTRIB_POINT, 10 )
			LuaFnDelAvailableItem(sceneId,selfId,nStoneId,10)
                   
                        AddText( sceneId, "成功兑换10点帮贡" )
 
                    EndEvent( sceneId )
              DispatchEventList( sceneId, selfId, targetId )

                    else
                BeginEvent( sceneId ) 
			
	       AddText( sceneId, "请确认你包里有10个回梦石,再来兑换"..cityguildid.."" )
               EndEvent( sceneId )

           DispatchEventList( sceneId, selfId, targetId )
  
               end 


	end	
end
--**********************************
--对话提示
--**********************************
function x002025_TalkMsg( sceneId, selfId, targetId, str )	
	BeginEvent(sceneId)
      AddText(sceneId, str)
  EndEvent(sceneId)
  DispatchEventList(sceneId,selfId,targetId)    
end

--**********************************
-- 屏幕中间信息提示
--**********************************
function x002025_NotifyFailTips( sceneId, selfId, Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--恢复血和气
--**********************************
function x002025_Restore_hpmp( sceneId, selfId, targetId )
	RestoreHp( sceneId, selfId )
	RestoreMp( sceneId, selfId )
	RestoreRage( sceneId, selfId )
end
--**********************************
--领取元宝
--**********************************
function x002025_lingquyuanbao( sceneId, selfId, targetId )
  local mylevel = GetLevel( sceneId, selfId )
  if mylevel <  GetNumText() then
  local strText = format("您的等级不够，待等级达到%d级再来找我吧。", GetNumText() )
  x002025_TalkMsg( sceneId, selfId, targetId, strText )
  return
  end
  if GetNumText()==80 then
    local index =	GetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO80 )
      if index == 1 then
        x002025_TalkMsg( sceneId, selfId, targetId, "您已经领取过该项奖励，不能再领了。" )	
        return
      end
    YuanBao(sceneId,selfId,targetId,1,50000)
    SetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO80, 1 )
    x002025_TalkMsg( sceneId, selfId, targetId, "领取元宝成功，您获得了50000元宝。谢谢你对天龙的支持。" )
  elseif GetNumText()==90 then
    local index =	GetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO90 )
      if index == 1 then
        x002025_TalkMsg( sceneId, selfId, targetId, "您已经领取过该项奖励，不能再领了。" )	
        return
      end
    YuanBao(sceneId,selfId,targetId,1,100000)
    SetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO90, 1 )
    x002025_TalkMsg( sceneId, selfId, targetId, "领取元宝成功，您获得了100000元宝。谢谢你对天龙的支持。" )
    elseif GetNumText()==100 then
    local index =	GetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO100 )
      if index == 1 then
        x002025_TalkMsg( sceneId, selfId, targetId, "您已经领取过该项奖励，不能再领了。" )	
        return
      end
    YuanBao(sceneId,selfId,targetId,1,150000)
    SetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO100, 1 )
    x002025_TalkMsg( sceneId, selfId, targetId, "领取元宝成功，您获得了150000元宝。谢谢你对天龙的支持。" )
    elseif GetNumText()==110 then
    local index =	GetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO110 )
      if index == 1 then
        x002025_TalkMsg( sceneId, selfId, targetId, "您已经领取过该项奖励，不能再领了。" )	
        return
      end
    YuanBao(sceneId,selfId,targetId,1,200000)
    SetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO110, 1 )
    x002025_TalkMsg( sceneId, selfId, targetId, "领取元宝成功，您获得了200000元宝。谢谢你对天龙的支持。" )
    elseif GetNumText()==120 then
    local index =	GetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO120 )
      if index == 1 then
        x002025_TalkMsg( sceneId, selfId, targetId, "您已经领取过该项奖励，不能再领了。" )	
        return
      end
    YuanBao(sceneId,selfId,targetId,1,300000)
    SetMissionFlag( sceneId, selfId, MF_LINGQUYUANBAO120, 1 )
    x002025_TalkMsg( sceneId, selfId, targetId, "领取元宝成功，您获得了300000元宝。谢谢你对天龙的支持。" )
   end
end


