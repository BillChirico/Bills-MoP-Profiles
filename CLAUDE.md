# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a collection of automated quest profiles for World of Warcraft: Mists of Pandaria using the Baneto bot framework. The profiles automate daily quest completion for the Golden Lotus and Klaxxi factions.

## Commands

### Linting
Install luacheck first if not available:
```bash
brew install luacheck  # macOS
# or
sudo apt-get install luacheck  # Linux
```

Then run:
```bash
luacheck src/
```

## Architecture

### Profile System
Quest profiles are Lua scripts that define automated quest behavior using the Baneto API. Each profile handles a specific quest or quest management function.

### Quest Chain Structure

**Golden Lotus (3-part chain):**
1. `Golden_Lotus_00_Start_Here_Accept_All.lua` - Entry point, accepts all available dailies
2. Individual quest files execute in sequence (`01_Laosy_Scouting` → `02_Unleashed_Spirits` → etc.)
3. `Golden_Lotus_08_TurnIn_All.lua` - Turns in Part 1 quests
4. Transitions to Mistfall Village for Part 2
5. `Golden_Lotus_Mistfall_Village_07_Quid_Pro_Quo.lua` - Final quest

**Klaxxi:**
1. `Klaxxi_00_Start_Here_Klaxxi_Accept_All.lua` - Entry point, accepts all available dailies from 4 NPCs
2. Individual quest files execute with skip logic if quest not available
3. `Klaxxi_TurnIn_All.lua` - Turns in all completed quests

### Key Baneto API Functions

- `BANETO_DefineProfileName/Type()` - Profile metadata
- `BANETO_DefineQuestId()` - Target quest ID
- `BANETO_DefineQuestStepType()` - Quest type (KillAndLoot, GatherObject, UseItemOnNpc, TalkTo)
- `BANETO_DefineCenter()` - Quest area center and radius
- `BANETO_DefineQuestPickupNPC/TurninNPC()` - NPC coordinates and IDs
- `BANETO_SetNextLocalQuestProfile()` - Chain to next profile
- `BANETO_ExecuteCustomQuestPulse()` - Custom quest logic function
- `BANETO_LoadQuestProfile()` - Load and execute a profile
- `BANETO_HasQuest/HasQuestCompleted()` - Quest status checks

### Quest Accept Handlers

Both `Golden_Lotus_00_Start_Here_Accept_All.lua` and `Klaxxi_00_Start_Here_Klaxxi_Accept_All.lua` implement sophisticated quest acceptance logic:

1. Groups quests by NPC for efficient processing
2. Moves to each NPC location
3. Interacts to open quest dialog
4. Uses `C_GossipInfo.GetAvailableQuests()` to detect offered quests
5. Accepts only quests not already in log or completed
6. Handles rotating daily quest pools (not all quests available each day)
7. Chains to first quest execution profile when done

### Custom Quest Pulse Functions

Many profiles implement `BANETO_ExecuteCustomQuestPulse()` for advanced behavior:
- Progress monitoring via WoW API
- Smart blacklisting of interacted objects
- Quest skipping if not available
- Automatic quest chain transitions

## Important Notes

- Profiles tested only on Horde characters
- Quest IDs and NPC IDs are specific to MoP content
- Coordinates use WoW's world coordinate system
- Daily quests rotate - profiles handle this automatically with skip logic