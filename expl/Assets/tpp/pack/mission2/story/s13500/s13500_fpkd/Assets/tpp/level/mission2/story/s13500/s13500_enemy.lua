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
		"base1_soldier02",
		"base1_soldier03",
		"base1_soldier04",
		"base1_soldier05",
		"base1_soldier06",
		"base1_soldier07", 

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
				"expl_sol_0000",
				"expl_sol_0001",
				"expl_sol_0002",
				"expl_sol_0003",
				"expl_sol_0004",
				"expl_sol_0005",
				"expl_sol_0006",
			},			
			
		},
		sneak_night= {
			groupA =
			{ 
				"expl_sol_0000",
				"expl_sol_0001",
				"expl_sol_0002",
				"expl_sol_0003",
				"expl_sol_0004",
				"expl_sol_0005",
				"expl_sol_0006",
			},			
			
		},
		caution = {
			groupA =
			{ 
				"expl_sol_0000",
				"expl_sol_0001",
				"expl_sol_0002",
				"expl_sol_0003",
				"expl_sol_0004",
				"expl_sol_0005",
				"expl_sol_0006",
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
				"expl_sol_0000",
				"expl_sol_0001",
				"expl_sol_0002",
				"expl_sol_0003",
				"expl_sol_0004",
				"expl_sol_0005",
				"expl_sol_0006",
			},			
			
		},
		sneak_night= {
			groupA =
			{ 
				"expl_sol_0000",
				"expl_sol_0001",
				"expl_sol_0002",
				"expl_sol_0003",
				"expl_sol_0004",
				"expl_sol_0005",
				"expl_sol_0006",
			
		}, },
		caution = {
			groupA =
			{ 
				"expl_sol_0000",
				"expl_sol_0001",
				"expl_sol_0002",
				"expl_sol_0003",
				"expl_sol_0004",
				"expl_sol_0005",
				"expl_sol_0006",
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

--Soldier Gear and atributes are defined in  this.soldierPowerSettings

--Gear:
--	SOFT_ARMOR - Regular Kevlar
--	HELMET - adds helmet to the soldier
--	QUEST_ARMOR - Heavy Armor
-- 	NVG - Night Vision Headgear
--  GAS_MASK - Gas Mask, Soldiers will be invunerable to sleeping / toxic gas
--Params:
--	STRONG_WEAPON
--	STRONG_PATROL
--	STRONG_NOTICE_TRANQ
--	FULTON_LOW
--	FULTON_HIGH
--	FULTON_SPECIAL
--	COMBAT_LOW
--	COMBAT_HIGH
--	COMBAT_SPECIAL
--	STEALTH_LOW
--	STEALTH_HIGH
--	STEALTH_SPECIAL
--	HOLDUP_LOW
--	HOLDUP_HIGH
--	HOLDUP_SPECIAL 
--Weapons
--	SNIPER
--	SHIELD (Shield and SMG)
--	MISSILE (Missile Launcher and SMG)
--	MG (machine gun)
--	SHOTGUN
--	SMG
--	GUN_LIGHT (assault rifle)

-- EXAMPLE:  bas1_soldier01 = { "QUEST_ARMOR", "MISSILE", "COMBAT_SPECIAL",}, (this soldier will be equiped with an heavy
--armour and missile launcher, it will also be very good at combat)

this.soldierPowerSettings = {	
	
	base1_soldier01 = { "SOFT_ARMOR",  "SNIPER",},
	base1_soldier02 = { "SOFT_ARMOR",  "SHIELD",},
	base1_soldier03 = { "SOFT_ARMOR",  "MISSILE",},
	base1_soldier04 = { "SOFT_ARMOR",  "MG",},
	base1_soldier05 = { "SOFT_ARMOR",  "SHOTGUN",},
	base1_soldier06 = { "SOFT_ARMOR",  "SMG",},
	base1_soldier07 = { "SOFT_ARMOR",  "GUN_LIGHT",},
	
}


-- TABLE TO CONTROL VEHICLES AND VEHICLES TYPES IN GAME	
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

this.vehicleDefine = {
	instanceCount	= #this.VEHICLE_SPAWN_LIST + 1,
}

--FUNCTION TO SPAWN THE VEHICLES (REQUIERES this.VEHICLE_SPAWN_LIST, this.vehicleDefine )
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
	
	
	
	-- ADD SHOTGUNS MANUALY TO SOLDIERS / WORKS WITH OTHER SPECIFIC WEAPONS 
	--GameObject.SendCommand( GameObject.GetGameObjectId( "base1_soldier01" ), { id = "SetEquipId", primary = TppEquip.EQP_WP_Com_sg_020_FL } )
	
	


	
end
--WEAPONS ADDED MANUALY MUST BE ADDED HERE TOO!

this.OnLoad = function ()
	TppEquip.RequestLoadToEquipMissionBlock( {	TppEquip.EQP_WP_Com_sg_020_FL, })

end


return this
