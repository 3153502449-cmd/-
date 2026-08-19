--½Å±¾ºÅ
x403264_g_ScriptId	= 403264

--¸±±¾Âß¼­½Å±¾ºÅ....
x402264_g_FuBenScriptId = 403263
--**********************************
--ËÀÍö....
--**********************************
function x402264_OnDie( sceneId, selfId, killerId )
	local MosDataID = GetMonsterDataID(sceneId,selfId)
 	local MosName = GetName(sceneId,selfId)
	local MosTitle = GetCharacterTitle(sceneId,selfId)
        local x,z = GetWorldPos( sceneId, selfId )

	local MstId = LuaFnCreateMonster( sceneId, MosDataID, x, z, 27, 0, 403264 )
 	SetCharacterName(sceneId, MstId, MosName)
	if MosTitle ~= "" then
		SetCharacterTitle(sceneId, MstId, MosTitle)
	end
end
