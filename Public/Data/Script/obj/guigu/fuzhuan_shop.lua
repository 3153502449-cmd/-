--商店
--门派商店
--逍遥 奇门遁甲

--脚本号
x080022_g_ScriptId = 080022

--商店号
x080022_g_shoptableindex=85

--商店名称
x080022_g_ShopName = "购买鬼谷符箓配方"

--**********************************
--任务入口函数
--**********************************
function x080022_OnDefaultEvent( sceneId, selfId, targetId )	--点击该任务后执行此脚本
	DispatchShopItem( sceneId, selfId,targetId, x080022_g_shoptableindex )
end

--**********************************
--列举事件
--**********************************
function x080022_OnEnumerate( sceneId, selfId, targetId )
	--判断是否是本派弟子
	if GetMenPai(sceneId,selfId) == MP_GUIGU then
		AddNumText(sceneId,x080022_g_ScriptId,x080022_g_ShopName,7,-1)
    end
	return
end

--**********************************
--检测接受条件
--**********************************
function x080022_CheckAccept( sceneId, selfId )
end

--**********************************
--接受
--**********************************
function x080022_OnAccept( sceneId, selfId )
end

--**********************************
--放弃
--**********************************
function x080022_OnAbandon( sceneId, selfId )
end

--**********************************
--继续
--**********************************
function x080022_OnContinue( sceneId, selfId, targetId )
end

--**********************************
--检测是否可以提交
--**********************************
function x080022_CheckSubmit( sceneId, selfId )
end

--**********************************
--提交
--**********************************
function x080022_OnSubmit( sceneId, selfId, targetId,selectRadioId )
end

--**********************************
--杀死怪物或玩家
--**********************************
function x080022_OnKillObject( sceneId, selfId, objdataId,objId)
end

--**********************************
--进入区域事件
--**********************************
function x080022_OnEnterArea( sceneId, selfId, zoneId )
end

--**********************************
--道具改变
--**********************************
function x080022_OnItemChanged( sceneId, selfId, itemdataId )
end
