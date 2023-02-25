local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}

this.requires = {
	"/Assets/tpp/level/mission2/story/s13500/s13500_orderBoxList.lua",
}

this.MAX_PICKABLE_LOCATOR_COUNT = 100

this.MAX_PLACED_LOCATOR_COUNT = 200	

this.NO_MISSION_TELOP_ON_START_HELICOPTER = true 

this.NO_RESULT = true

this.NPC_ENTRY_POINT_SETTING = {
	[ Fox.StrCode32("lz_drp_oldfob_N0000|rt_drp_oldfob_N_0000") ] = {
		[EntryBuddyType.VEHICLE] = { Vector3(-1, 0, 0), TppMath.DegreeToRadian( 255 ) }, 
		[EntryBuddyType.BUDDY] = { Vector3(2, 0, 0), TppMath.DegreeToRadian( 280 ) }, 
	},
	[ Fox.StrCode32("lz_drp_oldfob_N0001_drp") ] = {
		[EntryBuddyType.VEHICLE] = { Vector3(157.5, 0.1, 110.876), TppMath.DegreeToRadian( 15 ) }, 
		[EntryBuddyType.BUDDY] = { Vector3(157.348, 0.1, 110.876), TppMath.DegreeToRadian( 5 ) }, 
	},
}


function this.OnLoad()
	Fox.Log("#### OnLoad ####")	

	TppSequence.RegisterSequences{
		
		"Seq_Game_FreePlay",
			
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end





this.saveVarsList = {
	acceptMissionId					= 0,		
	isUniqueInter_interpreter		= 0,		
	isInterpreterRecognized			= false,	
	isOnGetIntel_LostQuiet			= false,	
	
	isBrokenGimmick_s10043_01		= false,	
	isBrokenGimmick_s10043_02		= false,	
	isBrokenGimmick_s10043_03		= false,	
	isBrokenGimmick_s10043_04		= false,	
	isBrokenGimmick_MissionClear	= false,	
}


this.checkPointList = {
	
	
	"CHK_bas1",
	nil
}


this.baseList = {
	
	"bas1",
	nil
}







this.missionObjectiveDefine = {

	default_none = {},
}












this.missionObjectiveTree = {
	default_none = {
	},
}

this.missionObjectiveEnum = Tpp.Enum{

	"default_none",
}


this.missionStartPosition = {
	
	orderBoxList = {		
	},
	helicopterRouteList = {
		"lz_drp_oldfob_N0000|rt_drp_oldfob_N_0000",
	},
}







function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")

	
	this.RegiserMissionSystemCallback()
	
	TppScriptBlock.RegisterCommonBlockPackList( "orderBoxBlock", s13012_orderBoxList.orderBoxBlockList )

	
	TppRatBird.EnableBird( "TppCritterBird" )

	
	Gimmick.EnableAlarmLampAll(false)
end






function this.OnGameOver()
	Fox.Log("*** " .. tostring(gameOverType) .. " OnGameOver ***")
	if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_KILL_CHILD_SOLDIER ) then
		TppPlayer.SetPlayerKilledChildCamera()
		TppMission.ShowGameOverMenu{ delayTime = TppDefine.GAME_OVER_TARGET_DEAD_DEMO_TIME }
		return true
	end
end




function this.OnRestoreSVars()
	
end


this.OnEndMissionPrepareSequence = function ()

	
	if TppMission.IsMissionStart() then
		Fox.Log( "ContainerRestore!!!!!" )
		this.commonContainerRestore()
		
	end

end

this.commonContainerRestore = function ()
	Gimmick.ResetGimmick(
		TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER,
		Gimmick.ResetGimmickData("TppPermanentGimmickData0000","/Assets/tpp/level/location/unsa/block_common/unsa_common_gimmick.fox2"))
	
end




function this.RegiserMissionSystemCallback()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " RegiserMissionSystemCallback ***")

	
	
		
		
		
		
	
	local systemCallbackTable ={
		OnEstablishMissionClear = function( missionClearType )
			
			local orderBoxName = TppMission.FindOrderBoxName( gvars.mis_orderBoxName )
			if ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO ) then
				if orderBoxName then
					local START_MISSION_GAME_END_TIME = 0.33
					local START_OPENING_DEMO_FADE_SPEED = TppUI.FADE_SPEED.FADE_HIGHESTSPEED
					TppSoundDaemon.PostEvent('sfx_s_ifb_mbox_arrival')
					GkEventTimerManager.Start( "Timer_LoadOpeningDemoBlock", START_OPENING_DEMO_FADE_SPEED + START_MISSION_GAME_END_TIME )
					GkEventTimerManager.Start( "Timer_StartMissionGamEndOnOpeningDemo", START_MISSION_GAME_END_TIME )
				else
					Fox.Warning("Cannot find orderBoxName from this.missionStartPosition.orderBoxList")
					TppMission.MissionGameEnd()
				end
			elseif ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR ) then
				SubtitlesCommand.SetIsEnabledUiPrioStrong( true ) 
				TppRadioCommand.SetEnableIgnoreGamePause( true )	
				if not mvars.f30010_playerFultoned then 
					this._ForceMBCamera()
				end
				TppMission.MissionGameEnd{ fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED, fadeDelayTime = 3.5 }
			else
				TppMission.MissionGameEnd()
			end
		end,
		OnDisappearGameEndAnnounceLog = function( missionClearType )
			
			if ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO ) then
				local orderBoxName = TppMission.FindOrderBoxName( gvars.mis_orderBoxName )
				if not orderBoxName then
					Fox.Error("Cannot get orderBoxName. gvars.mis_orderBoxName = " .. tostring(gvars.mis_orderBoxName) )
				end
				TppMission.ShowMissionReward()
				return
			end

			
			if	( missionClearType == TppDefine.MISSION_CLEAR_TYPE.QUEST_BOSS_QUIET_BATTLE_END )
			or	( missionClearType == TppDefine.MISSION_CLEAR_TYPE.QUEST_LOST_QUIET_END )
			or	( missionClearType == TppDefine.MISSION_CLEAR_TYPE.QUEST_INTRO_RESCUE_EMERICH_END ) then
				TppMission.MissionFinalize{ isNoFade = true, showLoadingTips = false }
				return
			end

			Player.SetPause()
			TppMission.ShowMissionReward()
		end,
		OnEndMissionReward = function()
			local missionClearType = TppMission.GetMissionClearType()
			if ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO ) then
				f30010_demo.PlayOpening()
			elseif ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR ) then
				Fox.Log("OnEndMissionReward to MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR")
				local radioList = TppStory.GetForceMBDemoNameOrRadioList("clearSideOpsForceMBRadio", { clearSideOpsName = mvars.qst_currentClearQuestName })
				if radioList and radioList[1] then
					mvars.freePlay_ForceGoToMbRadioName = radioList[1]
					SubtitlesCommand.SetIsEnabledUiPrioStrong( true )	
					TppRadioCommand.SetEnableIgnoreGamePause( true )	
					TppRadio.Play( radioList, { isEnqueue = true, delayTime = TppRadio.PRESET_DELAY_TIME.mid } )
				else
					SubtitlesCommand.SetIsEnabledUiPrioStrong( false )	
					TppRadioCommand.SetEnableIgnoreGamePause( false )	
					TppSound.PostEventOnForceGotMbHelicopter()
					TppMission.MissionFinalize{ isNoFade = true, showLoadingTips = false }
				end
			else
				TppMission.MissionFinalize{ isNoFade = true }
			end
		end,
		
		
		CheckMissionClearOnRideOnFultonContainer = function()
			return true
		end,
		nil
	}

	
	TppMission.RegiserMissionSystemCallback(systemCallbackTable)
end




function this.AcceptMission( missionId )
	TppMission.AcceptMissionOnFreeMission( missionId, f30010_orderBoxList.orderBoxBlockList, "acceptMissionId" )
end





function this.OnCheckMBReturnRadio()
	Fox.Log("### OnCheckMBReturnRadio ###")
	local currentStorySequence = TppStory.GetCurrentStorySequence()
	local playerRideState = Player.GetGameObjectIdIsRiddenToLocal()
	local rideHeli = 7168

end








function this.Messages()
	return
	StrCode32Table {
		Player = {
			{
				msg = "PlayerFultoned",
				func = function( )
					mvars.f30010_playerFultoned = true
				end,
				option = { isExecMissionClear = true },
			},
		},
		Radio = {
			{
				msg = "Finish",
				func = function( radioGroupNameHash )
					if not mvars.freePlay_ForceGoToMbRadioName then
						return
					end

					if radioGroupNameHash == Fox.StrCode32(mvars.freePlay_ForceGoToMbRadioName) then
						SubtitlesCommand.SetIsEnabledUiPrioStrong( false )	
						TppRadioCommand.SetEnableIgnoreGamePause( false )	
						TppSound.PostEventOnForceGotMbHelicopter()
						TppMission.MissionFinalize{ isNoFade = true, showLoadingTips = false }
					end
				end,
				option = { isExecMissionClear = true },
			},
		},
		Block = {
			{
				msg = "OnChangeLargeBlockState",
				func = function( blockName , state)
					
					if state == StageBlock.INACTIVE then
						this.OnCheckMBReturnRadio()
					end
				end,
			},
		},
		UI = {
			{
				msg = "StartMissionTelopFadeIn", 	func = function()
					DemoDaemon.SkipAll()
				end,
				option = { isExecDemoPlaying = true, isExecMissionClear = true }
			},
			nil
		},
		Timer = {
			
			{
				msg = "Finish",	sender = "Timer_LoadOpeningDemoBlock",
				func = s13012_demo.LoadOpeningDemoBlock,
				option = { isExecMissionClear = true },
			},
			{
				msg = "Finish",	sender = "Timer_StartMissionGamEndOnOpeningDemo",
				func = function()
					TppMission.MissionGameEnd{ fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED }
				end,
				option = { isExecMissionClear = true },
			},
		},
		Terminal = {
			{
				msg = "MbDvcActAcceptMissionList", func = this.AcceptMission,
			},
		},
		
		GameObject = {
			{	
				msg = "HeliDoorClosed", sender = "SupportHeli",
				func = function ()
					Fox.Log("Mission clear : on Heli")
					
					TppMission.ReserveMissionClear{
						missionClearType = TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,
						nextMissionId = TppDefine.SYS_MISSION_ID.AFGH_HELI,
					}
				end
			},
			{	
				msg =	"ChangePhase",
				func = function( cpId, phase )
					
					if cpId == GameObject.GetGameObjectId("afgh_powerPlant_cp") then
						Fox.Log( "**** s30010_sequence.ChangePhase::powerPlant ****"..phase )
						if phase == TppGameObject.PHASE_ALERT or phase == TppGameObject.PHASE_EVASION then
							Gimmick.EnableAlarmLampAll(true)	
						else
							Gimmick.EnableAlarmLampAll(false)
						end
					end
				end
			},									
		},
	}
end


sequences.Seq_Game_FreePlay = {

	Messages = function( self ) 
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeIn", sender = "FadeInOnGameStart",
					func = function()
						if TppSequence.IsHelicopterStart() then
							TppTerminal.ShowLocationAndBaseTelopForStartFreePlay()
						end
					end,
				},
				nil
			},
			nil
		}
	end,

	OnEnter = function()
		Fox.Log("######## Seq_Game_FreePlay.OnEnter ########")

		
		TppRadio.SetOptionalRadio( "Set_f2000_oprg0010" )

		Fox.Log("########     Free Heli Radio    ############")
		TppFreeHeliRadio.OnEnter()				

	end,

	OnLeave = function()
		TppFreeHeliRadio.OnLeave()
	end,
}


return this