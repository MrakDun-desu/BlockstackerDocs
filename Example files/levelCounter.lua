Name = ""
Current = ""
Total = ""
Level = "0"
function OnConditionChange(message)
    Name = message.ConditionName
    if Name == nil or Name == "None" or Name == "" then
        return ""
    end
    Current = StatUtility:FormatNumber(message.CurrentCount, 0)
    Total = StatUtility:FormatNumber(message.TotalCount, 0)
    return FormatOutput()
end

function OnLevelChange(message)
    Level = message.Level
    if Level == nil or Level == "None" or Level == "" then
        return ""
    end
    return FormatOutput()
end

function FormatOutput()
    return "Level " .. Level .. "\n" .. Current .. "/" .. Total .. " " .. Name .. " to next"
end

SetText("")
return {
    ["LevelUpConditionChanged"] = OnConditionChange,
    ["LevelChanged"] = OnLevelChange
}
