QBCore = exports['qb-core']:GetCoreObject()
PlayerJob = {}

function TakeOutVehicle(vehicleInfo, currentSelection)
    local coords = Config.PoliceLocations[currentSelection].spawn
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    if PlayerJob.name == "police" then
        QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
            SetVehicleNumberPlateText(veh, "LSPD"..tostring(math.random(1000, 9999)))
            SetEntityHeading(veh, coords.w)
            exports['lj-fuel']:SetFuel(veh, 100.0)
            TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
            TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
            SetVehicleEngineOn(veh, true, true)
            SetVehicleLivery(veh, 2)
            CurrentPlate = QBCore.Functions.GetPlate(veh)
        end, coords, true)
    end
end

function MenuGarage(currentSelection)
    local vehicleMenu = {
        {
            header = Config.PoliceLocations[currentSelection.garage].label,
            isMenuHeader = true
        }
    }

    local policeVehicles = Config.PoliceVehicles
    for veh, label in pairs(policeVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "zpevgarage:client:TakeOutVehicle",
                args = {
                    vehicle = veh,
                    currentSelection = currentSelection
                }
            }
        }
    end

    vehicleMenu[#vehicleMenu+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end


RegisterNetEvent('zpevgarage:client:TakeOutVehicle', function(data)
    local garage = data.currentSelection.garage
    local pos = GetEntityCoords(PlayerPedId())
    local locSpawn = Config.PoliceLocations[garage].spawn
    local vehicle = data.vehicle
    local closestVehicle = GetClosestVehicle(locSpawn.x, locSpawn.y, locSpawn.z, 2.0, 0, 127)

    if closestVehicle == 0 then
        TakeOutVehicle(vehicle, garage)
    else
        QBCore.Functions.Notify('Theres is a vehicle blocking the spawn point', 'error', 5000)
    end
end)

RegisterNetEvent('zpevgarage:client:MenuPoliceGarage', function(currentSelection)
    MenuGarage(currentSelection)
end)

RegisterNetEvent('zpevgarage:client:MenuPoliceGaragePark', function(data)
    local garages = data.garages
    local vehicle = GetClosestVehicle(garages.x, garages.y, garages.z, 10.0, 0, 127)
    if vehicle == 0 then
        QBCore.Functions.Notify('Theres is no vehicle nearby', 'error', 5000)
    else
        QBCore.Functions.DeleteVehicle(vehicle)
        QBCore.Functions.Notify('Vehicle has been parked', 'success', 5000)
    end
end)

for currentSelection, _ in pairs(Config.PoliceLocations) do
    exports['qb-target']:SpawnPed({
        model = Config.PoliceLocations[currentSelection].ped,
        coords = Config.PoliceLocations[currentSelection].coords, 
        minusOne = true, 
        freeze = true, 
        blockevents = true, 
        scenario = 'WORLD_HUMAN_CLIPBOARD', 
        spawnNow = false,
        target = { 
            options = { 
                { 
                garage = currentSelection,
                type = "client", 
                event = "zpevgarage:client:MenuPoliceGarage", 
                icon = 'fas fa-car', 
                label = 'Garage', 
                job = 'police', 
                },
                { 
                garages = Config.PoliceLocations[currentSelection].spawn,
                type = "client", 
                event = "zpevgarage:client:MenuPoliceGaragePark", 
                icon = 'fas fa-warehouse', 
                label = 'Park', 
                job = 'police', 
                }
            },
            distance = 2.5,
        },
    })
end

---EMS Garage
function TakeOutVehicleEMS(vehicleInfo, currentSelection)
    local coords = Config.EMSLocations[currentSelection].spawn
    local PlayerJob = QBCore.Functions.GetPlayerData().job
    QBCore.Functions.SpawnVehicle(vehicleInfo, function(veh)
        SetVehicleNumberPlateText(veh, "EMS"..tostring(math.random(1000, 9999)))
        SetEntityHeading(veh, coords.w)
        exports['lj-fuel']:SetFuel(veh, 100.0)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
        SetVehicleLivery(veh, 2)
        CurrentPlate = QBCore.Functions.GetPlate(veh)
    end, coords, true)
end

function MenuEMSGarage(currentSelection)
    local vehicleMenu = {
        {
            header = Config.EMSLocations[currentSelection.garage].label,
            isMenuHeader = true
        }
    }

    local emsVehicles = Config.EMSVehicles
    for veh, label in pairs(emsVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "zpevgarage:client:TakeOutVehicleEMS",
                args = {
                    vehicle = veh,
                    currentSelection = currentSelection
                }
            }
        }
    end

    vehicleMenu[#vehicleMenu+1] = {
        header = "Close",
        txt = "",
        params = {
            event = "qb-menu:client:closeMenu"
        }

    }
    exports['qb-menu']:openMenu(vehicleMenu)
end

RegisterNetEvent('zpevgarage:client:TakeOutVehicleEMS', function(data)
    local garage = data.currentSelection.garage
    local pos = GetEntityCoords(PlayerPedId())
    local locSpawn = Config.EMSLocations[garage].spawn
    local vehicle = data.vehicle
    local closestVehicle = GetClosestVehicle(locSpawn.x, locSpawn.y, locSpawn.z, 2.0, 0, 127)

    if closestVehicle == 0 then
        TakeOutVehicleEMS(vehicle, garage)
    else
        QBCore.Functions.Notify('Theres is a vehicle blocking the spawn point', 'error', 5000)
    end
end)

RegisterNetEvent('zpevgarage:client:MenuEMSGarage', function(currentSelection)
    MenuEMSGarage(currentSelection)
end)

RegisterNetEvent('zpevgarage:client:MenuEMSGaragePark', function(data)
    local garages = data.garages
    local vehicle = GetClosestVehicle(garages.x, garages.y, garages.z, 10.0, 0, 127)
    if vehicle == 0 then
        QBCore.Functions.Notify('Theres is no vehicle nearby', 'error', 5000)
    else
        QBCore.Functions.DeleteVehicle(vehicle)
        QBCore.Functions.Notify('Vehicle has been parked', 'success', 5000)
    end
end)

for currentSelection, _ in pairs(Config.EMSLocations) do
    exports['qb-target']:SpawnPed({
        model = Config.EMSLocations[currentSelection].ped, 
        coords = Config.EMSLocations[currentSelection].coords, 
        minusOne = true, 
        freeze = true, 
        blockevents = true, 
        scenario = 'WORLD_HUMAN_CLIPBOARD', 
        spawnNow = false,
        target = { 
            options = { 
                { 
                garage = currentSelection,
                type = "client", 
                event = "zpevgarage:client:MenuEMSGarage", 
                icon = 'fas fa-car', 
                label = 'Garage', 
                job = 'ambulance', 
                },
                { 
                garages = Config.EMSLocations[currentSelection].spawn,
                type = "client", 
                event = "zpevgarage:client:MenuEMSGaragePark", 
                icon = 'fas fa-warehouse', 
                label = 'Park', 
                job = 'ambulance', 
                }
            },
            distance = 2.5,
        },
    })
end