-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_05_Ruffling_Some_Feathers")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30232)

-- NPC Information
BANETO_DefineQuestPickupNPC(727.81665039062, 1621.7716064453, 377.74417114258, 59338) -- Che Wildwalker
BANETO_DefineQuestTurninNPC(727.81665039062, 1621.7716064453, 377.74417114258, 59338) -- Che Wildwalker

-- Quest Objective
BANETO_DefineQuestTargetId(58434)  -- Wildscale Saurok
BANETO_DefineQuestTargetId(58432)  -- Wildscale Herbalist

-- Quest Locations
BANETO_DefineCenter(1800.5, 1650.2, 450.3, 200)
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