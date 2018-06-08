#include "..\..\script_macros.hpp"
/*
    File: fn_dpFinish.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Finishes the DP Mission and calculates the money earned based
    on distance between A->B
*/
private ["_dp","_dis","_price"];
_dp = [_this,0,objNull,[objNull]] call BIS_fnc_param;

// --- Check if Cargo mission
_valid = true;
if (life_delivery_type == "cargo") then {
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
    _valid = false;

    // --- Remove that crate!
    {
      if (typeOf _x == "B_CargoNet_01_ammo_F") then {
        detach _x;
        deleteVehicle _x;

        _valid = true;
      };
    } forEach attachedObjects _vehicle;

  };
};

if (!_valid) exitWith {hint "You need to bring the Offroad to the delivery point to claim your reward!";};

life_delivery_in_progress = false;
life_dp_point = nil;
_dis = round((getPos life_dp_start) distance (getPos _dp));
_price = round(1.7 * _dis);

if ((_valid) && (life_delivery_type == "cargo")) then {
  _price = _price * 2;
};

["DeliverySucceeded",[format [(localize "STR_NOTF_Earned_1"),[_price] call life_fnc_numberText]]] call bis_fnc_showNotification;
life_cur_task setTaskState "Succeeded";
player removeSimpleTask life_cur_task;
CASH = CASH + _price;
[0] call SOCK_fnc_updatePartial;
