--苏州NPC
--套套
--普通

--套套
x001086_g_shoptableindex=255

--**********************************
--事件交互入口
--**********************************
function x001086_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x001086_g_shoptableindex )
end
