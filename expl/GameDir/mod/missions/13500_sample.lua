local this={	
	missionCode=13500, --Mission id, here taken from tex's range as it's also just a test thing
    location="EXPL", --Location name id, from the location script
       
	packs = function(missionCode)
		TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk"
		TppPackList.AddLocationCommonScriptPack(missionCode)
        TppPackList.AddLocationCommonMissionAreaPack(missionCode)
        TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_TANK)
        TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.EAST_LV)
		TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
        TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ORDER_BOX)
        --Mission pack must ALWAYS BE LAST IN THE LIST
		TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/story/s13500/s13500.fpk"

		
    end,
	missionGuaranteeGMP=300000, -- GMP received after completing the mission
	fovaSetupFunc = function(locationName,missionId)
        TppEneFova.SetupFovaForLocation("afgh") --faces
    end,
	lzInfo={
        -- LZ name from .fox2
        ["lz_oldfob_N0000|lz_oldfob_N_0000"]={
            -- apr, heli coming in when called in from the ground, stops at lz
            approachRoute="lz_oldfob_N0000|rt_apr_oldfob_N_0000",
            -- drp, entering mission area riding the heli and leaving after dropping off the player / i still have no way to make this work, the player was to automaticaly spawn on the map |:
            dropRoute="lz_drp_oldfob_N0000|rt_drp_oldfob_N_0000",
            -- rtn, leaving after holding at lz when the player calls it it from the ground, starts at lz
            returnRoute="lz_oldfob_N0000|rt_rtn_oldfob_N_0000",
        },
    },--lzInfo},
    
	startPos={0,0,0},

}
return this