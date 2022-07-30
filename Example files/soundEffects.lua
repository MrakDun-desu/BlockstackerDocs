function HandlePiecePlaced(message)
    local output = {}
    if message.WasAllClear then
        table.insert(output, "allclear")
    end

    if message.LinesCleared == 0 then
        if message.BrokenCombo then
            table.insert(output, "combobreak")
        end

        table.insert(output, "floor")
    elseif message.LinesCleared > 0 and message.LinesCleared < 4 then
        if message.WasSpin or message.WasSpinMini then
            if message.CurrentCombo == 0 then
                table.insert(output, "clearspin")
            elseif message.CurrentCombo < 16 then
                table.insert(output, "combo_" .. tostring(message.CurrentCombo) .. "_power")
            elseif message.CurrentCombo >= 16 then
                table.insert(output, "combo_16_power")
            end
        else
            if message.BrokenBackToBack then
                table.insert(output, "btb_break")
            end

            if message.CurrentCombo == 0 then
                table.insert(output, "clearline")
            elseif message.CurrentCombo < 16 then
                table.insert(output, "combo_" .. tostring(message.CurrentCombo))
            elseif message.CurrentCombo >= 16 then
                table.insert(output, "combo_16")
            end
        end
    elseif message.LinesCleared == 4 then
        if message.CurrentCombo == 0 then
            table.insert(output, "clearquad")
        elseif message.CurrentCombo < 16 then
            table.insert(output, "combo_" .. tostring(message.CurrentCombo) .. "_power")
        elseif message.CurrentCombo >= 16 then
            table.insert(output, "combo_16_power")
        end
    end


    return table.unpack(output)
end

function HandlePieceRotated(message)
    if message.WasSpin or message.WasSpinMini then
        return "spin"
    end
    return "rotate"
end

function HandlePieceMoved(message)
    if message.X ~= 0 then
        return "move"
    elseif message.Y ~= 0 and message.WasSoftDrop then
        return "softdrop"
    elseif message.Y ~= 0 and message.WasHardDrop then
        return "harddrop"
    end
end

function HandleHoldUsed(message)
    if message.WasSuccessful then
        return "hold"
    end
end

function HandlePieceSpawned(message)
    if message.NextPiece ~= "" then
        return message.NextPiece
    end
end

function HandleCountdownTicked(message)
    if message.RemainingTicks >= 4 then
        return "countdown5"
    end

    return "countdown" .. tostring(message.RemainingTicks)
end

function HandleGameLost(message)
    return "death"
end

function HandleGameEnded(message)
    return "finish"
end

return {
    ["PiecePlaced"] = HandlePiecePlaced,
    ["PieceRotated"] = HandlePieceRotated,
    ["PieceMoved"] = HandlePieceMoved,
    ["HoldUsed"] = HandleHoldUsed,
    ["PieceSpawned"] = HandlePieceSpawned,
    ["CountdownTicked"] = HandleCountdownTicked,
    ["GameLost"] = HandleGameLost,
    ["GameEnded"] = HandleGameEnded,
}
