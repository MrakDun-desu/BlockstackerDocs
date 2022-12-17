Stat counting is an essential part of any game, so the players knows what they're doing right and wrong, what they could make better and when precisely are they doing what.

In UStacker, there is a variety of preprogrammed stat counters and users can also write their own stat counters, based on receiving messages about game events.

## Using default stat counters

In game stat counting menu, you can see stat counting groups. Every group can be picked in the game settings and then the counters inside of it will be shown during the gameplay.

Some stat counters are only relevant to certain game types, so this is why there is a group for every game type. You can make any number of your own groups and then pick them in the game settings menu.

After you have picked a group and started the game, you can see the stat counters on their positions. Stat counter positions are relative to the 0,0 coordinate of the board and are sized by blocks. They are also children of the board - this means that if you move the board or resize it, they will retain their relative position. In future versions of UStacker, this will be optional and you'll be able to have some stat counters that stick to the screen.

During gameplay, you can reposition and resize your stat counters. These alterations will be saved into the game settings when you quit your game and will be used next time you play.

Handles for resizing and moving are only visible when your mouse is above the stat counter. You can see them like this:

![Stat counter reference](/Images/stat_counter_handles.png)

Top left handle is used for resizing the stat counter and bottom left for moving it.

By default, stat counter text scales with the stat counter itself, but some custom stat counters could have static or animated text scale.

### Stat counter reference

In the stat counting settings, you can see various options for your stat counters. Here you can look up what they mean:

- Position - where the stat counter will be positioned (bottom right corner in blocks). First field is x position, second field is y position.
- Size - how big the stat counter will be (distance from bottom right corner to top left corner in blocks). First field is distance from right to left, second field the distance from bottom to top.
- Update interval - if the stat counter updates regularly and not just when a game event happens, this value is the time in seconds between each regular update. If you have too many stat counters, increasing the update interval might improve the performance of the game slightly. If the stat counter doesn't update regularly, this value has no meaning.

## Using custom stat counters

To use a custom stat counter, you'll need to create a directory `statCounters` in the application persistent data path.

Each stat counter is a script that displays one or more stats. In the future, stat counters will also be able to save custom stats to show in the game ended screen.

### Loading a premade custom stat counter

1. Copy the stat counter file into the `statCounters` directory.
2. In settings, choose or create a stat counter group that will use your custom counter.
3. Add a stat counter to it and choose `custom` as the stat counter type.
4. After selecting `custom`, two new fields should appear - stat counter name and stat counter filename. For the name, just choose whatever you think is right. For filename, you should type exactly the filename that you added into the `statCounters` directory, including the extension. In the future, you'll be able to pick from a dropdown.
5. After choosing a game to play, choose your new group as stat counter group for that game.
6. You should now be able to see the stat counter working. If there are any errors during execution, UStacker will display an alert and shut down the stat counter.

### Creating a custom stat counter

1. Think up your stat counter name and create a Lua script with that name.
2. Write the stat counter script so that the game can use it. Explained [here](#how-to-write-a-stat-counter-script).
3. Copy the stat counter file into the `statCounters` directory.
4. In settings, choose or create a stat counter group that will use your custom counter.
5. Add a stat counter to it and choose `custom` as the stat counter type.
6. After selecting `custom`, two new fields should appear - stat counter name and stat counter filename. For the name, just choose whatever you think is right. For filename, you should type exactly the filename that you added into the `statCounters` directory, including the extension. In the future, you'll be able to pick from a dropdown.
7. After choosing a game to play, choose your new group as stat counter group for that game.
8. You should now be able to see the stat counter working. If there are any errors during execution, UStacker will display an alert and shut down the stat counter.

### How to write a stat counter script

Stat counter script decides what events to accept and what value to display when they arrive. Registering events works in the universal UStacker way. You can read about this way [here](../UStackerDocs/Game-events.md#subscribing-to-the-events). You can subscribe to every game event that is listed on the event page.

For stat counters, there is one more available event: `CounterUpdated` event. This event sends no message and its only purpose is to enable stat counters that are updated regularly, not only when game events are triggered. You can subscribe to this event as you would subscribe to any other event in the returned table.

You can display values by returning string values from your event functions.

#### Predefined values

Stat counter script has 3 predefined values:

1. [`StatUtility`](#stat-utility) - utility C# object to help working with stats
2. [`Stats`](#stats) - default counted stats in the game. If you just want to display the default stats, you don't have to count them yourself.
3. [`Board`](#board) - board of the currently played game.

##### Stat utility

`StatUtility` is an object that you can use to call some useful functions that aren't available in Lua by default. Functions are all accessed by the `:` notation.

These are the available utility functions in UStacker 0.3:
- `GetCurrentTime()` - will return the current time since the start of the game in seconds as a double.
- `FormatTime(seconds)` - will return a nicely formatted string of the time you pass in.
- `GetFormattedTime()` - will return a nicely formatted string of the current time. Calling this is equal to calling `StatUtility:FormatTime(StatUtility:GetCurrentTime())`.
- `FormatNumber(number, decimals)` - will return a rounded string of the number you pass in in the `number` parameter. `decimals` is optional and 2 by default. It's the number of digits after the decimal point that will be visible in the output. The number of decimals will always be equal to this. For instance, if you pass in number `3.2`, but the number of decimals is 2 by default, it will return `"3.20"`.

##### Stats

`Stats` are the default stats the game counts by itself. If stat is available here, you don't need to count it in your script, just display it in your preferred way.

All the stats are accessed by the `.` notation.

Stats that are available in UStacker 0.3:
- Score - 64bit integer
- Level - string
- LinesCleared - unsigned 32bit integer
- PiecesPlaced - unsigned 32bit integer
- KeysPressed - unsigned 32bit integer
- Singles - unsigned 32bit integer
- Doubles - unsigned 32bit integer
- Triples - unsigned 32bit integer
- Quads - unsigned 32bit integer
- Spins - unsigned 32bit integer
- MiniSpins - unsigned 32bit integer
- SpinSingles - unsigned 32bit integer
- SpinDoubles - unsigned 32bit integer
- SpinTriples - unsigned 32bit integer
- SpinQuads - unsigned 32bit integer
- MiniSpinSingles - unsigned 32bit integer
- MiniSpinDoubles - unsigned 32bit integer
- MiniSpinTriples - unsigned 32bit integer
- MiniSpinQuads - unsigned 32bit integer
- LongestCombo - unsigned 32bit integer
- LongestBackToBack - unsigned 32bit integer
- AllClears - unsigned 32bit integer
- Holds - unsigned 32bit integer
- GarbageLinesCleared - unsigned 32bit integer
- PiecesPerSecond - double precision float
- KeysPerPiece - double precision float
- KeysPerSecond - double precision float
- LinesPerMinute - double precision float

##### Board

Board is your interface to the board that you're currently counting stats for. It's a reference to the in-game C# game object which has multiple fields you can use.

You access fields with the `.` notation.

Fields available in UStacker 0.3:
- `Board.Width` - width of the board in blocks
- `Board.Height` - height of the board in blocks
- `Board.LethalHeight` - height that has been set in the game settings to be lethal. Is relevant only for certain topout conditions by itself.
- `Board.GarbageHeight` - height of garbage that is currently on the board.
- `Board.Slots` - list of lists of boolean values. Each inner list is one line on the board. Each boolean value is true if that slot is filled and false if it is not. 

Note: `Board.Slots` is dynamic, so if there are no blocks on the board, the `Slots` field will contain no lines.
Note: Indexing in Lua starts from 1, but when accessing objects which are taken from C#, this isn't the case. So instead of indexing `Board.Slots` from `1` to `Slots.Count`, you need to index from `0` to `Slots.Count - 1`.

#### Callable functions

Other than functions in predefined values, you can also call functions that have been registered before running your script.

Functions available in UStacker 0.3:

- `SetText(text)` - this is the same as returning the string from your event function. It will set the text of your stat counter. You can use this when the script is ran for the first time to display some default value before any messages arrive.
- `SetVisibility(visibility)` - set visibility of your displayed text. 0 is for invisible, 1 for completely opaque. If any visibility animation is happening, this will cancel it.
- `SetColor(color)` - set color of your displayed text. Accepts common HTML notation for hex colors - #rrggbb or #rrggbbaa. If any color animation is happening, this will cancel it.
- `SetTextSize(size)` - set the size of text manually. Size is in blocks, so setting it to some small value is probably better to start off.
- `SetAlignment(alignment)` - set the alignment of your text. Supported values are: `"left"`, `"right"`, `"center"`, `"top"`, `"bottom"`, `"middle"`.
- `AnimateVisibility(visibility, duration)` - animates the visibility of the text for the next `duration` seconds. If visibility animation is running, calling it again will cancel it and start the new animation. 
- `AnimateColor(color, duration)` - animates the color ofthe text for the next `duration` seconds. If color animation is running, calling it again will cancel it and start new animation.

#### Registering events

Registering events in a stat counter works the universal UStacker way. You can read about this way [here](/Game-events.md#subscribing-to-the-events).

You can subscribe to every game event that is listed on the event page and additionally to the `CounterUpdated` event that will be called depending on the timestep set in the stat counting settings.

#### Examples

There are several expamples of stat counters in the Example files directory. Here is the index:

- [Pieces counter](Example%20files/piecesCounter.lua)
- [All clears counter](Example%20files/allClearsCounter.lua)
- [Level counter](Example%20files/levelCounter.lua)
- [All clears action text](Example%20files/actionTextAllClear.lua)
