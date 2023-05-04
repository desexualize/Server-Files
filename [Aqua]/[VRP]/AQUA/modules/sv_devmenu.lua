RegisterServerEvent('AQUA:opendevmenu')
AddEventHandler('AQUA:opendevmenu', function()
    local source = source
    local user_id = AQUA.getUserId(source)
    if user_id == 1 or user_id == 19 then
      AQUAclient.opendevelopermenu(source,{})
    end
end)