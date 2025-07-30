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
BANETO_DefineCenter(1443.3646240234, 1143.2777099609, 429.45077514648, 130)
BANETO_DefineCenter(1487.8192138672, 1098.7009277344, 431.32638549805, 130)

-- Next Quest - Chain to consolidated turn-in handler after completing all quest objectives
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_TurnIn_All]])

-- Quest Pulse
-- Pulse
_G.BANETO_ExecuteCustomQuestPulse_Questmaster = true
-- _G.BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true

function _G.BANETO_ExecuteCustomQuestPulse()
	local targetId = BANETO_GetTargetId()

	-- Debug: Check if we have a target at all
	if not targetId then
		return
	end

	-- Check if target is a Wounded Defender (quest target)
	if targetId == 59183 then
		-- Get the target object for blacklisting
		local tgt = BANETO_GetTarget()
		if not tgt then
			return
		end

		-- Check if target is already blacklisted (already healed)
		if BANETO_IsGuidContainedInGuidBlacklist(tgt) then
			BANETO_Print("Target already blacklisted (healed) - clearing target")
			BANETO_ClearTarget()
			return
		end

		-- Let Baneto handle the quest item usage automatically
		-- Just add to blacklist after Baneto uses the item
		BANETO_Print("Healed Wounded Defender - Adding to blacklist!")
		BANETO_AddMobToGuidBlacklist(tgt)
		BANETO_ClearTarget()
	end
end
