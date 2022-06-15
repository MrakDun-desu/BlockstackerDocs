To use a custom sound pack, you'll need to create a directory `styleCustomization/soundPacks` in the application persistent data path. This directory can also be created and opened from the in-game customization settings.

Sound customization is divided into 2 parts - music and sound effects. You can customize them separately.

## Creating a custom sound pack

1. Think up your own sound pack name and create a directory named after it in the `soundPacks` directory.
2. If you want to customize music, put your music files into the `music` directory within your soundpack directory. Music can also be customized further by [creating a `musicConf.json` file](#musicConf.json-file) in the `music` directory.
3. If you want to customize sound effects, put your sound effects files into the `soundEffects` directory within your soundpack directory. Sound effects can also be customized further by [creating a `soundEffects.lua` script](#soundEffects.lua-script) in the `soundEffects` directory. 
4. Pick your sound pack in the game customization settings and wait for it to load.

## Loading a premade sound pack

1. Copy the sound pack source directory into the `soundPacks` directory.
2. Pick your sound pack in the game customization settings and wait for it to load.

## `musicConf.json` file

## `soundEffects.lua` script

This lua script can affect which sound effects will be played in-game depending on events that trigger them. At the end of your script, you need to define which events you will subscribe to. Each event needs a handler function that takes one parameter, which will be sent to you by the game. Parameter type will be different for each event.

Here is a table of available events.
| Event description | Event name | 
|:--------|:---------|
| Piece has been placed | `PiecePlaced` | 

