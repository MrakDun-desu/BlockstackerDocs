To use a custom game manager, you'll need to create a directory `rulesCustomization/gameManagers` in the application persistent data path.

Game manager is a script that takes care of levelling, score counting and other mechanics that are specific to different game types. UStacker natively supports 3 different game managers:

- modern system with levelling
- modern system without levelling (one static level)
- classic system with levelling

Game managers can change various aspects of the game during the gameplay. As of UStacker version 0.3, game manager can set score, gravity and lock delay as with most other games. With future versions, more options will be added, like changing up randomization to different piece types, making board blocks invisible, modifying the board state and more.

**Important note: All custom game manager files must have the extension .lua**

## Loading a premade game manager

1. Copy the game manager file into the `gameManagers` directory.
2. In the custom game settings, under Objective, pick "Custom" as you game manager type.
3. In the custom game manager dropdown, the new game manager should now be found by its filename without extension.

## Creating a custom game manager

1. Think up your own game manager name and create a Lua script with that name.
2. Write the game manager script so that the game can use it. Explained [here](#how-to-write-a-game-manager-script).
3. Copy the game manager file into the `gameManagers` directory.
4. In the custom game settings, under Objective, pick "Custom" as you game manager type.
5. In the custom game manager dropdown, the new game manager should now be found by its filename without extension.

## How to write a game manager script

Game manager script has the most options out of any UStacker scripts. You can subscribe to any game messages, manage state of the game, make your own score counting system and more.

### Predefined values

Game manager script has 2 predefined values
1. [`StartingLevel`](#starting-level) - used to provide the player-specified starting level when the game starts.
2. [`Board`](#board) - board of the currently played game.

#### Starting level

Starting level is simply a value that the user has requested from the game manager. You can choose to start at exactly that level, or to clamp it to some maximum value, or to ignore it alltogether.

Starting level is set in a global variable called `StartingLevel`. This variable is of string type, so if you have number-only levels, you need to parse it first. (storing as a string is done for more freedom in how to handle levelling)

#### Board

Board is your interface to the board you're currently managing. It's a reference to the in-game C# object which has multiple fields and methods that you can use.

You access fields with the `.` notation.

Fields available in UStacker 0.3:
- `Board.Width` - width of the board in blocks
- `Board.Height` - height of the board in blocks
- `Board.LethalHeight` - height that has been set in the game settings to be lethal. Is relevant only for certain topout conditions by itself.
- `Board.GarbageHeight` - height of garbage that is currently on the board.
- `Board.Slots` - list of lists of boolean values. Each inner list is one line on the board. Each boolean value is true if that slot is filled and false if it is not.

Note: `Board.Slots` dynamic, so if there are no blocks on the board, the `Slots` field will contain no lines.
Note: Indexing in Lua starts from 1, but when accessing objects which are taken from C#, this isn't the case. So instead of indexing `Board.Slots` from `1` to `Slots.Count`, you need to index from `0` to `Slots.Count - 1`.

You access functions with the `:` notation.
Functions available in UStacker 0.3:
- `Board:AddGarbageLayer(slotsTable, addToLast)` - `slotsTable` is a table of tables of boolean values. Each table represents one line of garbage and should be filled with boolean values, true for garbage block and false for no garbage blocks. `addToLast` is a boolean that decides if this garbage layer should be counted as a part of last added layer. Important for connected skins. Works the same as function in [Garbage generators](Garbage-generators.md).
- `Board:ClearAllBlocks()` - clears all blocks from the board.

### Callable functions

Other than functions on predefined values, you an also call functions that have been registered before running your script.

Functions available in UStacker 0.3:
- `EndGame(time)` - will end game successfully. For `time` parameter, you should use time that you get from one of events that you have registered. For more about registering events, look [here](#registering-events).
- `LoseGame(time)` - similar to `EndGame`, but will end game as a failure and a replay will not be saved. Note: this is exactly the same as `EndGame` if in game objective settings, Topping out is okay is set to true.
- `SetScore(score, time)` - will set the game score at a specified time. `score` can be any number, but will be converted to a 64bit signed integer after calling. For `time`, you should use time that you get from one of the events that you have registered.
- `SetLevel(level, time)` - will set the game level at a specified time. `level` can be any value, but will be converted to string after calling. For `time`, you should use time that you get from one of the events that you have registered.
- `SetLevelUpCondition(current, total, time, condName)` - will set the level up condition. This is useful for stat counters, so player knows when to expect level to change. `current` is the current value of the level up condition. `total` is the total value needed to get to the next level. Both of these values can be any number, but will be converted to doubles after calling the function. For `time`, you should use time that you get from one of the events that you have registered. `condName` is name of the condition that you want to be presented to the player. It should be of string type.
- `SetGameEndCondition(current, total, time, condName)` - will set the game end condition. This is useful for stat counters, so player knows when to expect the game to end. `current` is the current value of the game end condition. `total` is the total value needed to end game. Both of these can be any number, but will be converted to doubles after calling the function. For `time`, you should use time that you get from one of the events that you have registered. `condName` is the name of the condition that you want to be presented to the player. It should be of string type.
- `SetGravity(gravity, time)` - will set the gravity. `gravity` can be any number, but will be converted to double before calling the function. For `time`, you should use time that you get from one of the events that you have registered, or use 0 in case you call this at the start of the game.
- `SetLockDelay(lockDelay, time)` - will set the lock delay in seconds. `lockDelay` can be any number, but will be converted to double before calling the function. For `time`, you should use time that you get from one of the events that you have registered, or use 0 in case you call this at the start of the game.


### Registering events

Registering events in a game manager works the universal UStacker way. You can read about this way [here](../Game-events.md#subscribing-to-the-events).

You can subscribe to every game event that is listed on the event page.

### Examples

So far, there is one example script that should function the same as in-game modern manager without levelling. You can find it [here](../Example%20files/modernManagerNoLevelling.lua).
