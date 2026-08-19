--门派雕像系统
--2019-9-13 23:19:50 逍遥子 逻辑：焚尽铅华
--**********************************
--事件交互入口
--**********************************
function x900033_OnDefaultEvent( sceneId, actId, iNoticeType, param2, param3, param4, param5 )
	if sceneId == 0 then
		StartOneActivity( sceneId, actId, 5000, -1 );
		x900033_GenerateMonster( sceneId );
	end
end
--**********************************
--时钟
--**********************************
function x900033_OnTimer( sceneId, actId, uTime )
	StopOneActivity( sceneId, actId )
end
--**********************************
--生成对象
--**********************************
function x900033_GenerateMonster( sceneId )
	
	local nMonsterNum = GetMonsterCount(sceneId);
	if nMonsterNum == 0 then
		return 
	end
	
	--检索场景Monster
	local nMonsterObjId,nMonsterDataId = 0,0;
	nMonsterNum = nMonsterNum - 1;
	for i=0,nMonsterNum do
		nMonsterObjId = GetMonsterObjID(sceneId,i);
		nMonsterDataId = GetMonsterDataID(sceneId,nMonsterObjId );
		if (nMonsterDataId >= 14904 and nMonsterDataId <= 14923) then
			--return
			LuaFnDeleteMonster(sceneId,nMonsterObjId);
		end
	end
	
	local PosX = {99,97,95,93,91,89,87,85,83};
	local PosZ = {173,173,173,173,173,173,173,173,173};
	local Mp = {0,1,2,3,4,5,6,7,8,10,11,12,13};
	local Dir = {6.3,6.3,6.3,6.3,6.3,6.3,6.3,6.3,6.3,6.3,6.3,6.3,6.3}
	local SexTab = {
		[0] = {14904,14906,14908,14910,14912,14914,14916,14918,14920},
		[1] = {14905,14907,14909,14911,14913,14915,14917,14919,14921}
	}
	local nAvatarData = {};
	--数据初始化一次
	nMonsterObjId = 0
	for i=1,13 do
		nAvatarData[i] = {0,55000,1,"虚位以待"};
	end
	local nSign = "(%d+),(%d+),(%d+),(.+)";
	local nHandle = openfile("./ZY_DataBase/AvatarSystem/AllMenPaiTop.txt","r");
	if nHandle then
		for i=1,13 do
			local nLineData = read(nHandle,"*l");
			if nLineData then
				local _,_,nIndex,nDataId,nListIndex,nName = strfind(nLineData,nSign);
				nIndex = tonumber(nIndex);
				nDataId = tonumber(nDataId);				
				nListIndex = tonumber(nListIndex);
				if nIndex and nDataId and nListIndex and nName then
					nMonsterObjId = nMonsterObjId + 1;
					nAvatarData[nMonsterObjId] = {nIndex,nDataId,nListIndex,nName};
				else
					break
				end
			else
				break
			end
		end
		closefile(nHandle);
	end
--	if nMonsterObjId < 13 then
--		nMonsterObjId = 13 - nMonsterObjId;
--		for i=1,nMonsterObjId do
--			nAvatarData[i] = {0,55000,1,"虚位以待"};
--		end
--	end
	local nCharacterName = 0;
	for i=1,13 do
		local MonId = LuaFnCreateMonster(sceneId, nAvatarData[i][2], PosX[i], PosZ[i], 3, -1, 900034)
		--修正异常数据
		if MonId == -1 then
			MonId = LuaFnCreateMonster(sceneId,55000, PosX[i], PosZ[i], 3, -1, 900034)
		end
		if nAvatarData[i][4] and nAvatarData[i][4] ~= -1 and nAvatarData[i][4] ~= "虚位以待" then
			nCharacterName = nAvatarData[i][4].."的雕像";
		else
			nCharacterName = nAvatarData[i][4];
		end
		LuaFnSetNpcIntParameter( sceneId,MonId,0,SexTab[0][i]);
		LuaFnSetNpcIntParameter( sceneId,MonId,1,SexTab[1][i]);
		LuaFnSetNpcIntParameter( sceneId,MonId,2,Mp[i]);
		LuaFnSetNpcIntParameter( sceneId,MonId,3,nAvatarData[i][1]);
		LuaFnSetNpcIntParameter( sceneId,MonId,4,Dir[i]*100);
		SetLevel(sceneId,MonId, nAvatarData[i][3] )
 	    SetCharacterName(sceneId, MonId,nAvatarData[i][4]);
		nCharacterName = format("#{XYJ_MENPAI_%d}第一人",Mp[i]);
 	    SetCharacterTitle(sceneId,MonId,nCharacterName);
		SetObjDir(sceneId,MonId, Dir[i] );
	end
end
