---@author Dylan Malandain.
---@version 1.0
--[[
    File client/menu.lua
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

local list = {'Ouverture', 'Fermeture', 'Recrutement', 'Personnalisée'}
local listIndex = 1

Menu = {}
Menu.Toggle = false
function Menu:Create()
    Menu.Toggle = true
    mainMenu = RageUI.CreateMenu('Gouvernement', 'Que voulez-vous faire ?', 50, 200)
    security = RageUI.CreateSubMenu(mainMenu, 'Gouvernement', 'Que voulez-vous faire ?')
    mainMenu:SetRectangleBanner(Config.Settings.ColorBanner.r, Config.Settings.ColorBanner.g, Config.Settings.ColorBanner.b, Config.Settings.ColorBanner.a)
    security:SetRectangleBanner(Config.Settings.ColorBanner.r, Config.Settings.ColorBanner.g, Config.Settings.ColorBanner.b, Config.Settings.ColorBanner.a)
    mainMenu.Closed = function()
        Menu.Toggle = false
    end
end

function openMenu()
    Menu:Create()
    RageUI.Visible(mainMenu, true)
    while true do
        Citizen.Wait(2.0)
        if Menu.Toggle then

            RageUI.IsVisible(mainMenu, function()

                RageUI.Checkbox('Prendre son service', nil, service, {}, {
                    onChecked = function()
                        service = true
                    end,
                    onUnChecked = function()
                        service = false
                    end
                })

                if service then

                    RageUI.Line()

                    RageUI.List('Annonce', list, listIndex, nil, {}, true, {
                        onSelected = function()
                            if listIndex == 1 then
                                TriggerServerEvent('gouvernement:open')
                            elseif listIndex == 2 then
                                TriggerServerEvent('gouvernement:close')
                            elseif listIndex == 3 then
                                TriggerServerEvent('gouvernement:recruitment')
                            elseif listIndex == 4 then
                                local announce = KeyboardInput('Que voulez-vous faire ?', nil, 300)
                                if announce == nil then
                                    ESX.ShowNotification('~r~Votre annonce est vide !~s~')
                                end
                                if string.len(announce) <= 5 then
                                    ESX.ShowNotification('~r~Votre annonce est trop courte !~s~')
                                    return
                                end
                                TriggerServerEvent('gouvernement:personalized', announce)
                            end
                        end,
                        onListChange = function(Index)
                            listIndex = Index
                        end
                    })

                    RageUI.Button('Facturer un citoyen', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            openBilling()
                        end
                    })

                    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouvernement' and ESX.PlayerData.job.grade_name == 'security' then
                        RageUI.Button('Sécurité', nil, {RightLabel = '→'}, true, {
                            onSelected = function()
                            end
                        }, security)
                    else
                        RageUI.Button('Sécurité', nil, {RightLabel = '→'}, false, {
                            onSelected = function()
                            end
                        })

                    end
                end
            end)

            RageUI.IsVisible(security, function()

                if service then

                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                    RageUI.Button('Menotter un citoyen', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            heading = GetEntityHeading(PlayerPedId())
                            location = GetEntityForwardVector(PlayerPedId())
                            coords = GetEntityCoords(PlayerPedId())
                            local target_id = GetPlayerServerId(target)
                            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('gouvernement:handcuff', GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            end
                        end
                    })

                    RageUI.Button('Mettre un citoyen dans un véhicule', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            heading = GetEntityHeading(PlayerPedId())
                            location = GetEntityForwardVector(PlayerPedId())
                            coords = GetEntityCoords(PlayerPedId())
                            local target_id = GetPlayerServerId(target)
                            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('gouvernement:putInVehicle', GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            end
                        end
                    })

                    RageUI.Button('Sortir le citoyen du véhicule', nil, {RightLabel = '→'}, true, {
                        onSelected = function()
                            local target, distance = ESX.Game.GetClosestPlayer()
                            heading = GetEntityHeading(PlayerPedId())
                            location = GetEntityForwardVector(PlayerPedId())
                            coords = GetEntityCoords(PlayerPedId())
                            local target_id = GetPlayerServerId(target)
                            if closestPlayer ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('gouvernement:OutVehicle', GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification('~r~Aucun joueur à proximité !~s~')
                            end
                        end
                    })

                end
            end)
            
        else
            RageUI.Visible(mainMenu, false)
            RageUI.Visible(security, false)
            if not RageUI.Visible(mainMenu) and not RageUI.Visible(security) then
                mainMenu = RMenu:DeleteType('mainMenu', true)
            end
            return false
        end
    end
end

Keys.Register('F6', 'F6', 'Ouvrir le menu gouvernement.', function()
    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'gouvernement' then
        openMenu()
    end
end)