# 🏮 Baneto MoP Dailies

> **Premium Daily Quest Profiles for World of Warcraft: Mists of Pandaria**  
> Automated quest execution using the Baneto framework

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![WoW Version](https://img.shields.io/badge/WoW-Mists%20of%20Pandaria-orange.svg)](https://worldofwarcraft.com/)
[![Baneto Compatible](https://img.shields.io/badge/Baneto-Compatible-green.svg)](https://github.com/baneto)

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
| **Laosy Scouting**        | KillAndLoot  | Gather intelligence from enemy forces    |
| **Given a Second Chance** | UseItemOnNpc | Heal wounded defenders with sacred items |

## 🚀 Quick Start

### Prerequisites

- ✅ World of Warcraft: Mists of Pandaria
- ✅ [Baneto Bot](https://baneto-bot.com) installed and configured
- ✅ Character with access to the dailies

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
   - Load desired Golden Lotus profiles

## 📁 Project Structure

```
Baneto-MoP-Dailies/
├── 📄 README.md
├── 📄 LICENSE
├── ⚙️ .luacheckrc              # Lua linting configuration
└── 📂 src/
    └── 📂 Golden Lotus Dailies/
        ├── 🎯 Golden_Lotus_01_The_Eternal_Vigil.lua
        ├── 👻 Golden_Lotus_02_Unleashed_Spirits.lua
        ├── 🗿 Golden_Lotus_03_Crumbling_Behemoth.lua
        ├── 🔍 Golden_Lotus_04_Laosy_Scouting.lua
        └── 💚 Golden_Lotus_05_Given_a_Second_Chance.lua
```

## ⚙️ Configuration

### Quest Chain Execution

Quest profiles are designed to chain together automatically:

```
The Eternal Vigil → Unleashed Spirits → Crumbling Behemoth → Laosy Scouting → Given a Second Chance
```

### Custom Pulse Functions

Some quests include custom logic for advanced automation:

- **Smart Targeting** - Intelligent mob selection and blacklisting
- **Item Usage** - Automated quest item interaction
- **Error Recovery** - Handles edge cases and stuck scenarios

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

[Report Bug](https://github.com/yourusername/Baneto-MoP-Dailies/issues) • [Request Feature](https://github.com/yourusername/Baneto-MoP-Dailies/issues) • [Contribute](https://github.com/yourusername/Baneto-MoP-Dailies/pulls)

</div>
