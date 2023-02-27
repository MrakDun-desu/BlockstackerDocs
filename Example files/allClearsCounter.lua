function Reset(message)
    if message.NewState:ToString() == "Initializing" then
        return "All clears: 0"
    end
end

function OnPiecePlaced()
    return "All clears: " .. Stats.AllClears
end

SetText("All clears: 0")
SetAlignment("left")
return {
    ["PiecePlaced"] = OnPiecePlaced,
    ["GameStateChanged"] = Reset
}
