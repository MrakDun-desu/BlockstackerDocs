To use custom backgrounds, you'll need to create a directory `styleCustomization/backgroundPacks` in the application persistent data path. This directory can also be created and opened from the in-game customization settings.

## Loading a premade background pack

1. Copy the background pack source directory into the `backgroundPacks` directory. Be sure to rename the background pack if you have one with the same name already.
2. Pick your background pack in the game customization settings and wait for it to load.

## Creating a custom background pack

1. Think up your own background pack name and create a directory named after it in the `backgroundPacks` directory.
2. Put your background files in your background pack directory and name them accordingly. These are [currently supported changeable backgrounds](#background-names).
3. Pick your background pack in the game customization settings and wait for it to load.

## Background names
You can customize your backgrounds separately for each scene. Create a directory for scene you want to customize (`default`, if you want this background used in all scenes) and name it according to this table. When the scene is loaded, background will be randomly picked from one of the files in the according directory. Background names **are case sensitive**.

|     Scene     | Background name  |
| :-----------: | :--------------: |
|  All scenes   |    `default`     |
|   Main menu   |    `mainMenu`    |
|   Settings    | `globalSettings` |
| Game settings |  `gameSettings`  |
|  Custom game  |   `gameCustom`   |

You can also just use single file instead of a directory. In this case, the file will need to be named accordingly (except for extension). If you have both the background file and directory defined, the game will pick one at random - the backgrounds are loading asynchronously and whichever the game picks last will be the one used.

### Examples

Your background pack could look like this. Here, backgrounds from the default folder will be used in every scene except for main menu. In main menu, only the single image will be used.

![image](https://user-images.githubusercontent.com/39689572/173807513-67ba5938-d598-46fd-b186-6a5de3fb7359.png)

## Supported background formats

Still backgrounds:
1. `.png`
2. `.jpg`

Video backgrounds: 
1. `.mp4`

(even in video backgrounds with sound, sound will not be played)

During testing, some Unity warnings with videos were encountered, so be aware that game might not behave correctly if using a video background.

Other video formats should be supported by Unity, but .mp4 is the only tested format so far. BlockStacker uses Unity's video player to render video backgrounds, so you can look up your options <a href="https://docs.unity3d.com/Manual/VideoSources-FileCompatibility.html" target="_blank">here</a>.