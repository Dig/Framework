#include "..\..\script_macros.hpp"
/*
    File: fn_bankDeposit.sqf
    Author: Bryan "Tonic" Boardwine

    Description:
    Figure it out.
*/
if (CASH <= 0) exitWith {};

_max = CASH;
if (_max > 999999) then {
  _max = 999999;
};

[0, _max, (_max / 10), 0,
{
  _value = _this select 0;

  //Series of stupid checks
  if (_value > 999999) exitWith {hint localize "STR_ATM_GreaterThan";};
  if (_value < 0) exitWith {};
  if (!([str(_value)] call TON_fnc_isnumber)) exitWith {hint localize "STR_ATM_notnumeric"};
  if (_value > CASH) exitWith {hint localize "STR_ATM_NotEnoughCash"};

  CASH = CASH - _value;
  BANK = BANK + _value;

  hint format [localize "STR_ATM_DepositSuccess",[_value] call life_fnc_numberText];
  [] call life_fnc_atmMenu;
  [6] call SOCK_fnc_updatePartial;

  if (LIFE_SETTINGS(getNumber,"player_moneyLog") isEqualTo 1) then {
      if (LIFE_SETTINGS(getNumber,"battlEye_friendlyLogging") isEqualTo 1) then {
          money_log = format [localize "STR_DL_ML_depositedBank_BEF",_value,[BANK] call life_fnc_numberText,[CASH] call life_fnc_numberText];
      } else {
          money_log = format [localize "STR_DL_ML_depositedBank",profileName,(getPlayerUID player),_value,[BANK] call life_fnc_numberText,[CASH] call life_fnc_numberText];
      };
      publicVariableServer "money_log";
  };

}
] call life_fnc_getNumber;
