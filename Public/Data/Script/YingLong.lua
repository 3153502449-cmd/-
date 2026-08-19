--********************************************************************
--作  者:MaoMao QQ:5984763
--用  途:反挂回调
--脚本号:5984763
--时  间:2019-03-13 11:52:36

--使用方法:
--* 上传YingLong.lua至服务端的'/home/tlbb/Public/Data/Script'下
--* Script.dat文件中加入'5984763=\YingLong.lua'
--* AllowableScriptFunc.txt文件中加入'xxx	5984763	MaoMaoYingLong'
--********************************************************************

x5984763_g_scriptId = 5984763

--********************************************************************
--回调函数
--********************************************************************
function x5984763_MaoMaoYingLong(sceneId, selfId, Sign)
	-- Sign代码反挂特征
	
	-- 发送系统公告
	local Str = format( "#{_INFOUSR%s}#cFF0000由于涉嫌使用辅助软件,已进行掉线处理！请各位玩家维护游戏环境远离辅助！", GetName(sceneId,selfId))
	AddGlobalCountNews( sceneId, Str )
	
	-- 可以在这里添加自己功能
	
	-- 保存日志记录
	x5984763_MaoMaoLog(sceneId, selfId, Sign)
end

--********************************************************************
--Log
--********************************************************************
function x5984763_MaoMaoLog(sceneId, selfId, Sign)
	local nPatch = "MaoMao_YingLong"..date("_%Y-%m-%d_%H")
	local x,z = GetWorldPos( sceneId, selfId )
	local LogInfo = format("Callback:Sign=%d GUID=%s Name=%s Scene=(%s,%s,%0.2f,%0.2f) (T0=%s T1=%s)",
		Sign,
		LuaFnGetGUID( sceneId, selfId ),
		LuaFnGetName( sceneId, selfId ),
		GetSceneName( sceneId ),
		sceneId,
		x,
		z,
		date("%Y-%m-%d_%X"),
		clock())

	local nFile = openfile("../Public/Data/Script/"..nPatch..".log", "a+")
	if nFile ~= nil then
		write(nFile, LogInfo)
		write(nFile,tostring("\n"))
		closefile(nFile)
	end
end