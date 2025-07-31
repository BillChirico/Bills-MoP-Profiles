# 🏮 Baneto MoP Profiles

> **Premium Daily Quest Profiles for World of Warcraft: Mists of Pandaria**  
> Automated quest execution using the Baneto framework

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![WoW Version](https://img.shields.io/badge/WoW-Mists%20of%20Pandaria-orange.svg)](https://worldofwarcraft.com/)
[![Baneto Compatible](https://img.shields.io/badge/Baneto-Compatible-green.svg)](https://baneto-bot.com/)

---

## ✨ Features

- 🎯 **Precision Automation** - Fully automated daily quest completion
- 🗺️ **Smart Pathfinding** - Optimized routes and coordinates
- 🔄 **Chain Support** - Seamless quest-to-quest transitions
- 🛡️ **Error Handling** - Robust blacklisting and target management
- 📋 **Multiple Quest Types** - Support for KillAndLoot, UseItemOnNpc, and more
- 🔧 **Highly Configurable** - Easy to modify and extend

## 📦 Available Quest Profiles

### 🏮 Golden Lotus Faction

| Quest Name                | Type         | Description                              |
| ------------------------- | ------------ | ---------------------------------------- |
| **The Eternal Vigil**     | KillAndLoot  | Eliminate threats to maintain the vigil  |
| **Unleashed Spirits**     | KillAndLoot  | Contain escaped spirits                  |
| **Crumbling Behemoth**    | KillAndLoot  | Defeat the ancient stone guardian        |
| **Laosy Scouting**        | GatherObject | Gather intelligence from enemy cages     |
| **Given a Second Chance** | UseItemOnNpc | Heal wounded defenders with sacred items |

### 🦂 Klaxxi Faction

| Quest Name                 | Type        | Description                                |
| -------------------------- | ----------- | ------------------------------------------ |
| **The Fight Against Fear** | KillAndLoot | Eliminate Horrorscale Scorpids             |
| **The Scale-Lord**         | KillAndLoot | Defeat Mistblade Scale-Lords               |
| **A Little Brain Work**    | KillAndLoot | Collect brains from Ik'thik Amberstingers  |
| **Kunchong Treats**        | KillAndLoot | Hunt Chillwater Turtles for kunchong       |
| **Bad Genes**              | KillAndLoot | Eliminate Genemancers and Egg-Drones       |
| **Mistblade Destruction**  | KillAndLoot | Destroy Mistblade Rippers at Lake of Stars |

## 🚀 Quick Start

### Prerequisites

- ✅ World of Warcraft: Mists of Pandaria
- ✅ [Baneto Bot](https://baneto-bot.com) installed and configured
- ✅ Character with access to quests you want to do

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/Baneto-MoP-Dailies.git
   cd Baneto-MoP-Dailies
   ```

2. **Copy quest profiles to Baneto directory**

   ```bash
   cp -r src/* /path/to/baneto/profiles/
   ```

3. **Load profiles in Baneto**
   - Start Baneto
   - Navigate to the quest profile directory
   - **For Golden Lotus:** Load `!Golden_Lotus_Accept_All.lua` to automatically accept all available quests and start the full quest chain
   - **For Klaxxi:** Load `Klaxxi_01_The_Fight_Against_Fear.lua` to start the quest chain (quests must be accepted manually first)

## 📁 Project Structure

```
Baneto-MoP-Dailies/
├── 📄 README.md
├── 📄 LICENSE
├── ⚙️ .luacheckrc              # Lua linting configuration
└── 📂 src/
    ├── 📂 Golden Lotus Dailies/
    │   ├── ✅ !Golden_Lotus_Accept_All.lua
    │   ├── 🎯 Golden_Lotus_01_The_Eternal_Vigil.lua
    │   ├── 👻 Golden_Lotus_02_Unleashed_Spirits.lua
    │   ├── 🗿 Golden_Lotus_03_Crumbling_Behemoth.lua
    │   ├── 🔍 Golden_Lotus_04_Laosy_Scouting.lua
    │   ├── 💚 Golden_Lotus_05_Given_a_Second_Chance.lua
    │   ├── 📊 Golden_Lotus_Data.lua
    │   └── 🔄 Golden_Lotus_TurnIn_All.lua
    └── 📂 Klaxxi Dailies/
        ├── ⚔️ Klaxxi_01_The_Fight_Against_Fear.lua
        ├── 🐉 Klaxxi_02_The_Scale_Lord.lua
        ├── 🧠 Klaxxi_03_A_Little_Brain_Work.lua
        ├── 🐢 Klaxxi_04_Kunchong_Treats.lua
        ├── 🧬 Klaxxi_05_Bad_Genes.lua
        ├── ⚔️ Klaxxi_06_Mistblade_Destruction.lua
        └── 🔄 Klaxxi_TurnIn_All.lua
```

## ⚙️ Configuration

### Quest Chain Execution

Quest profiles are designed to chain together automatically:

**Golden Lotus Chain:**

```
Accept All → Execute Quests (The Eternal Vigil → Unleashed Spirits → Crumbling Behemoth → Laosy Scouting → Given a Second Chance) → TurnIn All
```

- **Accept Phase:** `!Golden_Lotus_Accept_All.lua` accepts all available daily quests
- **Execute Phase:** Automatically transitions to `Golden_Lotus_01_The_Eternal_Vigil.lua` and chains through all quest objectives
- **TurnIn Phase:** Final quest chains to `Golden_Lotus_TurnIn_All.lua` to submit completed quests

**Klaxxi Chain:**

```
Manual Quest Acceptance → Execute Quests (The Fight Against Fear → The Scale-Lord → A Little Brain Work → Kunchong Treats → Bad Genes → Mistblade Destruction) → TurnIn All
```

- **Manual Phase:** Player manually accepts available Klaxxi daily quests
- **Execute Phase:** Start with `Klaxxi_01_The_Fight_Against_Fear.lua` and chain through all objectives
- **TurnIn Phase:** Final quest chains to `Klaxxi_TurnIn_All.lua` to submit completed quests

### Key Differences Between Factions

**🏮 Golden Lotus - Fully Automated:**

- ✅ Automatic quest acceptance via `!Golden_Lotus_Accept_All.lua`
- ✅ All quests picked up from the same location (Temple of the White Tiger)
- ✅ Seamless transition from quest acceptance to execution to turn-in

**🦂 Klaxxi - Semi-Automated:**

- ⚠️ Manual quest acceptance required (quests come from different NPCs)
- ✅ Automated quest execution once started
- ✅ Automated turn-in via `Klaxxi_TurnIn_All.lua`

### Custom Pulse Functions

Some quests include custom logic for advanced automation:

- **Smart Targeting** - Intelligent mob selection and blacklisting
- **Item Usage** - Automated quest item interaction
- **Error Recovery** - Handles edge cases and stuck scenarios
- **Turn-In Logic** - Automatically detects completed quests in log and turns them in to appropriate NPCs

## 🛠️ Development

### Shared Data Files

To reduce code duplication, quest information is stored in shared data files:

- **`Golden_Lotus_Data.lua`** - Contains quest IDs, NPC IDs, coordinates, and names for all Golden Lotus dailies
- Both `!Golden_Lotus_Accept_All.lua` and `Golden_Lotus_TurnIn_All.lua` load this shared data using `dofile()`
- When adding new Golden Lotus quests, update the shared data file instead of duplicating information

### Adding New Quest Profiles

1. **Create new `.lua` file** following the naming convention:

   ```lua
   -- Quest Information
   BANETO_DefineProfileName("Your_Quest_Name")
   BANETO_DefineProfileType("Questing")
   BANETO_DefineQuestStepType([[KillAndLoot]])
   BANETO_DefineQuestId(12345)

   -- NPC Information
   BANETO_DefineQuestPickupNPC(x, y, z, npcId)
   BANETO_DefineQuestTurninNPC(x, y, z, npcId)

   -- Quest Objectives
   BANETO_DefineQuestTargetId(targetId)

   -- Quest Locations
   BANETO_DefineCenter(x, y, z, radius)
   ```

2. **Update quest chains** by modifying the `BANETO_SetNextLocalQuestProfile` calls

3. **Test thoroughly** before deploying to production

### Code Quality

- 🔍 **Lua Linting** - Configured with `.luacheckrc`
- 📝 **Documentation** - All functions and sections properly commented
- 🧪 **Testing** - Validate coordinates and quest IDs

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/new-quest`)
3. 💾 Commit your changes (`git commit -am 'Add new quest profile'`)
4. 📤 Push to the branch (`git push origin feature/new-quest`)
5. 🔄 Create a Pull Request

## 📋 Roadmap

- [x] 🏮 **Golden Lotus** faction dailies (5 quests)
- [x] 🦂 **Klaxxi** faction dailies (6 quests)
- [ ] 🏛️ **August Celestials** faction dailies
- [ ] 🐉 **Order of the Cloud Serpent** faction dailies
- [ ] 🌅 **Shado-Pan** faction dailies
- [ ] 🎣 **The Anglers** faction dailies
- [ ] 👥 **Operation: Shieldwall** / **Dominance Offensive** dailies
- [ ] 🏝️ **Isle of Thunder** quest chains
- [ ] ⏰ **Timeless Isle** automated farming

## ⚠️ Disclaimer

This project is for educational purposes. Use at your own risk and in accordance with Blizzard Entertainment's Terms of Service. The authors are not responsible for any account actions taken by Blizzard.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Made with ❤️ from Bill**

[Report Bug](https://github.com/BillChirico/Bills-MoP-Profiles/issues) • [Request Feature](https://github.com/BillChirico/Bills-MoP-Profiles/issues) • [Contribute](https://github.com/BillChirico/Bills-MoP-Profiles/pulls)

</div>
