function GenerateGarbage(amount, message)
    while amount > 0 do
        amount = amount - 1
        local newHole
        if LastHole == -1 then
            -- if we didn't generate anything yet, just generate randomly
            newHole = math.random(Board.Width)
        else
            -- if we already generated something, this will generate
            -- a different number than last one
            newHole = ((LastHole + math.random(Board.Width - 1)) % Board.Width)
        end

        LastHole = newHole

        local newLine = {}
        for i = 1, Board.Width do
            -- put a garbage block everywhere except the randomly generated hole
            table.insert(newLine, newHole ~= i)
        end

        -- board is expecting a table of tables, since we can generate
        -- more lines at once, so we pack it here

        -- the false is for adding to last layer.
        -- this is important for connected skins, since skin needs to know
        -- which minos to connect with
        Board:AddGarbageLayer({ newLine }, false)
    end
end

function Reset(seed)
    LastHole = -1
    math.randomseed(seed)
end

LastHole = -1

return GenerateGarbage, Reset
