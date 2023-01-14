function GetNextPiece()
    -- if current values have been emptied, we need to initialize them
    if not next(CurrentValues) then
        InitializeCurrentValues()
    end

    local nextIndex = math.random(#CurrentValues)
    local nextValue = CurrentValues[nextIndex]
    table.remove(CurrentValues, nextIndex)
    return nextValue
end

function InitializeCurrentValues()
    for _, v in ipairs(ActualPieces) do
        table.insert(CurrentValues, v)
    end
end

function Reset()
    -- if there are values in current left, we need to remove them first
    local count = #CurrentValues
    for i = 0, count do CurrentValues[i] = nil end
    InitializeCurrentValues()
end

-- helper function to check if table contains a value
function TableContains(table, value)
    for _, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end

-- these are piece types that our randomizer wants to use
NeededPieces = { "i", "o", "t", "l", "j", "s", "z" };
-- these are piece types that we will actually be using
ActualPieces = {}
CurrentValues = {}

-- first we need to filter our needed pieces to see if AvailablePieces contain every value we need
for _, v in ipairs(NeededPieces) do
    if TableContains(AvailablePieces, v) and not TableContains(ActualPieces, v) then
        table.insert(ActualPieces, v)
    end
end

return GetNextPiece, Reset
