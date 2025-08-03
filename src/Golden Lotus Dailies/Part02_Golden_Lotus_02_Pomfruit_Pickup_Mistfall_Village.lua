-- Quest Information
BANETO_DefineProfileName("Part02_Golden_Lotus_02_Pomfruit_Pickup_Mistfall_Village")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[GatherObject]])
BANETO_DefineQuestId(30231)

-- NPC Information
BANETO_DefineQuestPickupNPC(758.8076171875, 1624.3572998047, 370.361328125, 58818) -- Cook Tope
BANETO_DefineQuestTurninNPC(758.8076171875, 1624.3572998047, 370.361328125, 58818) -- Cook Tope

-- Quest Objective
BANETO_DefineQuestTargetId(58767) -- Pomfruit

-- Quest Locations
BANETO_DefineCenter(807.55700683594, 1611.5791015625, 375.10772705078, 130)
BANETO_DefineCenter(943.54974365234, 1649.6994628906, 370.34298706055, 130)
BANETO_DefineCenter(1086.0892333984, 1629.6673583984, 371.6979675293, 130)
BANETO_DefineCenter(1152.2344970703, 1775.4385986328, 373.70565795898, 130)
BANETO_DefineCenter(1001.3810424805, 1843.0981445312, 372.3623046875, 130)
BANETO_DefineCenter(840.20239257812, 1776.7647705078, 382.08474731445, 130)

-- Next Quest - Chain to Part 2 turn-in handler
BANETO_SetNextLocalQuestProfile([[Part02_Golden_Lotus_TurnIn_All_Mistfall_Village]])
