-- Quest Information
BANETO_DefineProfileName("Klaxxi_12_Sap_Tapping")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(31233)

-- Quest Objective
BANETO_DefineQuestTargetId(63740)  -- Amber Sap Extractor
BANETO_DefineQuestTargetId(213319) -- Amber Pot

-- Quest Locations
BANETO_DefineCenter(147.81346130371, 2274.5791015625, 206.95468139648, 300)
BANETO_DefineCenter(319.89987182617, 2243.2661132812, 235.23919677734, 300)

BANETO_DefineCenter(464.43737792969, 2407.4296875, 246.06338500977, 300)
BANETO_DefineCenter(611.26916503906, 2359.6960449219, 294.87854003906, 300)
BANETO_DefineCenter(670.79956054688, 2658.7651367188, 293.43746948242, 300)
-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_TurnIn_All]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31233) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_TurnIn_All]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
