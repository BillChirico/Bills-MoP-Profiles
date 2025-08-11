-- Golden Lotus Whitepetal Lake Quest Accept Handler
-- ⭐ START HERE: This is the entry point for Golden Lotus Whitepetal Lake dailies!
-- This profile will automatically accept all available Whitepetal Lake quests and start the quest chain.
BANETO_DefineProfileName("Golden_Lotus_Whitepetal_Lake_01_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- NPC Coordinates Table - Centralized coordinate data
local npcCoords = {
    -- He Softfoot
    [59342] = {
        x = 1170.4908447266,
        y = 1375.1470947266,
        z = 351.30313110352,
    },
    -- Ren Firetongue
    [59343] = {
        x = 1171.4375,
        y = 1409.7485351562,
        z = 343.01998901367,
    },
    -- Merchant Tantan
    [59341] = {
        x = 1173.2854003906,
        y = 1411.544921875,
        z = 343.07049560547,
    },
}

-- Quest Accept Information Table - No repeated coordinates
local questAccepts = {
    -- He Softfoot (59342) - Single quest
    {
        questId = 30313,
        npcId = 59342,
        questName = "The Moving Mists",
    },
    -- Ren Firetongue (59343) - Multiple quests
    {
        questId = 30342,
        npcId = 59343,
        questName = "Fiery Tongue, Fragile Feet",
    },
    {
        questId = 30291,
        npcId = 59343,
        questName = "Stunning Display",
    },
    -- Merchant Tantan (59341) - Single quest
    {
        questId = 30340,
        npcId = 59341,
        questName = "Stick in the Mud",
    },
}

-- Helper function to find quest info from WoW's available quest API
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

local inProgress = false
local wait = nil
local checked = false

function _G.BANETO_ExecuteCustomQuestPulse()
    if inProgress then
        inProgress = false
        checked = false
        wait = nil
        return
    end

    -- Handle wait timer
    if wait and time() < wait then
        return
    end

    -- Initialize global tracking variables
    if not _G.whitepetalCheckedNpcs then
        _G.whitepetalCheckedNpcs = {}
    end
    if not _G.whitepetalCheckedQuests then
        _G.whitepetalCheckedQuests = {}
    end
    if not _G.whitepetalProcessedCount then
        _G.whitepetalProcessedCount = 0
    end
    if not _G.whitepetalTotalQuests then
        _G.whitepetalTotalQuests = 0
    end

    -- Group quests by NPC for efficient processing
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

            -- Skip if we've already processed this NPC
            if _G.whitepetalCheckedNpcs[npcId] then
                break
            end

            BANETO_Print("Checking NPC: " .. npcId .. " for " .. #npcQuests .. " possible quests")

            -- Ensure we're in position to interact with the NPC
            local coords = npcCoords[npcId]
            if not BANETO_PlayerPosition(coords.x, coords.y, coords.z, 5) then
                BANETO_MeshTo(coords.x, coords.y, coords.z)
                wait = time() + 5
                BANETO_Print("Moving to NPC " .. npcId)
                return
            end

            -- Clear target before looking for new NPC
            BANETO_ClearTarget()
            
            -- Try to find the NPC
            local questGiver = GetObjectWithId(npcId)
            if not questGiver then
                _G.whitepetalCheckedNpcs[npcId] = true
                checked = false
                BANETO_Print("NPC " .. npcId .. " not found")
                wait = time() + 1
                return
            end

            -- Get available quests
            local availableQuests = C_GossipInfo.GetAvailableQuests()

            -- If no quests available, try interacting
            if not availableQuests or #availableQuests == 0 then
                if not checked then
                    UnlockedTargetUnit(questGiver)
                    BANETO_Interact(questGiver)
                    wait = time() + 2
                    BANETO_Print("Checking NPC " .. npcId .. " for quests")
                    checked = true
                    return
                else
                    BANETO_Print("No quests found for NPC " .. npcId)
                    checked = false
                end
            else
                BANETO_Print("Found " .. #availableQuests .. " available quests from NPC " .. npcId)
                checked = false
            end

            -- Process each quest for this NPC
            _G.whitepetalProcessedCount = 0
            _G.whitepetalTotalQuests = #npcQuests

            for j = 1, #npcQuests do
                local quest = npcQuests[j]

                -- Skip already processed quests
                if _G.whitepetalCheckedQuests[quest.questId] then
                    _G.whitepetalProcessedCount = _G.whitepetalProcessedCount + 1
                else
                    -- Check if we already have this quest
                    if BANETO_HasQuest(quest.questId) or BANETO_HasQuestCompleted(quest.questId) then
                        _G.whitepetalCheckedQuests[quest.questId] = true
                        _G.whitepetalProcessedCount = _G.whitepetalProcessedCount + 1
                    else
                        -- Check if NPC is offering this quest
                        local offeredInfo = GetAvailableQuestInfoByID(availableQuests, quest.questId)
                        if offeredInfo then
                            -- Accept the quest
                            BANETO_Print("Accepting " .. quest.questName .. " (" .. quest.questId .. ")")
                            _G.whitepetalCheckedQuests[quest.questId] = true

                            local questCoords = npcCoords[quest.npcId]
                            BANETO_DefineQuestId(quest.questId)
                            BANETO_SetToSkipTurnInQuest()
                            BANETO_DefineQuestPickupNPC(questCoords.x, questCoords.y, questCoords.z, quest.npcId)

                            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
                            BANETO_ExecuteCustomQuestPulse_Questmaster = false
                            BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Whitepetal_Lake_01_Accept_All]])
                            inProgress = true
                            return
                        elseif not availableQuests or #availableQuests == 0 then
                            -- Try direct acceptance
                            AcceptQuest()
                            _G.whitepetalCheckedQuests[quest.questId] = true
                            _G.whitepetalProcessedCount = _G.whitepetalProcessedCount + 1
                        else
                            -- Quest not offered today
                            _G.whitepetalCheckedQuests[quest.questId] = true
                            _G.whitepetalProcessedCount = _G.whitepetalProcessedCount + 1
                        end
                    end
                end
            end

            -- Mark NPC as complete
            if _G.whitepetalProcessedCount >= _G.whitepetalTotalQuests then
                _G.whitepetalCheckedNpcs[npcId] = true
                BANETO_Print("Finished checking NPC " .. npcId)
            end

            BANETO_ClearTarget()
            checked = false
            wait = nil
        until true
    end

    -- All NPCs processed - start quest chain
    _G.whitepetalCheckedNpcs = nil
    _G.whitepetalCheckedQuests = nil
    _G.whitepetalProcessedCount = nil
    _G.whitepetalTotalQuests = nil

    BANETO_ClearTarget()

    BANETO_Print("All available Whitepetal Lake quests accepted! Starting quest chain...")
    BANETO_LoadQuestProfile([[Golden_Lotus_Whitepetal_Lake_02_The_Moving_Mists]])
end
