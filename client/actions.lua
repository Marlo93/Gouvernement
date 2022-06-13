---@author Dylan Malandain.
---@version 1.0
--[[
    File client/actions.lua
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

local selectedButton = 1
local index = 1
local indexName = {'Objets', 'Vestiaire', 'Armurerie'}
local civil = false
local service = true

actions = {}
actions.Toggle = false
function actions:Create()
	actions.Toggle = true
	mainMenu = RageUI.CreateMenu('Gouvernement', 'Que voulez-vous faire ?', 50, 200)
	putMenu = RageUI.CreateSubMenu(mainMenu, 'Gouvernement', 'Que voulez-vous faire ?')
	getMenu = RageUI.CreateSubMenu(mainMenu, 'Gouvernement', 'Que voulez-vous faire ?')
	mainMenu:SetRectangleBanner(Config.Settings.ColorBanner.r, Config.Settings.ColorBanner.g, Config.Settings.ColorBanner.b, Config.Settings.ColorBanner.a)
    putMenu:SetRectangleBanner(Config.Settings.ColorBanner.r, Config.Settings.ColorBanner.g, Config.Settings.ColorBanner.b, Config.Settings.ColorBanner.a)
    getMenu:SetRectangleBanner(Config.Settings.ColorBanner.r, Config.Settings.ColorBanner.g, Config.Settings.ColorBanner.b, Config.Settings.ColorBanner.a)
	mainMenu.Closed = function()
		actions.Toggle = false
	end
end

all_items = {}

function openActions()
	actions:Create()
	RageUI.Visible(mainMenu, true)
	while true do
		Citizen.Wait(2.0)
		if actions.Toggle then

			RageUI.IsVisible(mainMenu, function()

				FreezeEntityPosition(PlayerPedId(), true)

				RageUI.List('Filtre', indexName, index, nil, {}, true, {
					onListChange = function(Index, Item)
						index = Index;
						selectedButton = Index;
					end,
				})

				if selectedButton == 1 then

					RageUI.Button('Déposer un objet', nil, {RightLabel = '→'}, true, {
						onSelected = function()
							getInventory()
						end
					}, putMenu)

					RageUI.Button('Retirer un objet', nil, {RightLabel = '→'}, true, {
						onSelected = function()
							getStock()
						end
					}, getMenu)

				elseif selectedButton == 2 then
					
					RageUI.Button('Reprendre sa tenue de civile', nil, {RightLabel = '→'}, civil, {
						onSelected = function()
							civil = false
							service = true
							resetPlayerOutfit()
							TriggerServerEvent('gouvernement:resetOutfit')
						end
					})

					for k,v in pairs (Config.Client.setOutfit) do
						RageUI.Button('Prendre sa tenue de sécurité', nil, {RightLabel = '→'}, service, {
							onSelected = function()
								civil = true
								service = false
								applySkinOutfit(v)
								TriggerServerEvent('gouvernement:setOutfit')
							end
						})

					end

				elseif selectedButton == 3 then

					RageUI.Button('Déposer vos armes', nil, {RightLabel = '→'}, true, {
						onSelected = function()
							TriggerServerEvent('gouvernement:putWeapons')
						end
					})

					RageUI.Line()

					for k,v in pairs (Config.Client.Armory) do
						RageUI.Button(v.label, nil, {RightBadge = RageUI.BadgeStyle.Gun}, true, {
							onSelected = function()
								TriggerServerEvent('gouvernement:takeWeapons', v.item, v.type, v.ammo)
							end
						})

					end
				end
			end)

			RageUI.IsVisible(putMenu, function()

				for k,v in pairs (all_items) do

					RageUI.Button(v.label, nil, {RightLabel = '('..v.nb..')'}, true, {
						onSelected = function()
							local deposit = KeyboardInput('Que voulez-vous faire ?', nil, 4)
							deposit = tonumber(deposit)
							TriggerServerEvent('gouvernement:putStockItems', v.item, deposit)
							getInventory()
						end
					})

				end
			end)

			RageUI.IsVisible(getMenu, function()

				for k,v in pairs (all_items) do

					RageUI.Button(v.label, nil, {RightLabel = '('..v.nb..')'}, true, {
						onSelected = function()
							local withdraw = KeyboardInput('Que voulez-vous faire ?', nil, 4)
							withdraw = tonumber(withdraw)
							if withdraw <= v.nb then
								TriggerServerEvent('gouvernement:takeStockItems', v.item, withdraw)
							else
								ESX.ShowNotification('~r~Vous n\'avez pas assez d\'objets !~s~')
							end
							getStock()
						end
					})

				end
			end)

		else
			RageUI.Visible(mainMenu, false)
			RageUI.Visible(putMenu, false)
			RageUI.Visible(getMenu, false)
			if not RageUI.Visible(mainMenu) and not RageUI.Visible(putMenu) and not RageUI.Visible(getMenu) then
				mainMenu = RMenu:DeleteType('mainMenu', FreezeEntityPosition(PlayerPedId(), false), true)
			end
			return false
		end
	end
end