--[[
================================================================================
                      KLAXXI DAILY QUEST ACCEPT HANDLER
================================================================================
⭐ START HERE: This is the entry point for all Klaxxi daily quests!

PROFILE PURPOSE:
    Automatically accepts all available Klaxxi daily quests from Paragons at
    Klaxxi'vess in the Dread Wastes. Handles the rotating quest system where
    only a subset of quests are available each day.

QUEST ROTATION SYSTEM:
    Klaxxi offers 12 possible daily quests, but only ~4-6 are available each
    day. The rotation is random and determined by Blizzard's daily reset.
    This handler automatically adapts to whatever quests are offered.

SUPPORTED QUESTS (12 total):
    From Korven the Prime (62180):
    • 31270 - The Fight Against Fear
    • 31269 - The Scale-Lord
    • 31232 - An Ancient Empire
    • 31233 - Sap Tapping

    From Rik'kal the Dissector (63072):
    • 31271 - Bad Genes
    • 31234 - Putting An Eye Out

    From Kaz'tik the Manipulator (63758):
    • 31268 - A Little Brain Work
    • 31024 - Kunchong Treats
    • 31238 - Brain Food

    From Kil'ruk the Wind-Reaver (62538):
    • 31231 - Dreadspinner Extermination
    • 31267 - Mistblade Destruction
    • 31235 - Nope Nope Nope

EXECUTION FLOW:
    1. Visit each Paragon in sequence
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
BANETO_DefineProfileName("Klaxxi_00_Start_Here_Klaxxi_Accept_All")
BANETO_DefineProfileType("Questing")
BANETO_DefineQuestStepType([[TalkTo]])

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
-- Complete list of all Klaxxi daily quests with metadata
-- Note: Quest availability rotates daily - typically 4-6 quests available
local questAccepts = {
    {
        questId = 31270,
        npcId = 62180,
        questName = "The Fight Against Fear",
    },
    {
        questId = 31269,
        npcId = 62180,
        questName = "The Scale-Lord",
    },

    {
        questId = 31232,
        npcId = 62180,
        questName = "An Ancient Empire",
    },
    {
        questId = 31233,
        npcId = 62180,
        questName = "Sap Tapping",
    },
    {
        questId = 31271,
        npcId = 63072,
        questName = "Bad Genes",
    },
    {
        questId = 31234,
        npcId = 63072,
        questName = "Putting An Eye Out",
    },
    {
        questId = 31268,
        npcId = 63758,
        questName = "A Little Brain Work",
    },
    {
        questId = 31024,
        npcId = 63758,
        questName = "Kunchong Treats",
    },
    {
        questId = 31238,
        npcId = 63758,
        questName = "Brain Food",
    },
    {
        questId = 31231,
        npcId = 62538,
        questName = "Dreadspinner Extermination",
    },
    {
        questId = 31267,
        npcId = 62538,
        questName = "Mistblade Destruction",
    },
    {
        questId = 31235,
        npcId = 62538,
        questName = "Nope Nope Nope",
    }
}

-- ============================================================================
-- NPC DATABASE
-- ============================================================================
-- NPC names for better logging
local npcNames = {
    [62180] = "Korven the Prime",
    [63758] = "Kaz'tik the Manipulator",
    [63072] = "Rik'kal the Dissector",
    [62538] = "Kil'ruk the Wind-Reaver",
}

-- ============================================================================
-- COORDINATE DATA
-- ============================================================================
-- All 4 Klaxxi Paragons are located at Klaxxi'vess in Dread Wastes
-- Coordinates obtained from in-game data collection
local npcCoords = {
    -- Korven the Prime
    [62180] = {
        x = 127.87126922607,
        y = 3233.3774414062,
        z = 215.64855957031,
    },
    -- Kaz'tik the Manipulator
    [63758] = {
        x = 139.79104614258,
        y = 3234.7741699219,
        z = 212.32595825195,
    },
    -- Rik'kal the Dissector
    [63072] = {
        x = 134.97793579102,
        y = 3228.5539550781,
        z = 215.59104919434,
    },
    -- Kil'ruk the Wind-Reaver
    [62538] = {
        x = 136.87948608398,
        y = 3193.1166992188,
        z = 214.7607421875,
    },
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
    local name = npcNames[npcId] or "Unknown Paragon"
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
local totalNpcsToCheck = 4    -- Total number of Paragons to visit
local npcsCheckedCount = 0    -- Counter for NPCs processed
local questsAcceptedCount = 0 -- Counter for quests accepted this session

-- ============================================================================
-- MAIN QUEST ACCEPTANCE LOGIC
-- ============================================================================
---Main quest acceptance function - executes continuously until all quests accepted
---Handles Paragon interaction, quest detection, and acceptance flow
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
        BANETO_Print("KLAXXI DAILY QUEST ACCEPTANCE INITIATED")
        BANETO_Print(string.format("Checking %d Paragons for available daily quests...", totalNpcsToCheck))
        PrintSeparator()
    end

    -- Initialize global tracking variables (persistent across function calls)
    if not _G.checkedNpcs then
        _G.checkedNpcs = {} -- Track which NPCs we've fully processed
        DebugPrint("Initialized checkedNpcs table")
    end

    if not _G.startedNpcs then
        _G.startedNpcs = {} -- Track which NPCs we've started processing (for counter)
        DebugPrint("Initialized startedNpcs table")
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
            -- Skip if we've already fully processed this NPC
            if _G.checkedNpcs[npcId] then
                DebugPrint(string.format("Skipping %s - already processed", FormatNpcName(npcId)))
                break
            end

            -- Update progress counter only for first time processing this NPC
            if not _G.startedNpcs[npcId] then
                _G.startedNpcs[npcId] = true
                npcsCheckedCount = npcsCheckedCount + 1
                PrintSeparator()
                BANETO_Print(string.format("[PARAGON %d/%d] Checking %s",
                    npcsCheckedCount, totalNpcsToCheck, FormatNpcName(npcId)))
                BANETO_Print(string.format("%d possible quests at this Paragon", #npcQuests))
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
                BANETO_Print(string.format("  [!] %s not found - skipping", FormatNpcName(npcId)))
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
                            BANETO_SetNextLocalQuestProfile([[Klaxxi_00_Start_Here_Klaxxi_Accept_All]])
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
    _G.startedNpcs = nil
    _G.checkedQuests = nil
    _G.processedCount = nil
    _G.totalQuests = nil

    BANETO_ClearTarget()
    C_GossipInfo.CloseGossip()

    -- Print session summary
    local sessionDuration = time() - sessionStartTime
    PrintSeparator()
    BANETO_Print("QUEST ACCEPTANCE COMPLETE")
    BANETO_Print(string.format("Summary: %d quest(s) accepted from %d Paragon(s)",
        questsAcceptedCount, totalNpcsToCheck))
    BANETO_Print(string.format("Time elapsed: %d seconds", sessionDuration))
    PrintSeparator()

    -- Start quest execution chain
    BANETO_Print("Starting quest execution chain...")
    BANETO_LoadQuestProfile([[Klaxxi_01_The_Fight_Against_Fear]])
end
