-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_02_Cannonfire")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31754)

-- Quest Objective
BANETO_DefineQuestTargetId(65506) -- Dreadspinner Egg

-- Quest Locations
BANETO_DefineCenter(1551.1240234375, 1201.814453125, 443.14520263672, 130)
BANETO_DefineCenter(1678.9040527344, 1388.1376953125, 453.60244750977, 130)
BANETO_DefineCenter(1573.8038330078, 1389.3203125, 445.32727050781, 130)
BANETO_DefineCenter(1511.4365234375, 1475.9962158203, 441.88012695312, 130)
BANETO_DefineCenter(1559.9156494141, 1524.8381347656, 439.8486328125, 130)

-- Quest Pulse
--[[
    @Description:
        This quest pulse checks if the quest is available and skips to the next quest if not.
        This handles the rotating daily quest pool where not all quests are available each day.
]]
_G.BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31754) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Golden_Lotus_03_Unleashed_Spirits]])
        return
    end
end

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_03_Unleashed_Spirits]])
