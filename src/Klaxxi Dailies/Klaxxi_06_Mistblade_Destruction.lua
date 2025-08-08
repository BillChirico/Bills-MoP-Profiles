-- Quest Information
BANETO_DefineProfileName("Klaxxi_06_Mistblade_Destruction")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31267)

-- NPC Information
BANETO_DefineQuestPickupNPC(136.87948608398, 3193.1166992188, 214.7607421875, 62538) -- Kil'ruk the Wind-Reaver
BANETO_DefineQuestTurninNPC(136.87948608398, 3193.1166992188, 214.7607421875, 62538) -- Kil'ruk the Wind-Reaver

-- Quest Objective
BANETO_DefineQuestTargetId(61970) -- Mistblade Ripper

-- Quest Locations
BANETO_DefineCenter(-673.48712158203, 2538.6809082031, 131.43994140625, 300)
BANETO_DefineCenter(-861.33026123047, 2692.1928710938, 130.79768371582, 300)
BANETO_DefineCenter(-642.70220947266, 2806.474609375, 135.87733459473, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_TurnIn_All]])

BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31267) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_TurnIn_All]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
