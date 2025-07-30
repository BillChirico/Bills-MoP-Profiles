-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_05_Given_a_Second_Chance")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[UseItemOnNpc]])
BANETO_DefineQuestId(30312)

-- NPC Information
BANETO_DefineQuestPickupNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58468)
BANETO_DefineQuestTurninNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58468)

-- Quest Objective
BANETO_DefineQuestTargetId(59183)
BANETO_DefineQuestTargetId(84242)

-- Quest Locations
BANETO_DefineCenter(1434.1118164062, 1131.5428466797, 434.8391418457, 300)

-- Next Quest
-- BANETO_SetNextLocalQuestProfile([[Golden_Lotus_06_Next_Quest]])

-- Quest Pulse
-- Pulse
_G.BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
	local tgt = BANETO_GetTarget()

	-- Check if the peon is being lazy
	if BANETO_ObjectId(tgt) then
		if not BANETO_IsGuidContainedInGuidBlacklist(tgt) then
			BANETO_PRINT("Healed Wounded Defender - Adding to blacklist!")
			BANETO_AddMobToGuidBlacklist(tgt)
			BANETO_ClearTarget()
		end
	end
end
