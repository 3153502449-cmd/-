--花苗（未成熟）

--**********************************
--事件交互入口
--**********************************
function x335702_OnDefaultEvent( sceneId, selfId,targetId )

	local xiezi = GetMonsterDataID(sceneId, targetId)
	local bb = 5
        if xiezi == 90 then
           bb = 3
        elseif xiezi == 91 then
           bb = 2
        elseif xiezi == 92 then
           bb = 1
 	end
	    BeginEvent( sceneId )
		  AddText( sceneId, "    #W我是一只快快长大的小花苗，还需施肥#G"..bb.."次#W，我就长大啦~" )
	    EndEvent( sceneId )
	    DispatchEventList( sceneId, selfId, targetId )

end
