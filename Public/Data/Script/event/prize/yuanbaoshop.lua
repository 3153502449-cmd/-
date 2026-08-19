--新的元宝商店

x888902_g_scriptId = 888902
--元宝商店列表 要与客户端界面对应
x888902_g_shoplist = {}
x888902_g_shoplist[1]	= {120, 121, 122, 123, 124, 125}		--大卖场
x888902_g_shoplist[2]	= {126, 127, 132, 128, 129, 131}--130 133			--宝石商城,添加"大理宝石斋--149",czf,2009.07.21
x888902_g_shoplist[3]	= {134, 135, 136, 137, 138, 139, 140}--141			--珍兽商城
x888902_g_shoplist[4]	= {142, 143, 144}				--南北杂货
x888902_g_shoplist[5]	= {145, 146, 147, 148, 149, 150, 151, 152}			--形象广场
x888902_g_shoplist[6]	= {153, 154} --155 156				--花舞人间
x888902_g_shoplist[7]	= {157, 158}	--158 159 160					--武功秘籍
x888902_g_shoplist[8]	= {161, 162, 163, 164, 165, 166, 167, 168}	--打造图

x888902_g_shoplist[101]	= {169,170,171}	
x888902_g_shoplist[102]	= {172,173}	
x888902_g_shoplist[103]	= {174}	
x888902_g_shoplist[104]	= {175}				
x888902_g_shoplist[105]	= {120}	
x888902_g_shoplist[106]	= {120}			
x888902_g_shoplist[107]	= {120}				
x888902_g_shoplist[108]	= {120}	

x888902_g_shoplist[9]	= {120}			--我要更强大
x888902_g_shoplist[10]	= {120}			--我要更有魅力
x888902_g_shoplist[11]	= {120}			--我要打造极品装备
x888902_g_shoplist[12]	= {120}				--我要打造极品珍兽
x888902_g_shoplist[13]	= {120}					--我要移动的更快
x888902_g_shoplist[14]	= {120}			--我要向别人表白
x888902_g_shoplist[15]	= {120}				--我要学习新技能

--**********************************
-- 检查此随身NPC的功能
-- op是请求类别，比如1代表元宝相关的随身操作……
--**********************************
function x888902_OpenYuanbaoShop( sceneId, selfId, targetId , shopA ,shopB )

	local bCheck = x888902_YuanbaoShopCheckOp(sceneId,selfId);
	
	if bCheck > 0 then
		if shopA > 0 and shopA < 109 and x888902_g_shoplist[shopA][shopB] ~= nil then
			--PrintStr(x888902_g_shoplist[shopA][shopB])
			if targetId == -1 then
				DispatchYuanbaoShopItem( sceneId, selfId, x888902_g_shoplist[shopA][shopB])
			else
				DispatchNpcYuanbaoShopItem( sceneId, selfId, targetId , x888902_g_shoplist[shopA][shopB])
			end
		end
	end
	
	
end

function x888902_YuanbaoShopCheckOp(sceneId,selfId)
	--地府
	if sceneId == 77 then 
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:地府里不能使用元宝商店功能", 0);
		return 0
	end
	--组队跟随
	local selfHasTeamFlag = LuaFnHasTeam(sceneId, selfId);
	if selfHasTeamFlag and selfHasTeamFlag == 1 then
		local teamFollowFlag = IsTeamFollow(sceneId,selfId);
		local teamLeaderFlag = LuaFnIsTeamLeader(sceneId,selfId);
		if not teamLeaderFlag or not teamFollowFlag then
			return 0
		end
		if teamFollowFlag ~= 0 and teamLeaderFlag ~= 1 then
			return 0
		end
	end
	--双人骑乘
	local selfHasDRideFlag = LuaFnGetDRideFlag(sceneId, selfId);
	if selfHasDRideFlag and selfHasDRideFlag == 1 then
		local selfIsDRideMountOwner = LuaFnIsDRideMountOwner(sceneId, selfId);
		if not selfIsDRideMountOwner or selfIsDRideMountOwner ~= 1 then
			--处于双人骑乘状态，且是被动的，交给主动方来处理
			return 0
		end
	end
	--15级以上
	local level = GetLevel(sceneId,selfId);
	if nil == level or level < 15 then
		BroadMsgByChatPipe(sceneId, selfId, "@*;SrvMsg;DBD:此功能只有当您的等级大于等于15级的时候方可使用", 0);
		return 0
	else

		return 1
	end
	return 0
end
