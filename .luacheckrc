-- Luacheck configuration for World of Warcraft Bento Profile Development

-- Set standard to lua51 (WoW uses Lua 5.1)
std = "lua51"

-- Allow unused arguments (common in WoW addon callbacks)
unused_args = false

-- Allow unused variables starting with underscore
unused = false

-- Allow setting global variables without warnings about them being unused
-- (BANETO framework reads these configuration variables externally)
unused_globals = false

-- Allow implicit global variable definitions without generating unused warnings
allow_defined = true

-- Suppress specific warning codes for unused globals (131 = unused global variable)
ignore = { "131" }

-- Allow accessing undefined fields in tables
allow_defined_top = true

-- Define global functions used in BANETO profiles and WoW API
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
    "BANETO_DefineProfileUnstuck",
    "BANETO_DefineWhitelist",
    "BANETO_DefineBlacklistIDGlobal",

    -- BANETO Quest Functions
    "BANETO_HasQuest",
    "BANETO_HasQuestCompleted",
    "BANETO_LoadQuestProfile",
    "BANETO_LoadProfile",
    "BANETO_Stop",

    -- BANETO Object/Target Functions
    "BANETO_Object",
    "BANETO_ObjectId",
    "BANETO_ObjectPosition",
    "BANETO_GetTarget",
    "BANETO_GetTargetId",
    "BANETO_ClearTarget",
    "BANETO_GetDistance3D",
    "BANETO_UnitHealth",
    "BANETO_GetUnitMovementFlags",
    "BANETO_SetBanetoTarget",

    -- BANETO Movement Functions
    "BANETO_MeshTo",
    "BANETO_PlayerPosition",
    "BANETO_RecordLandingspot",
    "BANETO_GetFacingValue",
    "BANETO_SetPlayerAnglesLuabox",
    "BANETO_StopMovement",

    -- BANETO Blacklist Functions
    "BANETO_AddMobToGuidBlacklist",
    "BANETO_IsGuidContainedInGuidBlacklist",
    "BANETO_BlacklistID",
    "BlacklistID",

    -- BANETO Interaction Functions
    "BANETO_Interact",
    "BANETO_UseItem",
    "BANETO_HasItem",

    -- BANETO Utility Functions
    "BANETO_Print",
    "BANETO_GetState",
    "BANETO_ReadFile",
    "BANETO_JsonDecode",

    -- BANETO Custom Quest Pulse Functions
    "BANETO_ExecuteCustomQuestPulse",
    "BANETO_ExecuteCustomQuestPulse_Questmaster",
    "BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior",

    -- Object Search Functions
    "GetObjectWithId",
    "GetObjectWithIdClose",
    "GetObjectWithIdMedium",
    "GetObjectWithIdIncludingBlacklistCheck",
    "UnlockedTargetUnit",

    -- WoW API Functions
    "C_QuestLog",
    "C_GossipInfo",
    "GetTime",
    "UnitGUID",
    "UnitExists",
    "AcceptQuest",

    -- Lua standard
    "time",
}

-- File-specific configurations
files["src/**/*.lua"] = {}
