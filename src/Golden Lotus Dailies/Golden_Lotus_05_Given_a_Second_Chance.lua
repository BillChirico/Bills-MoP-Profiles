-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_05_Given_a_Second_Chance")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[UseItemOnNpc]])
BANETO_DefineQuestId(30312)

-- NPC Information
BANETO_DefineQuestPickupNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58468)
BANETO_DefineQuestTurninNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58468)

-- Quest Item
BANETO_DefineQuestTargetId(84242)

-- Quest Objective
BANETO_DefineQuestTargetId(59183)

-- Quest Locations
BANETO_DefineCenter(1443.3646240234, 1143.2777099609, 429.45077514648, 200)

-- Whitelist fix for not targeting downed mobs
BANETO_DefineWhitelist(1443.3646240234, 1143.2777099609, 429.45077514648, 200)

-- Next Quest - Chain to consolidated turn-in handler after completing all quest objectives
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_06_Striking_First]])

-- Quest Pulse
_G.BANETO_ExecuteCustomQuestPulse_Questmaster = true

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(30312) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Golden_Lotus_06_Striking_First]])
        return
    end

    local currentTarget = BANETO_Object("target")
    local currentTargetId = BANETO_GetTargetId()

    if currentTarget and BANETO_UnitHealth(currentTarget) >= 50 and currentTargetId == 59183 then
        BANETO_AddMobToGuidBlacklist(currentTarget)

        BANETO_Print("Healed Wounded Defender - Adding to blacklist!")
        BANETO_ClearTarget()
    end
end
