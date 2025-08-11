-- Golden Lotus Part 2 Quest Accept Handler
-- ⭐ START HERE: This is the entry point for Golden Lotus Part 2 dailies!
-- This profile will automatically accept all available Part 2 quests and start the quest chain.
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_01_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- NPC Coordinates Table - Centralized coordinate data
local npcCoords = {
    -- Che Wildwalker
    [59338] = {
        x = 730.33160400391,
        y = 1623.9477539062,
        z = 377.74407958984,
    },
    -- Shen-zin Su
    [58818] = {
        x = 758.8076171875,
        y = 1624.3572998047,
        z = 370.361328125,
    },
    -- Mayor Shiyo
    [58819] = {
        x = 699.212890625,
        y = 1587.1867675781,
        z = 384.44644165039,
    },
}

-- Quest Accept Information Table - No repeated coordinates
local questAccepts = {
    -- Che Wildwalker (59338) - Multiple quests
    {
        questId = 30194,
        npcId = 59338,
        questName = "Encroaching Storm",
    },
    {
        questId = 30232,
        npcId = 59338,
        questName = "Ruffling Some Feathers",
    },
    -- Shen-zin Su (58818) - Single quest
    {
        questId = 30231,
        npcId = 58818,
        questName = "Pomfruit Pickup",
    },
    -- Mayor Shiyo (58819) - Multiple quests
    {
        questId = 30192,
        npcId = 58819,
        questName = "My Town, It's on Fire",
    },
    {
        questId = 30191,
        npcId = 58819,
        questName = "Steer Clear of the Beer Here",
    },
    {
        questId = 30190,
        npcId = 58819,
        questName = "Sprite Plight",
    }
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
        return
    end

    -- Handle wait timer
    if wait and time() < wait then
        return
    end

    -- Initialize global tracking variables
    if not _G.mistfallCheckedNpcs then
        _G.mistfallCheckedNpcs = {}
    end
    if not _G.mistfallCheckedQuests then
        _G.mistfallCheckedQuests = {}
    end
    if not _G.mistfallProcessedCount then
        _G.mistfallProcessedCount = 0
    end
    if not _G.mistfallTotalQuests then
        _G.mistfallTotalQuests = 0
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
            if _G.mistfallCheckedNpcs[npcId] then
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

            BANETO_StopMovement()

            -- Try to find the NPC
            local questGiver = GetObjectWithId(npcId)
            if not questGiver then
                _G.mistfallCheckedNpcs[npcId] = true
                checked = false
                BANETO_Print("NPC " .. npcId .. " not found")
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
            _G.mistfallProcessedCount = 0
            _G.mistfallTotalQuests = #npcQuests

            for j = 1, #npcQuests do
                local quest = npcQuests[j]

                -- Skip already processed quests
                if _G.mistfallCheckedQuests[quest.questId] then
                    _G.mistfallProcessedCount = _G.mistfallProcessedCount + 1
                else
                    -- Check if we already have this quest
                    if BANETO_HasQuest(quest.questId) or BANETO_HasQuestCompleted(quest.questId) then
                        _G.mistfallCheckedQuests[quest.questId] = true
                        _G.mistfallProcessedCount = _G.mistfallProcessedCount + 1
                    else
                        -- Check if NPC is offering this quest
                        local offeredInfo = GetAvailableQuestInfoByID(availableQuests, quest.questId)
                        if offeredInfo then
                            -- Accept the quest
                            BANETO_Print("Accepting " .. quest.questName .. " (" .. quest.questId .. ")")
                            _G.mistfallCheckedQuests[quest.questId] = true

                            local questCoords = npcCoords[quest.npcId]
                            BANETO_DefineQuestId(quest.questId)
                            BANETO_SetToSkipTurnInQuest()
                            BANETO_DefineQuestPickupNPC(questCoords.x, questCoords.y, questCoords.z, quest.npcId)

                            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
                            BANETO_ExecuteCustomQuestPulse_Questmaster = false
                            BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_01_Accept_All]])
                            inProgress = true
                            return
                        elseif not availableQuests or #availableQuests == 0 then
                            -- Try direct acceptance
                            AcceptQuest()
                            _G.mistfallCheckedQuests[quest.questId] = true
                            _G.mistfallProcessedCount = _G.mistfallProcessedCount + 1
                        else
                            -- Quest not offered today
                            _G.mistfallCheckedQuests[quest.questId] = true
                            _G.mistfallProcessedCount = _G.mistfallProcessedCount + 1
                        end
                    end
                end
            end

            -- Mark NPC as complete
            if _G.mistfallProcessedCount >= _G.mistfallTotalQuests then
                _G.mistfallCheckedNpcs[npcId] = true
                BANETO_Print("Finished checking NPC " .. npcId)
            end

            BANETO_ClearTarget()
            checked = false
            wait = nil
        until true
    end

    -- All NPCs processed - start quest chain
    _G.mistfallCheckedNpcs = nil
    _G.mistfallCheckedQuests = nil
    _G.mistfallProcessedCount = nil
    _G.mistfallTotalQuests = nil

    BANETO_Print("All available Mistfall Village quests accepted! Starting quest chain...")
    BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_02_Pomfruit_Pickup]])
end
