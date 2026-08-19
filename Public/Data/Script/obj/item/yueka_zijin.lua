-- 300305 
-- 紫金游龙卡
-- 脚本号
x300305_g_scriptId = 300305
--**********************************
--事件交互入口
--**********************************
function x300305_OnDefaultEvent( sceneId, selfId, bagIndex )
	CallScriptFunction(889678, "OnActiveCard", sceneId, selfId,bagIndex)
	return 0
end
--**********************************
-- 返回1：技能类似的物品，可以继续类似技能的执行；返回0：执行 OnDefaultEvent。
--**********************************
function x300305_IsSkillLikeScript( sceneId, selfId )
	return 0
end