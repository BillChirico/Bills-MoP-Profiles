-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_11_Set_in_Stone")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30309)

-- Quest Objective -
BANETO_DefineQuestTargetId(58855) -- Mogu Effigies

-- Quest Locations - Golden Stair area
BANETO_DefineCenter(1282.5, 1840.0, 382.0, 100)
BANETO_DefineCenter(1200.0, 1800.0, 385.0, 100)
BANETO_DefineCenter(1150.0, 1850.0, 390.0, 100)
BANETO_DefineCenter(1100.0, 1900.0, 395.0, 100)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_12_TurnIn_All]])

-- Quest Pulse
_G.BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(30309) then
        BANETO_Print("Quest 'Set in Stone' not found, skipping!")

        -- Load next profile in chain
        BANETO_LoadQuestProfile([[Golden_Lotus_12_TurnIn_All]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
