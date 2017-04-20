if (!isServer) exitWith {};
if (isNil "Epoch_TT_Initialized") exitWith {};

params ['_list', '_selection'];

{

    _fate = _x getVariable ['Epoch_TT_MysterySelection', []];
    _fate pushback _selection;
    _x setVariable ['Epoch_TT_MysterySelection', _fate];

    _length = count _fate;
    if (_fate select (_length- 1) == Epoch_TT_MysteryCombination select (_length - 1)) then {

        if (count _fate >= 3) then {

            'DoorSuccess' remoteExec ['Epoch_TT_LocalPlaySound', _x];

            // Put them at the end point on correct combo
            _x setPos Epoch_TT_MysteryCompleteMarker;

        } else {

            _x setPos (Epoch_TT_MysteryMarkers select ((count _fate) - 1) );
            'DoorCorrect' remoteExec ['Epoch_TT_LocalPlaySound', _x];

        };

    } else {

        // Reset player's combo either way
        _x setVariable ['Epoch_TT_MysterySelection', []];

        // Return player to start
        _x setPos Epoch_TT_MysteryStartMarker;
        'DoorFailure' remoteExec ['Epoch_TT_LocalPlaySound', _x];

    };

    false

} count _list > 0;
