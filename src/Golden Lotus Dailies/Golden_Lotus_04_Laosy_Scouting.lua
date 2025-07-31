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
--[[
    @Description:
        This quest pulse monitors quest progress and blacklists cage objects only after successful interaction.
        It tracks quest objective progress to ensure the bot doesn't blacklist cages prematurely.
]]
_G.BANETO_ExecuteCustomQuestPulse_Questmaster = true
local lastQuestProgress = nil
local lastTargetGuid = nil
local targetStartTime = nil
local maxWaitTime = 10000 -- 10 seconds max wait before blacklisting

function _G.BANETO_ExecuteCustomQuestPulse()
	local currentTarget = BANETO_GetTarget()
	local currentTime = GetTime() * 1000 -- Convert to milliseconds

	-- Get current quest progress
	local questData = C_QuestLog.GetQuestObjectives(31758)
	local currentProgress = questData and questData[1] and questData[1].numFulfilled or 0

	-- Initialize progress tracking on first run
	if lastQuestProgress == nil then
		lastQuestProgress = currentProgress
	end

	-- If we have a target and it's a cage object
	if currentTarget then
		-- Check if this is a new target
		if currentTarget ~= lastTargetGuid then
			lastTargetGuid = currentTarget
			targetStartTime = currentTime
		end

		-- Check if quest progress has increased (successful interaction)
		if currentProgress > lastQuestProgress then
			BANETO_Print("Quest progress increased! Blacklisting cage!")
			BANETO_AddMobToGuidBlacklist(currentTarget)
			lastQuestProgress = currentProgress
			lastTargetGuid = nil
			targetStartTime = nil
			return
		end

		-- Check if we've been targeting this cage too long without progress
		if targetStartTime and (currentTime - targetStartTime) > maxWaitTime then
			BANETO_Print("No progress after " .. (maxWaitTime / 1000) .. " seconds. Blacklisting cage!")
			BANETO_AddMobToGuidBlacklist(currentTarget) -- Shorter blacklist time for failed interactions
			lastTargetGuid = nil
			targetStartTime = nil
			return
		end
	else
		-- No target, reset tracking
		if lastTargetGuid then
			lastTargetGuid = nil
			targetStartTime = nil
		end
	end

	-- Clear target if it's already blacklisted
	if currentTarget and BANETO_IsGuidContainedInGuidBlacklist(currentTarget) then
		BANETO_Print("Target is blacklisted - Clearing target!")
		BANETO_ClearTarget()
	end
end

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_05_Given_a_Second_Chance]])
