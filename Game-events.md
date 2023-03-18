In UStacker, you are able to write your own scripts to create sound 
effect patterns. Here is the list of messages that you can recieve 
in your scripts. In different types of scripts, you can register different 
types of events.

You can access the fields of each message in your scripts like it was a normal 
Lua object.

## Subscribing to the events

When you write a script for UStacker that needs to access events, 
you need to define which functions in your script will handle them. 
This is currently done by returning a table that maps each event name to 
a handler function. Mapping functions could then look like this:

```lua
function MyFunction1(message)
    -- do some stuff with message
end

function MyFunction2(message)
    -- do some other stuff here
end

return {
    ["PiecePlaced"] = MyFunction1,
    ["PieceMoved"] = MyFunction2
}
```

If you try registering invalid events, UStacker will display a warning.

Here are the events, ordered in alphabetical order:

## `CountdownTicked` event

Event is triggered whenever the countdown before the game start ticks. Sent message contains these fields:

| RemainingTicks | uint       | Amount of countdown ticks that remain until the game starts |
| Field name | Field type | Field description |
| :--------- | :--------- | :---------------- |

## `GameEndConditionChanged` event

Event is triggered whenever the game end condition changes. This could be done by a custom game manager or by the game itself. Sent message 
contains these fields:

| Field name    | Field type | Field description                                             |
| :------------ | :--------- | :------------------------------------------------------------ |
| ConditionName | string     | The name of the game end condition that has changed           |
| CurrentCount  | double     | The part of the condition that has already been fulfilled     |
| TotalCount    | double     | Complete count that has to be fullfilled before the game ends |
| Time          | double     | Amount of seconds since the start of the game                 |


## `GameStateChanged` event

This event is sent whenever game state changes. Sent message contains these fields:

| Field name    | Field type | Field description                             |
| :------------ | :--------- | :-------------------------------------------- |
| PreviousState | GameState  | State the game has been in until now          |
| NewState      | GameState  | State the game has transitioned into          |
| IsReplay      | bool       | Is true if game is currently replaying        |
| Time          | double     | Amount of seconds since the start of the game |

GameState is an enum type, so you will need to call `:ToString()` method on it to compare them.

Possible values for GameState:
- "Unset" - game is in this state before it loads first time
- "Initializing" - game is in this state when it starts or restarts
- "StartCountdown" - game is in this state after initialization, but before it actually starts running
- "Running" - game is in this state when it's in progress and inputs are accepted
- "Paused" - game is in this state when it's in progress, but inputs are not accepted and timer is paused
- "ResumeCountdown" - game is in this state after unpausing, but before it actually starts running
- "Ended" - game is in this state after it has been successfully ended
- "Lost" - game is in this state after it has been ended with failure

## `HoldUsed` event

Event is triggered whenever the hold is used and sends a message that contains these fields:

| Field name    | Field type | Field description                                       |
| :------------ | :--------- | :------------------------------------------------------ |
| WasSuccessful | bool       | If the hold actually happened, is true, otherwise false |
| Time          | double     | Amount of seconds since the start of the game           |

## `InputAction` event

Event that is triggered whenever an input action happens. Sends a message that contains these fields:
| Field name    | Field type    | Field description                             |
| :------------ | :------------ | :-------------------------------------------- |
| ActionType    | ActionType    | Type of an action that just happened          |
| KeyActionType | KeyActionType | Number of units the piece has moved on X axis |
| Time          | double        | Amount of seconds since the start of the game |

ActionType and KeyActionType are enum types, so you will need to call `:ToString()` method on it to compare them.

Possible values for ActionType are:
- "MoveLeft"
- "MoveRight"
- "Hold"
- "Harddrop"
- "Softdrop"
- "RotateCW"
- "RotateCCW"
- "Rotate180"
- "MoveToLeftWall"
- "MoveToRightWall"

Possible values for KeyActionType are:
- "KeyUp"
- "KeyDown"

Note that this event is sent even when the action isn't successful. For actual piece movements, it's better to subscribe to other events.

A function that sould handle this kind of event could look like this:
```lua
KeysPressed = 0

-- this function counts every key press
function HandleInputAction(message)
    if message.KeyActionType:ToString() == "KeyDown" then
        KeysPressed = KeysPressed + 1

    return tostring(KeysPressed)
end
```

## `LevelChanged` event

This event is triggered whenever a level changes. It sends a message that contains these fields:

| Field name | Field type | Field description                             |
| :--------- | :--------- | :-------------------------------------------- |
| Level      | string     | The name of the new level                     |
| Time       | double     | Amount of seconds since the start of the game |

The Level field is a string to allow for more freedom in level naming. Like this, custom game managers can make levels with any names they like.

## `LevelUpConditionChanged` event

This event is triggered whenever the level up condition changes. It sends a message that contains these fields:

| Field name    | Field type | Field description                                                   |
| :------------ | :--------- | :------------------------------------------------------------------ |
| ConditionName | string     | Name of the level up condition that has just changed                |
| CurrentCount  | double     | Part of the condition that has already been fulfilled               |
| TotalCount    | double     | Total count that has to be fulfilled before the level changes again |

## `PieceMoved` event

Event that is triggered whenever the piece is moved and sends a message that contains these fields:

| Field name  | Field type | Field description                                        |
| :---------- | :--------- | :------------------------------------------------------- |
| X           | int        | Number of units the piece has moved on X axis            |
| Y           | int        | Number of units the piece has moved on Y axis            |
| WasHardDrop | bool       | Is true if the piece was harddropped                     |
| WasSoftDrop | bool       | Is true if the piece was softdropped                     |
| HitWall     | bool       | Is true if the piece hit left or right wall of the board |
| Time        | double     | Amount of seconds since the start of the game            |


A function that would handle this kind of event could look like this:
```lua
-- this function could handle choosing sound effect to play
function HandlePieceMoved(message)
    if message.X != 0 then
        return "move"
    end
end
```


## `PiecePlaced` event

Event is triggered whenever the piece is placed and sends a message that contains these fields:
| Field name          | Field type   | Field description                                                    |
| :------------------ | :----------- | :------------------------------------------------------------------- |
| LinesCleared        | uint         | Amount of lines cleared with this piece placement                    |
| CurrentCombo        | uint         | Amount of combo that player has achieved with this placement         |
| CurrentBackToBack   | uint         | Amount of back-to-back player has after this placement               |
| PieceType           | string       | Name of the piece type that was used in this placement               |
| WasAllClear         | bool         | Indicates whether this placement was an all clear                    |
| WasSpin             | bool         | Indicates whether this placement was a full spin                     |
| WasSpinMini         | bool         | Indicates whether this placement was a spin mini                     |
| WasSpinRaw          | bool         | Indicates whether this placement would be a full spin with all-spin  |
| WasSpinMiniRaw      | bool         | Indicates whether this placement would be a spin mini with all-spin  |
| BrokenCombo         | bool         | Indicates whether combo was broken with this placement               |
| BrokenBackToBack    | bool         | Indicates whether back to back was broken with this placement        |
| Time                | double       | Amount of seconds since the start of the game                        |
| GarbageLinesCleared | uint         | Amount of garbage lines cleared with this piece placement            |
| TotalRotation       | int          | Total amount of degrees this piece has rotated since spawning        |
| TotalMovement       | Vector2Int   | Total amount of units this piece has moved since spawning            |
| BlockPositions      | Vector2Int[] | An array of all the positions blocks were in when piece was placed   |
| WasBtbClear         | bool         | Is true if current clear is treated as back to back clear            |

A function that would handle this kind of event could look like this: 
```lua
PiecesPlaced = 0

-- this function computes pieces per second
function HandlePiecePlaced(message)
    PiecesPlaced = PiecesPlaced + 1
    local pps = PiecesPlaced / message.Time
    return tostring(pps)
end
```

## `PieceRotated` event

Event that is triggered whenever a piece is rotated and sends a message that contains these fields:
| Field name     | Field type    | Field description                                                   |
| :------------- | :------------ | :------------------------------------------------------------------ |
| PieceType      | string        | Name of the piece type that just moved                              |
| StartRotation  | RotationState | Rotation state of active piece before this rotation                 |
| EndRotation    | RotationState | Rotation state of active piece after this rotation                  |
| WasSpin        | bool          | Indicates whether the rotation would count as a full spin           |
| WasSpinMini    | bool          | Indicates whether the rotation would count as a spin mini           |
| WasSpinRaw     | bool          | Indicates whether this placement would be a full spin with all-spin |
| WasSpinMiniRaw | bool          | Indicates whether this placement would be a spin mini with all-spin |
| Time           | double        | Amount of seconds since the start of the game                       |

RotationState is an enum type, so you will need to call `:ToString()` method on it to compare it.

Possible values are:
- "Zero" - default rotation state
- "One" - piece is rotated 90 degrees counterclockwise
- "Two" - piece is rotated 180 degrees
- "Three" - piece is rotated 90 degrees clockwise


A function that sould handle this kind of event could look like this:
```lua
-- this function could handle choosing sound effect to play
function HandlePieceRotated(message)
    if (message.WasSpin || message.WasSpinMini) then
        return "spinSound"
    end
    return "rotationSound"
end
```

## `PieceSpawned` event

Event that is triggered whenever a piece is spawned and sends a message that contains these fields:

| Field name   | Field type | Field description                                                                                                          |
| :----------- | :--------- | :------------------------------------------------------------------------------------------------------------------------- |
| SpawnedPiece | string     | Name of the piece type that just spawned                                                                                   |
| NextPiece    | string     | Name of the next piece that is coming. If the player doesn't have hear next pieces enabled, this is always an empty string |
| Time         | double     | Amount of seconds since the start of the game                                                                              |

## `ScoreChanged` event

Event that is triggered whenever the score changes. It sends a message that contains these fields:

| Field name | Field type | Field description                             |
| :--------- | :--------- | :-------------------------------------------- |
| Score      | long       | The new score value                           |
| Time       | double     | Amount of seconds since the start of the game |

---
