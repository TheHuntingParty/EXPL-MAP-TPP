local this = {}

--TppMission.OnAllocate
--Leaving by heli will clear the mission
this.ENABLE_DEFAULT_HELI_MISSION_CLEAR = true

this.requires = {
	"/Assets/tpp/level/mission2/story/s13500/s13500_orderBoxList.lua",
}

this.NPC_ENTRY_POINT_SETTING = {
	[ Fox.StrCode32("lz_drp_oldfob_N0000|rt_drp_oldfob_N_0000") ] = {
		[EntryBuddyType.VEHICLE] = { Vector3(-1, 0, 0), TppMath.DegreeToRadian( 255 ) }, 
		[EntryBuddyType.BUDDY] = { Vector3(2, 0, 0), TppMath.DegreeToRadian( 280 ) }, 
	},
}
--At least one sequence has to be defined here
local seq={
	{
		--Main Game - before executing the mission completion requirement
		Seq_Game_MainGame = {
			--Sequences are string-associated arrays of possible functions. See TppSequence for more.
			--The self argument allows you to access any additional arbitrary table values in the current sequence.
			--The seeminlgy unused sequenceName (own name) argument returns the string name of the current seqeuence with TppSequence.GetSequenceNameWithIndex(svars.seq_sequence). 
			--Messages(self,sequenceName) - return a StrCode32Table of messages.
			--OnEnter(self,sequenceName) - executes upon entry into the sequence.
			--OnUpdate(self,sequenceName) - executes repeatedly while in the sequence.
			--OnLeave(self,sequenceName) - executes when leaving the sequence.
		}
	},
	{
		--Travel between sequences with TppSequence.SetNextSequence("Seq_Game_Escape")
		--Escape - after having executed the mission completion requirement, in this state, leaving will successfully clear the mission
		Seq_Game_Escape = {
			OnEnter=function(self,sequenceName)
				--Objectives have been completed, escaping the mission area will now consitute a mission clear. Hot zone appears as well.
				TppMission.CanMissionClear()
			end,
		}
	},
}

--TppHelicopter.Init
--Table describing mission start positions
this.missionStartPosition = {
	orderBoxList = {
		--Order box names, i.e. "box_s12000_00",
	},
	helicopterRouteList = {
		--Drop point route names, sometimes, need to be here
		"lz_drp_oldfob_N0000|rt_drp_oldfob_N_0000",
	},
}

--TppMain.OnAllocate
--The list of large and outerBase outposts that can have checkpoint traps.
--If they're acknowledged here, the checkpoint functionality will apply. Not important otherwise.
this.baseList={
	"base1_cp",
}

--No caller, so it must be global.
function this.OnLoad()
	local sequenceNames = {}
	local sequences = {}
	for index, seqTable in ipairs(seq) do
		for seqName, sequenceTable in pairs(seqTable) do
			sequenceNames[index]=seqName
			sequences[seqName]=sequenceTable
		end
	end
	--Register sequence names in order, first sequence will be the starting one
	TppSequence.RegisterSequences(sequenceNames)
	--Register sequence tables
	TppSequence.RegisterSequenceTable(sequences)
end

return this