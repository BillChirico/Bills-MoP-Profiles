-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_04_Laosy_Scouting")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(31758)

-- NPC Information
BANETO_DefineQuestPickupNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58471)
BANETO_DefineQuestTurninNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58471)

-- Quest Objective
BANETO_DefineQuestTargetId(214948)

-- Quest Locations
BANETO_DefineCenter(1467.1362304688, 1356.7120361328, 445.89776611328, 300)
BANETO_DefineCenter(1533.8942871094, 1442.2365722656, 442.35995483398, 300)
BANETO_DefineCenter(1392.3897705078, 1291.5573730469, 401.01940917969, 300)
BANETO_DefineCenter(1674.5532226562, 1352.6085205078, 453.59204101562, 300)

-- Quest Pulse
_G.BANETO_ExecuteCustomQuestPulse_Questmaster = true

local lastTarget = nil

function _G.BANETO_ExecuteCustomQuestPulse()
	local currentTarget = GetObjectWithIdClose(214948)

	if BANETO_IsGuidContainedInGuidBlacklist(currentTarget) then
		BANETO_Print("Cage already blacklisted - Clearing target!")
		BANETO_ClearTarget()
		return
	end

	-- If the bot has a target and it's a new one since the last pulse
	if currentTarget and currentTarget ~= lastTarget then
		BANETO_Print("Checked cage - Adding to blacklist!")
		BANETO_AddMobToGuidBlacklist(currentTarget)
		BANETO_BlacklistID(currentTarget)
		lastTarget = currentTarget

		return
	end
end

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_05_Given_a_Second_Chance]])
