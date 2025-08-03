-- Quest Information
BANETO_DefineProfileName("Part02_Golden_Lotus_04_My_Town_Its_on_Fire_Mistfall_Village")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(30192)

-- NPC Information
BANETO_DefineQuestPickupNPC(699.212890625, 1587.1867675781, 384.44644165039, 58819) -- Mayor Shiyo
BANETO_DefineQuestTurninNPC(699.212890625, 1587.1867675781, 384.44644165039, 58819) -- Mayor Shiyo

-- Quest Item
BANETO_DefineQuestTargetId(213369) -- Mistfall Water Bucket

-- Quest Objective
BANETO_DefineQuestTargetId(63787) -- Brazier Fire

-- Quest Locations
BANETO_DefineCenter(718.2734375, 1583.7919921875, 376.47161865234, 130)
BANETO_DefineCenter(706.97039794922, 1628.9475097656, 377.74404907227, 130)
BANETO_DefineCenter(680.28063964844, 1654.4566650391, 377.74417114258, 130)

-- Next Quest - Chain to Part 2 turn-in handler
BANETO_SetNextLocalQuestProfile([[Part02_Golden_Lotus_TurnIn_All_Mistfall_Village]])
