-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_01_Laosy_Scouting")
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
BANETO_DefineCenter(1551.1240234375, 1201.814453125, 443.14520263672, 130)
-- BANETO_DefineCenter(1162.54030761719, 1273.8989257812, 463.28009033203, 130)
BANETO_DefineCenter(1678.9040527344, 1388.1376953125, 453.60244750977, 130)
BANETO_DefineCenter(1573.8038330078, 1389.3203125, 445.32727050781, 130)
BANETO_DefineCenter(1511.4365234375, 1475.9962158203, 441.88012695312, 130)
BANETO_DefineCenter(1559.9156494141, 1524.8381347656, 439.8486328125, 130)

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
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_02_Unleashed_Spirits]])
