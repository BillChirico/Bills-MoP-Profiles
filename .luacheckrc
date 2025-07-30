-- Luacheck configuration for World of Warcraft Bento Profile Development

-- Set standard to lua51 (WoW uses Lua 5.1)
std = "lua51"

-- Allow unused arguments (common in WoW addon callbacks)
unused_args = false

-- Allow unused variables starting with underscore
unused = false

-- Allow accessing undefined fields in tables
allow_defined_top = true

-- Define global functions used in BANETO profiles
globals = {
	-- BANETO Profile Definition Functions
	"BANETO_DefineProfileName",
	"BANETO_DefineProfileType",
	"BANETO_SetToSkipPulseQuest",
	"BANETO_SetToSkipTurnInQuest",
	"BANETO_DefineQuestStepType",
	"BANETO_DefineQuestId",
	"BANETO_DefineCenter",
	"BANETO_DefineQuestPickupNPC",
	"BANETO_DefineQuestTurninNPC",
	"BANETO_DefineQuestTargetId",
	"BANETO_SetNextLocalQuestProfile",
}

-- File-specific configurations
files["src/**/*.lua"] = {}
