To use a custom rotation system, you'll need to create a directory `rulesCustomization/rotationSystems` in the application persistent data path.

**Important note: All custom rotation systems must have the extension .json**

## Loading a premade rotation system

1. Copy the rotation system file into the `rotationSystems` directory.
2. In the custom game settings, under General, pick "Custom" as your rotation system type.
3. In the custom rotation system dropdown, the new rotation system should now be found by its filename without extension.

## Creating a custom rotation system

1. Think up your own rotation system name and create a JSON file with that name.
2. Write the rotation system so that the game can use it. Explained [here](#how-to-write-a-custom-rotation-system).
3. Copy the rotation system file into the `rotationSystems` directory.
4. In the custom game settings, under General, pick "Custom" as your rotation system type.
5. In the custom rotation system dropdown, the new rotation system should now be found by its filename without extension.

## How to write a custom rotation system

Rotation system is essentially just a collection of kick tables for different piece types. In block stacker, kick table doesn't just contain different possible kicks, but also the starting state of the piece and full-spin kicks.

Starting state is an enum which has 4 possible values:

- 0 - initial state
- 1 - rotated 90 degrees counterclockwise
- 2 - rotated 180 degrees
- 3 - rotated 90 degrees clockwise

This will change how the piece will spawn, but not how it will appear in queue (as of Blockstacker version 0.3, might change in the future).

Full spin kicks are both vectors with x and y fields for the kick values.

After full-spins and start state, you need to define the kicktables themselves. Each kicktable is a list of vectors with x and y fields for the kick values. X is the value by which the piece will move in horizontal axis and y is the value by which the piece will move in vertical axis.

There is one kicktable for every possible combination of spin states. That makes it 12 kicktables - 4 for spins clockwise, 4 for spins counterclockwise and 4 for 180 spins.

After defining kick tables for every piece you need to have differentiated from others, there is also the default table - this will be used for every other piece.

Usually, default table works for every piece with the exception of i piece. That means that in the default table, you need to define the table that will be shared among all pieces and in `KickTables` dictionary of your rotation system, only the key of `"i"` will be defined.

You can find an example of a rotation system [here](../Example%20files/superRotationSystem.json). This is identical to the SRS system that the game uses by default.

### How spins work in blockstacker

Every time you rotate a piece in game, the piece will try all the kicks in its kick table, depending to start state and potential ends state. It will use the first kick that works without overlapping the piece with other blocks on board or moving the piece beyond the board's borders.

In the default systems, the first kick is always 0,0. This means that the piece will try to rotate around its pivot point and not move at all. If this is not successful, other kicks will be tried next.

At the end of this file, you can find a [spin reference](#blockstacker-spin-reference). Every piece pivot is documented there.

Next, if you have spins for that particular piece type turned on, the game will decide if this spin could count as a "spin clear". This is a special type of clear that (in most scoring systems) awards more points. In official **Tetris** games, this only applies to purple t pieces. In Blockstacker, you can achieve a spin with any piece.

### Detecting spins

Every piece has designated "spin detectors" and "full spin detectors". Also a minimum of "spin detectors" for the placement to count as spin. For it to count as full spin, all "full spin detectors" must be satisfied. 

Spin detector is satisfied if there is a block on board where that detector is, or if board ends there. Every full spin detector is also a normal spin detector.

At the end of this file, you can find a [spin reference](#blockstacker-spin-reference), but there is one reference here for simplicity.

![T reference](/Images/t_reference.png)

In this picture, you can see the reference for a t piece. The gray circles are normal spin detectors and gray diamonds are full spin detectors.

Spin detector count for a t piece is 3. So at least 3 of spin detectors must be filled by blocks to count as a spin.

For a full spin, both of the diamonds, full spin detectors, must be filled. So for full spin, you need to fill at least one of the gray circles and both of gray diamonds. If you fill 3 spin detectors but not both full spin detectors, clear will count as a spin mini.

There is an exception for this. If special full spin kicks are used, every spin will count as a full spin, even if it normally would be just a spin mini.

In SRS, these special kicks are:

```json
[
    {
        "x": -1,
        "y": -2
    },
    {
        "x": 1,
        "y": -2
    }
]
```

## Blockstacker spin reference

### I piece

Spin detector count: 5

Image reference:

![I reference](/Images/i_reference.png)

### J piece

Spin detector count: 3

Image reference:

![J reference](/Images/j_reference.png)

### L piece

Spin detector count: 3

Image reference:

![L reference](/Images/l_reference.png)

### O piece

Spin detector count: 7

Image reference:

![O reference](/Images/o_reference.png)

### S piece

Spin detector count: 3

Image reference:

![S reference](/Images/s_reference.png)

### T piece

Spin detector count: 3

Image reference:

![T reference](/Images/t_reference.png)

### Z piece

Spin detector count: 3

Image reference:

![Z reference](/Images/z_reference.png)
