-- Quest Information
BANETO_DefineProfileName("Klaxxi_02_The_Scale_Lord")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31269)

-- Quest Objective
BANETO_DefineQuestTargetId(63179) -- Mistblade Scale-Lord

-- Quest Locations
BANETO_DefineCenter(-931.46478271484, 2586.9377441406, 101.58531951904, 45)
BANETO_RecordLandingspot(-852.19769287109, 2573.0510253906, 132.61027526855, 870)
BANETO_DefineProfileUnstuck(1, -859.44061279297, 2566.5915527344, 132.5147857666)
BANETO_DefineProfileUnstuck(2, -874.39770507812, 2565.5668945312, 120.18105316162)
BANETO_DefineProfileUnstuck(3, -891.91363525391, 2566.9047851562, 109.91634368896)
BANETO_DefineProfileUnstuck(4, -919.21221923828, 2575.3872070312, 102.29878234863)
BANETO_DefineProfileUnstuck(5, -941.00616455078, 2582.0427246094, 101.13288116455)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_03_A_Little_Brain_Work]])

BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31269) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_03_A_Little_Brain_Work]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
