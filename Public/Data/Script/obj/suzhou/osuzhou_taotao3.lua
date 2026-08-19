--苏州NPC
--套套
--普通

--套套
x001088_g_shoptableindex=256

--**********************************
--事件交互入口
--**********************************
function x001088_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x001088_g_shoptableindex )
end
