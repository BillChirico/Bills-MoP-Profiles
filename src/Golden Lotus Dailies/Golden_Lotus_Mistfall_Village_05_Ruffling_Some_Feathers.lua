-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_05_Ruffling_Some_Feathers")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30232)

-- Quest Objective
BANETO_DefineQuestTargetId(58457) -- Silkfeather Hawk

-- Quest Locations
BANETO_DefineCenter(978.77215576172,1798.9145507812,350.58459472656 300)
BANETO_DefineCenter(1850.3, 1700.8, 455.1, 200)
BANETO_DefineCenter(1900.7, 1750.4, 460.8, 200)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_06_Sprite_Plight]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(30232) then
        BANETO_Print("Quest not found, skipping!")
        BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_06_Sprite_Plight]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end