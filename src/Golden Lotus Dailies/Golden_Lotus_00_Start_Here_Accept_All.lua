-- Golden Lotus Quest Accept Handler
-- ⭐ START HERE: This is the entry point for Golden Lotus dailies!
--
-- This profile will automatically:
-- 1. Check all Golden Lotus NPCs for available daily quests
-- 2. Accept any quests that are offered and not already completed
-- 3. Handle the rotating daily quest system intelligently
-- 4. Start the quest execution chain once all available quests are accepted
--
-- The Golden Lotus daily system rotates quests each day, so not all 8 quests
-- will be available every day. This handler adapts to whatever is offered.

-- luacheck: globals GossipFrame QuestDetailScrollFrame AcceptQuest

BANETO_DefineProfileName("Golden_Lotus_00_Start_Here_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Quest Information Table
-- Contains all 9 possible Golden Lotus daily quests with their associated NPCs
-- Each quest has a rotating availability - not all will be offered each day
local questAccepts = {
    {
        questId = 30307,
        npcId = 58408,
        questName = "The Eternal Vigil",
    },
    {
        questId = 31757,
        npcId = 58465,
        questName = "Unleashed Spirits",
    },
    {
        questId = 31762,
        npcId = 58465,
        questName = "Crumbling Behemoth",
    },
    {
        questId = 31760,
        npcId = 58465,
        questName = "Striking First",
    },
    {
        questId = 30308,
        npcId = 58465,
        questName = "Stone Hard Quilen",
    },
    {
        questId = 31758,
        npcId = 58471,
        questName = "Laosy Scouting",
    },
    {
        questId = 31754,
        npcId = 58471,
        questName = "Cannonfire",
    },
    {
        questId = 31756,
        npcId = 58471,
        questName = "High Chance of Rain",
    },
    {
        questId = 30312,
        npcId = 58468,
        questName = "Given a Second Chance",
    },
    {
        questId = 31755,
        npcId = 58468,
        questName = "Acts of Cruelty",
    }
}

-- Helper function to find quest info from WoW's available quest API
-- @param available: Table returned by C_GossipInfo.GetAvailableQuests()
-- @param questID: The specific quest ID we're looking for
-- @return: Quest info table if found, nil otherwise
local function GetAvailableQuestInfoByID(available, questID)
    for i = 1, #available do
        local info = available[i]

        if info and info.questID == questID then
            return info
        end
    end

    return nil
end

-- NPC Coordinates
-- All Golden Lotus NPCs are located at the Temple of the White Tiger
-- These coordinates ensure proper positioning for quest interactions
local npcCoords = {
    -- Leven Dawnblade (58408)
    [58408] = {
        x = 1211.8581542969,
        y = 1044.7891845703,
        z = 425.96737670898,
    },
    -- Anji Autumnlight (58465)
    [58465] = {
        x = 1211.6048583984,
        y = 1048.1136474609,
        z = 425.96737670898,
    },
    -- Kun Autumnlight(58471)
    [58471] = {
        x = 1211.3977050781,
        y = 1049.5463867188,
        z = 425.96737670898,
    },
    -- Sun Tenderheart (58468)
    [58468] = {
        x = 1215.8614501953,
        y = 1050.3850097656,
        z = 425.96737670898,
    },
}

-- Quest Pulse Configuration
BANETO_ExecuteCustomQuestPulse_Questmaster = true
BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true

-- State management variables
local inProgress = false -- Prevents multiple simultaneous quest accepts
local wait = nil         -- Timer for waiting between interactions
local checked = false    -- Tracks if we've checked an NPC for quests

-- Main quest acceptance logic
-- This function runs continuously until all available quests are accepted
function _G.BANETO_ExecuteCustomQuestPulse()
    if inProgress then
        return
    end

    -- Handle wait timer - prevents spam interactions
    if wait and time() < wait then
        return -- Still waiting, do nothing
    end

    -- Initialize global tracking variables (persistent across function calls)
    if not _G.checkedNpcs then
        _G.checkedNpcs = {} -- Track which NPCs we've fully processed
    end

    if not _G.checkedQuests then
        _G.checkedQuests = {} -- Track which quests we've already handled
    end

    if not _G.processedCount then
        _G.processedCount = 0 -- Count of processed quests for current NPC
    end

    if not _G.totalQuests then
        _G.totalQuests = 0 -- Total quests for current NPC
    end

    -- Group quests by NPC for efficient processing
    -- This creates a table where each NPC ID maps to their quest list
    local questsByNpc = {}
    for i = 1, #questAccepts do
        local quest = questAccepts[i]
        local npcId = quest.npcId

        if not questsByNpc[npcId] then
            questsByNpc[npcId] = {}
        end
        table.insert(questsByNpc[npcId], quest)
    end

    -- Process each NPC and their quests
    for npcId, npcQuests in pairs(questsByNpc) do
        repeat
            BANETO_ClearTarget()

            -- Skip if we've already fully processed this NPC
            if _G.checkedNpcs[npcId] then
                BANETO_Print("NPC " .. npcId .. " already processed")
                
                break
            end

            BANETO_Print("Checking NPC: " .. npcId .. " for " .. #npcQuests .. " possible quests")

            -- Ensure we're in position to interact with the NPC
            if not BANETO_PlayerPosition(npcCoords[npcId].x, npcCoords[npcId].y, npcCoords[npcId].z, 5) then
                -- Move to NPC location and wait for arrival
                BANETO_MeshTo(npcCoords[npcId].x, npcCoords[npcId].y, npcCoords[npcId].z)
                wait = time() + 5 -- Wait 5 seconds for movement
                BANETO_Print("Moving to NPC " .. npcId)

                return
            end

            BANETO_StopMovement()

            -- Try to find the NPC object in the game world
            local questGiver = GetObjectWithId(npcId)
            local questGiverId = BANETO_GetTargetId()

            -- If NPC not found (out of range, not spawned, etc.), mark as complete
            if not questGiver then
                _G.checkedNpcs[npcId] = true
                checked = false
                BANETO_Print("NPC " .. npcId .. " not found")
                C_GossipInfo.CloseGossip()

                return
            end

            -- If the target is not the NPC, clear the target and return
            if questGiverId ~= npcId then
                BANETO_ClearTarget()
                C_GossipInfo.CloseGossip()

                return
            end

            -- Get list of available quests from this NPC
            local availableQuests = C_GossipInfo.GetAvailableQuests()

            -- If no quests are immediately available, try interacting with NPC
            if not availableQuests or #availableQuests == 0 then
                if not checked then
                    -- First attempt: target and interact with NPC to open quest dialog
                    UnlockedTargetUnit(questGiver)
                    BANETO_Interact(questGiver)
                    wait = time() + 5 -- Wait for interaction to process
                    BANETO_Print("Checking NPC " .. npcId .. " for quests")
                    checked = true

                    return
                else
                    -- Second attempt: still no quests found
                    -- For single-quest NPCs, we'll try direct acceptance as fallback
                    BANETO_Print("No quests found for NPC " .. npcId .. ", trying direct acceptance")
                    checked = false
                end
            else
                BANETO_Print("Found " .. #availableQuests .. " available quests from NPC " .. npcId)
                checked = false
            end

            -- Process each potential quest for this NPC
            _G.processedCount = 0
            _G.totalQuests = #npcQuests

            for j = 1, #npcQuests do
                local quest = npcQuests[j]

                -- Skip quests we've already processed in previous iterations
                if _G.checkedQuests[quest.questId] then
                    -- Quest already processed - increment counter
                    _G.processedCount = _G.processedCount + 1
                else
                    -- Check if we already have this quest or completed it today
                    if BANETO_HasQuest(quest.questId) or BANETO_HasQuestCompleted(quest.questId) then
                        -- Quest already in our log or completed - mark as processed
                        _G.checkedQuests[quest.questId] = true
                        _G.processedCount = _G.processedCount + 1
                    else
                        -- Quest is not in our log - check if NPC is offering it
                        local offeredInfo = GetAvailableQuestInfoByID(availableQuests, quest.questId)

                        if offeredInfo then
                            -- Quest is available! Accept it now
                            BANETO_Print("Accepting " ..
                                (offeredInfo.title or quest.questName) ..
                                " (" .. quest.questId .. ") from NPC (" .. npcId .. ")")

                            -- Mark quest as processed and configure Baneto to accept it
                            _G.checkedQuests[quest.questId] = true
                            local coords = npcCoords[npcId]
                            BANETO_DefineQuestId(quest.questId)
                            BANETO_SetToSkipTurnInQuest() -- We'll turn in later via TurnIn_All
                            BANETO_DefineQuestPickupNPC(coords.x, coords.y, coords.z, npcId)

                            -- Switch to normal Baneto behavior to accept quest
                            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
                            BANETO_ExecuteCustomQuestPulse_Questmaster = false
                            BANETO_SetNextLocalQuestProfile([[Golden_Lotus_00_Start_Here_Accept_All]])
                            inProgress = true

                            return
                        elseif not availableQuests or #availableQuests == 0 then
                            -- No API results (single quest NPC case) - use AcceptQuest() directly
                            BANETO_Print("No quests found, trying AcceptQuest() for " ..
                                quest.questName .. " (" .. quest.questId .. ")")

                            -- Try to accept the quest directly using WoW API
                            AcceptQuest()

                            -- Mark quest as processed to avoid retrying
                            _G.checkedQuests[quest.questId] = true
                            _G.processedCount = _G.processedCount + 1
                        else
                            -- Quest not offered by this NPC today - mark as processed
                            _G.checkedQuests[quest.questId] = true
                            _G.processedCount = _G.processedCount + 1
                        end
                    end
                end
            end

            -- Mark NPC as complete if all their quests have been processed
            if _G.processedCount >= _G.totalQuests then
                _G.checkedNpcs[npcId] = true
                BANETO_Print("Finished checking NPC " ..
                    npcId .. " (" .. _G.processedCount .. "/" .. _G.totalQuests .. " quests processed)")
            end

            -- Reset state for next NPC
            BANETO_ClearTarget()
            C_GossipInfo.CloseGossip()
            checked = false
            wait = nil
        until true
    end

    -- All NPCs have been checked and all available quests accepted
    -- Now start the quest execution chain
    _G.checkedNpcs = nil
    _G.checkedQuests = nil
    _G.processedCount = nil
    _G.totalQuests = nil

    BANETO_ClearTarget()
    C_GossipInfo.CloseGossip()

    BANETO_Print("All available quests accepted! Starting quest chain...")
    BANETO_LoadQuestProfile([[Golden_Lotus_01_Laosy_Scouting]])
end
