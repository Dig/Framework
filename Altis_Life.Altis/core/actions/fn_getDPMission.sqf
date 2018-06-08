#include "..\..\script_macros.hpp"
/*
    File: fn_getDPMission.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Selects a random DP point for a delivery mission.

*/
private ["_dp","_target"];

_target = param [0,objNull,[objNull]];
_type = "dp";

if (str(_target) in LIFE_SETTINGS(getArray,"delivery_points")) then {
    private "_point";
    _point = LIFE_SETTINGS(getArray,"delivery_points");
    _point deleteAt (_point find (str(_target)));
    _dp = _point call BIS_fnc_selectRandom;
} else {
    _dp = LIFE_SETTINGS(getArray,"delivery_points") call BIS_fnc_selectRandom;
};

// --- Check if Cargo mission
_valid = true;
if (count(_this select 3) == 2) then {
  _type = (_this select 3) select 1;

  if (_type == "cargo") then {
    _vehicle = vehicle player;

    // --- Fetch vehicles within 30m
    _vehicles = nearestObjects[player, ["C_Offroad_01_F"], 30];
    if (count(_vehicles) > 0) then {
      {
        _vehData = _x getVariable ["vehicle_info_owners",[]];
        if (count _vehData  > 0) then {
            _vehOwner = ((_vehData select 0) select 0);
            if ((getPlayerUID player) == _vehOwner) exitWith {
                _vehicle = _x;
            };
        };
      } forEach _vehicles;
    };

    // --- Check if vehicle is valid
    if ((isNil "_vehicle") || (isNull _vehicle) || (!alive _vehicle) || (typeOf _vehicle != "C_Offroad_01_F")) then {
      _valid = false;
    } else {

      // --- Pimp the vehicle
      _crate = "B_CargoNet_01_ammo_F" createVehicle position player;
      _crate setDir (getDir _vehicle);
      _crate attachTo [_vehicle, [0, -1.8, 0]];

    };
  };
};

if (!_valid) exitWith {hint "You need a offroad nearby in order to do a Cargo mission!";};

life_dp_start = _target;
life_delivery_type = _type;

life_delivery_in_progress = true;
life_dp_point = call compile format ["%1",_dp];

_dp = [_dp,"_"," "] call KRON_Replace;
life_cur_task = player createSimpleTask [format ["Delivery_%1",life_dp_point]];
life_cur_task setSimpleTaskDescription [format [localize "STR_NOTF_DPStart",toUpper _dp],"Delivery Job",""];
life_cur_task setTaskState "Assigned";
player setCurrentTask life_cur_task;

["DeliveryAssigned",[format [localize "STR_NOTF_DPTask",toUpper _dp]]] call bis_fnc_showNotification;

if (_type == "dp") then {
  [] spawn {
      waitUntil {!life_delivery_in_progress || !alive player};
      if (!alive player) then {
          life_cur_task setTaskState "Failed";
          player removeSimpleTask life_cur_task;
          ["DeliveryFailed",[localize "STR_NOTF_DPFailed"]] call BIS_fnc_showNotification;
          life_delivery_in_progress = false;
          life_dp_point = nil;
      };
  };
};
