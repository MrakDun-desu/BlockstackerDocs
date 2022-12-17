To use a custom randomizer, you'll need to create a directory `rulesCustomization/randomizers` in the application persistent data path.

**Important note: All custom randomizer files must have the extension .lua**

## Loading a premade randomizer

1. Copy the randomizer file into the `randomizers` directory.
2. In the custom game settings, under General, pick "Custom" as your randomizer type.
3. In the custom randomizer dropdown, the new randomizer should now be found by its filename without extension.
4. If the randomizer isn't valid, the game will tell you upon initialization.

## Creating a custom randomizer

1. Think up your own randomizer name and create a Lua script with that name.
2. Write the randomizer script so that the game can use it. Explained [here](#how-to-write-randomizer-script).
3. Copy the randomizer file into the `randomizers` directory.
4. In the custom game settings, under General, pick "Custom" as your randomizer type.
5. In the custom randomizer dropdown, the new randomizer should now be found by its filename without extension.
6. If the randomizer isn't valid, the game will tell you upon initialization.


## How to write randomizer script

The randomizer script needs to implement 2 functions - one for resetting the state of randomizer when a game starts and one for getting the next piece.

### Predefined values in your script

Before activating your script, UStacker will define the `AvailablePieces` variable. This is a table of strings that you will be able to return in your next piece function. If a piece name is defined here, that means that UStacker supports spawning this piece. As of version 0.3, the available pieces should be:

```lua
AvailablePieces = {"i", "o", "t", "l", "j", "s", "z"};
```

In future when there will be more pieces available, you should always check if this array contains your desired piece type. If you return a string that is not in this array or other type than string, your randomizer will not be valid and might cause undefined behavior (this will be fixed in future versions, where the game will end immediately after receiving such a value).

### Next piece function

This function is used to generate the next piece that will spawn in the game. It should return one of the string values that are contained in the `AvailablePieces` table that will be set by a global variable.

This function should receive no arguments and return one string value.

### Reset function

This function is used to reset the state of your randomizer to initialize the random number generator.

It should receive one argument that is the new seed for your randomizer and return no value.

It will be also called automatically after loading up your script to initialize the random state before asking for next piece the first time.

If you won't use the seed set by this function in your random number generation or don't generate numbers deterministically, the games with your randomizer will not be replayable by UStacker.

### Returning the functions

Similarly to other Lua scripts, these functions should be returned at the end of your script. But since they aren't subscribing to any events, they should just be returned separated by a comma.

### Example script

You can find an example of a script that generates similar random pieces as in-game seven bag randomizer [here](/Example%20files/sevenBagRandomizer.lua).
