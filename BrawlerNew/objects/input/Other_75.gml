/// @description Detect Controllers
show_debug_message("Event = " + async_load[? "event_type"]);        // Debug cocde so you can see which event has been
show_debug_message("Pad = " + string(async_load[? "pad_index"]));   // triggered and the pad associated with it.

switch(async_load[? "event_type"])             // Parse the async_load map to see which event has been triggered
{
case "gamepad discovered":                     
     var index = async_load[? "pad_index"];
     global.pad = index;       // Get the pad index value from the async_load map
     gamepad_set_axis_deadzone(global.pad, 0.3);       
     gamepad_set_button_threshold(global.pad, 0.3);    
     break;
case "gamepad lost":                           
     var index = async_load[? "pad_index"];   
     global.pad = noone;    
     break;
}