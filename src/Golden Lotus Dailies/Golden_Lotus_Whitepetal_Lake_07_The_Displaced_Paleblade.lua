-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Whitepetal_Lake_07_The_Displaced_Paleblade")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30314)

-- Quest Objective
BANETO_DefineQuestTargetId(59378) -- Paleblade Saurok

-- Quest Locations
BANETO_DefineCenter(1082.5245361328, 1374.8916015625, 354.11651611328, 200)
BANETO_DefineCenter(1157.4372558594, 1516.5017089844, 349.71102905273, 200)
BANETO_DefineCenter(1177.8199462891, 1411.6109619141, 343.08337402344, 200)

-- Next Quest in Chain
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Whitepetal_Lake_TurnIn_All]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    -- Skip if quest not available
    if not BANETO_HasQuest(30314) then
        BANETO_Print("Quest 'Sparkle in the Eye' (30265) not available, skipping...")
        BANETO_LoadQuestProfile([[Golden_Lotus_Whitepetal_Lake_TurnIn_All]])
        return
    end

    -- Check if quest is completed
    if BANETO_HasQuestCompleted(30314) then
        BANETO_Print("Quest 'Sparkle in the Eye' (30265) completed!")
        BANETO_LoadQuestProfile([[Golden_Lotus_Whitepetal_Lake_TurnIn_All]])
        return
    end

    BANETO_ExecuteCustomQuestPulse_Questmaster = false
end
