# Configuration

[Home](../README.md)

---

All configuration is done in [`OrderConfig`](../Order/scripts/OrderConfig/OrderConfig.gml). Edit the macros there to customise Order's behaviour.

---

## Controls

### ORDER_SUMMON_KEY
```gml
#macro ORDER_SUMMON_KEY vk_f12
```
The key used to open and close the console. Default is `F12`.

---

## Display

### ORDER_TEXT_CURSOR
```gml
#macro ORDER_TEXT_CURSOR "_"
```
The string used as the text cursor in the input field. A single character is recommended. Default is `_`.

### ORDER_PULSE_INTERVAL
```gml
#macro ORDER_PULSE_INTERVAL 0.5
```
The time in seconds between the text cursor toggling on and off. Default is `0.5`.

### ORDER_ESCAPE_TAB_SPACES
```gml
#macro ORDER_ESCAPE_TAB_SPACES 4
```
The number of spaces used to replace `\t` tab characters in log entries. Default is `4`.

---

## Commands

### PHY_DEBUG_MINIMAL
```gml
#macro PHY_DEBUG_MINIMAL phy_debug_render_shapes | phy_debug_render_aabb | phy_debug_render_joints
```
The physics debug flags drawn when `physics_view` is set to regular mode. Edit this to customise what is shown.

### PHY_DEBUG_EXTENDED
```gml
#macro PHY_DEBUG_EXTENDED phy_debug_render_shapes | phy_debug_render_aabb | phy_debug_render_joints | phy_debug_render_collision_pairs | phy_debug_render_coms | phy_debug_render_core_shapes | phy_debug_render_obb
```
The physics debug flags drawn when `physics_view` is set to extended mode. Edit this to customise what is shown.

---

## Advanced

### ORDER_PAUSE_EXCLUDE
```gml
#macro ORDER_PAUSE_EXCLUDE []
```
An array of object types that remain active when the `pause` command is used. `__OrderManager` is always excluded regardless of this setting. Add any objects that need to keep running while the game is paused, such as a camera controller or HUD object.

```gml
#macro ORDER_PAUSE_EXCLUDE [obj_camera, obj_hud]
```

---

[Next: API Reference](API-Reference.md)
