-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_05_Given_a_Second_Chance")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[UseItemOnNpc]])
BANETO_DefineQuestId(30312)

-- NPC Information
BANETO_DefineQuestPickupNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58468)
BANETO_DefineQuestTurninNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58468)

-- Quest Item
BANETO_DefineQuestTargetId(84242)

-- Quest Objective
BANETO_DefineQuestTargetId(59183)

-- Quest Locations
BANETO_DefineCenter(1443.3646240234, 1143.2777099609, 429.45077514648, 200)

-- Next Quest - Chain to consolidated turn-in handler after completing all quest objectives
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_TurnIn_All]])

-- Quest Pulse
_G.BANETO_SCAN_FLYINGMOBS = true
_G.BANETO_ALLOWSCAN_COMBATMOBS = true
-- _G.BANETO_ExecuteCustomQuestPulse_Questmaster = true
-- _G.BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true
-- local lastStepProgress = nil
-- local questID = 30312
-- local stepIndex = 1

-- function _G.BANETO_ExecuteCustomQuestPulse()
-- 	local questData = C_QuestLog.GetQuestObjectives(questID)
-- 	local finished = questData[stepIndex]["finished"]
-- 	local stepProgress = questData[stepIndex]["numFulfilled"]

-- 	-- Check if we have stored progress from the last pulse, if not, initialize it
-- 	if lastStepProgress == nil then
-- 		lastStepProgress = stepProgress
-- 	end

-- 	-- If progress has increased by 1, add the current mob to the blacklist
-- 	if stepProgress > lastStepProgress and stepProgress == lastStepProgress + 1 then
-- 		local currentTarget = BANETO_Object("target")

-- 		-- Check if target is already blacklisted (already healed)
-- 		if BANETO_IsGuidContainedInGuidBlacklist(currentTarget) then
-- 			BANETO_Print("Wounded Defender already blacklisted (healed) - Clearing target!")
-- 			BANETO_ClearTarget()
-- 			return
-- 		end

-- 		if currentTarget then
-- 			BANETO_AddMobToGuidBlacklist("target")
-- 			BANETO_AddMobToGuidBlacklist(currentTarget)
-- 			BANETO_AddMobToGuidBlacklist(UnitGUID("target"))

-- 			BANETO_Print("Healed Wounded Defender - Adding to blacklist!")
-- 		end
-- 	end

-- 	-- Update the stored progress for the next pulse
-- 	lastStepProgress = stepProgress

-- 	if finished then
-- 		BANETO_LoadProfile([[Golden_Lotus_TurnIn_All]])
-- 	end
-- end
