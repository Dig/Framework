#include "..\..\script_macros.hpp"
/*
    File: fn_getNumber.sqf
    Author: Digital

    Description:
    Value selector

    Returns:
    [value]
*/

params [
    ["_min",0,[0]],
    ["_max",10,[10]],
    ["_inc",1,[1]],
    ["_start",0,[0]],
    ["_callback",{}]
];

createDialog "SliderMenu";

// --- Slider bar
sliderSetRange [2901, _min, _max];
sliderSetSpeed [2901, _inc, _inc];
sliderSetPosition [2901, _start];

// --- Edit box
ctrlSetText [2902, str (_start)];

// --- Confirm button
((findDisplay 2919) displayCtrl 2903) setVariable ["callback", _callback];
_event = ((findDisplay 2919) displayCtrl 2903) ctrlAddEventHandler ["ButtonClick", {
  _value = sliderPosition 2901;
  [(round _value)] call (((findDisplay 2919) displayCtrl 2903) getVariable "callback");
  closeDialog 0;
}];

// --- Remove event after close
[_event] spawn {
  waitUntil {isNull (findDisplay 2919)};
  ((findDisplay 2919) displayCtrl 2903) ctrlRemoveEventHandler ["ButtonClick", (_this select 0)];
};
