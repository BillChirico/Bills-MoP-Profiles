-- Quest Information
BANETO_DefineProfileName("Klaxxi_09_Nope_Nope_Nope")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31235)

-- NPC Information
BANETO_DefineQuestPickupNPC(136.87948608398, 3193.1166992188, 214.7607421875, 62538) -- Kil'ruk the Wind-Reaver
BANETO_DefineQuestTurninNPC(136.87948608398, 3193.1166992188, 214.7607421875, 62538) -- Kil'ruk the Wind-Reaver

-- Quest item
BANETO_DefineQuestTargetId(82807) -- Shado-Pan Dragon Gun

-- Quest Objective
BANETO_DefineQuestTargetId(620077) -- Dreadspinner Egg

-- Quest Locations
BANETO_DefineCenter(322.75918579102, 2384.0385742188, 202.71076965332, 300)
BANETO_DefineCenter(360.16882324219, 2507.5568847656, 218.33654785156, 300)
BANETO_DefineCenter(406.19610595703, 2618.5681152344, 218.66253662109, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_10_Putting_An_Eye_Out]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31235) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_10_Putting_An_Eye_Out]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
