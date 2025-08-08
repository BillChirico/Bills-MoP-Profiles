-- Quest Information
BANETO_DefineProfileName("Klaxxi_10_Putting_An_Eye_Out")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31234)

-- NPC Information
-- BANETO_DefineQuestPickupNPC(134.97793579102, 3228.5539550781, 215.59104919434, 63072) -- Rik'kal the Dissector
-- BANETO_DefineQuestTurninNPC(134.97793579102, 3228.5539550781, 215.59104919434, 63072) -- Rik'kal the Dissector

-- Quest Objective
BANETO_DefineQuestTargetId(63731) -- Mire Beast

-- Quest Locations
BANETO_DefineCenter(119.56773376465, 2551.4650878906, 147.24160766602, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_11_Brain_Food]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31234) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_11_Brain_Food]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
