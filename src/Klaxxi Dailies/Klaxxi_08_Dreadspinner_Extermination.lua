-- Quest Information
BANETO_DefineProfileName("Klaxxi_08_Dreadspinner_Extermination")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31231)

-- Quest Objective
BANETO_DefineQuestTargetId(61981) -- Dreadspinner Tender

-- Quest Locations
BANETO_DefineCenter(322.75918579102, 2384.0385742188, 202.71076965332, 300)
BANETO_DefineCenter(360.16882324219, 2507.5568847656, 218.33654785156, 300)
BANETO_DefineCenter(406.19610595703, 2618.5681152344, 218.66253662109, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_09_Nope_Nope_Nope]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31231) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_09_Nope_Nope_Nope]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
