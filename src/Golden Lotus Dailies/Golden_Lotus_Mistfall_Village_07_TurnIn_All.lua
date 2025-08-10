-- Golden Lotus Part 2 Quest Turn-In Handler
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_07_TurnIn_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- NPC Coordinates Table - Centralized coordinate data
local npcCoords = {
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
    -- Che Wildwalker
    [59338] = {
        x = 727.81665039062,
        y = 1621.7716064453,
        z = 377.74417114258,
    },
}

-- Quest Turn-In Information Table - No repeated coordinates
local questTurnIns = {
    {
        questId = 30231,
        npcId = 58818,
        questName = "Pomfruit Pickup",
    },
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
    {
        questId = 30192,
        npcId = 58819,
        questName = "My Town, It's on Fire",
    },
    {
        questId = 30190,
        npcId = 58819,
        questName = "Sprite Plight",
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
            BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_07_TurnIn_All]])
            inProgress = true

            return
        end
    end

    BANETO_Print("All Part 2 quests completed! Starting Part 3...")
    BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_08_Quid_Pro_Quo]])
end
