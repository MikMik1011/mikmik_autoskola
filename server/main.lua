ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) 
	ESX = obj 
end)

RegisterNetEvent('revolucija_autoskola:dajDozvolu')
AddEventHandler('revolucija_autoskola:dajDozvolu', function(source)
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer then
    xPlayer.addInventoryItem('vozackadozvolaa', 1)
  end
end)


RegisterNetEvent('revolucija_autoskola:plati')
AddEventHandler('revolucija_autoskola:plati', function(price)
  local xPlayer = ESX.GetPlayerFromId(source)

  if xPlayer then
    xPlayer.removeMoney(price)
    TriggerClientEvent('panama_notifikacije:sendNotification', xPlayer.source, 'fas fa-user', 'Platili ste ' .. price .. '€ teorijski test!', 2000)
  end
end)