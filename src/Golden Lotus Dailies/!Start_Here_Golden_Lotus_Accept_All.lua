-- Golden Lotus Quest Accept Handler
-- ⭐ START HERE: This is the entry point for Golden Lotus dailies!
-- This profile will automatically accept all available quests and start the quest chain.
BANETO_DefineProfileName("!Start_Here_Golden_Lotus_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Load shared Golden Lotus quest data
dofile("Golden_Lotus_Data.lua")

-- Use shared data
local questAccepts = GoldenLotusData.quests
local npcCoords = GoldenLotusData.npcCoords

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
			BANETO_SetNextLocalQuestProfile([[!Start_Here_Golden_Lotus_Accept_All]])
			inProgress = true

			return
		end
	end

	BANETO_Print("All available quests accepted! Starting quest chain...")
	BANETO_LoadQuestProfile([[Golden_Lotus_01_The_Eternal_Vigil]])
end
