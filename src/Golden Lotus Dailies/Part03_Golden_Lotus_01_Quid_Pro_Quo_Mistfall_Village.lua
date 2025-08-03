-- Quest Information
BANETO_DefineProfileName("Part03_Golden_Lotus_01_Quid_Pro_Quo_Mistfall_Village")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30235)

-- NPC Information
BANETO_DefineQuestPickupNPC(727.81665039062, 1621.7716064453, 377.74417114258, 59338) -- Che Wildwalker
BANETO_DefineQuestTurninNPC(727.81665039062, 1621.7716064453, 377.74417114258, 59338) -- Che Wildwalker

-- Quest Objective
BANETO_DefineQuestTargetId(58771) -- Quid

-- Quest Locations
BANETO_DefineCenter(603.54644775391, 1698.8565673828, 364.26226806641, 60)

-- Next Quest - Chain to Part 3 turn-in handler
BANETO_SetNextLocalQuestProfile([[Part03_Golden_Lotus_TurnIn_All_Mistfall_Village]])
