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

Most importantly, there are `Board.Width` and `Board.Height`. These are actual dimensions of the board. You will need to use `Board.Width` to decide how wide should the layers you generate be.

As an additional size variable, there's `Board.GarbageHeight`. It states how many lines of garbage currently are on the board.

You also have access to `Board.Slots`. This is the slots of the board, but only up to the height the board had been filled. So if you access `Board.Slots.Count`, it will give you the y position of highest block that's currently on board. Each of values in `Board.Slots` then has a count of exactly the board width. Every value in those lists is a bool, `true` if the slot is occupied by a block, `false` if not.

If you want to check which is the currently highest column on the board, you access the last line, which can be done by `Board.Slots[Board.Slots.Count - 1]` and check which of those values are true. Of course, if slots are empty, this will give you an error (slots always start up empty because there is nothing on the board in the start).

**Note: Indexing in Lua starts from 1, but when accessing objects which are taken from C# context, this isn't the case. So instead of indexing `Board.Slots` from 1 to `Slots.Count`, you need to index from 0 to `Slots.Count - 1`.**

Lastly and most importantly, there is a method `AddGarbageLayer()` on the `Board`. You can add garbage to the board by calling this method. Method takes two parameters:

- table of tables of bools. Inner tables should all have length of `Board.Width`. Each inner table is one line of garbage. Every bool inside the inner tables represents if a block should appear on that position or not.
- boolean value which tells the board whether to connect this layer to previous layer. This is important for connected skins, but otherwise has no meaning. If you choose to connect layers, they will appear connected when using a connected skin even though you didn't generate them at the same time.

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
