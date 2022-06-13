---@author Dylan Malandain.
---@version 1.0
--[[
    File client/main.lua
    Project Gouvernement Job
    Created at 13/06/2022
    Credit : https://github.com/Marlo93
--]]

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Config.getESX, function(object) ESX = object end)
        Wait(10)
    end

    if Config.Settings.showBlip then
        for k,v in pairs (Config.Settings.Zones.Blip) do
            local blip = AddBlipForCoord(v)
            SetBlipSprite(blip, Config.Settings.infoBlip.Sprite)
            SetBlipDisplay(blip, Config.Settings.infoBlip.Display)
            SetBlipScale(blip, Config.Settings.infoBlip.Scale)
            SetBlipColour(blip, Config.Settings.infoBlip.Color)
            SetBlipAsShortRange(blip, Config.Settings.infoBlip.Range)
            BeginTextCommandSetBlipName('STRING')
            AddTextComponentString(Config.Settings.infoBlip.Name)
            EndTextCommandSetBlipName(blip)
        end
    end

    if Config.Settings.showPed then
        for _,ped in pairs (Config.Settings.infoPed) do
            while (not HasModelLoaded(ped.pedModel)) do
                RequestModel(ped.pedModel)
                Citizen.Wait(1)
            end
            local ped = CreatePed(2, GetHashKey(ped.pedModel), ped.pedPos, ped.heading, 0, 0)
            FreezeEntityPosition(ped, 1)
            if Config.Settings.scenarioPed then
                TaskStartScenarioInPlace(ped, Config.Settings.scenarioName, 0, false)
            end
            SetEntityInvincible(ped, true)
            SetBlockingOfNonTemporaryEvents(ped, 1)
            npc = ped
        end
    end
end)