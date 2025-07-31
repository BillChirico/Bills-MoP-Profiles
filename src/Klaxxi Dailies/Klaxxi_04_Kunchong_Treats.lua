-- Quest Information
BANETO_DefineProfileName("Klaxxi_04_Kunchong_Treats")
BANETO_DefineProfileType("Questing")
BANETO_SetToSkipTurnInQuest()
BANETO_DefineQuestStepType([[KillAndLoot]])
BANETO_DefineQuestId(31024)

-- NPC Information
BANETO_DefineQuestPickupNPC(139.79104614258, 3234.7741699219, 212.32595825195, 63758) -- Kaz'tik the Manipulator
BANETO_DefineQuestTurninNPC(139.79104614258, 3234.7741699219, 212.325958251954, 63758) -- Kaz'tik the Manipulator

-- Quest Objective
BANETO_DefineQuestTargetId(62160) -- Chillwater Turtle

-- Quest Locations
BANETO_DefineCenter(-556.62609863281, 2768.7702636719, 130.58763122559, 300)
BANETO_DefineCenter(-442.16436767578, 2662.6335449219, 162.55923461914, 300)
BANETO_DefineCenter(-451.47494506836, 3030.1540527344, 190.53112792969, 300)

-- Next Quest
BANETO_SetNextLocalQuestProfile([[Klaxxi_05_Bad_Genes]])
