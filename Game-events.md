In BlockStacker-desu, you are able to write your own scripts to create your own sound effect patterns and stats. Here is the list of messages that you can recieve in your scripts. In different types of scripts, you can register different types of messages.

You can access the fields of each message in your scripts like it was a normal Lua object.

## PiecePlaced event

Event is triggered whenever the piece is placed and sends a message that contains these fields:
| Field name        | Field type | Field description                                            |
| :---------------- | :--------- | :----------------------------------------------------------- |
| LinesCleared      | uint       | Amount of lines cleared with this piece placement            |
| CurrentCombo      | uint       | Amount of combo that player has achieved with this placement |
| CurrentBackToBack | uint       | Amount of back-to-back player has after this placement       |
| PieceType         | string     | Name of the piece type that was used in this placement       |
| WasAllClear       | bool       | Indicates whether this placement was an All clear            |
| WasSpin           | bool       | Indicates whether this placement was a spin                  |
| WasSpinMini       | bool       | Indicates whether this placement was a spin mini             |
| Time              | double     | Amount of seconds from the start of the game                 |

A function that would handle this kind of event could look like this: 
```lua
PiecesPlaced = 0

function HandlePiecePlaced(message)
    PiecesPlaced = PiecesPlaced + 1
    local pps = PiecesPlaced / message.Time
    return tostring(pps)
end
```