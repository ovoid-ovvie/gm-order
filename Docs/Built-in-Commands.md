# Built-in Commands

[Home](../README.md)

---

All commands are available via `help` in the console. This page documents each one in full.

---

## General

### help
```
help
help <topic>
```
Lists all available commands. Pass a topic to filter commands by name. For example, `help instance` shows all commands with "instance" in their name.

### clear
```
clear
```
Wipes the console log.

### echo
```
echo <text>
```
Prints text back to the console. Useful for testing or leaving notes in an exported log.

### history
```
history
```
Prints all previously entered commands.

### export
```
export
```
Saves the current console log to a numbered text file in `order_api/` in local app data. Each export gets a unique filename so previous exports are never overwritten.

### screenshot
```
screenshot
```
Saves an image of the application surface to a numbered png file in `order_api/screenshots/` in local app data. Each screenshot gets a unique filename so previous screenshots are never overwritten.

---

## Game

### game_restart
```
game_restart
```
Restarts the game and returns it to its opening state.

### quit
```
quit
```
Closes the game.

### timescale
```
timescale <multiplier>
```
Applies a multiplier to the game speed. `timescale 0.5` runs the game at half speed, `timescale 2` at double speed, `timescale 1` restores normal speed.

### pause
```
pause <true/false>
```
Pauses or unpauses the game by deactivating or activating all instances. `__OrderManager` is always kept active. Any objects listed in `ORDER_PAUSE_EXCLUDE` in the config are also kept active.

### delta
```
delta
```
Returns the current value of `delta_time`.

### fps
```
fps
```
Returns the current `fps` and `fps_real` values.

---

## Room

### goto
```
goto <room name>
```
Teleports to the specified room. Cannot be the current room.

### room_info
```
room_info
```
Returns the current room's name, dimensions, instance count, and whether it is persistent.

### room_restart
```
room_restart
```
Restarts the current room without a full game restart.

---

## Instances

### spawn
```
spawn <object name>
```
Spawns an instance of the specified object at the current mouse position, at depth 0.

### destroy
```
destroy <instance id>
```
Destroys the specified instance by ID.

### destroy_all
```
destroy_all <object name>
```
Destroys all instances of the specified object.

### inspect
```
inspect
inspect <instance id>
```
Returns the variable names and values of an instance. Without an argument, inspects the instance at the current mouse position. Pass an instance ID to inspect directly.

### instances
```
instances
```
Lists all active objects in the current room and their instance counts.

### instance_count
```
instance_count <object name>
```
Returns the number of active instances of the specified object.

### instance_get
```
instance_get <instance id> <variable>
```
Returns the current value of a variable on the specified instance.

### instance_set
```
instance_set <instance id> <variable> <type> <value>
```
Sets a variable on the specified instance to a new value. Type must be `string`, `bool`, `real`, or `int64`. Logs the previous value before changing it.

### instance_move
```
instance_move <instance id> <x> <y>
```
Teleports the specified instance to the given coordinates.

### instance_freeze
```
instance_freeze <instance id> <true/false>
```
Freezes or unfreezes an instance by deactivating or activating it.

### instance_near
```
instance_near <distance>
```
Lists all instances within the given distance to the mouse position.

---

## Global Variables

### global_get
```
global_get <variable>
```
Returns the current value of the specified global variable, including its type.

### global_set
```
global_set <variable> <type> <value>
```
Sets a global variable to a new value. Type must be `string`, `bool`, `real`, or `int64`. Logs the previous value before changing it.

### global_list
```
global_list
```
Lists all global variables and their current values.

---

## Layers

### layer_list
```
layer_list
```
Lists all layers in the current room with their depth and visibility.

### layer_set_visible
```
layer_set_visible <layer name> <true/false>
```
Sets the specified layer to visible or hidden.

---

## Audio

### audio_debug
```
audio_debug <true/false>
```
Toggles the audio debug overlay.

### audio_pause_all
```
audio_pause_all <true/false>
```
Pauses or resumes all audio.

### audio_stop_all
```
audio_stop_all
```
Stops all audio.

---

## Debug Overlays

### overlay
```
overlay <true/false>
```
Toggles the FPS and memory debug overlay.

### log
```
log <true/false>
```
Toggles the GML output window.

### physics_view
```
physics_view <true/false>
physics_view <true/false> <extended true/false>
```
Toggles the physics debug overlay. Only works in rooms that contain a physics world. Pass a second argument to toggle between regular and extended view. The flags drawn in each mode can be configured in `OrderConfig`.

### flush_textures
```
flush_textures
```
Removes all textures from video memory. They will be reloaded on first use. Useful for testing texture streaming behaviour.

---

[Next: Adding Commands](Adding-Commands.md)
