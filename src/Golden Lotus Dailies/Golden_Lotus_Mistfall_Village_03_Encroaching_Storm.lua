-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_03_Encroaching_Storm")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30194)

-- Quest Objective
BANETO_DefineQuestTargetId(58456) -- Thundermaw

-- Quest Locations
BANETO_DefineCenter(807.55700683594, 1611.5791015625, 375.10772705078, 130)
BANETO_DefineCenter(943.54974365234, 1649.6994628906, 370.34298706055, 130)
BANETO_DefineCenter(1086.0892333984, 1629.6673583984, 371.6979675293, 130)
BANETO_DefineCenter(1152.2344970703, 1775.4385986328, 373.70565795898, 130)
BANETO_DefineCenter(1001.3810424805, 1843.0981445312, 372.3623046875, 130)
BANETO_DefineCenter(840.20239257812, 1776.7647705078, 382.08474731445, 130)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_04_My_Town_Its_on_Fire]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(30194) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_04_My_Town_Its_on_Fire]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
