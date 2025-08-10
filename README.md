# 🏮 Bill's MoP Profiles

> **Fully Automated Questing Profiles by Bill**  
> Golden Lotus and Klaxxi daily quest automation for World of Warcraft: Mists of Pandaria

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![WoW Version](https://img.shields.io/badge/WoW-Mists%20of%20Pandaria-orange.svg)](https://worldofwarcraft.com/)
[![Baneto Compatible](https://img.shields.io/badge/Baneto-Compatible-green.svg)](https://baneto-bot.com/)
[![Lua Lint](https://github.com/BillChirico/Bills-MoP-Profiles/actions/workflows/lua-lint.yml/badge.svg)](https://github.com/BillChirico/Bills-MoP-Profiles/actions/workflows/lua-lint.yml)

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

**Two-Part Daily System:**
- **Part 1:** Main hub at Temple of the White Tiger (always same location, rotating quests)
- **Part 2:** Secondary hub assigned by Leven Dawnblade (changes daily - currently only Mistfall Village implemented)

**Part 1 - Temple of the White Tiger (Main Hub):**
| Quest Name | Type | Description |
| ------------------------- | ------------ | ---------------------------------------- |
| [**Laosy Scouting**](https://www.wowhead.com/quest=31758/laosy-scouting) | GatherObject | Gather intelligence from enemy cages |
| [**Unleashed Spirits**](https://www.wowhead.com/quest=31757/unleashed-spirits) | KillAndLoot | Contain escaped spirits |
| [**The Eternal Vigil**](https://www.wowhead.com/quest=30307/the-eternal-vigil) | KillAndLoot | Eliminate threats to maintain the vigil |
| [**Crumbling Behemoth**](https://www.wowhead.com/quest=31762/crumbling-behemoth) | KillAndLoot | Defeat the ancient stone guardian |
| [**Given a Second Chance**](https://www.wowhead.com/quest=30312/given-a-second-chance) | UseItemOnNpc | Heal wounded defenders with sacred items |
| [**Striking First**](https://www.wowhead.com/quest=31760/striking-first) | KillAndLoot | Launch preemptive strikes against enemies |
| [**Acts of Cruelty**](https://www.wowhead.com/quest=31755/acts-of-cruelty) | KillAndLoot | Eliminate cruel oppressors |
| [**High Chance of Rain**](https://www.wowhead.com/quest=31756/high-chance-of-rain) | GatherObject | Collect weather monitoring devices |

**Part 2 - Mistfall Village (Secondary Hub):**
| Quest Name | Type | Description |
| ------------------------- | ------------ | ---------------------------------------- |
| [**Pomfruit Pickup**](https://www.wowhead.com/quest=30231/pomfruit-pickup) | GatherObject | Collect pomfruits for the village |
| [**Encroaching Storm**](https://www.wowhead.com/quest=30194/encroaching-storm) | KillAndLoot | Defeat Thundermaw enemies |
| [**Ruffling Some Feathers**](https://www.wowhead.com/quest=30232/ruffling-some-feathers) | KillAndLoot | Hunt down feathered troublemakers |
| [**My Town, It's on Fire**](https://www.wowhead.com/quest=30192/my-town-its-on-fire) | GatherObject | Extinguish fires with water buckets |
| [**Steer Clear of the Beer Here**](https://www.wowhead.com/quest=30191/steer-clear-of-the-beer-here) | GatherObject | Recover stolen ale kegs |
| [**Sprite Plight**](https://www.wowhead.com/quest=30190/sprite-plight) | KillAndLoot | Eliminate Slateskin Troublemakers |

**Final Quest (After Part 2):**
| Quest Name | Type | Description |
| ------------------------- | ------------ | ---------------------------------------- |
| [**Quid Pro Quo**](https://www.wowhead.com/quest=30235/quid-pro-quo) | KillAndLoot | Defeat Quid in the final challenge |

📌 **Note:** Additional secondary hubs (Ruins of Guo-Lai, Setting Sun Garrison, Whitepetal Lake) will be added as they are discovered in the daily rotation.

### 🦂 Klaxxi Faction

**Daily Quest Pool (Rotates Daily):**
| Quest Name | NPC | Type | Description |
| ------------------------------- | ----------------------- | ------------ | ---------------------------------------------- |
| [**The Fight Against Fear**](https://www.wowhead.com/quest=31270/the-fight-against-fear) | Korven the Prime | KillAndLoot | Eliminate Horrorscale Scorpids |
| [**The Scale-Lord**](https://www.wowhead.com/quest=31269/the-scale-lord) | Korven the Prime | KillAndLoot | Defeat Mistblade Scale-Lords |
| [**A Little Brain Work**](https://www.wowhead.com/quest=31268/a-little-brain-work) | Kaz'tik the Manipulator | KillAndLoot | Collect brains from Ik'thik Amberstingers |
| [**Kunchong Treats**](https://www.wowhead.com/quest=31024/kunchong-treats) | Kaz'tik the Manipulator | KillAndLoot | Hunt Chillwater Turtles for kunchong |
| [**Bad Genes**](https://www.wowhead.com/quest=31271/bad-genes) | Rik'kal the Dissector | KillAndLoot | Eliminate Genemancers and Egg-Drones |
| [**Mistblade Destruction**](https://www.wowhead.com/quest=31267/mistblade-destruction) | Kil'ruk the Wind-Reaver | KillAndLoot | Destroy Mistblade Rippers |
| [**An Ancient Empire**](https://www.wowhead.com/quest=31232/an-ancient-empire) | Korven the Prime | GatherObject | Collect 8 Gurthani Tablets from Terrace |
| [**Dreadspinner Extermination**](https://www.wowhead.com/quest=31231/dreadspinner-extermination) | Kil'ruk the Wind-Reaver | KillAndLoot | Slay 8 Dreadspinner Tenders |
| [**Nope Nope Nope**](https://www.wowhead.com/quest=31235/nope-nope-nope) | Kil'ruk the Wind-Reaver | KillAndLoot | Destroy 20 Dreadspinner Eggs with Dragon Gun |
| [**Putting An Eye Out**](https://www.wowhead.com/quest=31234/putting-an-eye-out) | Rik'kal the Dissector | KillAndLoot | Collect Pristine Mire Beast Eye |
| [**Brain Food**](https://www.wowhead.com/quest=31238/brain-food) | Kaz'tik the Manipulator | KillAndLoot | Hunt Greatback Mushan for 4 Mushan Tongues |
| [**Sap Tapping**](https://www.wowhead.com/quest=31233/sap-tapping) | Korven the Prime | GatherObject | Collect 6 Amber Sap from extractors on trees |

**Note:** Both Golden Lotus and Klaxxi dailies are rotating pools of quests that change each day. The system automatically detects which quests are available and completes them. Not all quests will be available every day.

⚠️ **Faction Note:** These profiles have only been tested on **Horde** characters. Alliance compatibility is not guaranteed.

**Total: 12 Different Daily Quests in Rotation**

## 🚀 Quick Start

### 📋 Prerequisites

- ✅ **World of Warcraft: Mists of Pandaria** (any private server)
- ✅ **[Baneto Bot](https://baneto-bot.com)** installed and configured  
- ✅ **Horde character** level 90 with access to:
  - 🏛️ Vale of Eternal Blossoms (Golden Lotus hub)
  - 🦂 Dread Wastes (Klaxxi hub)
- ✅ **Faction reputation:** Friendly+ to unlock daily quests
- ⚠️ **Tested on Horde only** - Alliance compatibility not guaranteed

### 📦 Installation

1. **📥 Clone the repository**
   ```bash
   git clone https://github.com/BillChirico/Bills-MoP-Profiles.git
   cd Bills-MoP-Profiles
   ```

2. **📋 Copy profiles to Baneto**
   ```bash
   cp -r src/* /path/to/baneto/profiles/
   ```

3. **🎮 Launch in Baneto**
   - 🟢 Start Baneto and navigate to quest profiles
   - 🏮 **Golden Lotus:** Load `Golden_Lotus_00_Start_Here_Accept_All.lua`
   - 🦂 **Klaxxi:** Load `Klaxxi_00_Start_Here_Klaxxi_Accept_All.lua`
   
   **That's it!** 🎉 The system will automatically handle everything else!

## 📁 Project Structure

```
Bills-MoP-Profiles/
├── 📄 README.md
├── 📄 LICENSE
├── 📄 CLAUDE.md                # Claude Code guidance
├── ⚙️ .luacheckrc              # Lua linting configuration
└── 📂 src/
    ├── 📂 Golden Lotus Dailies/
    │   ├── ✅ Golden_Lotus_00_Start_Here_Accept_All.lua
    │   ├── 🔍 Golden_Lotus_01_Laosy_Scouting.lua
    │   ├── 👻 Golden_Lotus_02_Unleashed_Spirits.lua
    │   ├── 🎯 Golden_Lotus_03_The_Eternal_Vigil.lua
    │   ├── 🗿 Golden_Lotus_04_Crumbling_Behemoth.lua
    │   ├── 💚 Golden_Lotus_05_Given_a_Second_Chance.lua
    │   ├── ⚔️ Golden_Lotus_06_Striking_First.lua
    │   ├── 🔥 Golden_Lotus_07_Acts_of_Cruelty.lua
    │   ├── 🌧️ Golden_Lotus_08_High_Chance_of_Rain.lua
    │   ├── 🔄 Golden_Lotus_09_TurnIn_All.lua
    │   ├── 🗺️ Golden_Lotus_10_Quest_Router.lua
    │   ├── 🚶 Golden_Lotus_Mistfall_Village_00_Transition.lua
    │   ├── ✅ Golden_Lotus_Mistfall_Village_01_Accept_All.lua
    │   ├── 🍎 Golden_Lotus_Mistfall_Village_02_Pomfruit_Pickup.lua
    │   ├── ⚡ Golden_Lotus_Mistfall_Village_03_Encroaching_Storm.lua
    │   ├── 🔥 Golden_Lotus_Mistfall_Village_04_My_Town_Its_on_Fire.lua
    │   ├── 🪶 Golden_Lotus_Mistfall_Village_05_Ruffling_Some_Feathers.lua
    │   ├── 🍺 Golden_Lotus_Mistfall_Village_06_Steer_Clear_of_the_Beer_Here.lua
    │   ├── 🧚 Golden_Lotus_Mistfall_Village_07_Sprite_Plight.lua
    │   ├── 🔄 Golden_Lotus_Mistfall_Village_08_TurnIn_All.lua
    │   └── 🏆 Golden_Lotus_Mistfall_Village_09_Quid_Pro_Quo.lua
    └── 📂 Klaxxi Dailies/
        ├── ✅ Klaxxi_00_Start_Here_Klaxxi_Accept_All.lua
        ├── ⚔️ Klaxxi_01_The_Fight_Against_Fear.lua
        ├── 🐉 Klaxxi_02_The_Scale_Lord.lua
        ├── 🧠 Klaxxi_03_A_Little_Brain_Work.lua
        ├── 🐢 Klaxxi_04_Kunchong_Treats.lua
        ├── 🧬 Klaxxi_05_Bad_Genes.lua
        ├── ⚔️ Klaxxi_06_Mistblade_Destruction.lua
        ├── 🏺 Klaxxi_07_An_Ancient_Empire.lua
        ├── 🚫 Klaxxi_08_Nope_Nope_Nope.lua
        ├── 🕷️ Klaxxi_09_Dreadspinner_Extermination.lua
        ├── 👁️ Klaxxi_10_Putting_An_Eye_Out.lua
        ├── 🍖 Klaxxi_11_Brain_Food.lua
        ├── 🌳 Klaxxi_12_Sap_Tapping.lua
        └── 🔄 Klaxxi_TurnIn_All.lua
```

## ⚙️ Configuration

### Quest Chain Execution

Quest profiles are designed to chain together automatically:

**Golden Lotus Chain (Two-Part Structure):**

```
Part 1: Temple of the White Tiger (Main Hub)
  ↓
Accept All → Execute Quests → Turn In All → Quest Router (Leven Dawnblade)
                                                    ↓
                                        Assigns secondary hub for Part 2
                                                    ↓
Part 2: Secondary Hub (Changes Daily)
  ↓
Transition → Accept All → Execute Quests → Turn In All → Final Quest
```

🎯 **How It Works:**
- **Part 1 - Main Hub:** Always at Temple of the White Tiger
  - `Golden_Lotus_00_Start_Here_Accept_All.lua` accepts all available dailies
  - Execute 8 rotating quests (different each day, same location)
  - `Golden_Lotus_09_TurnIn_All.lua` turns in completed quests
  - `Golden_Lotus_10_Quest_Router.lua` talks to Leven Dawnblade for Part 2 assignment
  
- **Part 2 - Secondary Hub:** Location changes daily
  - Currently implemented: **Mistfall Village**
  - Coming soon: Ruins of Guo-Lai, Setting Sun Garrison, Whitepetal Lake
  - Each hub has its own set of quests and final challenge

**Klaxxi Chain (Simple 3-Phase):**

```
Accept All → Execute Individual Quests (Daily Rotation) → TurnIn All
     ↓                        ↓                               ↓
4 Different NPCs      12 Quest Pool (varies daily)    Smart Turn-In System
```

🎯 **How It Works:**
- **Accept Phase:** `Klaxxi_00_Start_Here_Klaxxi_Accept_All.lua` visits 4 NPCs and accepts available dailies
- **Execute Phase:** 12 individual quest profiles with smart skip logic for unavailable quests
- **TurnIn Phase:** `Klaxxi_TurnIn_All.lua` efficiently turns in completed quests
- **Daily Variety:** Each day offers different quests from the 12-quest pool

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

- 🔍 **Automated Lua Linting** - GitHub Actions with intelligent caching (3x faster builds!)
- 📝 **Comprehensive Documentation** - Every function and quest properly documented
- 🧪 **Rigorous Testing** - All coordinates and quest IDs validated in-game
- ✅ **Modern CI/CD Pipeline** - Automated quality checks with LuaRocks dependency caching
- ⚡ **Performance Optimized** - Smart caching reduces build times from 45s to 15s

#### Running Linting Locally

```bash
# Install luacheck (one-time setup)
brew install luacheck        # macOS
sudo apt-get install luacheck # Linux

# Run linting
luacheck src/
```

## 🤝 Contributing

We welcome contributions! Please follow these guidelines:

1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/new-quest`)
3. ✅ Ensure your code passes linting (`luacheck src/`)
4. 💾 Commit your changes (`git commit -am 'Add new quest profile'`)
5. 📤 Push to the branch (`git push origin feature/new-quest`)
6. 🔄 Create a Pull Request (automated checks will run)

## 🗺️ Roadmap

- [x] 🏮 **Golden Lotus** faction dailies - Part 1 (Main Hub) complete, Part 2 (Mistfall Village) complete
  - [ ] Additional Part 2 hubs: Ruins of Guo-Lai, Setting Sun Garrison, Whitepetal Lake
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
