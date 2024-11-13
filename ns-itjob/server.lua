ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('ns-itjob:completeMission')
AddEventHandler('ns-itjob:completeMission', function()
    local xPlayer = ESX.GetPlayerFromId(source)  -- Get the player who completed the mission
    local money = Config.Money  -- Money reward from the config

    -- Add money to the player's account
    xPlayer.addMoney(money)  
    TriggerClientEvent('esx:showNotification', source, 'Получавате '..money..' за успешното завършване на мисията!')
end)
