---@author Dylan Malandain.
---@version 1.0
--[[
    File client/boss.lua
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

gouvernement_fond = nil

boss = {}
boss.Toggle = false
function boss:Create()
	boss.Toggle = true
	mainMenu = RageUI.CreateMenu('Gouvernement', 'Que voulez-vous faire ?', 50, 200)
    mainMenu:SetRectangleBanner(Config.Settings.ColorBanner.r, Config.Settings.ColorBanner.g, Config.Settings.ColorBanner.b, Config.Settings.ColorBanner.a)
	mainMenu.Closed = function()
		boss.Toggle = false
	end
end

function openBoss()
	boss:Create()
	RageUI.Visible(mainMenu, true)
	while true do
		Citizen.Wait(2.0)
		if boss.Toggle then

            RageUI.IsVisible(mainMenu, function()

                FreezeEntityPosition(PlayerPedId(), true)

                if gouvernement_fond then
                    RageUI.Button('Argent de l\'entreprise :', nil, {RightLabel = gouvernement_fond..'~g~ $~s~'}, true, {
                        onSelected = function()
                        end
                    })
                end

                RageUI.Button('Déposer de l\'argent', nil, {RightLabel = '→'}, true, {
                    onSelected = function()
                        local deposit = KeyboardInput('Que voulez-vous faire ?', nil, 50)
                        deposit = tonumber(deposit)
                        if deposit == nil then
                            ESX.ShowNotification('~r~Montant invalide !~s~')
                            else
                                TriggerServerEvent('esx_society:depositMoney', 'gouvernement', deposit)
                                TriggerServerEvent('gouvernement:deposit', deposit)
                                refreshMoney()
                            end
                        end
                    })

                    RageUI.Button('Retirer de l\'argent', nil, {RightLabel = '→'}, true, {
                        onSelected = function ()
                            local withdraw = KeyboardInput('Que voulez-vous faire ?', nil, 50)
                            withdraw = tonumber(withdraw)
                            if withdraw == nil then
                                ESX.ShowNotification('~r~Montant invalide !~s~')
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', 'gouvernement', withdraw)
                                TriggerServerEvent('gouvernement:withdraw', withdraw)
                                refreshMoney()
                            end
                        end
                    })

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