-- Golden Lotus Mistfall Village Daily: The Pandaren Uprising Relived
-- Quest ID: 30237
-- Kill 8 Ancient Mogu Spirits at Tu Shen Burial Ground
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_09_The_Pandaren_Uprising_Relived")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30237)

-- Quest Objective
BANETO_DefineQuestTargetId(58671) -- Ancient Mogu Spirit

-- Quest Locations
BANETO_DefineCenter(743.79956054688, 1340.1297607422, 465.8759765625, 300)
BANETO_DefineCenter(817.48120117188, 1215.9324951172, 486.46109008789, 300)

-- Next Quest - Continue to turn-in handler
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_10_TurnIn_All]])

-- Quest Pulse with skip logic for daily rotation
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    -- Check if we have the quest
    if not BANETO_HasQuest(30237) then
        BANETO_Print("The Pandaren Uprising Relived not available today, skipping!")
        BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_10_TurnIn_All]])
        return
    else
        -- Quest found, execute normal KillAndLoot behavior
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
        BANETO_Print("Starting The Pandaren Uprising Relived - Kill 8 Ancient Mogu Spirits")
    end
end
