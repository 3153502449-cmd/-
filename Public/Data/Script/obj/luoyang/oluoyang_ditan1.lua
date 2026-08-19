--洛阳NPC
--地摊
--普通

--地摊
x000158_g_shoptableindex=258

--**********************************
--事件交互入口
--**********************************
function x000158_OnDefaultEvent( sceneId, selfId,targetId )
	DispatchShopItem( sceneId, selfId,targetId, x000158_g_shoptableindex )
end
