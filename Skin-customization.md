To use a custom skin, you'll need to create a directory `styleCustomization/skins` in the application persistent data path. This directory can also be created and opened from the in-game customization settings.

## Creating a custom skin

1. Think up your own skin name and create a directory named after it in the `skins` directory.
2. Create the skin files.
3. Create a `skinConfig.json` file and specify how your skins should work. Explained [here](#skinConfigjson-file).
4. Put your skin files in your skin directory.
5. Pick your skin in the game customization settings and wait for it to load.

## Loading a premade skin

1. Copy the skin source directory into the `skins` directory.
2. Pick your skin in the game customization settings and wait for it to load.

## `skinConfig.json` file

This file contains all information on how the skins should be loaded and then processed. You can pick skins for all different types of blocks and even individually for each block in the piece if you want.

`skinConfig.json` is a collection of skin records. You'll need to specify one record for each different skin that you'd like to load. One record looks like this:

```json
{
    "SkinType": "i",
    "BlockNumbers": [0, 1, 2, 3],
    "Layer": 0,
    "IsConnected": false,
    "RotateWithPiece": false,
    "AnimationFps": 60.0,
    "Sprites": [
        {
            "Filename": "skin.png",
            "LoadFromUrl": false,
            "PixelsPerUnit": 30.0,
            "PivotPoint": {
                "x": 0.5,
                "y": 0.5
            },
            "SpriteStart": {
                "x": 186.0,
                "y": 0.0
            },
            "SpriteSize": {
                "x": 30.0,
                "y": 30.0
            }
        }
    ],
    "ConnectedSprites": [
        {
            "ConnectedEdges": 7,
            "Sprites": []
        }
    ],
}
```

Explanation of each field:
### `SkinType`
Type of the block that this will be applied to. Currently valid values are:
- "z" - Z piece blocks
- "l" - L piece blocks
- "o" - O piece blocks
- "s" - S piece blocks
- "i" - I piece blocks
- "j" - J piece blocks
- "t" - T piece blocks
- "usedHold" - blocks in hold piece when it's not available
- "ghost" - ghost piece blocks
- "warning" - warning blocks that signal the spawning position of next piece
- "grid" - blocks of the board grid
### `BlockNumbers` 
Array of numbers that this skin will be applied to. Works for every skin except for the grid, where all blocks are treated as number 0. Is set to `[0, 1, 2, 3]` by default (all blocks in piece). Accepts arrays of unsigned integers.
### `Layer` 
In case there are multiple skins for this block, layer on which this skin should be rendered on. The higher number, the higher priority of skin rendering. Is set to 0 by default. Accepts integer values.
### `IsConnected`
If this skin is in connected format, should be set to true. In that case the sprites will be read from the `ConnectedSprites` instead of `Sprites` field. Is set to `false` by default. Accepts boolean values.

### `RotateWithPiece`
If this skin should rotate when piece rotates, should be set to true. Is set to false by default. Accepts boolean values.

### `AnimationFps`
If this skin is animated, this is the amount of frames per second that will it will be animated at. Skin is treated as animated by specifying multiple sprites in the `Sprites` field (in case of connected skin, each connected part can be animated as well). Is set to 60 by default. Accepts floating point values.

### `Sprites`
Array of sprite records that are used in this skin. If the skin is not animated, should be array with one value. If the skin is connected, should be left empty. This field is an array of objects and each object has these fields:

#### `Filename`
Path to the file in which this sprite is present in. If `LoadFromUrl` is set to false, this is treated as relative path in skin folder. If `LoadFromUrl` is set to true, this is treated as a URL and will try to load sprite from the internet. If the file is not found, it is treated as if the sprite record did not exist. Is set to false by default. Accepts string values.

#### `LoadFromUrl`
Specifies if the skin should be loaded from URL or from relative path in current skin folder. Accepts boolean values.

<span style="color: red">Note: if this is set to true, skins are loaded from URL every time the application starts. Be sure to download the skin files if you don't have access to the internet all the time.</span>

#### `PixelsPerUnit`
Amount of pixels per unit (one block is exactly 1 by 1 unit). Accepts floating point values bigger than zero.

#### `PivotPoint`
Relative position within the sprite that will be treated as the center of the sprite. You can change this if you want to offset your skins. Is set to `{"x": 0.5, "y": 0.5}` by default. Accepts objects with x and y properties, each a floating point value between 0 and 1.

#### `SpriteStart`
Position within the image in pixels where the sprite is starting. Pixels are counted from bottom left of the image. Is set to `{"x": 0, "y": 0}` by default. Accepts objects with x and y properties, each a floating point value bigger than zero.

#### `SpriteSize`
Size of the sprite in pixels. Using `SpriteStart` and `SpriteSize`, sprites are sliced out of the images from which they are loaded. These values are counted from bottom left to top right. Is set to `{"x": 64, "y": 64}` by default. Accepts objects with x and y properties, each a floating point value bigger than zero.

### `ConnectedSprites`
Array of connected sprite records that are used in this skin. If this skin is not connected, should be left empty. Each value is an object with one `Sprites` field, which is the same as main `Sprites` field, and one `Edges` field.

`Edges` field is an integer between 0 and 255. It is a collection of bit flags for each of the edges and corners in a connected sprite.

These are the flags:
- 1 - Top 
- 2 - Left
- 4 - Right
- 8 - Bottom
- 16 - TopLeft
- 32 - TopRight
- 64 - BottomLeft
- 128 - BottomRight

If the flag is set, the sprite has an edge on that side/corner. For example, if the sprite has edges on top and left sides, the `Edges` field should be set to 3.

Corner flags (16 and higher) should be set only if the edge is only the corner, not adjacent sides. For example if the skin has top and left edges and bottom right corner, the `Edges` field should be set to 131, not 147.

## Templates for used skin formats

To make creating skins simpler, there are templates available for known skin formats. Here is the list of available templates:

- [Old TETR.IO](/Example%20files/oldTetrio.json)
- [New TETR.IO](/Example%20files/newTetrio.json)
- [New TETR.IO connected](Example%20files/newTetrioConnected.json)

Jstris is not included because it supports dynamically sized skins, which Blockstacker-desu does not. 

New TETR.IO and new TETR.IO connected are at the base size - 46 pixels per block.

## Supported file types

Supported file types are only `.jpg`, `.jpeg` and `.png` so far. Any other files won't be loaded.
