-- Golden Lotus Whitepetal Lake Quest Turn-In Handler
BANETO_DefineProfileName("Golden_Lotus_Whitepetal_Lake_TurnIn_All")
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

-- Quest Turn-In Information Table - No repeated coordinates
local questTurnIns = {
    {
        questId = 30313,
        npcId = 59342,
        questName = "The Moving Mists",
    },
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
    {
        questId = 30340,
        npcId = 59341,
        questName = "Stick in the Mud",
    }
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

            local coords = npcCoords[quest.npcId]
            BANETO_DefineQuestId(quest.questId)
            BANETO_DefineQuestPickupNPC(coords.x, coords.y, coords.z, quest.npcId)
            BANETO_DefineQuestTurninNPC(coords.x, coords.y, coords.z, quest.npcId)
            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
            BANETO_ExecuteCustomQuestPulse_Questmaster = false
            BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Whitepetal_Lake_TurnIn_All]])
            inProgress = true

            return
        end
    end

    BANETO_Print("All Whitepetal Lake quests completed!")
    BANETO_Print("Whitepetal Lake daily chain complete!")
    BANETO_Stop()
end