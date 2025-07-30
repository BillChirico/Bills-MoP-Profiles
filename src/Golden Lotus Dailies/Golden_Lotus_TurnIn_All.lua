-- Golden Lotus Quest Turn-In Handler
BANETO_DefineProfileName("Golden_Lotus_TurnIn_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Quest Turn-In Information Table
local questTurnIns = {
    {
        questId = 30307,
        npcId = 58408,
        questName = "The Eternal Vigil"
    },
    {
        questId = 31757,
        npcId = 58465,
        questName = "Unleashed Spirits"
    },
    {
        questId = 31762,
        npcId = 58465,
        questName = "Crumbling Behemoth"
    },
    {
        questId = 31758,
        npcId = 58471,
        questName = "Laosy Scouting"
    },
    {
        questId = 30312,
        npcId = 58468,
        questName = "Given a Second Chance"
    }
}

-- NPC Coordinates (all quest NPCs are at the same location)
local npcCoords = {
    x = 1215.7375488281,
    y = 1047.44921875,
    z = 425.9674987793
}

-- Define all possible quest turn-in NPCs
for i = 1, #questTurnIns do
    local quest = questTurnIns[i]
    BANETO_DefineQuestTurninNPC(npcCoords.x, npcCoords.y, npcCoords.z, quest.npcId)
end

-- Simple turn-in handler - let Baneto handle the quest turn-in logic automatically
-- This file defines all the quest turn-in NPCs and Baneto will handle the rest
