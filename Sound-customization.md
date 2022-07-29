To use a custom sound pack, you'll need to create a directory `styleCustomization/soundPacks` in the application persistent data path. This directory can also be created and opened from the in-game customization settings.

Sound customization is divided into 2 parts - music and sound effects. You can customize them separately.

## Creating a custom sound pack

1. Think up your own sound pack name and create a directory named after it in the `soundPacks` directory.
2. If you want to customize music, put your music files into the `music` directory within your soundpack directory. Music can also be customized further by [creating a `musicConfig.json` file](#musicConfig.json-file) in the `music` directory.
3. If you want to customize sound effects, put your sound effects files into the `soundEffects` directory within your soundpack directory. Sound effects can also be customized further by [creating a `soundEffects.lua` script](#soundEffects.lua-script) in the `soundEffects` directory. 
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

If you put your music tracks into any of the lists except for `GameMusicGroups` list, it will not be played in the game but instead at the specified occasion. `MenuMusic` will be played in menus, `VictoryMusic` when you successfully finish a game and `LossMusic` when you lose the game.

`GameMusicGroups` will help you when trying to achieve a certain feel in your game. Before the game, you can choose if the music should be played randomly, randomly from one of the groups or if just one track should repeat. You can organize your tracks by the feel and then pick relaxing track group, fighting track group or different groups that you would like. You can have as many different groups as you want.

If you do not specify one of these values, the default will be used. If you specify a 
track name that wasn't loaded or isn't in the game by default, it will be removed from the configuration.

## `soundEffects.lua` script

This lua script can affect which sound effects will be played in-game depending on events that trigger them. In your script, you need to define which events you will subscribe to. Each event needs a handler function that takes one parameter, which will be sent to you by the game.

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

You can play multiple sounds at once by returning more than one string value.

For example, if you have audio clips that are stored in files `single.mp3`, `double.ogg`, `triple.wav`, you would choose one of them by returning a string `"single"`, `"double"` or `"triple"`. If you had a spin sound in `spin.mp3` that you'd like to play as well, you would return `"spin", "double"`.

Using multiple files with same name but a different extension is discouraged, as the game will load just one of them at random due to asynchronous loading.

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


