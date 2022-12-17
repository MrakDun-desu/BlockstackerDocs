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

When loading the file, UStacker will check if the contents are a valid 
Lua script and show you a warning if it isn't.

Here are the events, ordered in alphabetical order:

## `CountdownTicked` event

Event is triggered whenever the countdown before the game start ticks. Sent message contains these fields:

| Field name     | Field type | Field description                                           |
| :------------- | :--------- | :---------------------------------------------------------- |
| RemainingTicks | uint       | Amount of countdown ticks that remain until the game starts |

## `GameEnded` event

Event is triggered whenever the game successfully ends. This means that either the game end condition was met,
or that the player topped out and topping out is okay setting was set to true.

This event sends an empty message.

## `GameLost` event

Event is triggered whenever the game is lost. This means that the player has topped out.

This event sends an empty message.

## `GamePaused` event

Event is triggered whenever the game is paused.

This event sends an empty message.

## `GameRestarted` event

Event is triggered whenever the game is restarted.

This event sends an empty message.

## `GameResumed` event

Event is triggered whenever the game is resumed.

This event sends an empty message.

## `GameStarted` event

Event is triggered whenever the game is started.

This event sends an empty message.

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

Possible values for KeyActionType are:
- "KeyUp"
- "KeyDown"

Note that this event is sent even when the action isn't successful. For actual piece movements, it's better to subscibe to other events.

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
| Field name        | Field type | Field description                                                   |
| :---------------- | :--------- | :------------------------------------------------------------------ |
| LinesCleared      | uint       | Amount of lines cleared with this piece placement                   |
| CurrentCombo      | uint       | Amount of combo that player has achieved with this placement        |
| CurrentBackToBack | uint       | Amount of back-to-back player has after this placement              |
| PieceType         | string     | Name of the piece type that was used in this placement              |
| WasAllClear       | bool       | Indicates whether this placement was an all clear                   |
| WasSpin           | bool       | Indicates whether this placement was a full spin                    |
| WasSpinMini       | bool       | Indicates whether this placement was a spin mini                    |
| WasSpinRaw        | bool       | Indicates whether this placement would be a full spin with all-spin |
| WasSpinMiniRaw    | bool       | Indicates whether this placement would be a spin mini with all-spin |
| BrokenCombo       | bool       | Indicates whether combo was broken with this placement              |
| BrokenBackToBack  | bool       | Indicates whether back to back was broken with this placement       |
| Time              | double     | Amount of seconds since the start of the game                       |

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
| StartRotation  | RotationState | Starting rotation of the piece in degrees                           |
| EndRotation    | RotationState | Ending rotation of the piece in degrees                             |
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


---
