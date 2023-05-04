function NotificationText(text)
    SetNotificationTextEntry('STRING')
	AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, true)
end

function table.removeKey(table, key)
    local element = table[key]
    table[key] = nil
    return element
end