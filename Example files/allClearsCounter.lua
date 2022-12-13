function Reset()
    AllClears = 0
    return "All clears: 0"
end

function OnPiecePlaced(message)
    if message.WasAllClear then
        AllClears = AllClears + 1
    end
    return "All clears: " .. AllClears
end

SetText(Reset())
SetAlignment("left")
return {
    ["PiecePlaced"] = OnPiecePlaced,
    ["GameStarted"] = Reset,
    ["GameRestarted"] = Reset
}
