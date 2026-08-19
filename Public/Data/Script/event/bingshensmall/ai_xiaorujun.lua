--兵圣奇阵 萧如筠
--2019-11-7 18:53:44 逍遥子
x895065_g_ScriptId	= 895065

--副本逻辑脚本号....
x895065_g_FuBenScriptId = 895063

function x895065_OnDie( sceneId, selfId, killerId )

	--重置AI....

	--如果还没有挑战过乌老大则可以挑战乌老大....
	if 1 ~= CallScriptFunction( x895065_g_FuBenScriptId, "GetBossBattleFlag", sceneId, "YeLvYan" )	then
		CallScriptFunction( x895065_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "YeLvYan", 1 )
	end
	
	-- zchw 全球公告
	local	playerName	= GetName( sceneId, killerId )
	
	--杀死怪物的是宠物则获取其主人的名字....
	local playerID = killerId
	local objType = GetCharacterType( sceneId, killerId )
	if objType == 3 then
		playerID = GetPetCreator( sceneId, killerId )
		playerName = GetName( sceneId, playerID )
	end
	
	--如果玩家组队了则获取队长的名字....
	local leaderID = GetTeamLeader( sceneId, playerID )
	if leaderID ~= -1 then
		playerName = GetName( sceneId, leaderID )
	    LuaFnSendSpecificImpactToUnit( sceneId, leaderID, leaderID, leaderID, 8846, 0 )
	end
	
	if playerName ~= nil then
		str = format(" 踏平林阵之后，#{_INFOUSR%s}#P正欲转身离开，却发现受#cFF0000萧如筠#W溃败所倒的竹林中竟藏有绝世宝物#P，于是便欣然将其收入囊中，拍马直奔火阵而去。", playerName); --桑土公
		AddGlobalCountNews( sceneId, str )
	end

	CallScriptFunction( x895065_g_FuBenScriptId, "TipAllHuman", sceneId, "陈勇仁道： 虽说 萧如筠 已败于阵前，但还请迅速击杀 萧如蔚，否则 萧如筠 30秒后将会复生。 。" )

	--设置已经挑战过桑土公....
	CallScriptFunction( x895065_g_FuBenScriptId, "SetBossBattleFlag", sceneId, "XiaoRuJun", 2 )
end
