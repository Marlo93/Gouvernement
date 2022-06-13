---@author Dylan Malandain.
---@version 1.0
--[[
    File server/server.lua
    Project Gouvernement Job
    Created at 13/06/2022
    Credit : https://github.com/Marlo93
--]]

ESX = nil
TriggerEvent(Config.getESX, function(object) ESX = object end)
TriggerEvent('esx_society:registerSociety', 'gouvernement', 'gouvernement', 'society_gouvernement', 'society_gouvernement', 'society_gouvernement', {type = 'public'})

RegisterServerEvent('gouvernement:open')
AddEventHandler('gouvernement:open', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local getPlayers = ESX.GetPlayers()
    for i=1, #getPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(getPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', getPlayers[i], 'Gouvernement', 'Informations', Config.Server.openNotification, 'CHAR_MP_FM_CONTACT', 3)
    end
end)

RegisterServerEvent('gouvernement:close')
AddEventHandler('gouvernement:close', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local getPlayers = ESX.GetPlayers()
    for i=1, #getPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(getPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', getPlayers[i], 'Gouvernement', 'Informations', Config.Server.closeNotification, 'CHAR_MP_FM_CONTACT', 3)
    end
end)

RegisterServerEvent('gouvernement:recruitment')
AddEventHandler('gouvernement:recruitment', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local getPlayers = ESX.GetPlayers()
    for i=1, #getPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(getPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', getPlayers[i], 'Gouvernement', 'Informations', Config.Server.recruitmentNotification, 'CHAR_MP_FM_CONTACT', 3)
    end
end)

RegisterServerEvent('gouvernement:personalized')
AddEventHandler('gouvernement:personalized', function(message)
    local _src = source
    local getPlayers = ESX.GetPlayers()
    for i=1, #getPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(getPlayers[i])
        TriggerClientEvent('esx:showAdvancedNotification', _src, 'Gouvernement', 'Informations', message, 'CHAR_MP_FM_CONTACT', 3)
    end
end)

RegisterServerEvent('gouvernement:handcuff')
AddEventHandler('gouvernement:handcuff', function(target)
    TriggerClientEvent('gouvernement:handcuff', target)
end)

RegisterServerEvent('gouvernement:putInVehicle')
AddEventHandler('gouvernement:putInVehicle', function(target)
    TriggerClientEvent('gouvernement:putInVehicle', target)
end)

RegisterServerEvent('gouvernement:OutVehicle')
AddEventHandler('gouvernement:OutVehicle', function(target)
    TriggerClientEvent('gouvernement:OutVehicle', target)
end)

ESX.RegisterServerCallback('gouvernement:playerinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end
	cb(all_items)
end)

ESX.RegisterServerCallback('gouvernement:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernement', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end
	end)
	cb(all_items)
end)

RegisterServerEvent('gouvernement:putStockItems')
AddEventHandler('gouvernement:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernement', function(inventory)
		if item_in_inventory >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Vous n\'avez pas assez d\'objets !~s~')
		end
	end)
end)

RegisterServerEvent('gouvernement:takeStockItems')
AddEventHandler('gouvernement:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_gouvernement', function(inventory)
		xPlayer.addInventoryItem(itemName, count)
		inventory.removeItem(itemName, count)
	end)
end)

RegisterServerEvent('gouvernement:resetOutfit')
AddEventHandler('gouvernement:resetOutfit', function()
	local _src = source
	TriggerClientEvent('esx:showNotification', _src, Config.Server.resetOutfit)
end)

RegisterServerEvent('gouvernement:setOutfit')
AddEventHandler('gouvernement:setOutfit', function()
	local _src = source
	TriggerClientEvent('esx:showNotification', _src, Config.Server.setOutfit)
end)

RegisterServerEvent('gouvernement:putWeapons')
AddEventHandler('gouvernement:putWeapons', function()
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	for k,v in pairs (Config.Client.Armory) do
		if xPlayer.hasWeapon(v.item) then
			xPlayer.removeWeapon(v.item)
			TriggerClientEvent('esx:showNotification', _src, Config.Server.putWeapons)
		else
			TriggerClientEvent('esx:showNotification', _src, Config.Server.noWeaponsOnPlayer)
		end
	end
end)

RegisterServerEvent('gouvernement:takeWeapons')
AddEventHandler('gouvernement:takeWeapons', function(item, type, ammo)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	for k,v in pairs (Config.Client.Armory) do
		if item == v.item then
		end
	end
	if type == 'weapon' then
		if not xPlayer.hasWeapon(item) then
			xPlayer.addWeapon(item, ammo)
			TriggerClientEvent('esx:showNotification', _src, Config.Server.takeWeapons)
		else
			TriggerClientEvent('esx:showNotification', _src, Config.Server.noWeaponsInArmory)
		end
	end
end)