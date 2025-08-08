-- Quest Information
BANETO_DefineProfileName("Klaxxi_03_A_Little_Brain_Work")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31268)

-- NPC Information
-- BANETO_DefineQuestPickupNPC(139.79104614258, 3234.7741699219, 212.32595825195, 63758)  -- Kaz'tik the Manipulator
-- BANETO_DefineQuestTurninNPC(139.79104614258, 3234.7741699219, 212.325958251954, 63758) -- Kaz'tik the Manipulator

-- Quest Objective
BANETO_DefineQuestTargetId(63728) -- Ik'thik Amberstinger

-- Quest Locations (Ik'thik territory in the south)
BANETO_DefineCenter(-1038.4776611328, 2737.1511230469, 98.71753692627, 300)
BANETO_DefineCenter(-880.50927734375, 2810.1728515625, 114.3451461792, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_04_Kunchong_Treats]])

BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31268) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_04_Kunchong_Treats]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
