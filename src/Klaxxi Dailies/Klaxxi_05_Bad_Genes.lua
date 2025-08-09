-- Quest Information
BANETO_DefineProfileName("Klaxxi_05_Bad_Genes")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31271)

-- Quest Objectives
BANETO_DefineQuestTargetId(63257) -- Ik'thik Genemancer
BANETO_DefineQuestTargetId(63176) -- Ik'thik Egg-Drone

-- Quest Locations
BANETO_DefineCenter(-1038.4776611328, 2737.1511230469, 98.71753692627, 300)
BANETO_DefineCenter(-880.50927734375, 2810.1728515625, 114.3451461792, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_06_Mistblade_Destruction]])

BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31271) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_06_Mistblade_Destruction]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
