local this={
	description="EXPL MAP", --An IH-only thing I think?
	locationName="EXPL", --Four-letter name of the map 
	--For the location ID check (https://metalgearmodding.fandom.com/wiki/Custom_Locations_List) for available IDs to avoid mod conflicts 
	locationId=140, --LocationId, also found in the TppLocationData in pack_common.fpkd's common_data DataSet, though there it can be set to 0, like here and in MGO maps, and it works fine. Here the id is near-after 113, the last MGO map.
	packs={
			--here you add the map (location) FPKs
		"/Assets/tpp/pack/location/expl/expl.fpk"

			},
		
		-- TppMissionList.locationPackTable entry. 

	 locationMapParams={ -- These are the iDroid map parameters we'd find in /Assets/tpp/pack/mbdvc/mb_dvc_top_fpkd/Assets/tpp/ui/Script/mbdvc_map_location_parameter.lua
		 stageSize=2048,
		 scrollMaxLeftUpPosition=Vector3(-200,0,-395), -- These 2 define there area where the player can move the mouse while on Idroid / map 
		 scrollMaxRightDownPosition=Vector3(400,0,204), -- Make it big, just in case
		 highZoomScale=2, 
		 middleZoomScale=1,
		 lowZoomScale=0.75,
		 naviHighZoomScale = 2,
		 naviMiddleZoomScale	= 1,
		 locationNameLangId="tpp_loc_expl",
		 stageRotate=0,

		 -- MAP TEXTURES FOR MAP IDROID IMAGES
		 -- You can add them on "Modfolder/Assets/tpp/ui/texture/map/expl"
		-- heightMapTexturePath="/Assets/tpp/ui/texture/map/expl/afn0_iDroid_clp.ftex",
		-- photoRealMapTexturePath="/Assets/tpp/ui/texture/map/expl/afn0_hill_sat_clp.ftex",
		-- uniqueTownTexturePath="/Assets/tpp/ui/texture/map/building_icon/mb_map_bild_icon_afgh_alp_clp.ftex",
		-- commonTownTexturePath="/Assets/tpp/ui/texture/map/building_icon/mb_map_bild_icon_cmn_alp_clp.ftex",
		 townParameter = {
			 { 
				 cpName = "base0_cp", 
				 langId = "", 
				 cursorLangId = "tpp_loc_expl", 
				 position = Vector3(0,0,0), -- this is the possition of the Comand Post - here defines the location of cp and the icon on map
				 radius=400, -- Size of the Comand Post
				 uShift=0.25 , --No clue
				 vShift=0.25 , --No clue
				 mini=true -- No clue
			 },  
		 },
	 },
	 globalLocationMapParams={
		-- Intel level needed to mark objects on the map:
		sectionFuncRankForDustBox = 4, 
		sectionFuncRankForToilet  = 4, 
		-- The map will need a TppUICommand.RegisterCrackPoints table defined, or else it will use the last map's crack points table
		--sectionFuncRankForCrack   = 6, 
		-- Enable enemy FOM: -- enemie red circle on the map
		isSpySearchEnable = Ivars.disableSpySearch~=nil and Ivars.disableSpySearch:Get() or true,--tex was true
		-- Enable herb marking:
		isHerbSearchEnable = Ivars.disableHerbSearch~=nil and Ivars.disableHerbSearch:Get() or true,--tex was true
		-- Size of the FOMs: -- size of the enemies red circles 
		spySearchRadiusMeter = { 40.0, 40.0, 35.0, 30.0, 25.0, 20.0, 15.0, 10.0, },
		-- Intervals between enemy FOM updates, corresponding to Intel level:
		spySearchIntervalSec = { 420.0,	420.0,	360.0,	300.0,	240.0,	180.0,	150.0,	120.0, },
		-- Radius at which Intel will mark herbs, according to Intel level:
		herbSearchRadiusMeter = { 0.0,  0.0,  10.0, 15.0, 20.0, 25.0, 30.0, 35.0, },
	},

}
return this