Client documentation for Blockstacker game. Here you can read about how to customize your game look, sound and even rules.

- [Used terms](#used-terms)
- [Skin Customization](#skin-customization)
- [UI Customization](#ui-customization)
- [Background Customization](#background-customization)
- [Sound Customization](#sound-customization)
- [Rule Customization](#rule-customization)
  - [Custom rotation systems](#custom-rotation-systems)
  - [Randomization customization](#randomization-customization)
    - [Randomizer guidelines](#randomizer-guidelines)
- [FAQ](#faq)

# Used terms
Application persistent data path is Unity's path to persistent data. On different operating systems:

| Operating system | Persistent data path                                           |
|:-----------------|:---------------------------------------------------------------|
| Windows          | %userprofile%\AppData\LocalLow\CloudStacking\BlockStacker-desu |
| Linux            | $HOME/.config/unity3d                                          |
| Mac              | ~/Library/Application Support/CloudStacking/BlockStacker-desu  |

Source: [Unity docs](https://docs.unity3d.com/ScriptReference/Application-persistentDataPath.html)

# Skin Customization

To be implemented.

# UI Customization

To be implemented.

# Background Customization

# Sound Customization

To be implemented.

# Rule Customization

## Custom rotation systems
You can define your own rotation systems in the persistent data path.
1. Create a directory called ruleCustomization/rotationSystems <!-- TODO: Refactor these names in the source -->
2. Add a file with a custom rotation system format
3. In game settings, rules, controls, put your rotation system file name into the `Rotation System Name` field.
4. In game settings, rules, controls, choose the option "Custom" in the `Rotation System` field.
5. Enjoy!

Rotation systems are comprised of 7 kicktables, one for each piece.
Kick tables have the format:
```json
{
    "StartState": [0-3],
    "ZeroToThree": [
        {
            "x": ?-[0-5],
            "y": ?-[0-5]
        },
        {
            "x": ...,
            "y": ...
        }
    ],
    "ZeroToOne": [
        {...}
    ]
    ...
}
```

Each possible rotation is defined here, including 180 rotations.
Rotation system then has the format:
```json
{
    "IKickTable": {},
    "TKickTable": {},
    ...
}
```
Kick tables are defined for each one piece to allow great customizability.

> You can also make the pieces be kicked even if they would have the space to rotate normally. That is because the kick tables also store the first attempt ("x": 0, "y": 0). Don't forget to include it, unless you want your pieces to rotate wildly!

> T piece kick table is a little special, because it determines how t-spins are evaluated. A full t-spin is evaluated if no kick happened, or if the kick that happened was the last one in the table.

<!-- TODO put an example here --->


## Randomization customization

You can customize the piece generation by making your own randomization script in the persistent data path.
1. Create a directory called ruleCustomization/randomizers
2. Add a Lua script that will adhere to the [guidelines](#rotation-system-guidelines)
3. In game settings, rules, general, put your randomizer file name into the `Custom Randomizer Name` field
4. In the game settings, rules, general, choose the option "Custom" in the `Randomizer Type` field.
5. On the game start, your rotation system will be validated and the game will not start if it is not valid.

### Randomizer guidelines

There are 2 important parts of your randomizer. First, the whole script will be loaded into the game state on the start of the game and you will recieve the value of the seed. Then, with each new piece spawn, the game will ask your script to provide a value corresponding to the next spawning piece.

The seed will be set in the `seed` global variable by the game.
The name of the function which will be called by the game is `GetNextPiece()`. It should always return a number between 0 and 6.

| Number | Corresponding piece |
|:-------|:--------------------|
| 0      | I Piece             |
| 1      | T Piece             |
| 2      | O Piece             |
| 3      | L Piece             |
| 4      | J Piece             |
| 5      | S Piece             |
| 6      | Z Piece             |

<!-- TODO put an example here --->

# FAQ

Why is appearance/sound customization divided into so many parts?
: To make it simpler to customize just a part of your game feel. You won't need to change anything about your backgrounds to make your sound configuration different, and the look of your blocks will have nothing to do with the look of your UI.
