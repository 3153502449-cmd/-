-- 300304 
-- 亮银游龙卡
-- 脚本号
x300304_g_scriptId = 300304
--**********************************
--事件交互入口
--**********************************
function x300304_OnDefaultEvent( sceneId, selfId, bagIndex )
	CallScriptFunction(889678, "OnActiveCard", sceneId, selfId,bagIndex)
	return
end
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x300304_IsSkillLikeScript( sceneId, selfId )
	return 0
end
