function Reset()
    PiecesPlaced = 0
    return "Pieces: 0\nPPS: 0"
end

function OnPiecePlaced()
    PiecesPlaced = PiecesPlaced + 1
    -- we don't need to return here since OnUpdated function
    -- is being called constantly anyways
end

function OnUpdated()
    local pps = Stats.PiecesPerSecond
    return "Pieces: " .. PiecesPlaced .. "\nPPS: " .. StatUtility:FormatNumber(pps)
end

SetText(Reset())
return {
    ["CounterUpdated"] = OnUpdated,
    ["PiecePlaced"] = OnPiecePlaced,
    ["GameStarted"] = Reset,
    ["GameRestarted"] = Reset
}
