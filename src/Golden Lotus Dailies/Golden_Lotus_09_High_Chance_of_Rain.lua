-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_09_High_Chance_of_Rain")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(31756)

-- Quest Objective
BANETO_DefineQuestTargetId(214899)
BANETO_DefineQuestTargetId(214900)
BANETO_DefineQuestTargetId(214901)
BANETO_DefineQuestTargetId(214895)

-- Quest Locations
BANETO_DefineCenter(1627.4318847656, 1269.5202636719, 463.03427124023, 150)
BANETO_DefineCenter(1477.4821777344, 1388.1213378906, 444.74633789062, 150)
BANETO_DefineCenter(1639.8022460938, 1548.3728027344, 440.14541625977, 150)
BANETO_DefineCenter(1573.4532470703, 1190.1579589844, 445.09268188477, 150)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_10_Stone_Hard_Quilen]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true
local lastQuestProgress = nil
local lastTargetGuid = nil
local targetStartTime = nil
local maxWaitTime = 10000 -- 10 seconds max wait before blacklisting

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31756) then
        BANETO_Print("Quest not found, skipping!")
        BANETO_LoadQuestProfile([[Golden_Lotus_10_Stone_Hard_Quilen]])
        return
    end

    local currentTarget = BANETO_GetTarget()
    local currentTime = GetTime() * 1000 -- Convert to milliseconds

    -- Get current quest progress
    local questData = C_QuestLog.GetQuestObjectives(31756)
    local currentProgress = questData and questData[1] and questData[1].numFulfilled or 0

    -- Initialize progress tracking on first run
    if lastQuestProgress == nil then
        lastQuestProgress = currentProgress
    end

    -- If we have a target and it's a staff object
    if currentTarget then
        -- Check if this is a new target
        local targetX, targetY, targetZ = BANETO_ObjectPosition(currentTarget)

        if not BANETO_PlayerPosition(targetX, targetY, targetZ, 5) then
            return
        end

        if currentTarget ~= lastTargetGuid then
            lastTargetGuid = currentTarget
            targetStartTime = currentTime
        end

        -- Check if quest progress has increased (successful interaction)
        if currentProgress > lastQuestProgress then
            BANETO_Print("Quest progress increased! Blacklisting staff!")
            BANETO_AddMobToGuidBlacklist(currentTarget)
            lastQuestProgress = currentProgress
            lastTargetGuid = nil
            targetStartTime = nil
            return
        end

        -- Check if we've been targeting this staff too long without progress
        if targetStartTime and (currentTime - targetStartTime) > maxWaitTime then
            BANETO_Print("No progress after " .. (maxWaitTime / 1000) .. " seconds. Blacklisting staff!")
            BANETO_AddMobToGuidBlacklist(currentTarget)
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
