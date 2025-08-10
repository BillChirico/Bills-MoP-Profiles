-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_05_Ruffling_Some_Feathers")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30232)

-- Quest Item
BANETO_DefineQuestTargetId(84121) -- Silken Feather

-- Quest Objective
BANETO_DefineQuestTargetId(58457) -- Silkfeather Hawk

-- Quest Locations
BANETO_DefineCenter(978.77215576172, 1798.9145507812, 350.58459472656, 300)
BANETO_DefineCenter(1082.17578125, 1651.0288085938, 353.23202514648, 300)
BANETO_DefineCenter(934.21026611328, 1508.2529296875, 363.10101318359, 300)
BANETO_DefineCenter(812.24890136719, 1725.2684326172, 355.86428833008, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_06_Steer_Clear_of_the_Beer_Here]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(30232) then
        BANETO_Print("Quest not found, skipping!")
        BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_06_Steer_Clear_of_the_Beer_Here]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
