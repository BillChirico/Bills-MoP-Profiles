-- Quest Information
BANETO_DefineProfileName("Klaxxi_08_Nope_Nope_Nope")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31235)

-- Quest item
-- BANETO_DefineQuestTargetId(82807) -- Shado-Pan Dragon Gun

-- Quest Objective
BANETO_DefineQuestTargetId(62077) -- Dreadspinner Egg

-- Quest Locations
BANETO_DefineCenter(322.75918579102, 2384.0385742188, 202.71076965332, 300)
BANETO_DefineCenter(360.16882324219, 2507.5568847656, 218.33654785156, 300)
BANETO_DefineCenter(406.19610595703, 2618.5681152344, 218.66253662109, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_09_Dreadspinner_Extermination]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

local wait = nil

function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31235) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_09_Dreadspinner_Extermination]])
        return
    end

    local object = GetObjectWithId(62077)
    UnlockedTargetUnit(object)

    local currentTarget = object
    local targetX, targetY, targetZ = BANETO_ObjectPosition(currentTarget)

    if currentTarget and object and BANETO_HasItem(82807) then
        if not wait and BANETO_PlayerPosition(targetX, targetY, targetZ, 5) then
            local facing = BANETO_GetFacingValue(targetX, targetY, targetZ)
            BANETO_SetPlayerAnglesLuabox(facing)

            BANETO_UseItem(82807)
            wait = time() + 5
        elseif wait and time() > wait then
            wait = nil
            BANETO_AddMobToGuidBlacklist(currentTarget)
            BANETO_ClearTarget()
        else
            BANETO_MeshTo(targetX, targetY, targetZ)
        end
    end
end
