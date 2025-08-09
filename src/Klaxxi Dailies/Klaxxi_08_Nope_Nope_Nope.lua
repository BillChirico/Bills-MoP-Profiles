-- Quest Information
BANETO_DefineProfileName("Klaxxi_08_Nope_Nope_Nope")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31235)

-- Quest Objective
BANETO_DefineQuestTargetId(62077) -- Dreadspinner Egg (target to destroy with Dragon Gun)

-- Quest Locations
BANETO_DefineCenter(322.75918579102, 2384.0385742188, 202.71076965332, 300)
BANETO_DefineCenter(360.16882324219, 2507.5568847656, 218.33654785156, 300)
BANETO_DefineCenter(406.19610595703, 2618.5681152344, 218.66253662109, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_09_Dreadspinner_Extermination]])

-- Quest Pulse
BANETO_ExecuteCustomQuestPulse_Questmaster = true

local wait = nil -- Timer to prevent spam clicking

-- Custom quest logic for Dragon Gun usage
-- This handles the special mechanics of using the Dragon Gun item on eggs
function _G.BANETO_ExecuteCustomQuestPulse()
    if not BANETO_HasQuest(31235) then
        BANETO_Print("Quest not found, skipping!")

        BANETO_LoadQuestProfile([[Klaxxi_09_Dreadspinner_Extermination]])
        return
    end

    -- Find and target a Dreadspinner Egg
    local object = GetObjectWithId(62077)
    UnlockedTargetUnit(object)

    local currentTarget = object
    local targetX, targetY, targetZ = BANETO_ObjectPosition(currentTarget)

    -- If we have a target and the Dragon Gun item, proceed with destruction
    if currentTarget and object and BANETO_HasItem(82807) then
        if not wait and BANETO_PlayerPosition(targetX, targetY, targetZ, 5) then
            -- Face the target properly before using Dragon Gun
            local facing = BANETO_GetFacingValue(targetX, targetY, targetZ)
            BANETO_SetPlayerAnglesLuabox(facing)

            -- Use the Dragon Gun on the egg
            BANETO_UseItem(82807)
            wait = time() + 5 -- Wait for action to complete
        elseif wait and time() > wait then
            -- Action completed, blacklist this egg and find next one
            wait = nil
            BANETO_AddMobToGuidBlacklist(currentTarget)
            BANETO_ClearTarget()
        else
            -- Move closer to the target
            BANETO_MeshTo(targetX, targetY, targetZ)
        end
    end
end
