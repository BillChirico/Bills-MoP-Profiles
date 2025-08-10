-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_04_My_Town_Its_on_Fire")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(30192)

-- Quest Item
BANETO_DefineQuestTargetId(213369) -- Mistfall Water Bucket

-- Quest Objective
BANETO_DefineQuestTargetId(63787) -- Brazier Fire

-- Quest Locations
BANETO_DefineCenter(718.2734375, 1583.7919921875, 376.47161865234, 130)
BANETO_DefineCenter(706.97039794922, 1628.9475097656, 377.74404907227, 130)
BANETO_DefineCenter(680.28063964844, 1654.4566650391, 377.74417114258, 130)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_05_Ruffling_Some_Feathers]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(30192) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_05_Ruffling_Some_Feathers]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
