-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_04_Laosy_Scouting")
BANETO_DefineProfileType("Questing")
-- BANETO_SetToSkipPulseQuest()
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31758)

-- NPC Information
BANETO_DefineQuestPickupNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58471)
BANETO_DefineQuestTurninNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58471)

-- Quest Objective
BANETO_DefineQuestTargetId(65868)

-- Quest Locations
BANETO_DefineCenter(-420.32574462891, -4206.9638671875, 52.409133911133, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_05_Given_a_Second_Chance]])
