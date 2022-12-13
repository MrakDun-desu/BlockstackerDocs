To use a custom garbage generator, you'll need to create a directory `rulesCustomization/garbageGenerators` in the application persistent data path.

**Important note: All custom garbage generator files must have the extension .lua**

## Loading a premade garbage generator

1. Copy the garbage generator file into the `garbageGenerators` directory.
2. In the custom game settings, under Objective, pick "Custom" as your garbage generation.
3. In the custom garbage generator dropdown, the new garbage generator should now be found by its filename without extension.
4. If the garbage generator isn't valid, the game will tell you upon initialization.

## Creating a custom garbage generator

1. Think up your own garbage generator name and create a Lua script with that name.
2. Write the garbage generator script so that the game can use it. Explained [here](#how-to-write-a-garbage-generator-script).
3. Copy the garbage generator file into the `garbageGenerators` directory.
4. In the custom game settings, under Objective, pick "Custom" as your garbage generation.
5. In the custom garbage generator dropdown, the new garbage generator should now be found by its filename without extension.
6. If the garbage generator isn't valid, the game will tell you upon initialization.

## How to write a garbage generator script

The garbage generator script needs to implement 2 functions - one for resetting the state of generator when a game starts and one for actually generating the garbage. You will be able to access some of the properties of the board that you're working with.

### Predefined values in your script

Before activating your script, Blockstacker will set a global variable `Board`, which will hold the information about the board you're generating garbage for. On this `Board`, you have access to some information that you need to generate garbage.
Board is your interface to the board you're currently managing. It's a reference to the in-game C# object which has multiple fields and methods that you can use.

You access fields with the `.` notation.

Fields available in Blockstacker 0.3:
- `Board.Width` - width of the board in blocks
- `Board.Height` - height of the board in blocks
- `Board.LethalHeight` - height that has been set in the game settings to be lethal. Is relevant only for certain topout conditions by itself.
- `Board.GarbageHeight` - height of garbage that is currently on the board.
- `Board.Slots` - list of lists of boolean values. Each inner list is one line on the board. Each boolean value is true if that slot is filled and false if it is not.

Note: `Board.Slots` dynamic, so if there are no blocks on the board, the `Slots` field will contain no lines.
Note: Indexing in Lua starts from 1, but when accessing objects which are taken from C#, this isn't the case. So instead of indexing `Board.Slots` from `1` to `Slots.Count`, you need to index from `0` to `Slots.Count - 1`.

You access functions with the `:` notation.
Functions available in Blockstacker 0.3:
- `Board:AddGarbageLayer(slotsTable, addToLast)` - `slotsTable` is a table of tables of boolean values. Each table represents one line of garbage and should be filled with boolean values, true for garbage block and false for no garbage blocks. `addToLast` is a boolean that decides if this garbage layer should be counted as a part of last added layer. Important for connected skins. Works the same as function in [Garbage generators](Garbage-generators.md).

### Generator function

This function is used to generate the garbage layers. It is called every time a piece is placed. It takes 2 parameters - first parameter is the amount of requested garbage and second is the message about piece placement that has just happened.

First parameter is dependant on the game settings. It will always request the garbage such that the garbage height is the same as height set in game settings. You can choose to ignore this value and just generate as much garbage as you want to.

Second parameter is the message about piece placement. You can look up more about this message [here](/Game-events.md#pieceplaced-event).

Generating garbage in this function is done by calling the `AddGarbageLayer()` function, as described previously.

### Reset function

This function is used to reset the state of your garbage generator. It should receive one argument that is the new seed for your randomizer and return no value.

It will be called automatically after loading up your script for the first time.

If you won't use the seed set by this function in your random garbage generation or generate the garbage deterministically, the games with your garbage generator will not be replayable by Blockstacker.

### Returning the functions

Similarly to other Lua scripts for Blockstacker, these functions should be returned at the end of your script. But since they aren't subscribing to any events, they should just be returned separated by a comma.

### Example script

You can find an example of a script that generates single holes, similarly to in-game `singles` setting for garbage generation [here](../Example%20files/singlesGenerator.lua).
