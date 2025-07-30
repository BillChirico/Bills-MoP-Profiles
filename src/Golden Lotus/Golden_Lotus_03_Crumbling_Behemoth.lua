-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_03_Crumbling_Behemoth")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipPulseQuest()
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31762)

-- NPC Information
BANETO_DefineQuestPickupNPC(-600.13208007812, -4186.1938476562, 41.089248657227, 58465)
BANETO_DefineQuestTurninNPC(-600.13208007812, -4186.1938476562, 41.089248657227, 58465)

-- Quest Objective
BANETO_DefineQuestTargetId(65824)

-- Quest Locations
BANETO_DefineCenter(1467.1362304688, 1356.7120361328, 445.89776611328, 300)
BANETO_DefineCenter(1533.8942871094, 1442.2365722656, 442.35995483398, 300)
BANETO_DefineCenter(1392.3897705078, 1291.5573730469, 401.01940917969, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_04_Laosy_Scouting]])
