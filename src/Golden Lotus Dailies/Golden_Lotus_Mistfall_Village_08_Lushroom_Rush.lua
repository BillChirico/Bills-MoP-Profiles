-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_08_Lushroom_Rush")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(30196)

-- Quest Objective
BANETO_DefineQuestTargetId(213350) -- Lushroom

-- Quest Locations
BANETO_DefineCenter(743.79956054688, 1340.1297607422, 465.8759765625, 300)
BANETO_DefineCenter(817.48120117188, 1215.9324951172, 486.46109008789, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_09_The_Pandaren_Uprising_Relived]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    -- Check if we have the quest
    if not BANETO_HasQuest(30196) then
        BANETO_Print("Quest not found, skipping!")
        BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_09_The_Pandaren_Uprising_Relived]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
