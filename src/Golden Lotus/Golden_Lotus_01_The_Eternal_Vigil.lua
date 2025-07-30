-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_01_The_Eternal_Vigil")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipPulseQuest()
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30307)

-- NPC Information
BANETO_DefineQuestPickupNPC(-600.13208007812, -4186.1938476562, 41.089248657227, 58408)
BANETO_DefineQuestTurninNPC(-600.13208007812, -4186.1938476562, 41.089248657227, 58408)

-- Quest Objective
BANETO_DefineQuestTargetId(58412)

-- Locations
BANETO_DefineCenter(-420.32574462891, -4206.9638671875, 52.409133911133, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_02_Unleashed_Spirits]])
