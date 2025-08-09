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

**Part 1 - Temple of the White Tiger:**
| Quest Name | Type | Description |
| ------------------------- | ------------ | ---------------------------------------- |
| **Laosy Scouting** | GatherObject | Gather intelligence from enemy cages |
| **Unleashed Spirits** | KillAndLoot | Contain escaped spirits |
| **The Eternal Vigil** | KillAndLoot | Eliminate threats to maintain the vigil |
| **Crumbling Behemoth** | KillAndLoot | Defeat the ancient stone guardian |
| **Given a Second Chance** | UseItemOnNpc | Heal wounded defenders with sacred items |

**Part 2 - Mistfall Village:**
| Quest Name | Type | Description |
| ------------------------- | ------------ | ---------------------------------------- |
| **Pomfruit Pickup** | GatherObject | Collect pomfruits for the village |
| **Encroaching Storm** | KillAndLoot | Defeat Thundermaw enemies |
| **My Town, It's on Fire** | GatherObject | Extinguish fires with water buckets |
| **Sprite Plight** | KillAndLoot | Eliminate Slateskin Troublemakers |

**Part 3 - Final Quest:**
| Quest Name | Type | Description |
| ------------------------- | ------------ | ---------------------------------------- |
| **Quid Pro Quo** | KillAndLoot | Defeat Quid in the final challenge |

### 🦂 Klaxxi Faction

**Daily Quest Pool (Rotates Daily):**
| Quest Name | NPC | Type | Description |
| ------------------------------- | ----------------------- | ------------ | ---------------------------------------------- |
| **The Fight Against Fear** | Korven the Prime | KillAndLoot | Eliminate Horrorscale Scorpids |
| **The Scale-Lord** | Korven the Prime | KillAndLoot | Defeat Mistblade Scale-Lords |
| **A Little Brain Work** | Kaz'tik the Manipulator | KillAndLoot | Collect brains from Ik'thik Amberstingers |
| **Kunchong Treats** | Kaz'tik the Manipulator | KillAndLoot | Hunt Chillwater Turtles for kunchong |
| **Bad Genes** | Rik'kal the Dissector | KillAndLoot | Eliminate Genemancers and Egg-Drones |
| **Mistblade Destruction** | Kil'ruk the Wind-Reaver | KillAndLoot | Destroy Mistblade Rippers |
| **An Ancient Empire** | Korven the Prime | GatherObject | Collect 8 Gurthani Tablets from Terrace |
| **Dreadspinner Extermination** | Kil'ruk the Wind-Reaver | KillAndLoot | Slay 8 Dreadspinner Tenders |
| **Nope Nope Nope** | Kil'ruk the Wind-Reaver | KillAndLoot | Destroy 20 Dreadspinner Eggs with Dragon Gun |
| **Putting An Eye Out** | Rik'kal the Dissector | KillAndLoot | Collect Pristine Mire Beast Eye |
| **Brain Food** | Kaz'tik the Manipulator | KillAndLoot | Hunt Greatback Mushan for 4 Mushan Tongues |
| **Sap Tapping** | Korven the Prime | GatherObject | Collect 6 Amber Sap from extractors on trees |

**Note:** Klaxxi dailies are a rotating pool of quests that change each day. The system automatically detects which quests are available and completes them. Not all quests will be available every day.

**Total: 12 Different Daily Quests in Rotation**

## 🚀 Quick Start

### Prerequisites

- ✅ World of Warcraft: Mists of Pandaria
- ✅ [Baneto Bot](https://baneto-bot.com) installed and configured
- ✅ Character with access to quests you want to do

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/BillChirico/Bills-MoP-Profiles.git
   cd Bills-MoP-Profiles
   ```

2. **Copy quest profiles to Baneto directory**

   ```bash
   cp -r src/* /path/to/baneto/profiles/
   ```

3. **Load profiles in Baneto**
   - Start Baneto
   - Navigate to the quest profile directory
   - **For Golden Lotus:** Load `Part01_!Start_Here_Golden_Lotus_Accept_All.lua` to automatically accept all available quests and start the full quest chain
   - **For Klaxxi:** Load `!Start_Here_Klaxxi_Accept_All.lua` to automatically accept all available quests and start the full quest chain

## 📁 Project Structure

```
Baneto-MoP-Dailies/
├── 📄 README.md
├── 📄 LICENSE
├── ⚙️ .luacheckrc              # Lua linting configuration
└── 📂 src/
    ├── 📂 Golden Lotus Dailies/
    │   ├── ✅ Part01_!Start_Here_Golden_Lotus_Accept_All.lua
    │   ├── 🔍 Part01_Golden_Lotus_01_Laosy_Scouting.lua
    │   ├── 👻 Part01_Golden_Lotus_02_Unleashed_Spirits.lua
    │   ├── 🎯 Part01_Golden_Lotus_03_The_Eternal_Vigil.lua
    │   ├── 🗿 Part01_Golden_Lotus_04_Crumbling_Behemoth.lua
    │   ├── 💚 Part01_Golden_Lotus_05_Given_a_Second_Chance.lua
    │   ├── 🔄 Part01_Golden_Lotus_TurnIn_All.lua
    │   ├── 🚶 Part02_!!Golden_Lotus_Transition_Mistfall_Village.lua
    │   ├── ✅ Part02_!Golden_Lotus_Accept_All_Mistfall_Village.lua
    │   ├── 🍎 Part02_Golden_Lotus_01_Pomfruit_Pickup_Mistfall_Village.lua
    │   ├── ⚡ Part02_Golden_Lotus_02_Encroaching_Storm_Mistfall_Village.lua
    │   ├── 🔥 Part02_Golden_Lotus_03_My_Town_Its_on_Fire_Mistfall_Village.lua
    │   ├── 🧚 Part02_Golden_Lotus_04_Sprite_Plight_Mistfall_Village.lua
    │   ├── 🔄 Part02_Golden_Lotus_TurnIn_All_Mistfall_Village.lua
    │   └── 🏆 Part03_Golden_Lotus_01_Quid_Pro_Quo_Mistfall_Village.lua
    └── 📂 Klaxxi Dailies/
        ├── ✅ !Start_Here_Klaxxi_Accept_All.lua
        ├── ⚔️ Klaxxi_01_The_Fight_Against_Fear.lua
        ├── 🐉 Klaxxi_02_The_Scale_Lord.lua
        ├── 🧠 Klaxxi_03_A_Little_Brain_Work.lua
        ├── 🐢 Klaxxi_04_Kunchong_Treats.lua
        ├── 🧬 Klaxxi_05_Bad_Genes.lua
        ├── ⚔️ Klaxxi_06_Mistblade_Destruction.lua
        ├── 🏺 Klaxxi_07_An_Ancient_Empire.lua
        ├── 🕷️ Klaxxi_08_Dreadspinner_Extermination.lua
        ├── 🚫 Klaxxi_09_Nope_Nope_Nope.lua
        ├── 👁️ Klaxxi_10_Putting_An_Eye_Out.lua
        ├── 🍖 Klaxxi_11_Brain_Food.lua
        ├── 🌳 Klaxxi_12_Sap_Tapping.lua
        └── 🔄 Klaxxi_TurnIn_All.lua
```

## ⚙️ Configuration

### Quest Chain Execution

Quest profiles are designed to chain together automatically:

**Golden Lotus Chain (3-Part Structure):**

```
Part 1: Accept All → Execute Quests (Laosy Scouting → Unleashed Spirits → The Eternal Vigil → Crumbling Behemoth → Given a Second Chance) → TurnIn All
↓
Part 2: Transition → Accept All → Execute Quests (Pomfruit Pickup → Encroaching Storm → My Town, It's on Fire → Sprite Plight) → TurnIn All
↓
Part 3: Quid Pro Quo → Complete (Final Quest)
```

- **Part 1:** `Part01_!Start_Here_Golden_Lotus_Accept_All.lua` accepts all available daily quests at Temple of the White Tiger
- **Part 2:** `Part02_!Golden_Lotus_Accept_All_Mistfall_Village.lua` accepts all available daily quests at Mistfall Village
- **Part 3:** `Part03_Golden_Lotus_01_Quid_Pro_Quo_Mistfall_Village.lua` completes the final quest
- **Automatic Transitions:** Each part seamlessly chains to the next with consolidated turn-in handlers

**Klaxxi Chain:**

```
Accept All → Execute Individual Quests (Daily Rotation) → TurnIn All
```

- **Accept Phase:** `!Start_Here_Klaxxi_Accept_All.lua` accepts all available daily quests from 4 different NPCs (varies daily)
- **Execute Phase:** Individual quest files handle specific objectives with quest skipping logic:
  - **Daily Rotation:** Each day presents a different subset of the 12 available quests
  - **Smart Detection:** System automatically detects which quests are offered and skips unavailable ones
- **TurnIn Phase:** `Klaxxi_TurnIn_All.lua` intelligently submits all completed quests to appropriate NPCs

**Quest Skipping Logic:** Each individual quest file includes smart logic to skip to the next quest if not available, ensuring seamless automation even when dailies reset or specific quests aren't offered.

### Custom Pulse Functions

Some quests include custom logic for advanced automation:

- **Smart Blacklisting** - Blacklists quest objects after interaction to prevent re-targeting
- **Progress Monitoring** - Tracks quest objective completion using WoW API
- **Turn-In Logic** - Automatically detects completed quests and turns them in to appropriate NPCs
- **Quest Chaining** - Seamlessly transitions between quest profiles
- **Multi-Part Structure** - Organized quest chains with consolidated accept and turn-in handlers

## 🛠️ Development

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

- [x] 🏮 **Golden Lotus** faction dailies (9 quests across 3 parts)
- [x] 🦂 **Klaxxi** faction dailies (12 rotating daily quests with comprehensive accept/turn-in system)
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
