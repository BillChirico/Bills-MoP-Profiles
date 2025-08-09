-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_06_Striking_First")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31760)

-- Quest Objective
BANETO_DefineQuestTargetId(65978) -- Mogu Target

-- Quest Locations
BANETO_DefineCenter(1673.4184570312, 1360.3067626953, 453.59228515625, 40)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_07_Acts_of_Cruelty]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31760) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Golden_Lotus_07_Acts_of_Cruelty]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
