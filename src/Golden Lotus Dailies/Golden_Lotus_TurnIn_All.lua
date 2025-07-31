-- Golden Lotus Quest Turn-In Handler
BANETO_DefineProfileName("Golden_Lotus_TurnIn_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Golden Lotus Quest Turn-In Information Table
local questTurnIns = {
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
BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true
BANETO_ExecuteCustomQuestPulse_Questmaster = true
local inProgress = false

function _G.BANETO_ExecuteCustomQuestPulse()
	if inProgress then
		return
	end

	for i = 1, #questTurnIns do
		local quest = questTurnIns[i]

		if BANETO_HasQuest(quest.questId) and not BANETO_HasQuestCompleted(quest.questId) then
			BANETO_Print("Turning in " .. quest.questName .. " (" .. quest.questId .. ")")

			BANETO_DefineQuestId(quest.questId)
			BANETO_DefineQuestPickupNPC(npcCoords.x, npcCoords.y, npcCoords.z, quest.npcId)
			BANETO_DefineQuestTurninNPC(npcCoords.x, npcCoords.y, npcCoords.z, quest.npcId)
			BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
			BANETO_ExecuteCustomQuestPulse_Questmaster = false
			BANETO_SetNextLocalQuestProfile([[Golden_Lotus_TurnIn_All]])
			inProgress = true

			return
		end
	end

	BANETO_Print("No more completed quests to turn in!")
	BANETO_Stop()
end
