function Reset(message)
    if message.NewState:ToString() == "Initializing" then
        return FormatOutput()
    end
end

function FormatOutput()
    local pps = Stats.PiecesPerSecond
    local piecesPlaced = Stats.PiecesPlaced
    return "Pieces: " .. piecesPlaced .. "\nPPS: " .. StatUtility:FormatNumber(pps)
end

SetText(FormatOutput())
return {
    ["CounterUpdated"] = FormatOutput,
    ["PiecePlaced"] = FormatOutput,
    ["GameStateChanged"] = Reset
}
