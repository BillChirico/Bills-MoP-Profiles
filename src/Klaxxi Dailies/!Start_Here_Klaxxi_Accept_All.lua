-- Klaxxi Quest Accept Handler
-- ⭐ START HERE: This is the entry point for Klaxxi dailies!
-- This profile will automatically accept all available quests and start the quest chain.
BANETO_DefineProfileName("!Start_Here_Klaxxi_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Klaxxi Quest Accept Information Table
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
        questId = 31496,
        npcId = 62180,
        questName = "Sampling the Empire's Finest",
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
        questId = 31502,
        npcId = 63072,
        questName = "Wing Clip",
    },
    {
        questId = 31503,
        npcId = 63072,
        questName = "Shortcut to Ruin",
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
        questId = 31487,
        npcId = 63758,
        questName = "Sonic Disruption",
    },
    {
        questId = 31494,
        npcId = 63758,
        questName = "Free From Her Clutches",
    },
    {
        questId = 31238,
        npcId = 63758,
        questName = "Brain Food",
    },
    {
        questId = 31808,
        npcId = 63758,
        questName = "Brain Food",
    },
    {
        questId = 31267,
        npcId = 63758,
        questName = "Rampage Against the Machine",
    },
    {
        questId = 31109,
        npcId = 62538,
        questName = "Culling the Swarm",
    },
    {
        questId = 31231,
        npcId = 62538,
        questName = "Dreadspinner Extermination",
    },
    {
        questId = 31235,
        npcId = 62538,
        questName = "Nope Nope Nope",
    }
}
-- NPC Coordinates for different quest givers
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

local function GetAvailableQuestInfoByID(available, questID)
    for i = 1, #available do
        local info = available[i]

        if info and info.questID == questID then
            return info
        end
    end

    return nil
end

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true
BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true
local inProgress = false
local wait = nil
local checked = false

function _G.BANETO_ExecuteCustomQuestPulse()
    if inProgress then
        return
    end

    -- Handle wait timer at the start
    if wait and time() < wait then
        return -- Still waiting, do nothing
    end

    if not _G.checkedNpcs then
        _G.checkedNpcs = {}
    end

    if not _G.checkedQuests then
        _G.checkedQuests = {}
    end

    if not _G.processedCount then
        _G.processedCount = 0
    end

    if not _G.totalQuests then
        _G.totalQuests = 0
    end

    -- Group quests by NPC
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
                BANETO_Print("NPC " .. npcId .. " already fully processed, skipping!")
                break
            end

            BANETO_Print("Checking NPC: " .. npcId .. " for " .. #npcQuests .. " quests!")

            local questGiver = GetObjectWithId(npcId)

            if not questGiver then
                -- NPC not found, mesh and set wait
                BANETO_MeshTo(npcCoords[npcId].x, npcCoords[npcId].y, npcCoords[npcId].z)
                wait = time() + 5
                BANETO_Print("Mesh to NPC: " .. npcId .. " (waiting 5s)")
                return
            end

            -- Check if in position
            if not BANETO_PlayerPosition(npcCoords[npcId].x, npcCoords[npcId].y, npcCoords[npcId].z, 5) then
                -- Not in position, mesh and set wait
                BANETO_MeshTo(npcCoords[npcId].x, npcCoords[npcId].y, npcCoords[npcId].z)
                wait = time() + 5
                BANETO_Print("Not in position for NPC " .. npcId .. " - meshing (waiting 5s)")
                return
            end

            BANETO_Print("Interacting with NPC: " .. npcId)

            local availableQuests = C_GossipInfo.GetAvailableQuests()

            if not availableQuests or #availableQuests == 0 then
                if not checked then
                    UnlockedTargetUnit(questGiver)
                    BANETO_Interact(questGiver)
                    wait = time() + 2
                    BANETO_Print("No quests available for NPC " .. npcId .. " - waiting 2 seconds")
                    checked = true
                    return
                else
                    _G.checkedNpcs[npcId] = true
                    checked = false
                    BANETO_Print("No quests available for NPC " .. npcId .. " - marking as complete")
                    return
                end
            end

            -- Check each quest for this NPC
            _G.processedCount = 0
            _G.totalQuests = #npcQuests

            for j = 1, #npcQuests do
                local quest = npcQuests[j]

                -- Skip if already checked
                if _G.checkedQuests[quest.questId] then
                    BANETO_Print("Quest " .. quest.questId .. " already checked, skipping")
                    _G.processedCount = _G.processedCount + 1
                else
                    if BANETO_HasQuest(quest.questId) or BANETO_HasQuestCompleted(quest.questId) then
                        BANETO_Print("Quest already in log or completed! (" .. quest.questId .. ")")
                        _G.checkedQuests[quest.questId] = true
                        _G.processedCount = _G.processedCount + 1
                    else
                        local offeredInfo = GetAvailableQuestInfoByID(availableQuests, quest.questId)

                        if offeredInfo then
                            BANETO_Print(
                                "Accepting "
                                .. (offeredInfo.title or quest.questName)
                                .. " ("
                                .. quest.questId
                                .. ") from NPC ("
                                .. npcId
                                .. ")"
                            )

                            _G.checkedQuests[quest.questId] = true
                            local coords = npcCoords[npcId]
                            BANETO_DefineQuestId(quest.questId)
                            BANETO_SetToSkipTurnInQuest()
                            BANETO_DefineQuestPickupNPC(coords.x, coords.y, coords.z, npcId)
                            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
                            BANETO_ExecuteCustomQuestPulse_Questmaster = false
                            BANETO_SetNextLocalQuestProfile([[!Start_Here_Klaxxi_Accept_All]])
                            inProgress = true

                            return
                        else
                            _G.checkedQuests[quest.questId] = true
                            _G.processedCount = _G.processedCount + 1
                            BANETO_Print("Quest " .. quest.questId .. " not offered by NPC " .. npcId)
                        end
                    end
                end
            end

            -- If all quests for this NPC are processed, mark NPC as fully checked
            if _G.processedCount >= _G.totalQuests then
                _G.checkedNpcs[npcId] = true
                BANETO_Print("All quests for NPC " ..
                    npcId .. " processed (" .. _G.processedCount .. "/" .. _G.totalQuests .. "), marking as complete")
            end

            checked = false
            wait = nil
        until true
    end

    BANETO_Print("All available quests accepted! Starting quest chain...")
    BANETO_LoadQuestProfile([[Klaxxi_01_The_Fight_Against_Fear]])
end
