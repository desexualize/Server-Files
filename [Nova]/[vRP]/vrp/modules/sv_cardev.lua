RegisterServerEvent("Nova:openCarDev")
AddEventHandler("Nova:openCarDev", function()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and (vRP.hasPermission(user_id, "cardeveloper.menu") or vRP.hasGroup(user_id, "founder")) then
      	TriggerClientEvent("Nova:CarDevMenu", source)
    end
end)

RegisterServerEvent("Nova:setCarDev")
AddEventHandler("Nova:setCarDev", function(status)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id ~= nil and (vRP.hasPermission(user_id, "cardeveloper.menu") or vRP.hasGroup(user_id, "founder")) then
		if status then
			SetPlayerRoutingBucket(source, 10)
		else
			SetPlayerRoutingBucket(source, 0)
		end
	else
		-- put anticheat ban here
	end
end)

RegisterServerEvent("Nova:takeCarScreenshot")
AddEventHandler(
  "Nova:takeCarScreenshot",
  function(spawncode, orientation)
    local source = source
    local user_id = vRP.getUserId(source)
    local name = GetPlayerName(source)
    if user_id ~= nil and vRP.hasPermission(user_id, "cardeveloper.menu") then
      os.execute("mkdir C:\\xampp\\htdocs\\locks\\" .. spawncode)
      exports["screenshot-basic"]:requestClientScreenshot(
        source,
        {
          fileName = "car screenshots path here" .. spawncode .. "/" .. orientation .. ".jpg"
        },
        function()
        end
      )
      if orientation == "side" then
        local file = io.open("link to html file", "w+")
        file:write(
          '<html><style>	body {background-color: #262626;}</style><img src="front.jpg" style="max-width: 80%;height: auto; display: block; margin-left: auto;margin-right: auto;padding: 10px;margin-bottom: 10px;"><img src="rear.jpg" style="max-width: 80%;height: auto; display: block; margin-left: auto;margin-right: auto;padding: 10px;margin-bottom: 10px;"><img src="side.jpg" style="max-width: 80%;height: auto; display: block; margin-left: auto;margin-right: auto;padding: 10px;margin-bottom: 10px;"></html>'
        )
        file:close()
      end
    else
      -- put anticheat ban here
    end
  end
)

RegisterServerEvent("Nova:getCarDevDebug")
AddEventHandler(
  "Nova:getCarDevDebug",
  function(text)
    local source = source
    local user_id = vRP.getUserId(source)
    vRP.prompt(
      source,
      "Vehicle Debug Info",
      text[1],
      function(player, a)
      end
    )
  end
)
