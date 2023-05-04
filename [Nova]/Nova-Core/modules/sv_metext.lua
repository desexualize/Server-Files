-- ## 3dme : server side

-- Command
RegisterCommand('me', function(source, args)
    local text = "".. table.concat(args, " ") .. ""
    TriggerClientEvent('3dme:shareDisplay', -1, text, source)
end)
