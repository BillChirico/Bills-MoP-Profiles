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

-- Group quests by NPC for efficient processing
local questsByNpc = {}
for _, quest in ipairs(questAccepts) do
    if not questsByNpc[quest.npcId] then
        questsByNpc[quest.npcId] = {}
    end
    table.insert(questsByNpc[quest.npcId], quest)
end

-- Quest Pulse Configuration
BANETO_ExecuteCustomQuestPulse_Questmaster = true
BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true

local wait = nil
local currentNpcIndex = 1
local npcIds = {}
local npcQueued = false
local questsAccepted = false
local questsChecked = false

-- Build ordered list of NPCs
for npcId, _ in pairs(questsByNpc) do
    table.insert(npcIds, npcId)
end

-- Sort NPCs by ID for consistent order
table.sort(npcIds)

function _G.BANETO_ExecuteCustomQuestPulse()
    -- Handle wait timer
    if wait and time() < wait then
        return
    end

    -- Process NPCs in order
    if currentNpcIndex <= #npcIds then
        local npcId = npcIds[currentNpcIndex]
        local coords = npcCoords[npcId]
        local quests = questsByNpc[npcId]

        -- Move to NPC if not in position
        if not BANETO_PlayerPosition(coords.x, coords.y, coords.z, 5) then
            if not npcQueued then
                BANETO_MeshTo(coords.x, coords.y, coords.z)
                BANETO_Print("Moving to NPC " .. npcId .. " for quest acceptance")
                npcQueued = true
            end
            wait = time() + 5
            return
        end

        -- Target and interact with NPC
        if not questsChecked then
            local questGiver = GetObjectWithId(npcId)
            if questGiver then
                UnlockedTargetUnit(questGiver)
                BANETO_Interact(questGiver)
                BANETO_Print("Interacting with NPC " .. npcId)
                wait = time() + 2
                questsChecked = true
                return
            else
                BANETO_Print("NPC " .. npcId .. " not found, skipping...")
                currentNpcIndex = currentNpcIndex + 1
                npcQueued = false
                questsChecked = false
                questsAccepted = false
                return
            end
        end

        -- Get available quests from gossip
        if not questsAccepted then
            local availableQuests = C_GossipInfo.GetAvailableQuests()
            if availableQuests and #availableQuests > 0 then
                BANETO_Print("Found " .. #availableQuests .. " available quests from NPC " .. npcId)

                -- Check each available quest against our quest list for this NPC
                for _, availableQuest in ipairs(availableQuests) do
                    for _, questInfo in ipairs(quests) do
                        -- Check if we already have this quest
                        if not BANETO_HasQuest(questInfo.questId) and not BANETO_HasQuestCompleted(questInfo.questId) then
                            -- Accept quest by selecting it
                            C_GossipInfo.SelectAvailableQuest(availableQuest.questID)
                            BANETO_Print("Accepted quest: " .. questInfo.questName .. " (" .. questInfo.questId .. ")")
                            wait = time() + 1
                        else
                            BANETO_Print("Skipping quest " .. questInfo.questName .. " - already have or completed")
                        end
                    end
                end

                questsAccepted = true
                wait = time() + 2
                return
            else
                -- No quests available from this NPC
                BANETO_Print("No quests available from NPC " .. npcId)
                questsAccepted = true
            end
        end

        -- Move to next NPC
        if questsAccepted then
            currentNpcIndex = currentNpcIndex + 1
            npcQueued = false
            questsChecked = false
            questsAccepted = false
            wait = time() + 1
            return
        end
    end

    -- All NPCs processed - check which quests we actually have and chain to appropriate profile
    BANETO_Print("========================================")
    BANETO_Print("All Whitepetal Lake NPCs processed!")
    BANETO_Print("========================================")

    -- Priority order for quest execution
    local questPriority = {
        { questId = 30313, profile = "Golden_Lotus_Whitepetal_Lake_02_The_Moving_Mists" },
        { questId = 30342, profile = "Golden_Lotus_Whitepetal_Lake_03_Fiery_Tongue_Fragile_Feet" },
        { questId = 30291, profile = "Golden_Lotus_Whitepetal_Lake_04_Stunning_Display" },
        { questId = 30340, profile = "Golden_Lotus_Whitepetal_Lake_05_Stick_in_the_Mud" },
    }

    -- Find first available quest and load its profile
    for _, questInfo in ipairs(questPriority) do
        if BANETO_HasQuest(questInfo.questId) and not BANETO_HasQuestCompleted(questInfo.questId) then
            BANETO_Print("Starting quest chain with: " .. questInfo.profile)
            BANETO_LoadQuestProfile(questInfo.profile)
            return
        end
    end

    -- No quests found - likely all completed for today
    BANETO_Print("No Whitepetal Lake quests available or all completed!")
    BANETO_Print("Moving to turn-in phase...")
    BANETO_LoadQuestProfile([[Golden_Lotus_Whitepetal_Lake_TurnIn_All]])
end