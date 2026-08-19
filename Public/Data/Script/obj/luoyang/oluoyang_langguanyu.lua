--洛阳NPC
--郎冠宇
--普通

--药店
x000065_g_shoptableindex=32

--**********************************
--事件交互入口
--**********************************
function x000065_OnDefaultEvent( sceneId, selfId,targetId )
    if GetName(sceneId,targetId) == "钱二娘" then
	BeginEvent( sceneId )
		local strText = "    我钱二娘，四处闯荡。寻边山海得到些稀有药品，肉类，矿类。如果少侠有所需要可到我这里购买，不过，价格也自然不会便宜。"
		AddText( sceneId, strText )
		AddNumText( sceneId, 000065, "稀有草药", 5, 1)
		AddNumText( sceneId, 000065, "新鲜鱼虾贝", 5, 2)
		AddNumText( sceneId, 000065, "稀有矿石（1）", 5, 3)
		AddNumText( sceneId, 000065, "稀有矿石（2）", 5, 4)
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
	else
	DispatchShopItem( sceneId, selfId,targetId, x000065_g_shoptableindex )
	end
end


function x000065_OnEventRequest( sceneId, selfId, targetId, eventId )
       if GetNumText() == 1 then
	   DispatchShopItem( sceneId, selfId,targetId, 209 )
       end
       if GetNumText() == 2 then
	   DispatchShopItem( sceneId, selfId,targetId, 210 )
       end
       if GetNumText() == 3 then
	   DispatchShopItem( sceneId, selfId,targetId, 211 )
       end
       if GetNumText() == 4 then
	   DispatchShopItem( sceneId, selfId,targetId, 212 )
       end
end