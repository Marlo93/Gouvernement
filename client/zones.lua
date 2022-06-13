---@author Dylan Malandain.
---@version 1.0
--[[
    File client/zones.lua
    Project Gouvernement Job
    Created at 13/06/2022
    Credit : https://github.com/Marlo93
--]]

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        local interval = true
        local playerCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'gouvernement' then
            for i = 1, #Config.Settings.Zones.Actions do
                local distance = #(playerCoords - vector3(Config.Settings.Zones.Actions[i].x, Config.Settings.Zones.Actions[i].y, Config.Settings.Zones.Actions[i].z))
                if distance < 10.0 then
                    interval = false
                    if not actions.Toggle then
                        DrawMarker(Config.Settings.Marker.Type, Config.Settings.Zones.Actions[i], 0, 0, 0, Config.Settings.Marker.Rotation, nil, nil, Config.Settings.Marker.Size[1], Config.Settings.Marker.Size[2], Config.Settings.Marker.Size[3], Config.Settings.Marker.Color[1], Config.Settings.Marker.Color[2], Config.Settings.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)   
                    end
                    if distance <= 3.0 then
                        if not actions.Toggle then
                            ESX.ShowHelpNotification(Config.Client.Utilitary.notificationActions)
                            if IsControlJustPressed(1, 51) then
                                openActions()
                            end
                        end
                    else
                        actions.Toggle = false
                    end
                end
            end
        end
        if interval then
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        local interval = true
        local playerCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'gouvernement' and ESX.PlayerData.job.grade_name == 'boss' then
            for i = 1, #Config.Settings.Zones.Boss do
                local distance = #(playerCoords - vector3(Config.Settings.Zones.Boss[i].x, Config.Settings.Zones.Boss[i].y, Config.Settings.Zones.Boss[i].z))
                if distance < 10.0 then
                    interval = false
                    if not boss.Toggle then
                        DrawMarker(Config.Settings.Marker.Type, Config.Settings.Zones.Boss[i], 0, 0, 0, Config.Settings.Marker.Rotation, nil, nil, Config.Settings.Marker.Size[1], Config.Settings.Marker.Size[2], Config.Settings.Marker.Size[3], Config.Settings.Marker.Color[1], Config.Settings.Marker.Color[2], Config.Settings.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)   
                    end
                    if distance <= 3.0 then
                        if not boss.Toggle then
                            ESX.ShowHelpNotification(Config.Client.Utilitary.notificationBoss)
                            if IsControlJustPressed(1, 51) then
                                openBoss()
                            end
                        end
                    else
                        boss.Toggle = false
                    end
                end
            end
        end
        if interval then
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1.0)
        local interval = true
        local playerCoords = GetEntityCoords(PlayerPedId())
        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'gouvernement' then
            for i = 1, #Config.Settings.Zones.Garage do
                local distance = #(playerCoords - vector3(Config.Settings.Zones.Garage[i].x, Config.Settings.Zones.Garage[i].y, Config.Settings.Zones.Garage[i].z))
                if distance < 10.0 then
                    interval = false
                    if not garage.Toggle then
                       -- DrawMarker(Config.Settings.Marker.Type, Config.Settings.Zones.Garage[i], 0, 0, 0, Config.Settings.Marker.Rotation, nil, nil, Config.Settings.Marker.Size[1], Config.Settings.Marker.Size[2], Config.Settings.Marker.Size[3], Config.Settings.Marker.Color[1], Config.Settings.Marker.Color[2], Config.Settings.Marker.Color[3], 170, 0, 1, 0, 0, nil, nil, 0)   
                    end
                    if distance <= 3.0 then
                        if not garage.Toggle then
                            ESX.ShowHelpNotification(Config.Client.Utilitary.notificationGarage)
                            if IsControlJustPressed(1, 51) then
                                openGarage()
                            end
                        end
                    else
                        garage.Toggle = false
                    end
                end
            end
        end
        if interval then
            Citizen.Wait(500)
        end
    end
end)