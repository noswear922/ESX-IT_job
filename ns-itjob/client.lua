RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local veh = false
local spawned = false
local getBox = false
local spawnedVeh = nil
local packet = 30
local alreadyGetPacket = false
local currentBlip = nil  

---@param vehicleModel string
local spawnVehicle = function(vehicleModel)
    for i=1, #Config.pedMenu do
        local curr <const> = Config.pedMenu[i]
        if ESX.Game.IsSpawnPointClear(curr.spawnCoords, 2.5) then
            ESX.Game.SpawnVehicle(vehicleModel, vec3(-1100.8228, -261.3531, 37.6916), 206.6831, function(vehicle, props)  
                SetVehicleFuelLevel(vehicle, 100.0)
                DecorSetFloat(vehicle, '_FUEL_LEVEL', GetVehicleFuelLevel(vehicle))
                exports.garages:setPlayerOwnsVehicle(vehicle)
                ESX.ShowNotification('Ти успешно извади служебното МПС!')
                spawned = true
                spawnedVeh = vehicle
            end)
            ESX.ShowNotification('Вземи си инструментите преди да тръгнеш!')
        else
            ESX.ShowNotification('Паркирания автомобил пречи!')
        end
    end
end

CreateThread(function()
    while ESX.GetPlayerData().job == nil do
        Wait(100)
    end
    PlayerData = ESX.GetPlayerData()

    local blipId = nil
    while true do
        local playerJob = ESX.PlayerData?.job?.name
        if playerJob == 'itjob' and not blipId then
            blipId = AddBlipForCoord(-1083.0610, -245.7139, 37.7632)  -- Updated coordinates for IT job
            SetBlipSprite(blipId, 521)
            SetBlipDisplay(blipId, 4)
            SetBlipScale(blipId, 1.0)
            SetBlipColour(blipId, 3)
            SetBlipAsShortRange(blipId, true)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringKeyboardDisplay('IT Работа')
            EndTextCommandSetBlipName(blipId)
        elseif playerJob ~= 'itjob' and blipId then
            RemoveBlip(blipId)
            blipId = nil
        end
        Wait(3000)
    end
end)

CreateThread(function()
    for i=1, #Config.pedMenu do
        local curr <const> = Config.pedMenu[i]
        lib.requestModel(curr.pedHash)
        lib.requestAnimDict('mini@strip_club@idles@bouncer@base')
        local ped = CreatePed(4, curr.pedHash, curr.pedCoords, curr.heading, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        TaskPlayAnim(ped, 'mini@strip_club@idles@bouncer@base', 'base', 8.0, 0.0, -1, 1, 0, false, false, false)
        exports.ox_target:addBoxZone({
            coords = curr.coords,
            size = curr.size,
            options = {
                {
                    label = curr.label,
                    icon = curr.icon,
                    distance = curr.distance,
                    groups = curr.groups,
                    onSelect = function()
                        lib.registerContext({
                            id = 'garagetruckstation',
                            title = 'IT',
                            options = {
                                {
                                    title = 'Вземи Автомобил',
                                    icon = 'car',
                                    arrow = true,
                                    onSelect = function()
                                        spawnVehicle('sadler')
                                    end,
                                },
                                {
                                    title = 'Вземи инструментите',
                                    icon = 'box',
                                    arrow = true,
                                    onSelect = function()
                                        if spawnedVeh and not alreadyGetPacket then
                                            TriggerEvent('ns-itjob:setboxtruck')  -- Updated event name
                                        elseif not spawnedVeh then
                                            ESX.ShowNotification('Трябва да извадиш камиона първо!')
                                        elseif alreadyGetPacket then
                                            ESX.ShowNotification('Ти вече си заредил за днес, изчакай буря!')
                                        end
                                    end,
                                },
                                {
                                    title = 'Прибери Автомобил/Приключи Работа',
                                    icon = 'parking',
                                    arrow = true,
                                    onSelect = function()
                                        if spawnedVeh and #(GetEntityCoords(spawnedVeh) - curr.coords) < 30.0 then
                                            DeleteEntity(spawnedVeh)
                                            ESX.ShowNotification('Ти успешно прибра служебното МПС!')
                                            spawnedVeh = false
                                            RemoveBlip(Blip)
                                        end
                                    end,
                                },
                            }
                        })
                        lib.showContext('garagetruckstation')  
                    end
                }
            }
        })
    end

    for i=1, #Config.vehiclePacket do
        local curr <const> = Config.vehiclePacket[i]
        local vehicle = ESX.Game.GetClosestVehicle()
        exports.ox_target:addModel('sadler', {
            label = curr.label,
            icon = curr.icon,
            groups = curr.groups,
            onSelect = function()
                if packet > 0 and not getBox then
                    SetVehicleDoorOpen(vehicle, 2, false, true)
                    Wait(300)
                    SetVehicleDoorOpen(vehicle, 3, false, true)
                    lib.progressCircle({
                        duration = 1000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                          car = true,
                          move = true,
                        },
                    });
                    exports["rpemotes"]:EmoteCommandStart('businessbag')
                    ESX.ShowNotification('Ти взе чантата!')
                    SetTimeout(1500, function()
                        SetVehicleDoorShut(vehicle, 2, false)
                        Wait(300)
                        SetVehicleDoorShut(vehicle, 3, false)
                    end)

                    getBox = true
                elseif packet < 0 and not getBox then
                    ESX.ShowNotification('Ти свърши работата, нужно е да вземеш от централата!') 
                    alreadyGetPacket = false
                elseif getBox and packet > 0 then
                    ESX.ShowNotification('Вече имаш инструменти!')
                end
            end
        })

        exports.ox_target:addModel('seatleon', {
            label = curr.label,
            icon = curr.icon,
            groups = curr.groups,
            onSelect = function()
                if packet > 0 and not getBox then
                    SetVehicleDoorOpen(vehicle, 2, false, true)
                    Wait(300)
                    SetVehicleDoorOpen(vehicle, 3, false, true)
                    lib.progressCircle({
                        duration = 1000,
                        position = 'bottom',
                        useWhileDead = false,
                        canCancel = true,
                        disable = {
                          car = true,
                          move = true,
                        },
                    });
                    exports["rpemotes"]:EmoteCommandStart('businessbag')
                    ESX.ShowNotification('Ти взе чантата')
                    SetTimeout(1500, function()
                        SetVehicleDoorShut(vehicle, 2, false)
                        Wait(300)
                        SetVehicleDoorShut(vehicle, 3, false)
                    end)

                    getBox = true
                elseif packet < 0 and not getBox then
                    ESX.ShowNotification('Ти свърши работата, нужно е да вземеш от централата!') 
                    alreadyGetPacket = false
                elseif getBox and packet > 0 then
                    ESX.ShowNotification('Вече си взел пакет!')
                end
            end
        })
    end 
end)

RegisterNetEvent('ns-itjob:missions', function()
    local id = math.random(1, #Config.Locations)
    local location = Config.Locations[id].vector3
    local x, y, z, heading = location[1], location[2], location[3], location[4]

    if not x or not y or not z then
        ESX.ShowNotification("Невалидни координати за мисия!")
        return
    end

    local money = Config.Money

    if currentBlip then
        RemoveBlip(currentBlip)
    end

    currentBlip = AddBlipForCoord(x, y, z)
    SetBlipSprite(currentBlip, 1)
    SetBlipColour(currentBlip, 2)
    SetBlipAsShortRange(currentBlip, true)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('PC')
    EndTextCommandSetBlipName(currentBlip)
    SetBlipAsMissionCreatorBlip(currentBlip, true)
    SetBlipRoute(currentBlip, true)

    lib.points.new({
        coords = vec3(x, y, z),
        distance = 1.5,
        onEnter = function()
            if ESX.PlayerData.job.name == 'itjob' then
                lib.showTextUI('[E] - Инсталирай софтуер')
            end
        end,
        onExit = function()
            lib.hideTextUI()
        end,
        nearby = function(self)
            if IsControlJustPressed(0, 38) and ESX.PlayerData.job.name == 'itjob' then
                if getBox then
                    -- Trigger the mini-game here
                    local success = exports.bl_ui:Untangle(3, {
                        numberOfNodes  = 10,
                        duration = 20000,
                    })

                    if success then
                        getBox = false
                        packet = packet - 1
                        TriggerServerEvent('ns-itjob:mangizi', money)
                        ESX.ShowNotification('Получи: ' .. money)
                        ESX.ShowNotification('Остават ти ' .. packet .. ' места')
                        exports.rpemotes:EmoteCancel(true)
                        RemoveBlip(currentBlip)
                        self:remove()
                        TriggerEvent('ns-itjob:missions')
                    else
                        ESX.ShowNotification('Неуспешно! Опитайте отново.')
                    end
                else
                    ESX.ShowNotification('Вземи първо чантата от автомобила')
                end
                lib.hideTextUI()
            end
        end
    })
end)

RegisterNetEvent('ns-itjob:setboxtruck', function(vehicle)  
    local finished = lib.progressCircle({
        duration = 5000,
        position = 'bottom',
        useWhileDead = false,
        canCancel = true,
        disable = {
          car = true,
          move = true,
        },
    });

    if finished then
        SetVehicleDoorOpen(vehicle, 3, false, true)
        ESX.ShowNotification('Вие поправихте 30 PC!')
        alreadyGetPacket = true
        SetVehicleDoorShut(veh, 3, false)
        TriggerEvent('ns-itjob:missions')  
    end
end)
