-- Quest Information
BANETO_DefineProfileName("Part02_Golden_Lotus_Transition_Mistfall_Village")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[TalkTo]])
BANETO_DefineQuestId(31242)

-- NPC Information
BANETO_DefineQuestPickupNPC(1212.2109375, 1042.9044189453, 425.96655273438, 58408)
BANETO_DefineQuestTurninNPC(727.81665039062, 1621.7716064453, 377.74417114258, 59338)

-- Quest Objective

-- Quest Locations

-- Next Quest - Chain to Part 2 accept all handler after transition
BANETO_SetNextLocalQuestProfile([[Part02_!Golden_Lotus_Accept_All_Mistfall_Village]])
