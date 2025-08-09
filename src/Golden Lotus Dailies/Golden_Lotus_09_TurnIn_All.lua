-- Golden Lotus Quest Turn-In Handler
BANETO_DefineProfileName("Golden_Lotus_09_TurnIn_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Golden Lotus Quest Turn-In Information Table
-- Contains all 8 possible Golden Lotus daily quests that can be turned in
local questTurnIns = {
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
        questId = 31758,
        npcId = 58471,
        questName = "Laosy Scouting",
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
    },
}

-- NPC Coordinates
-- All Golden Lotus NPCs are located at the Temple of the White Tiger
-- These coordinates ensure proper positioning for quest turn-ins
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
    -- Kun Autumnlight (58471)
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

-- Helper function to check if all quest objectives are complete
local function IsQuestObjectivesComplete(questId)
    local objectives = C_QuestLog.GetQuestObjectives(questId)
    if not objectives or #objectives == 0 then
        return false
    end

    for i = 1, #objectives do
        if not objectives[i].finished then
            return false
        end
    end

    return true
end

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true
BANETO_ExecuteCustomQuestPulse_Questmaster = true
local inProgress = false

function _G.BANETO_ExecuteCustomQuestPulse()
    if inProgress then
        return
    end

    for i = 1, #questTurnIns do
        local quest = questTurnIns[i]

        -- Check if quest is in log, not already completed, and all objectives are finished
        if
            BANETO_HasQuest(quest.questId)
            and not BANETO_HasQuestCompleted(quest.questId)
            and IsQuestObjectivesComplete(quest.questId)
        then
            BANETO_Print("Turning in " .. quest.questName .. " (" .. quest.questId .. ")!")

            BANETO_DefineQuestId(quest.questId)
            local coords = npcCoords[quest.npcId]
            BANETO_DefineQuestPickupNPC(coords.x, coords.y, coords.z, quest.npcId)
            BANETO_DefineQuestTurninNPC(coords.x, coords.y, coords.z, quest.npcId)
            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
            BANETO_ExecuteCustomQuestPulse_Questmaster = false
            BANETO_SetNextLocalQuestProfile([[Golden_Lotus_09_TurnIn_All]])
            inProgress = true

            return
        end
    end

    BANETO_Print("No more completed quests to turn in at the main hub! Starting transition to the next hub...")
    BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_00_Transition]])
end
