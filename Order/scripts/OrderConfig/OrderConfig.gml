////////////////
//            //
//  Controls  //
//            //
////////////////

// Key used to summon or dismiss the console
#macro ORDER_SUMMON_KEY vk_f12
// Default vk_f12

///////////////
//           //
//  Display  //
//           //
///////////////

// The string to use as a text cursor (i.e. the
// symbol that indicates where you're typing)
#macro ORDER_TEXT_CURSOR "_"
// Default "_", single character recommended

// The time in seconds it takes for the text cursor to
// to pulse on and off
#macro ORDER_PULSE_INTERVAL 0.5
// Default 0.5

// The amount of spaces to add to console log entries
// in place of the `\t` escape character
#macro ORDER_ESCAPE_TAB_SPACES 4
// Default 4

////////////////
//            //
//  Commands  //
//            //
////////////////

// Physics view flags. Edit these to customise what
// the `physics_view` console command draws in each
// mode
#macro PHY_DEBUG_MINIMAL  phy_debug_render_shapes | phy_debug_render_aabb | phy_debug_render_joints
#macro PHY_DEBUG_EXTENDED phy_debug_render_shapes | phy_debug_render_aabb | phy_debug_render_joints | phy_debug_render_collision_pairs | phy_debug_render_coms | phy_debug_render_core_shapes | phy_debug_render_obb

////////////////
//            //
//  Advanced  //
//            //
////////////////

// All objects in this array are excluded from
// being paused when using the `pause` command
#macro ORDER_PAUSE_EXCLUDE []
// The Order manager is excluded by default