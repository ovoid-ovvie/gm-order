# Order

Order is a command console API for GameMaker 2024.14. It provides an in-game console that you can summon at any time during a run, type commands into, and use to interact with the game without touching the code.

It is designed to work for everyone -- developers debugging a build, players who want more control over their experience, and modders looking to understand or modify what is happening in the game.

---

## Who is it for?

**Developers** can use the built-in commands to inspect variables, spawn or destroy instances, switch rooms, change game speed, capture screenshots, and more, all without recompiling.

**Players** can be given access to custom commands that you define, tailored to whatever your game needs. Cheat codes, debug modes, accessibility options, sandbox tools -- anything can be a console command.

**Modders** can use the built-in commands to inspect the game state and understand how things work from the inside. The ability to query globals, inspect instances, and list rooms gives modders a live window into the game.

---

## Feature Overview

- In-game console summoned and dismissed with a configurable key
- Large built-in command set covering instances, rooms, audio, globals, layers, and more
- Dedicated script for adding custom commands, for developer or player use
- Tab autocomplete with cycling through suggestions
- Did-you-mean suggestions for unknown commands
- Optional and required argument support per command
- Command history
- Log export to a text file
- Screenshot capture
- Clipboard integration
- Configurable appearance and behaviour

---

## Getting Started

See the [Setup](Docs/Setup.md) page to get Order integrated into your project.

---

## Documentation

- [Setup](Docs/Setup.md)
- [How It Works](Docs/How-It-Works.md)
- [Using the Console](Docs/Using-the-Console.md)
- [Built-in Commands](Docs/Built-in-Commands.md)
- [Adding Commands](Docs/Adding-Commands.md)
- [Configuration](Docs/Configuration.md)
- [API Reference](Docs/API-Reference.md)

---

## Font

The font used for the console is [Pixeloid](https://ggbot.itch.io/pixeloid-font) by ggbot. It uses the SIL Open Font License, Version 1.1.
This license is available with a FAQ [here](https://scripts.sil.org/OFL).
