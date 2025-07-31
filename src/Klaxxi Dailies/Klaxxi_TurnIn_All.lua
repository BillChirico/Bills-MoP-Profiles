-- Klaxxi Quest Turn-In Handler
BANETO_DefineProfileName("Klaxxi_TurnIn_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

-- Klaxxi Quest Turn-In Information Table
local questTurnIns = {
	{
		questId = 31270,
		npcId = 62180,
		questName = "The Fight Against Fear",
	},
	{
		questId = 31269,
		npcId = 62180,
		questName = "The Scale-Lord",
	},
	{
		questId = 31268,
		npcId = 63758,
		questName = "A Little Brain Work",
	},
	{
		questId = 31024,
		npcId = 63758,
		questName = "Kunchong Treats",
	},
	{
		questId = 31271,
		npcId = 63072,
		questName = "Bad Genes",
	},
	{
		questId = 31267,
		npcId = 62538,
		questName = "Mistblade Destruction",
	},
}

-- NPC Coordinates for different quest givers
local npcCoords = {
	-- Korven the Prime
	[62180] = {
		x = 130.63441467285,
		y = 3231.4921875,
		z = 215.64880371094,
	},
	-- Kaz'tik the Manipulator
	[63758] = {
		x = 139.79104614258,
		y = 3234.7741699219,
		z = 212.32595825195,
	},
	-- Rik'kal the Dissector
	[63072] = {
		x = 133.96636962891,
		y = 3228.0466308594,
		z = 215.70733642578,
	},
	-- Kil'ruk the Wind-Reaver
	[62538] = {
		x = 136.87948608398,
		y = 3193.1166992188,
		z = 214.7607421875,
	},
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

		if BANETO_HasQuest(quest.questId) and BANETO_HasQuestCompleted(quest.questId) then
			BANETO_Print("Turning in " .. quest.questName .. " (" .. quest.questId .. ")")

			local coords = npcCoords[quest.npcId]
			BANETO_DefineQuestId(quest.questId)
			BANETO_DefineQuestPickupNPC(coords.x, coords.y, coords.z, quest.npcId)
			BANETO_DefineQuestTurninNPC(coords.x, coords.y, coords.z, quest.npcId)
			BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = nil
			BANETO_ExecuteCustomQuestPulse_Questmaster = nil
			BANETO_SetNextLocalQuestProfile([[Klaxxi_TurnIn_All]])
			inProgress = true

			return
		end
	end

	BANETO_Print("No more completed quests to turn in!")
	BANETO_Stop()
end
