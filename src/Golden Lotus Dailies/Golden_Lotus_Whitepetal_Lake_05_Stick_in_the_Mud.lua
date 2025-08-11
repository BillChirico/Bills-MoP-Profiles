BANETO_DefineProfileName("Golden_Lotus_Whitepetal_Lake_05_Stick_in_the_Mud")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(30340)

-- Quest Objective
BANETO_DefineQuestTargetId(212744) -- Whitepetal Reeds

-- Quest Locations
BANETO_DefineCenter(1082.5245361328, 1374.8916015625, 354.11651611328, 200)
BANETO_DefineCenter(1157.4372558594, 1516.5017089844, 349.71102905273, 200)
BANETO_DefineCenter(1177.8199462891, 1411.6109619141, 343.08337402344, 200)

-- Next Quest in Chain - Go to turn-in phase
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Whitepetal_Lake_TurnIn_All]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    -- Skip if quest not available
    if not BANETO_HasQuest(30340) then
        BANETO_Print("Quest 'Stick in the Mud' (30340) not available, skipping...")
        BANETO_LoadQuestProfile([[Golden_Lotus_Whitepetal_Lake_TurnIn_All]])
        return
    end

    -- Check if quest is completed
    if BANETO_HasQuestCompleted(30340) then
        BANETO_Print("Quest 'Stick in the Mud' (30340) completed!")
        BANETO_LoadQuestProfile([[Golden_Lotus_Whitepetal_Lake_TurnIn_All]])
        return
    end
end
