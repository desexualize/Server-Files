Citizen.Trace = function(text)
  if #text ~= 0 then
    if string.find(text, 'SCRIPT ERROR') or string.find(text, 'Error parsing script') then
      TriggerServerEvent('RIVAL::errorCaught', text)
      print(text)
    end
  end
end
