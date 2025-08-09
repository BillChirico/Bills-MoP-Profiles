-- Quest Information
BANETO_DefineProfileName("Klaxxi_07_An_Ancient_Empire")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(31232)

-- Quest Objective
BANETO_DefineQuestTargetId(213314) -- Gurthani Tablet

-- Quest Locations
BANETO_DefineCenter(322.75918579102, 2384.0385742188, 202.71076965332, 300)
BANETO_DefineCenter(360.16882324219, 2507.5568847656, 218.33654785156, 300)
BANETO_DefineCenter(406.19610595703, 2618.5681152344, 218.66253662109, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_08_Dreadspinner_Extermination]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31232) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_08_Dreadspinner_Extermination]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
