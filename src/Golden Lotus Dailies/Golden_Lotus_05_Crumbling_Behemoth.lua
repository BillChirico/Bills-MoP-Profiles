-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_05_Crumbling_Behemoth")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31762)

-- Quest Objective
BANETO_DefineQuestTargetId(65824)

-- Quest Locations
BANETO_DefineCenter(1467.1362304688, 1356.7120361328, 445.89776611328, 300)
BANETO_DefineCenter(1533.8942871094, 1442.2365722656, 442.35995483398, 300)
BANETO_DefineCenter(1392.3897705078, 1291.5573730469, 401.01940917969, 300)
BANETO_DefineCenter(1674.5532226562, 1352.6085205078, 453.59204101562, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_06_Given_a_Second_Chance]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31762) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Golden_Lotus_06_Given_a_Second_Chance]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
