-- Quest Information
BANETO_DefineProfileName("Klaxxi_11_Brain_Food")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31238)

-- NPC Information
BANETO_DefineQuestPickupNPC(139.79104614258, 3234.7741699219, 212.32595825195, 63758) -- Kaz'tik the Manipulator
BANETO_DefineQuestTurninNPC(139.79104614258, 3234.7741699219, 212.32595825195, 63758) -- Kaz'tik the Manipulator

-- Quest Objective
BANETO_DefineQuestTargetId(62029) -- Greatback Mushan

-- Quest Locations
BANETO_DefineCenter(721.42352294922, 2651.0187988281, 303.10122680664, 300)
BANETO_DefineCenter(560.79339599609, 2786.2145996094, 245.14797973633, 300)
BANETO_DefineCenter(540.19525146484, 3022.3325195312, 267.25503540039, 300)
BANETO_DefineCenter(488.28393554688, 3183.8854980469, 266.76470947266, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_TurnIn_All]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31238) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_TurnIn_All]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
