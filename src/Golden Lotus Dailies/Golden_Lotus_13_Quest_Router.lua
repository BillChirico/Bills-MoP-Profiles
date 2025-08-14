-- Golden Lotus Next Hub Quest Router
-- This profile talks to Leven Dawnblade to accept his quest and determines the next hub
-- Based on which quest he offers, routes to the appropriate area (Mistfall Village or other hubs)

BANETO_DefineProfileName("Golden_Lotus_13_Quest_Router")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Leven Dawnblade coordinates
local levenCoords = {
    x = 1211.8740234375,
    y = 1044.6020507812,
    z = 425.96743774414,
    npcId = 58408
}

-- Hub routing based on quest accepted from Leven Dawnblade
-- Each quest ID maps to a specific hub transition profile
local hubRoutes = {
    [31242] = "Golden_Lotus_Mistfall_Village_00_Transition", -- Mistfall Village quest
    [31131] = "Golden_Lotus_Whitepetal_Lake_00_Transition",  -- Whitepetal Lake quest
}

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true
BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true

local wait = nil
local checked = false
local questAccepted = false

function _G.BANETO_ExecuteCustomQuestPulse()
    -- Handle wait timer
    if wait and time() < wait then
        return
    end

    -- First, check if we already have any incomplete main hub quests to finish
    -- Keep this list in sync with `Golden_Lotus_00_Start_Here_Accept_All.lua`
    local mainHubQuests = {
        30307, -- The Eternal Vigil
        30308, -- Stone Hard Quilen
        30309, -- Set in Stone
        30312, -- Given a Second Chance
        31754, -- Cannonfire
        31755, -- Acts of Cruelty
        31756, -- High Chance of Rain
        31757, -- Unleashed Spirits
        31758, -- Laosy Scouting
        31760, -- Striking First
        31762, -- Crumbling Behemoth
    }

    for i = 1, #mainHubQuests do
        local questId = mainHubQuests[i]
        if BANETO_HasQuest(questId) and not BANETO_HasQuestCompleted(questId) then
            BANETO_Print("Found incomplete main hub quest: " .. questId)
            BANETO_Print("Going back to complete remaining quests...")
            BANETO_LoadQuestProfile([[Golden_Lotus_01_Laosy_Scouting]])
            return
        end
    end

    -- Ensure we're in position to talk to Leven Dawnblade
    if not BANETO_PlayerPosition(levenCoords.x, levenCoords.y, levenCoords.z, 5) then
        BANETO_MeshTo(levenCoords.x, levenCoords.y, levenCoords.z)
        wait = time() + 5
        BANETO_Print("Moving to Leven Dawnblade")

        return
    end

    BANETO_StopMovement()

    -- Find Leven Dawnblade (NPC 58408)
    local questGiver = GetObjectWithId(58408)
    if not questGiver then
        BANETO_Print("Leven Dawnblade (58408) not found!")
        BANETO_Stop()

        return
    end

    -- Target and interact with Leven Dawnblade
    if not checked then
        BANETO_Print("Targeting and interacting with Leven Dawnblade (58408) to accept next hub quest...")
        UnlockedTargetUnit(questGiver)
        BANETO_Interact(questGiver)
        wait = time() + 5
        checked = true

        return
    end

    -- Accept the single quest he offers
    if not questAccepted then
        BANETO_Print("Accepting quest from Leven Dawnblade!")
        AcceptQuest()
        questAccepted = true
        wait = time() + 5 -- Wait for quest to register in quest log

        return
    end

    -- Check which quest we just accepted and route accordingly
    for questId, hubProfile in pairs(hubRoutes) do
        if BANETO_HasQuest(questId) then
            BANETO_Print("Accepted quest ID " .. questId .. " - Routing to: " .. hubProfile)
            BANETO_LoadQuestProfile(hubProfile)

            return
        end
    end

    -- No supported quest found - stop the bot and warn the user
    BANETO_Print("===========================================")
    BANETO_Print("WARNING: UNSUPPORTED QUEST ACCEPTED!")
    BANETO_Print("===========================================")
    BANETO_Print("Leven Dawnblade gave a quest that is not yet supported.")
    BANETO_Print("Please report the quest ID to add support for this hub to Bill on Discord.")
    BANETO_Print("Check your quest log for the new quest from Leven Dawnblade.")
    BANETO_Print("===========================================")
    BANETO_Print("STOPPING BOT - Manual intervention required")
    BANETO_Print("===========================================")

    -- Stop the bot
    BANETO_Stop()
end
