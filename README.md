# 🏦 Pawnshop Script (ESX)

Custom **Pawn Shop** script designed **only for FiveM ESX servers**.  
Players can interact with an NPC using a target system, open a menu, and purchase items using **cash or bank**.

---

## ✨ Features

- 🧑 NPC-based pawn shop
- 🎯 Target interaction to open the menu
- 🛒 Item purchase system
- 💵 Multiple payment methods:
  - Cash
  - Bank
- 🖥️ Clean and simple UI menu powered by **lation-ui**
- ⚙️ Optimized for ESX servers

---

## 📌 Requirements

This script **requires** the following resources:

- **ESX framework**
- **lation-ui** (used for menu UI)
- Any compatible **target system** (e.g. ox_target equivalent for ESX)

> ⚠️ Without `lation-ui`, the menu will not work.

---

## 🛠️ Installation

1. Download or clone this repository
2. Place the script into your server's `resources` folder
3. Make sure `lation-ui` is installed and started **before** this script
4. Add the following lines to your `server.cfg`:
   ```
   ensure lation-ui
   ensure kts-lombardas
5. Configure the script via `config.lua`
6. Restart your server
