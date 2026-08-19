--门派雕像系统-NPC
--2019-9-13 23:40:52 逍遥子 逻辑：焚尽铅华
--2019-11-1 19:12:03 逍遥子 桃花岛添加
x900034_g_ScriptId = 900034;
x900034_g_MenPai = {
[0]  = "少林",
[1]  = "明教",
[2]  = "丐帮",
[3]  = "武当",
[4]  = "峨嵋",
[5]  = "星宿",
[6]  = "天龙",
[7]  = "天山",
[8]  = "逍遥",
[9]  = "Error",
[10] = "慕容",
[11] = "唐门",
[12] = "鬼谷",
[13] = "桃花岛",
};
--底部显示字典
x900034_g_MenPaiShowText = {
[0]  = "#{XY_0110_14}",
[1]  = "#{XY_0110_15}",
[2]  = "#{XY_0110_16}",
[3]  = "#{XY_0110_17}",
[4]  = "#{XY_0110_18}",
[5]  = "#{XY_0110_19}",
[6]  = "#{XY_0110_20}",
[7]  = "#{XY_0110_21}",
[8]  = "#{XY_0110_22}",
[9]  = "Error",
[10] = "#{XY_0110_23}",
[11] = "#{XMPTM_130123_35}",
[12] = "#{XY_160530_03}",
[13] = "#{XY_160530_06}",
};
--公告显示内容
x900034_g_MenPaiShowText_Global = {
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将少林武学发挥到彩虹，已进入无人之境，#Y少林第一人#H是少林武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将明教武学发挥到彩虹，已进入无人之境，#Y明教第一人#H是明教武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将丐帮武学发挥到彩虹，已进入无人之境，#Y丐帮第一人#H是丐帮武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将武当武学发挥到彩虹，已进入无人之境，#Y武当第一人#H是武当武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将峨嵋武学发挥到彩虹，已进入无人之境，#Y峨嵋第一人#H是峨嵋武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将星宿武学发挥到彩虹，已进入无人之境，#Y星宿第一人#H是星宿武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将天龙武学发挥到彩虹，已进入无人之境，#Y天龙第一人#H是天龙武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将天山武学发挥到彩虹，已进入无人之境，#Y天山第一人#H是天山武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将逍遥武学发挥到彩虹，已进入无人之境，#Y逍遥第一人#H是逍遥武学领域的最高荣誉。",
	"Error-MenPaiTop-GlobalShow",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将慕容武学发挥到彩虹，已进入无人之境，#Y慕容第一人#H是慕容武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将唐门武学发挥到彩虹，已进入无人之境，#Y唐门第一人#H是唐门武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将鬼谷武学发挥到彩虹，已进入无人之境，#Y鬼谷第一人#H是鬼谷武学领域的最高荣誉。",
	"#H朝廷在#G洛阳（228，129）#H处，为#{_INFOUSR%s}树立起巨大的#cff0000雕像#H，传说此人将桃花岛武学发挥到彩虹，已进入无人之境，#Y桃花岛第一人#H是桃花岛武学领域的最高荣誉。",
}
--./XYD_DataBase/AvatarSystem/
--**********************************
--事件交互入口
--**********************************
function x900034_OnDefaultEvent( sceneId, selfId,targetId )
	local nMenPaiID = LuaFnGetNpcIntParameter( sceneId,targetId,2);
	local MosterName = GetName(sceneId,targetId)
	local nPos = strfind(MosterName,"的雕像");
	if nPos then
		MosterName = strsub(MosterName,1,nPos-1);
	end
	local nShowMsg = ""
	--字库显示
	--#Y少林第一人：#G%s
	if x900034_g_MenPai[nMenPaiID] ~= nil then
		nShowMsg = "#Y"..x900034_g_MenPai[nMenPaiID].."第一人：#G"..MosterName..x900034_g_MenPaiShowText[nMenPaiID]
	end
	BeginEvent(sceneId)
		AddText(sceneId,nShowMsg)
		AddNumText( sceneId, x900034_g_ScriptId, "#{XY_0110_24}", 6, 1 )
		AddNumText( sceneId, x900034_g_ScriptId, "#{XY_0110_26}", 6, 2 )
		AddNumText( sceneId, x900034_g_ScriptId, "#{XY_0110_27}", 11, 3 ) 
	EndEvent(sceneId)
	DispatchEventList(sceneId,selfId,targetId)
end
--**********************************
--事件相应
--**********************************
function x900034_OnEventRequest( sceneId, selfId, targetId, eventId )
	local nNumID = GetNumText();
	if nNumID == 1 then
		x900034_SetTop( sceneId, selfId, targetId )
		return
	end
	if nNumID == 2 then
		x900034_GetTop( sceneId, selfId, targetId )
		return
	end
	if nNumID == 3 then
		BeginEvent(sceneId)
			AddText(sceneId,"#{XY_0110_28}")
		EndEvent(sceneId)
		DispatchEventList(sceneId,selfId,targetId)
		return
	end
end
--**********************************
--关闭NPC交互
--**********************************
function x900034_CloseNpcWind(sceneId, selfId, targetId)
	BeginUICommand( sceneId )
		UICommand_AddInt( sceneId, targetId )
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId, 1000 )	
end
--**********************************
--消息框
--**********************************
function x900034_Box( sceneId, selfId, targetId, Box )
	BeginEvent( sceneId )
		AddText( sceneId, Box )
	EndEvent( sceneId )
	DispatchEventList( sceneId, selfId, targetId )
end
--**********************************
--醒目事件提醒
--**********************************
function x900034_Tip( sceneId,selfId,Tip )
	BeginEvent( sceneId )
		AddText( sceneId, Tip )
	EndEvent( sceneId )
	DispatchMissionTips( sceneId, selfId )
end

--**********************************
--打开名人堂显示
--**********************************
function x900034_GetTop( sceneId, selfId, targetId )
	local nMenPaiID = LuaFnGetNpcIntParameter( sceneId,targetId,2);
	local Txt = "./ZY_DataBase/AvatarSystem/MenPaiTop"..nMenPaiID..".txt";
	local nSign = "%d+,%d+,(.+)";
	local nHumanData = {};
	local nLineID,nHumanNum = "",0;
	local nHandle = openfile(Txt,"r");
	if nHandle then
		for i=1,10 do
			nLineID = read(nHandle,"*l");
			if nLineID and nLineID ~= "" then
				local _,_,nData = strfind(nLineID,nSign);
				if nData then
					nHumanNum = nHumanNum + 1;
					nHumanData[nHumanNum] = nData;
				else
					break
				end
			else
				break
			end
		end
		closefile(nHandle);
	end
	if nHumanNum ~= 10 then
		x900034_Tip( sceneId,selfId,"名人堂服务端数据异常，请联系GM来解决问题" );
		return
	end
	--打开客户端UI
	BeginUICommand( sceneId );
	UICommand_AddInt(sceneId,targetId);
	UICommand_AddInt(sceneId,nMenPaiID);
	for i = 1,10 do
		UICommand_AddString(sceneId,nHumanData[i]);
	end
	UICommand_AddString(sceneId,"1000000116");
	EndUICommand( sceneId )
	DispatchUICommand( sceneId, selfId,1000000116)
end
--**********************************
--设置第一人数据 新写逻辑
--**********************************
function x900034_SetTopData(sceneId,selfId,targetId)
	local nMenpai = LuaFnGetNpcIntParameter(sceneId,selfId,targetId,2);
	local nSelfMenPai = GetMenPai(sceneId,selfId);
	--首先比较等级
	if GetLevel(sceneId,selfId) < 50 then
		x900034_Tip(sceneId,selfId,"#{XY_0110_30}");
		return
	end
	if nMenpai ~= nSelfMenPai then
		x900034_Tip(sceneId,selfId,"#{XY_0110_35}");
		return
	end

end
--**********************************
--设置第一人数据
--**********************************
function x900034_SetTop( sceneId, selfId, targetId )
	local Par = LuaFnGetNpcIntParameter( sceneId,targetId,2);
	local Mp = GetMenPai(sceneId, selfId);
	if Mp ~= Par then
		x900034_Tip( sceneId,selfId,"#{XY_0110_35}" )
		return
	end
	local Lv = LuaFnGetLevel( sceneId, selfId );
	if Lv < 50 then
		x900034_Tip( sceneId,selfId,"#{XY_0110_30}" )
		return
	end
	local Tab1 = {};
	local Tab2 = {};
	--身份证,怪物号,角色名,性别,门派,帮会,等级,历史总分\n
	local Fa = "(%d+),(%d+),(.+),%d,%d+,.+,(%d+),(%d+)";
	local Line;
	local Fag = 0;
	local Txt = "./ZY_DataBase/AvatarSystem/MenPaiTop"..Par..".txt"
	local Op = openfile(Txt,"r");
	if Op then
		for i=1,10 do
			Par = read(Op,"*l");
			if Par then
				local _,_,F1,F2,F3,F4,F5 = strfind(Par,Fa);
				F1 = tonumber(F1);
				F2 = tonumber(F2);
				F4 = tonumber(F4);
				F5 = tonumber(F5);
				if F5 then
					Fag = Fag + 1;
					Tab1[Fag] = {F1,F2,F3,F4,F5};
				else
					break
				end
				Tab2[i] = Par;
			else
				break
			end
		end
		closefile(Op);
	end
	if Fag ~= 10 then
		x900034_Tip( sceneId,selfId,"门派雕像数据初始化异常，请联系GM解决问题！" );
		return
	end
	local F1 = LuaFnGetGUID( sceneId, selfId);
	local F2 = LuaFnGetName( sceneId, selfId );
	local F3 = GetSex(sceneId,selfId);
	local F4 = LuaFnGetGuildName(sceneId, selfId);
	if not F4 or F4 == "" then
		F4 = "无";
	end
	local F5 = GetMissionData(sceneId,selfId,XYJ_EQUIP_GRADE);
	local F6 = LuaFnGetNpcIntParameter( sceneId,targetId,F3);
	local MyTop = format("%d,%d,%s,%d,%d,%s,%d,%d",F1,F6,F2,F3,Mp,F4,Lv,F5);
	local MyTop1 = {F1,F6,F2,Lv,F5};
	local Fag1,Fag2,Fag4,Fag5 = 0,0,0,10;
	local OldNO = Tab1[1][1];
	local Mos = LuaFnGetNpcIntParameter( sceneId,targetId,3);
	for i=1,10 do
		Fag = Tab1[i];
		if Fag[1] == F1 then
			Fag1 = i;
			break
		end
	end
	if Fag1 > 0 then
		if Tab1[Fag1][4] ~= Lv or Tab1[Fag1][5] ~= F5 then
			tremove(Tab1,Fag1);
			tinsert(Tab1,MyTop1)
			tremove(Tab2,Fag1);
			tinsert(Tab2,MyTop)
			Fag2 = 1;
		elseif Tab2[Fag1] == MyTop then
			Fag2 = 3;
		else
			Tab1[Fag1] = MyTop1;
			Tab2[Fag1] = MyTop;
			Fag2 = 2;
		end
	end
	if Fag2 < 2 then
		Fag5=Fag5-Fag2;
		for i=1,Fag5 do
			Fag = Tab1[i];
			if Lv > Fag[4] then
				Fag4 = i;
				break
			elseif Lv == Fag[4] then
				if F5 > Fag[5] then
					Fag4 = i;
					break
				end
			end
		end
		if Fag4 > 0 then
			tinsert(Tab1,Fag4,MyTop1);
			tinsert(Tab2,Fag4,MyTop);
		end
	end
	if Fag2 < 3 then
		local NewTop = "";
		for i=1,10 do
			NewTop = NewTop..Tab2[i].."\n";
		end
		Op = openfile(Txt,"wb");
		if Op then
			write(Op,NewTop)
			closefile(Op)
		end
	end
	local Fag3 = Tab1[1];
	if Mos ~= Fag3[1] then
		local NewStr = Fag3[1]..","..Fag3[2]..","..Fag3[4]..","..Fag3[3].."的雕像\n";
		local NewTop = "";
		Fag = Mp;
		if Mp < 9 then
			Fag = Mp + 1;
		end
		Txt = "./ZY_DataBase/AvatarSystem/AllMenPaiTop.txt";
		Op = openfile(Txt,"r");
		if Op then
			for i=1,13 do
				Fag2 = read(Op,"*l");
				if Fag2 then
					if i ~= Fag then
						NewTop = NewTop..Fag2.."\n";
					else
						NewTop = NewTop..NewStr;
					end
				else
					NewTop = NewTop.."0,52013,1,虚位以待\n";
				end
			end
			closefile(Op);
		end
		Op = openfile(Txt,"wb");
		if Op then
			write(Op,NewTop)
			closefile(Op)
		end
		local Msg = format(x900034_g_MenPaiShowText_Global[Mp + 1],F2);
		local Posx, Posz = GetWorldPos(sceneId,targetId);
		local J1 = LuaFnGetNpcIntParameter( sceneId,targetId,0);
		local J2 = LuaFnGetNpcIntParameter( sceneId,targetId,1);
		local Dir = LuaFnGetNpcIntParameter( sceneId,targetId,4);
		Dir1 = Dir/100;
		x900034_CloseNpcWind(sceneId, selfId, targetId);
		LuaFnDeleteMonster(sceneId,targetId);
		local MonId = LuaFnCreateMonster(sceneId, Fag3[2], 0, 0, 3, -1, 900034)
		local nName = Fag3[3].."的雕像";
		LuaFnSetNpcIntParameter( sceneId,MonId,0,J1);
		LuaFnSetNpcIntParameter( sceneId,MonId,1,J2);
		LuaFnSetNpcIntParameter( sceneId,MonId,2,Mp);
		LuaFnSetNpcIntParameter( sceneId,MonId,3,Fag3[1]);
		LuaFnSetNpcIntParameter( sceneId,MonId,4,Dir);
		SetLevel(sceneId,MonId, Fag3[4] )
		SetCharacterName(sceneId, MonId,nName);
		nName = format("#{XYJ_MENPAI_%d}第一人",Mp);
		SetCharacterTitle(sceneId,MonId,nName);
		SetObjDir(sceneId,MonId,Dir1 );
		SetPos(sceneId,MonId,Posx,Posz);
		LuaFnAwardTitle( sceneId, selfId,5,Mp+103)
	    SetCurTitle(sceneId,selfId,5,Mp+103)
	    LuaFnDispatchAllTitle(sceneId, selfId)
		x900034_Tip( sceneId,selfId,"#{XY_0110_66}" )
		local Msg = format("@*;SrvMsg;SCA:"..Msg);
		AddGlobalCountNews( sceneId, Msg );
		return
	end
	x900034_Tip( sceneId,selfId,"#{XY_0110_66}" )
end

	
