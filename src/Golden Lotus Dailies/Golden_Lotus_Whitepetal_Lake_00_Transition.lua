-- Quest Information
BANETO_DefineProfileName("Golden_Lotus_Whitepetal_Lake_00_Transition")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])
BANETO_DefineQuestId(31131)

-- NPC Information
BANETO_DefineQuestPickupNPC(1212.2109375, 1042.9044189453, 425.96655273438, 58408)    -- Leven Dawnblade
BANETO_DefineQuestTurninNPC(1170.4908447266, 1375.1470947266, 351.30313110352, 59342) -- He Softfoot

-- Next Quest - Chain to Whitepetal Lake accept all handler after transition
BANETO_SetNextLocalQuestProfile([[Golden_Lotus_Whitepetal_Lake_01_Accept_All]])
