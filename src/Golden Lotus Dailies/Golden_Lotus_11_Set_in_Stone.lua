-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_11_Set_in_Stone")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30309)

-- Quest Objective -
BANETO_DefineQuestTargetId(59196) -- Mogu Effigies

-- Quest Locations
BANETO_DefineCenter(1467.1362304688, 1356.7120361328, 445.89776611328, 300)
BANETO_DefineCenter(1533.8942871094, 1442.2365722656, 442.35995483398, 300)
BANETO_DefineCenter(1392.3897705078, 1291.5573730469, 401.01940917969, 300)
BANETO_DefineCenter(1674.5532226562, 1352.6085205078, 453.59204101562, 300)

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
