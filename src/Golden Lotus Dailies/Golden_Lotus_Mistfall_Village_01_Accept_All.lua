-- Golden Lotus Part 2 Quest Accept Handler
-- ⭐ START HERE: This is the entry point for Golden Lotus Part 2 dailies!
-- This profile will automatically accept all available Part 2 quests and start the quest chain.
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_01_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Golden Lotus Part 2 Quest Accept Information Table
local questAccepts = {
    {
        questId = 30194,
        npcId = 59338,
        questName = "Encroaching Storm",
        coords = {
            x = 727.81665039062,
            y = 1621.7716064453,
            z = 377.74417114258,
        },
    },
    {
        questId = 30231,
        npcId = 58818,
        questName = "Pomfruit Pickup",
        coords = {
            x = 758.8076171875,
            y = 1624.3572998047,
            z = 370.361328125,
        },
    },
    {
        questId = 30192,
        npcId = 58819,
        questName = "My Town, It's on Fire",
        coords = {
            x = 699.212890625,
            y = 1587.1867675781,
            z = 384.44644165039,
        },
    },
    {
        questId = 30190,
        npcId = 58819,
        questName = "Sprite Plight",
        coords = {
            x = 699.212890625,
            y = 1587.1867675781,
            z = 384.44644165039,
        },
    }
}

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true
local inProgress = false

function _G.BANETO_ExecuteCustomQuestPulse()
    if inProgress then
        return
    end

    for i = 1, #questAccepts do
        local quest = questAccepts[i]

        -- Check if quest is available (not in log and not completed for today)
        if not BANETO_HasQuest(quest.questId) and not BANETO_HasQuestCompleted(quest.questId) then
            BANETO_Print("Accepting " .. quest.questName .. " (" .. quest.questId .. ")")

            BANETO_DefineQuestId(quest.questId)
            BANETO_SetToSkipTurnInQuest()
            BANETO_DefineQuestPickupNPC(quest.coords.x, quest.coords.y, quest.coords.z, quest.npcId)
            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
            BANETO_ExecuteCustomQuestPulse_Questmaster = false
            BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_01_Accept_All]])
            inProgress = true

            return
        end
    end

    BANETO_Print("All available Part 2 quests accepted! Starting quest chain...")
    BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_02_Pomfruit_Pickup]])
end
