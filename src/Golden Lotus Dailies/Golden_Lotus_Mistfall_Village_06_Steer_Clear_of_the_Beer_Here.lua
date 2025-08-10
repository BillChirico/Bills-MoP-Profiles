-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_06_Steer_Clear_of_the_Beer_Here")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(30191)

-- Quest Objective
BANETO_DefineQuestTargetId(213365) -- Stolen Mistfall Keg

-- Quest Locations - Mistfall Village area with beer barrels
BANETO_DefineCenter(716.07702636719, 1593.9254150391, 376.66329956055, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_07_Sprite_Plight]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(30191) then
        BANETO_Print("Quest not found, skipping!")
        BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_07_Sprite_Plight]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
