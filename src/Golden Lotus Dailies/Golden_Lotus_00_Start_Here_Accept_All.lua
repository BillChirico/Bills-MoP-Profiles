--[[
================================================================================
                    GOLDEN LOTUS DAILY QUEST ACCEPT HANDLER
================================================================================
⭐ START HERE: This is the entry point for all Golden Lotus daily quests!

PROFILE PURPOSE:
    Automatically accepts all available Golden Lotus daily quests from NPCs at
    the Temple of the White Tiger. Handles the rotating quest system where only
    a subset of quests are available each day.

QUEST ROTATION SYSTEM:
    Golden Lotus offers 11 possible daily quests, but only ~5-7 are available
    each day. The rotation is random and determined by Blizzard's daily reset.
    This handler automatically adapts to whatever quests are offered.

SUPPORTED QUESTS (11 total):
    From Leven Dawnblade (58408):
    • 30307 - The Eternal Vigil (Always available as hub starter)

    From Anji Autumnlight (58465):
    • 31757 - Unleashed Spirits
    • 31762 - Crumbling Behemoth
    • 31760 - Striking First
    • 30308 - Stone Hard Quilen
    • 30309 - Set in Stone

    From Kun Autumnlight (58471):
    • 31758 - Laosy Scouting
    • 31754 - Cannonfire
    • 31756 - High Chance of Rain

    From Sun Tenderheart (58468):
    • 30312 - Given a Second Chance
    • 31755 - Acts of Cruelty

EXECUTION FLOW:
    1. Visit each NPC in sequence
    2. Check for available quests using C_GossipInfo API
    3. Accept any quests not already in quest log
    4. Track progress and provide detailed logging
    5. Chain to first quest execution profile when complete

DEBUG OPTIONS:
    Set BANETO_DEBUG_MODE = true for verbose logging
    Set BANETO_VISUAL_SEPARATORS = false to disable console formatting

AUTHOR: Bills-MoP-Profiles
VERSION: 2.0.0
LAST UPDATED: 2025
================================================================================
--]]

-- luacheck: globals GossipFrame QuestDetailScrollFrame AcceptQuest C_GossipInfo

-- Profile Configuration
BANETO_DefineProfileName("Golden_Lotus_00_Start_Here_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])
BANETO_DefineProfileContinent(870) -- Pandaria

-- ============================================================================
-- CONFIGURATION OPTIONS
-- ============================================================================
-- Toggle debug mode for verbose logging
local DEBUG_MODE = false

-- Toggle visual separators in console output
local VISUAL_SEPARATORS = true

-- Interaction delays (in seconds)
local INTERACTION_DELAY = 5
local MOVEMENT_TIMEOUT = 5
local QUEST_ACCEPT_DELAY = 2

-- ============================================================================
-- QUEST DATABASE
-- ============================================================================
-- Complete list of all Golden Lotus daily quests with metadata
-- Note: Quest availability rotates daily - typically 5-7 quests available
local questAccepts = {
    {
        questId = 30307,
        npcId = 58408,
        questName = "The Eternal Vigil",
    },
    {
        questId = 31757,
        npcId = 58465,
        questName = "Unleashed Spirits",
    },
    {
        questId = 31762,
        npcId = 58465,
        questName = "Crumbling Behemoth",
    },
    {
        questId = 31760,
        npcId = 58465,
        questName = "Striking First",
    },
    {
        questId = 30308,
        npcId = 58465,
        questName = "Stone Hard Quilen",
    },
    {
        questId = 30309,
        npcId = 58465,
        questName = "Set in Stone",
    },
    {
        questId = 31758,
        npcId = 58471,
        questName = "Laosy Scouting",
    },
    {
        questId = 31754,
        npcId = 58471,
        questName = "Cannonfire",
    },
    {
        questId = 31756,
        npcId = 58471,
        questName = "High Chance of Rain",
    },
    {
        questId = 30312,
        npcId = 58468,
        questName = "Given a Second Chance",
    },
    {
        questId = 31755,
        npcId = 58468,
        questName = "Acts of Cruelty",
    }
}

-- ============================================================================
-- NPC DATABASE
-- ============================================================================
-- NPC names for better logging
local npcNames = {
    [58408] = "Leven Dawnblade",
    [58465] = "Anji Autumnlight",
    [58471] = "Kun Autumnlight",
    [58468] = "Sun Tenderheart",
}

-- ============================================================================
-- HELPER FUNCTIONS
-- ============================================================================

---Print a separator line in the console for better readability
local function PrintSeparator()
    if VISUAL_SEPARATORS then
        BANETO_Print("================================================")
    end
end

---Print a debug message if debug mode is enabled
---@param message string The debug message to print
local function DebugPrint(message)
    if DEBUG_MODE then
        BANETO_Print("[DEBUG] " .. message)
    end
end

---Format NPC name with ID for consistent logging
---@param npcId number The NPC ID
---@return string The formatted NPC string
local function FormatNpcName(npcId)
    local name = npcNames[npcId] or "Unknown NPC"
    return string.format("%s (%d)", name, npcId)
end

---Find quest info from WoW's available quest API
---@param available table Table returned by C_GossipInfo.GetAvailableQuests()
---@param questID number The specific quest ID we're looking for
---@return table|nil Quest info table if found, nil otherwise
local function GetAvailableQuestInfoByID(available, questID)
    for i = 1, #available do
        local info = available[i]

        if info and info.questID == questID then
            return info
        end
    end

    return nil
end

-- ============================================================================
-- COORDINATE DATA
-- ============================================================================
-- All Golden Lotus NPCs are located at the Temple of the White Tiger
-- Coordinates obtained from in-game data collection
local npcCoords = {
    -- Leven Dawnblade (58408)
    [58408] = {
        x = 1211.8581542969,
        y = 1044.7891845703,
        z = 425.96737670898,
    },
    -- Anji Autumnlight (58465)
    [58465] = {
        x = 1211.6048583984,
        y = 1048.1136474609,
        z = 425.96737670898,
    },
    -- Kun Autumnlight(58471)
    [58471] = {
        x = 1211.3977050781,
        y = 1049.5463867188,
        z = 425.96737670898,
    },
    -- Sun Tenderheart (58468)
    [58468] = {
        x = 1215.8614501953,
        y = 1050.3850097656,
        z = 425.96737670898,
    },
}

-- ============================================================================
-- PULSE CONFIGURATION & STATE MANAGEMENT
-- ============================================================================
-- Configure custom pulse behavior
BANETO_ExecuteCustomQuestPulse_Questmaster = true
BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = true

-- State management variables
local inProgress = false      -- Prevents multiple simultaneous quest accepts
local wait = nil              -- Timer for waiting between interactions
local checked = false         -- Tracks if we've checked an NPC for quests
local sessionStartTime = nil  -- Track session duration
local totalNpcsToCheck = 4    -- Total number of NPCs to visit
local npcsCheckedCount = 0    -- Counter for NPCs processed
local questsAcceptedCount = 0 -- Counter for quests accepted this session

-- ============================================================================
-- MAIN QUEST ACCEPTANCE LOGIC
-- ============================================================================
---Main quest acceptance function - executes continuously until all quests accepted
---Handles NPC interaction, quest detection, and acceptance flow
function _G.BANETO_ExecuteCustomQuestPulse()
    if inProgress then
        return
    end

    -- Handle wait timer - prevents spam interactions
    if wait and time() < wait then
        return -- Still waiting, do nothing
    end

    -- Initialize session tracking on first run
    if not sessionStartTime then
        sessionStartTime = time()
        PrintSeparator()
        BANETO_Print("GOLDEN LOTUS DAILY QUEST ACCEPTANCE INITIATED")
        BANETO_Print(string.format("Checking %d NPCs for available daily quests...", totalNpcsToCheck))
        PrintSeparator()
    end

    -- Initialize global tracking variables (persistent across function calls)
    if not _G.checkedNpcs then
        _G.checkedNpcs = {} -- Track which NPCs we've fully processed
        DebugPrint("Initialized checkedNpcs table")
    end

    if not _G.checkedQuests then
        _G.checkedQuests = {} -- Track which quests we've already handled
        DebugPrint("Initialized checkedQuests table")
    end

    if not _G.processedCount then
        _G.processedCount = 0 -- Count of processed quests for current NPC
        DebugPrint("Initialized processedCount table")
    end

    if not _G.totalQuests then
        _G.totalQuests = 0 -- Total quests for current NPC
        DebugPrint("Initialized totalQuests table")
    end

    -- Group quests by NPC for efficient processing
    -- This creates a table where each NPC ID maps to their quest list
    local questsByNpc = {}
    for i = 1, #questAccepts do
        local quest = questAccepts[i]
        local npcId = quest.npcId

        if not questsByNpc[npcId] then
            questsByNpc[npcId] = {}
        end
        table.insert(questsByNpc[npcId], quest)
    end

    -- Process each NPC and their quests
    for npcId, npcQuests in pairs(questsByNpc) do
        repeat
            BANETO_ClearTarget()

            -- Skip if we've already fully processed this NPC
            if _G.checkedNpcs[npcId] then
                DebugPrint(string.format("Skipping %s - already processed", FormatNpcName(npcId)))
                break
            end

            -- Update progress counter for new NPC
            if not _G.checkedNpcs[npcId] then
                npcsCheckedCount = npcsCheckedCount + 1
                PrintSeparator()
                BANETO_Print(string.format("[NPC %d/%d] Checking %s",
                    npcsCheckedCount, totalNpcsToCheck, FormatNpcName(npcId)))
                BANETO_Print(string.format("%d possible quests at this NPC", #npcQuests))
            end

            -- Ensure we're in position to interact with the NPC
            if not BANETO_PlayerPosition(npcCoords[npcId].x, npcCoords[npcId].y, npcCoords[npcId].z, 5) then
                -- Move to NPC location and wait for arrival
                BANETO_MeshTo(npcCoords[npcId].x, npcCoords[npcId].y, npcCoords[npcId].z)
                BANETO_Print(string.format("Moving to %s...", FormatNpcName(npcId)))
                wait = time() + MOVEMENT_TIMEOUT

                return
            end

            BANETO_StopMovement()

            -- Try to find the NPC object in the game world
            local questGiver = GetObjectWithId(npcId)
            local questGiverId = BANETO_GetTargetId()

            -- If NPC not found (out of range, not spawned, etc.), mark as complete
            if not questGiver then
                _G.checkedNpcs[npcId] = true
                checked = false
                BANETO_Print(string.format("[!] %s not found - skipping", FormatNpcName(npcId)))
                C_GossipInfo.CloseGossip()
                return
            end

            -- If the target is not the NPC, clear the target and return
            if questGiverId and questGiverId ~= npcId then
                BANETO_ClearTarget()
                C_GossipInfo.CloseGossip()
                DebugPrint(string.format("Different NPC targeted (ID: %d), clearing", questGiverId))
                return
            end

            -- Get list of available quests from this NPC
            local availableQuests = C_GossipInfo.GetAvailableQuests()

            -- If no quests are immediately available, try interacting with NPC
            if not availableQuests or #availableQuests == 0 then
                if not checked then
                    -- First attempt: target and interact with NPC to open quest dialog
                    UnlockedTargetUnit(questGiver)
                    BANETO_Interact(questGiver)
                    wait = time() + INTERACTION_DELAY
                    BANETO_Print(string.format("Interacting with %s...", FormatNpcName(npcId)))
                    checked = true

                    return
                else
                    -- Second attempt: still no quests found
                    -- For single-quest NPCs, we'll try direct acceptance as fallback
                    DebugPrint(string.format("No gossip quests from %s, trying direct accept", FormatNpcName(npcId)))
                    checked = false
                end
            else
                BANETO_Print(string.format("[OK] Found %d available quest(s) from %s",
                    #availableQuests, FormatNpcName(npcId)))
                checked = false
            end

            -- Process each potential quest for this NPC
            _G.processedCount = 0
            _G.totalQuests = #npcQuests

            for j = 1, #npcQuests do
                local quest = npcQuests[j]

                -- Skip quests we've already processed in previous iterations
                if _G.checkedQuests[quest.questId] then
                    -- Quest already processed - increment counter
                    _G.processedCount = _G.processedCount + 1
                else
                    -- Check if we already have this quest or completed it today
                    if BANETO_HasQuest(quest.questId) or BANETO_HasQuestCompleted(quest.questId) then
                        -- Quest already in our log or completed - mark as processed
                        _G.checkedQuests[quest.questId] = true
                        _G.processedCount = _G.processedCount + 1
                    else
                        -- Quest is not in our log - check if NPC is offering it
                        local offeredInfo = GetAvailableQuestInfoByID(availableQuests, quest.questId)

                        if offeredInfo then
                            -- Quest is available! Accept it now
                            questsAcceptedCount = questsAcceptedCount + 1
                            BANETO_Print(string.format("[ACCEPTED] %s (ID: %d)",
                                offeredInfo.title or quest.questName, quest.questId))

                            -- Mark quest as processed and configure Baneto to accept it
                            _G.checkedQuests[quest.questId] = true
                            local coords = npcCoords[npcId]
                            BANETO_DefineQuestId(quest.questId)
                            BANETO_SetToSkipTurnInQuest() -- We'll turn in later via TurnIn_All
                            BANETO_DefineQuestPickupNPC(coords.x, coords.y, coords.z, npcId)

                            -- Switch to normal Baneto behavior to accept quest
                            BANETO_ExecuteCustomQuestPulse_SkipNormalBehavior = false
                            BANETO_ExecuteCustomQuestPulse_Questmaster = false
                            BANETO_SetNextLocalQuestProfile([[Golden_Lotus_00_Start_Here_Accept_All]])
                            inProgress = true

                            -- Add delay after accepting quest to prevent spam
                            wait = time() + QUEST_ACCEPT_DELAY

                            return
                        elseif (not availableQuests or #availableQuests == 0) and
                            QuestDetailScrollFrame:IsVisible() then
                            -- No API results (single quest NPC case) - use AcceptQuest() directly
                            DebugPrint(string.format("Attempting direct accept for %s (ID: %d)",
                                quest.questName, quest.questId))

                            -- Try to accept the quest directly using WoW API
                            AcceptQuest()
                            questsAcceptedCount = questsAcceptedCount + 1
                            BANETO_Print(string.format("[ACCEPTED] %s (ID: %d) [Direct]",
                                quest.questName, quest.questId))

                            -- Mark quest as processed to avoid retrying
                            _G.checkedQuests[quest.questId] = true
                            _G.processedCount = _G.processedCount + 1

                            -- Add delay after accepting quest to prevent spam
                            wait = time() + QUEST_ACCEPT_DELAY
                        else
                            -- Quest not offered by this NPC today - mark as processed
                            _G.checkedQuests[quest.questId] = true
                            _G.processedCount = _G.processedCount + 1
                        end
                    end
                end
            end

            -- Mark NPC as complete if all their quests have been processed
            if _G.processedCount >= _G.totalQuests then
                _G.checkedNpcs[npcId] = true
                BANETO_Print(string.format("Completed %s (%d/%d quests processed)",
                    FormatNpcName(npcId), _G.processedCount, _G.totalQuests))
            end

            -- Reset state for next NPC
            BANETO_ClearTarget()
            C_GossipInfo.CloseGossip()
            checked = false
            wait = nil
        until true
    end

    -- All NPCs have been checked and all available quests accepted
    -- Clean up tracking variables
    _G.checkedNpcs = nil
    _G.checkedQuests = nil
    _G.processedCount = nil
    _G.totalQuests = nil

    BANETO_ClearTarget()
    C_GossipInfo.CloseGossip()

    -- Print session summary
    local sessionDuration = time() - sessionStartTime
    PrintSeparator()
    BANETO_Print("QUEST ACCEPTANCE COMPLETE")
    BANETO_Print(string.format("Summary: %d quest(s) accepted from %d NPC(s)",
        questsAcceptedCount, totalNpcsToCheck))
    BANETO_Print(string.format("Time elapsed: %d seconds", sessionDuration))
    PrintSeparator()

    -- Start quest execution chain
    BANETO_Print("Starting quest execution chain...")
    BANETO_LoadQuestProfile([[Golden_Lotus_01_Laosy_Scouting]])
end
