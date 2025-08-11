-- Klaxxi Quest Accept Handler
-- ⭐ START HERE: This is the entry point for Klaxxi dailies!
--
-- This profile will automatically:
-- 1. Check all 4 Klaxxi NPCs for available daily quests
-- 2. Accept any quests that are offered and not already completed
-- 3. Handle the rotating daily quest system intelligently
-- 4. Start the quest execution chain once all available quests are accepted
--
-- The Klaxxi daily system rotates quests each day, so not all 12 quests
-- will be available every day. This handler adapts to whatever is offered.
BANETO_DefineProfileName("Klaxxi_00_Start_Here_Klaxxi_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Quest Information Table
-- Contains all 12 possible Klaxxi daily quests with their associated NPCs
-- Each quest has a rotating availability - not all will be offered each day
local questAccepts = {
    {
        questId = 31270,
        npcId = 62180,
        questName = "The Fight Against Fear",
    },
    {
        questId = 31269,
        npcId = 62180,
        questName = "The Scale-Lord",
    },

    {
        questId = 31232,
        npcId = 62180,
        questName = "An Ancient Empire",
    },
    {
        questId = 31233,
        npcId = 62180,
        questName = "Sap Tapping",
    },
    {
        questId = 31271,
        npcId = 63072,
        questName = "Bad Genes",
    },
    {
        questId = 31234,
        npcId = 63072,
        questName = "Putting An Eye Out",
    },
    {
        questId = 31268,
        npcId = 63758,
        questName = "A Little Brain Work",
    },
    {
        questId = 31024,
        npcId = 63758,
        questName = "Kunchong Treats",
    },
    {
        questId = 31238,
        npcId = 63758,
        questName = "Brain Food",
    },
    {
        questId = 31231,
        npcId = 62538,
        questName = "Dreadspinner Extermination",
    },
    {
        questId = 31267,
        npcId = 62538,
        questName = "Mistblade Destruction",
    },
    {
        questId = 31235,
        npcId = 62538,
        questName = "Nope Nope Nope",
    }
}

-- NPC Coordinates
-- All 4 Klaxxi Paragons are located at Klaxxi'vess in Dread Wastes
-- These coordinates ensure proper positioning for quest interactions
local npcCoords = {
    -- Korven the Prime
    [62180] = {
        x = 127.87126922607,
        y = 3233.3774414062,
        z = 215.64855957031,
    },
    -- Kaz'tik the Manipulator
    [63758] = {
        x = 139.79104614258,
        y = 3234.7741699219,
        z = 212.32595825195,
    },
    -- Rik'kal the Dissector
    [63072] = {
        x = 134.97793579102,
        y = 3228.5539550781,
        z = 215.59104919434,
    },
    -- Kil'ruk the Wind-Reaver
    [62538] = {
        x = 136.87948608398,
        y = 3193.1166992188,
        z = 214.7607421875,
    },
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

            -- If NPC not found (out of range, not spawned, etc.), mark as complete
            if not questGiver then
                _G.checkedNpcs[npcId] = true
                checked = false
                BANETO_Print("NPC " .. npcId .. " not found")
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
                    wait = time() + 2 -- Wait for interaction to process
                    BANETO_Print("Checking NPC " .. npcId .. " for quests")
                    checked = true
                    return
                else
                    -- Second attempt: no quests found, mark NPC as complete
                    _G.checkedNpcs[npcId] = true
                    checked = false
                    BANETO_Print("No quests available from NPC " .. npcId)
                    return
                end
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
                            BANETO_SetNextLocalQuestProfile([[Klaxxi_00_Start_Here_Klaxxi_Accept_All]])
                            inProgress = true

                            return
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
            checked = false
            wait = nil
        until true
    end

    _G.checkedNpcs = nil
    _G.checkedQuests = nil
    _G.processedCount = nil
    _G.totalQuests = nil

    -- All NPCs have been checked and all available quests accepted
    -- Now start the quest execution chain
    BANETO_Print("All available quests accepted! Starting quest chain...")
    BANETO_LoadQuestProfile([[Klaxxi_01_The_Fight_Against_Fear]])
end
