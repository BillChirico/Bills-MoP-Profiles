-- Golden Lotus Quest Turn-In Handler
BANETO_DefineProfileName("Golden_Lotus_TurnIn_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Load shared Golden Lotus quest data
dofile("Golden_Lotus_Data.lua")

-- Use shared data
local questTurnIns = GoldenLotusData.quests
local npcCoords = GoldenLotusData.npcCoords

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
