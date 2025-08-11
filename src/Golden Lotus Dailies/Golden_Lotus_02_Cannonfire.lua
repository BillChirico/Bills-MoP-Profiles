-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_02_Cannonfire")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[UseItemOnNpc]])
BANETO_DefineQuestId(31754)

-- Quest Item
BANETO_DefineQuestTargetId(89123) -- Wu Kao Explosive

-- Quest Objective
BANETO_DefineQuestTargetId(65762) -- Shao-Tien Cannon

-- Quest Locations
BANETO_DefineCenter(1467.1362304688, 1356.7120361328, 445.89776611328, 300)
BANETO_DefineCenter(1533.8942871094, 1442.2365722656, 442.35995483398, 300)
BANETO_DefineCenter(1392.3897705078, 1291.5573730469, 401.01940917969, 300)
BANETO_DefineCenter(1674.5532226562, 1352.6085205078, 453.59204101562, 300)

-- Quest Pulse
_G.BANETO_ExecuteCustomQuestPulse_Questmaster = true

local lastQuestProgress = nil
local lastTargetGuid = nil
local targetStartTime = nil
local itemUseTime = nil
local maxWaitTime = 10000 -- 10 seconds max wait before blacklisting

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31754) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Golden_Lotus_03_Unleashed_Spirits]])
        return
    end

    local currentTarget = BANETO_GetTarget()
    local currentTime = GetTime() * 1000 -- Convert to milliseconds

    -- Get current quest progress
    local questData = C_QuestLog.GetQuestObjectives(31754)
    local currentProgress = questData and questData[1] and questData[1].numFulfilled or 0

    -- Initialize progress tracking on first run
    if lastQuestProgress == nil then
        lastQuestProgress = currentProgress
    end

    -- If we have a target and it's a cannon object
    if currentTarget then
        -- Check if this is a new target
        local targetX, targetY, targetZ = BANETO_ObjectPosition(currentTarget)

        if not BANETO_PlayerPosition(targetX, targetY, targetZ, 5) then
            BANETO_MeshTo(targetX, targetY, targetZ)
            return
        end

        BANETO_StopMovement()

        if currentTarget ~= lastTargetGuid then
            lastTargetGuid = currentTarget
            targetStartTime = currentTime
            itemUseTime = nil
        end

        -- Check if quest progress has increased (successful interaction)
        if currentProgress > lastQuestProgress then
            BANETO_Print("Quest progress increased! Blacklisting cannon!")
            BANETO_AddMobToGuidBlacklist(currentTarget)
            lastQuestProgress = currentProgress
            lastTargetGuid = nil
            targetStartTime = nil
            itemUseTime = nil
            return
        end

        -- Use the explosive item on the cannon if we haven't tried recently
        if not itemUseTime or (currentTime - itemUseTime) > 3000 then
            BANETO_Print("Using Wu Kao Explosive on cannon!")
            BANETO_UseItem(89123)
            itemUseTime = currentTime
        end

        -- Check if we've been targeting this cannon too long without progress
        if targetStartTime and (currentTime - targetStartTime) > maxWaitTime then
            BANETO_Print("No progress after " .. (maxWaitTime / 1000) .. " seconds. Blacklisting cannon!")
            BANETO_AddMobToGuidBlacklist(currentTarget) -- Blacklist for failed interactions
            lastTargetGuid = nil
            targetStartTime = nil
            itemUseTime = nil
            return
        end
    else
        -- No target, reset tracking
        if lastTargetGuid then
            lastTargetGuid = nil
            targetStartTime = nil
            itemUseTime = nil
        end
    end

    -- Clear target if it's already blacklisted
    if currentTarget and BANETO_IsGuidContainedInGuidBlacklist(currentTarget) then
        BANETO_Print("Target is blacklisted - Clearing target!")
        BANETO_ClearTarget()
    end
end

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_03_Unleashed_Spirits]])
