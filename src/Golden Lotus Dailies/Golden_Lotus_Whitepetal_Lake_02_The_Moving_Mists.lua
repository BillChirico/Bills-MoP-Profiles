BANETO_DefineProfileName("Golden_Lotus_Whitepetal_Lake_02_The_Moving_Mists")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30313)

-- Quest Objective
BANETO_DefineQuestTargetId(58672) -- Fog Walker

-- Quest Locations
BANETO_DefineCenter(1082.5245361328, 1374.8916015625, 354.11651611328, 200)
BANETO_DefineCenter(1157.4372558594, 1516.5017089844, 349.71102905273, 200)
BANETO_DefineCenter(1177.8199462891, 1411.6109619141, 343.08337402344, 200)

-- Next Quest in Chain
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Whitepetal_Lake_03_Fiery_Tongue_Fragile_Feet]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    -- Skip if quest not available
    if not BANETO_HasQuest(30313) then
        BANETO_Print("Quest 'The Moving Mists' (30313) not available, skipping...")
        BANETO_LoadQuestProfile([[Golden_Lotus_Whitepetal_Lake_03_Fiery_Tongue_Fragile_Feet]])
        return
    end

    -- Check if quest is completed
    if BANETO_HasQuestCompleted(30313) then
        BANETO_Print("Quest 'The Moving Mists' (30313) completed!")
        BANETO_LoadQuestProfile([[Golden_Lotus_Whitepetal_Lake_03_Fiery_Tongue_Fragile_Feet]])
        return
    end

    BANETO_ExecuteCustomQuestPulse_Questmaster = false
end
