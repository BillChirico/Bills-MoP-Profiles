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
function _G.BANETO_ExecuteCustomQuestPulse()
	local questID = 30312
	local stepIndex = 1 -- Step index to check
	local questData = C_QuestLog.GetQuestObjectives(questID)
	local isFinishedStep = questData[stepIndex]["finished"]
	local numFulfilled = questData[stepIndex]["numFulfilled"]

	-- Check if we have stored progress from the last pulse, if not, initialize it
	if _G.lastStepProgress == nil then
		_G.lastStepProgress = numFulfilled
	end

	-- If progress has increased by 1, add the current mob to the blacklist
	if numFulfilled > _G.lastStepProgress and numFulfilled == _G.lastStepProgress + 1 then
		local currentTarget = BANETO_Object("target")

		if currentTarget then
			BANETO_AddMobToGuidBlacklist("target")
			BANETO_AddMobToGuidBlacklist(currentTarget)
			BANETO_AddMobToGuidBlacklist(UnitGUID("target"))

			print("Added target to blacklist due to quest progress increase.")
		end
	end

	-- Update the stored progress for the next pulse
	_G.lastStepProgress = numFulfilled
end
