-- Klaxxi Quest Turn-In Handler
-- Automatically turns in all completed Klaxxi daily quests
-- This handler intelligently detects which quests are ready for turn-in
-- and submits them to the appropriate NPCs at Klaxxi'vess
BANETO_DefineProfileName("Klaxxi_TurnIn_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Quest Turn-In Information
-- Contains all possible Klaxxi daily quests that can be turned in
-- The handler will check each quest to see if it's completed and ready
local questTurnIns = {
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
        questId = 31238,
        npcId = 63758,
        questName = "Brain Food",
    },
    {
        questId = 31231,
        npcId = 62538,
        questName = "Dreadspinner Extermination",
    },
    {
        questId = 31267,
        npcId = 62538,
        questName = "Mistblade Destruction",
    },
    {
        questId = 31235,
        npcId = 62538,
        questName = "Nope Nope Nope",
    },
}

-- NPC Coordinates
-- Locations of all 4 Klaxxi Paragons at Klaxxi'vess for quest turn-ins
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

-- Helper function to check if all quest objectives are complete
-- @param questId: The quest ID to check
-- @return: true if all objectives are finished, false otherwise
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

-- Quest Pulse Configuration
BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true
BANETO_ExecuteCustomQuestPulse_Questmaster = true
local inProgress = false -- Prevents multiple simultaneous turn-ins

-- Main turn-in logic
-- Continuously checks for completed quests and turns them in one by one
function _G.BANETO_ExecuteCustomQuestPulse()
    if inProgress then
        return
    end

    -- Check each quest to see if it's ready for turn-in
    for i = 1, #questTurnIns do
        local quest = questTurnIns[i]

        -- Quest must be: in our log, not yet turned in, and all objectives complete
        if
            BANETO_HasQuest(quest.questId)
            and not BANETO_HasQuestCompleted(quest.questId)
            and IsQuestObjectivesComplete(quest.questId)
        then
            BANETO_Print("Turning in " .. quest.questName .. " (" .. quest.questId .. ")")

            -- Configure Baneto to turn in this specific quest
            local coords = npcCoords[quest.npcId]
            BANETO_DefineQuestId(quest.questId)
            BANETO_DefineQuestPickupNPC(coords.x, coords.y, coords.z, quest.npcId)
            BANETO_DefineQuestTurninNPC(coords.x, coords.y, coords.z, quest.npcId)

            -- Switch to normal Baneto behavior to handle turn-in
            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
            BANETO_ExecuteCustomQuestPulse_Questmaster = false
            BANETO_SetNextLocalQuestProfile([[Klaxxi_TurnIn_All]]) -- Return here after turn-in
            inProgress = true

            return
        end
    end

    -- No more quests to turn in - all Klaxxi dailies are complete!
    BANETO_Print("No more completed quests to turn in! Successfully completed all Klaxxi dailies. Stopping...")
    BANETO_Stop()
end
