Lua is the language used for UStacker scripts. For safety and user convenience, some functionality is changed or removed.

## Removed functionality

All these global variables normally available in Lua are set to `nil` in UStacker for safety:
- `os`
- `io`
- `require`
- `dofile`
- `package`
- `luanet`
- `load`

If you try to use any of these, you will get an error.

## Changed functionality

`math.random` works differently in UStacker than in normal Lua. Function signatures all the same and they produce the same results, but instead of using normal Lua randomizer, it is replaced by UStacker randomizer. This means that when you call the function random, you will be calling C# code.
Thanks to this, random seed is also set automatically before every game. You don't have to set it yourself.

**Note: Since the random seed is set automatically to the external random object, calling `math.randomseed` will have *no effect* in any UStacker script.**

## Added functionality

For debugging purposes, you can call the function `DebugLog(obj)`. This function will append your message along with timestamp of your current time to the `logs.txt` file in the persistent data path.