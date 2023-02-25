local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}
this.USE_COMMON_REINFORCE_PLAN = true	

this.ENEMY_TANK1 = "veh_expl000_0000"
this.ENEMY_CAR1 = "veh_expl000_0001"

this.soldierDefine =
{
	base1_cp = 
	{		
		"base1_soldier01", 

	},	
	nil
}

this.routeSets = {
	
	base1_cp = {
		priority = {	
			"groupA",	
			nil
		},		
		sneak_day = {
			groupA =
			{ 
				"oldfob_sol_0000_N",
			},			
			
		},
		sneak_night= {
			groupA =
			{ 
				"oldfob_sol_0000_N",
			},			
			
		},
		caution = {
			groupA =
			{ 
				"oldfob_sol_0000_N",
			},			
			
		},
		nil
	},


	nil
}


this.RouteSetsAfter = {
	
	base1_cp = {
		priority = {	
			"groupA",	
			nil
		},		
		sneak_day = {
			groupA =
			{ 
				"oldfob_sol_0000_N",
			},			
			
		},
		sneak_night= {
			groupA =
			{ 
				"oldfob_sol_0000_N",
			},			
			
		},
		caution = {
			groupA =
			{ 
				"oldfob_sol_0000_N",
			},			
			
		},
		nil
	},


	nil
}


this.cpGroups = {	
	group_Area1 =
	{	
		"base1_cp",
	},
}


this.combatSetting = {
	base1_cp = { 
		"TppGuardTargetData0000", 
		"TppCombatLocatorSetData0000",
		},	
	nil
}

-- "COMBAT_SPECIAL", "NVG", "STEALTH_SPECIAL", "FULTON_SPECIAL", "STRONG_NOTICE_TRANQ", "HOLDUP_SPECIAL", "STRONG_PATROL", "GUN_LIGHT",
this.soldierPowerSettings = {	
	
	bas1_soldier01 = { "SOFT_ARMOR", "MISSILE", "COMBAT_SPECIAL", "STEALTH_SPECIAL", "FULTON_SPECIAL", "STRONG_NOTICE_TRANQ", "HOLDUP_SPECIAL", "STRONG_PATROL", "GUN_LIGHT",},
	
}

this.vehicleDefine = { instanceCount = 2 }	

this.VEHICLE_SPAWN_LIST = {
	{
		id="Spawn",
		locator="veh_expl000_0000",
		type=Vehicle.type.EASTERN_TRACKED_TANK,
		class = Vehicle.class.DEFAULT,
	},
	
	{
		id="Spawn",
		locator="veh_expl000_0001",
		type=Vehicle.type.EASTERN_LIGHT_VEHICLE,
		class = Vehicle.class.DEFAULT,
	},	
}

--this.SpawnVehicleOnInitialize = function()
	
	
--	local spawnList = {
--		{ id="Spawn", locator="veh_unsa000_0000", type=Vehicle.type.EASTERN_TRACKED_TANK,	index = 1 },
--		{ id="Spawn", locator="veh_unsa000_0001", type=Vehicle.type.EASTERN_TRACKED_TANK,	index = 2 },
--		
--	}
--	TppEnemy.SpawnVehicles( spawnList )
--end

this.vehicleDefine = {
	instanceCount	= #this.VEHICLE_SPAWN_LIST + 1,
}

this.SpawnVehicleOnInitialize = function()
	TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST )
end

this.InitEnemy = function ()
	-- Nothing

end

this.SetUpEnemy = function ()
	--TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	TppEnemy.ChangeRouteSets( this.RouteSetsAfter )
	
	TppEnemy.InitialRouteSetGroup {
	        cpName = "base1_cp",
	        soldierList = 
			{ 
				"base1_soldier01",
			},
	        groupName = "groupA",
		}
	
	
	GameObject.SendCommand( GameObject.GetGameObjectId( "TppSoldier2", this.soldierDefine ), { id = "SetCommandPost", cp="base1_cp" } )
	
	
	
	-- SHOTGUNS
	--GameObject.SendCommand( GameObject.GetGameObjectId( "bas1_soldier01" ), { id = "SetEquipId", primary = TppEquip.EQP_WP_Com_sg_020_FL } )
	--GameObject.SendCommand( GameObject.GetGameObjectId( "bas1_soldier02" ), { id = "SetEquipId", primary = TppEquip.EQP_WP_Com_sg_020_FL } )
	--GameObject.SendCommand( GameObject.GetGameObjectId( "bas1_soldier03" ), { id = "SetEquipId", primary = TppEquip.EQP_WP_Com_sg_020_FL } )
	--GameObject.SendCommand( GameObject.GetGameObjectId( "bas1_soldier04" ), { id = "SetEquipId", primary = TppEquip.EQP_WP_Com_sg_020_FL } )
	


	
end

this.OnLoad = function ()
	TppEquip.RequestLoadToEquipMissionBlock( {	TppEquip.EQP_WP_Com_sg_020_FL, })

end


return this
