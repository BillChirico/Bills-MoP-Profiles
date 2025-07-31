-- Golden Lotus Quest Accept Handler
BANETO_DefineProfileName("!Golden_Lotus_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Golden Lotus Quest Accept Information Table
local questAccepts = {
	{
		questId = 30307,
		npcId = 58408,
		questName = "The Eternal Vigil",
	},
	{
		questId = 31757,
		npcId = 58465,
		questName = "Unleashed Spirits",
	},
	{
		questId = 31762,
		npcId = 58465,
		questName = "Crumbling Behemoth",
	},
	{
		questId = 31758,
		npcId = 58471,
		questName = "Laosy Scouting",
	},
	{
		questId = 30312,
		npcId = 58468,
		questName = "Given a Second Chance",
	},
}

-- NPC Coordinates (all quest NPCs are at the same location)
local npcCoords = {
	x = 1215.7375488281,
	y = 1047.44921875,
	z = 425.9674987793,
}

-- Quest Pulse
-- BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true
BANETO_ExecuteCustomQuestPulse_Questmaster = true
local inProgress = false

function _G.BANETO_ExecuteCustomQuestPulse()
	if inProgress then
		return
	end

	for i = 1, #questAccepts do
		local quest = questAccepts[i]

		-- Check if quest is available (not in log and not completed for today)
		if not BANETO_HasQuest(quest.questId) and not BANETO_HasQuestCompleted(quest.questId) then
			BANETO_Print("Accepting " .. quest.questName .. " (" .. quest.questId .. ")")

			BANETO_DefineQuestId(quest.questId)
			BANETO_SetToSkipTurnInQuest()
			BANETO_DefineQuestPickupNPC(npcCoords.x, npcCoords.y, npcCoords.z, quest.npcId)
			BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
			BANETO_ExecuteCustomQuestPulse_Questmaster = false
			BANETO_SetNextLocalQuestProfile([[!Golden_Lotus_Accept_All]])
			inProgress = true

			return
		end
	end

	BANETO_Print("All available quests accepted! Starting quest chain...")
	BANETO_LoadQuestProfile([[Golden_Lotus_01_The_Eternal_Vigil]])
end
