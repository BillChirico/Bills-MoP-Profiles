-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_01_The_Eternal_Vigil")
BANETO_DefineProfileType("Questing")
-- BANETO_SetToSkipPulseQuest()
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(30307)

-- NPC Information
BANETO_DefineQuestPickupNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58408)
BANETO_DefineQuestTurninNPC(1215.7375488281, 1047.44921875, 425.9674987793, 58408)

-- Quest Objective
BANETO_DefineQuestTargetId(65810)

-- Quest Locations
BANETO_DefineCenter(1467.1362304688, 1356.7120361328, 445.89776611328, 300)
BANETO_DefineCenter(1533.8942871094, 1442.2365722656, 442.35995483398, 300)
BANETO_DefineCenter(1392.3897705078, 1291.5573730469, 401.01940917969, 300)
BANETO_DefineCenter(1674.5532226562, 1352.6085205078, 453.59204101562, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_02_Unleashed_Spirits]])
