--苏州NPC
--套套
--普通

--套套
x001087_g_shoptableindex=257

--**********************************
--事件交互入口
--**********************************
function x001087_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x001087_g_shoptableindex )
end
