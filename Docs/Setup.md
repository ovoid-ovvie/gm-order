# Setup

[Home](../README.md)

---

## 1. Download Order

Go to the [Releases](../../../releases) page and download the latest `.yymps` file.

## 2. Import into GameMaker

There are two ways to import the package:

**Drag and drop** -- drag the `.yymps` file directly onto the GameMaker IDE and it will open the import window automatically.

**Tools menu** -- open your project in GameMaker, go to `Tools > Import Local Package`, and browse to the downloaded `.yymps` file.

Either way, an import window will open showing the package contents. Click `Add All` to select everything, then click `Import`.

## 3. Done

Order creates and manages `__OrderManager` automatically at game start. You do not need to place anything in a room. The `order_api` and `order_api/screenshots` directories are also created automatically in local app data on first run.

Press `F12` (or whatever key you have set for `ORDER_SUMMON_KEY`) during a run to open the console. Type `help` to see all available commands.

---

## Adding Custom Commands

Custom commands are added in [`OrderCustomData`](../Order/scripts/OrderCustomData/OrderCustomData.gml). This is the only file you need to edit to extend the console with your own commands. See [Adding Commands](Adding-Commands.md) for a full guide.

---

[Next: How It Works](How-It-Works.md)
