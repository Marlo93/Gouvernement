---@author Dylan Malandain.
---@version 1.0
--[[
    File client/garage.lua
    Project Gouvernement Job
    Created at 13/06/2022
    Credit : https://github.com/Marlo93
--]]

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

garage = {}
garage.Toggle = false
function garage:Create()
    garage.Toggle = true
    mainMenu = RageUI.CreateMenu('Gouvernement', 'Que voulez-vous faire ?', 50, 200)
    mainMenu:SetRectangleBanner(Config.Settings.ColorBanner.r, Config.Settings.ColorBanner.g, Config.Settings.ColorBanner.b, Config.Settings.ColorBanner.a)
    mainMenu.Closed = function()
        garage.Toggle = false
    end
end

function openGarage()
    garage:Create()
    RageUI.Visible(mainMenu, true)
    while true do
        Citizen.Wait(2.0)
        if garage.Toggle then

            RageUI.IsVisible(mainMenu, function()

                FreezeEntityPosition(PlayerPedId(), true)

                for k,v in pairs (Config.Client.Garage.Vehicles) do
                    RageUI.Button(v.label, nil, {RightBadge = RageUI.BadgeStyle.Car}, true, {
                        onSelected = function()
                            if not ESX.Game.IsSpawnPointClear(vector3(v.spawnPoint.x, v.spawnPoint.y, v.spawnPoint.z), 10.0) then
                                ESX.ShowNotification(Config.Client.Garage.SpawnPointNotClear)
                            else
                                local hash = GetHashKey(v.name)
                                RequestModel(hash)
                                while not HasModelLoaded(hash) do
                                    Citizen.Wait(10)
                                end
                                DoScreenFadeOut(1000)
                                Citizen.Wait(1000)
                                local vehicle = CreateVehicle(hash, v.spawnPoint, v.headingSpawn, true, false)
                                SetVehicleNumberPlateText(vehicle, "Gouvernement")
                                TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
                                DoScreenFadeIn(1000)
                            end
                        end
                    })

                end
            end)

        else
            RageUI.Visible(mainMenu, false)
            if not RageUI.Visible(mainMenu) then
                mainMenu = RMenu:DeleteType('mainMenu', FreezeEntityPosition(PlayerPedId(), false), true)
            end
            return false
        end
    end
end