To use a custom sound pack, you'll need to create a directory `styleCustomization/soundPacks` in the application persistent data path. This directory can also be created and opened from the in-game customization settings.

Sound customization is divided into 2 parts - music and sound effects. You can customize them separately.

## Creating a custom sound pack

1. Think up your own sound pack name and create a directory named after it in the `soundPacks` directory.
2. If you want to customize music, put your music files into the `music` directory within your soundpack directory. Music can also be customized further by [creating a `musicConfig.json` file](#musicConfigjson-file) in the `music` directory.
3. If you want to customize sound effects, put your sound effects files into the `soundEffects` directory within your soundpack directory. You can read which sound effects you can customize [here][#available-sound-effects]. Sound effects can also be customized further by [creating a `soundEffects.lua` script](#soundEffectslua-script) in the `soundEffects` directory. 
4. Pick your sound pack in the game customization settings and wait for it to load.

## Loading a premade sound pack

1. Copy the sound pack source directory into the `soundPacks` directory.
2. Pick your sound pack in the game customization settings and wait for it to load.

## `musicConfig.json` file

This json file enables you to customize what music plays in each part of the game. By default, all custom music you add will be only played in game. If you use this configuration, you can customize your menu music, victory and lose music and also create groups to choose from when playing different game types.

### Example file

```json
{
    "MenuMusic": [
        "myMenuMusic1",
        "myMenuMusic2"
    ],
    "VictoryMusic": [
        "myVictoryMusic"
    ],
    "LossMusic": [
        "myLossMusic"
    ],
    "GameMusicGroups": {
        "Relax": [
            "relaxingMusic1",
            "relaxingMusic2"
        ],
        "Tryhard": [
            "tryhardMusic1",
            "tryhardMusic2"
        ]
    }
}
```

If you put your music tracks into any of the lists except for `GameMusicGroups` list, it will not be played during the gameplay but instead at the specified occasion. `MenuMusic` will be played in menus, `VictoryMusic` when you successfully finish a game and `LossMusic` when you lose the game.

`GameMusicGroups` will help you when trying to achieve a certain feel in your game. Before the game, you can choose if the music should be played randomly, randomly from one of the groups or if just one track should repeat. You can organize your tracks by the feel and then pick relaxing track group, tryhard track group or different groups that you would like. You can have as many different groups as you want.

If you do not specify one of these values, the default will be used. If you specify a track name that wasn't loaded or isn't in the game by default, it will be removed from the configuration upon loading (the configuration file will not be rewritten).

## Available sound effects

By default, game plays these sound effects:

| Clip name            | When the clip is played                                                        |
| :------------------- | :----------------------------------------------------------------------------- |
| spin                 | When a spin happens                                                            |
| rotate               | When normal rotation (non-spin) happens                                        |
| move                 | When piece is moved left or right                                              |
| softdrop             | When piece is moved down with softdrop                                         |
| hold                 | When piece is successfully held                                                |
| allclear             | When all-clear occurs                                                          |
| floor                | When piece is dropped                                                          |
| clearspin            | When a spin is cleared                                                         |
| combobreak           | When a combo is broken                                                         |
| btb_break            | When back-to-back is broken                                                    |
| clearline            | When one to three lines are cleared without a spin and without combo           |
| clearquad            | When 4 lines are cleared                                                       |
| finish               | When the game successfully ends                                                |
| death                | When player tops out (loses)                                                   |
| i                    | When the "Hear next pieces" setting is set to true and the next piece is i     |
| j                    | When the "Hear next pieces" setting is set to true and the next piece is j     |
| l                    | When the "Hear next pieces" setting is set to true and the next piece is l     |
| o                    | When the "Hear next pieces" setting is set to true and the next piece is o     |
| s                    | When the "Hear next pieces" setting is set to true and the next piece is s     |
| z                    | When the "Hear next pieces" setting is set to true and the next piece is z     |
| t                    | When the "Hear next pieces" setting is set to true and the next piece is t     |
| countdown{number}    | When the countdown ticks with number + 1 ticks remainig                        |
| combo_{number}       | When one to three lines are cleared without a spin, with combo equal to number |
| combo_{number}\_power| When either spin or a quad is cleared with a combo equal to number            |

In default sound effects, game has 5 countdown clips. When countdown larger than 5 ticks, the sound effect countdown5 is played.

In default sound effects, game has 16 combo clips. When combo larger than 16 happens, the sound effect combo_16 or combo_16_power is played depending on type of the line clear.

## `soundEffects.lua` script

This lua script can affect which sound effects will be played in game depending on events that trigger them. In your script, you need to define which events you will subscribe to. Each event needs a handler function that takes one parameter, which will be sent to you by the game.

You can read more about game events [here](Game-events.md).

Here is a list of available events:
- `CountdownTicked`
- `GameEnded`
- `GameLost`
- `GamePaused`
- `GameRestarted`
- `GameResumed`
- `GameStarted`
- `HoldUsed`
- `InputAction`
- `PieceMoved`
- `PiecePlaced`
- `PieceRotated`
- `PieceSpawned`

In function that handles each of these events, you can use the message to pick an audio clip that shoud play. Each audio clip is identified by its name, a simple string. You can use any of the default clips and all clips that you have in your sound pack `soundEffects` directory. Note that you need to identify the clip without the extension.

You can make the game play sounds by two means - either returning a string name of the clip in your handler function, or by calling a function with the string name. You have 2 available functions - `Play` and `PlayAsAnnouncer`. `Play` will just play the clip and not cancel any other clips that have been played before. `PlayAsAnnouncer` will stop the previous clip that you played using this function and start the new clip. This is useful if you want to have an annoucer (hence the name of the function). If the voicelines were are too long and go over each other, you can cancel the previous one using this method.

You can play multiple sounds at once by returning more than one string value, or by calling `Play` multiple times in your handler function. For example, if you have audio clips that are stored in files `single.mp3`, `double.ogg`, `triple.wav`, you would choose one of them by returning a string `"single"`, `"double"` or `"triple"`. If you had a spin sound in `spin.mp3` that you'd like to play as well, you would return `"spin", "double"`. Alternatively, you can just call the `Play` function, like so:
```lua
Play("spin")
Play("double")
```

If you attempt to return a name of a clip that is not loaded, the game will show you a warning that you attempted to play a non-existent sound. 

Using multiple files with same name but a different extension is discouraged, as the game will load just one of them at random due to asynchronous loading.

If you want to write your own sound effects script, you can start with [this example script](/Example%20files/soundEffects.lua). This script exactly replicates the default game sound effects.

## Accepted audio formats

As BlockStacker-desu uses Unity to import audio, it supports the same formats. 

- mp3
- ogg
- wav
- aif/aiff
- mod
- s3m
- xm

These are formats officially supported by Unity. You can read more [here](https://docs.unity3d.com/Manual/AudioFiles.html).


