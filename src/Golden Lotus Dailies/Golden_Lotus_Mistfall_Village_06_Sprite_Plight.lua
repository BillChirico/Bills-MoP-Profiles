-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Mistfall_Village_06_Sprite_Plight")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30190)

-- NPC Information
BANETO_DefineQuestPickupNPC(699.212890625, 1587.1867675781, 384.44644165039, 58819) -- Mayor Shiyo
BANETO_DefineQuestTurninNPC(699.212890625, 1587.1867675781, 384.44644165039, 58819) -- Mayor Shiyo

-- Quest Objective
BANETO_DefineQuestTargetId(58673) -- Slateskin Troublemaker

-- Quest Locations
BANETO_DefineCenter(606.77709960938, 1500.1634521484, 412.3415222168, 130)
BANETO_DefineCenter(681.00341796875, 1493.0206298828, 412.3415222168, 130)
BANETO_DefineCenter(572.55438232422, 1536.2253417969, 412.3576965332, 130)

-- Next Quest - Chain to Part 2 turn-in handler
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Mistfall_Village_07_TurnIn_All]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(30190) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Golden_Lotus_Mistfall_Village_07_TurnIn_All]])
        return
    else
        BANETO_ExecuteCustomQuestPulse_Questmaster = false
    end
end
