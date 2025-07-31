-- Quest Information
BANETO_DefineProfileName("Klaxxi_02_The_Scale_Lord")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31269)

-- NPC Information
BANETO_DefineQuestPickupNPC(130.63441467285, 3231.4921875, 215.64880371094, 62180) -- Korven the Prime
BANETO_DefineQuestTurninNPC(130.63441467285, 3231.4921875, 215.64880371094, 62180) -- Korven the Prime

-- Quest Objective
BANETO_DefineQuestTargetId(63179) -- Mistblade Scale-Lord

-- Quest Locations
BANETO_DefineCenter(-939.36853027344, 2585.9526367188, 146.56216430664, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_03_A_Little_Brain_Work]])
