-- Quest Information
BANETO_DefineProfileName("Klaxxi_01_The_Fight_Against_Fear")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31270)

-- Quest Objective
BANETO_DefineQuestTargetId(62162) -- Horrorscale Scorpid

-- Quest Locations
BANETO_DefineCenter(-473.82046508789, 3067.7724609375, 194.68385314941, 300)
BANETO_DefineCenter(-606.00811767578, 2879.7368164062, 168.73880004883, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_02_The_Scale_Lord]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31270) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_02_The_Scale_Lord]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
