---@author Dylan Malandain.
---@version 1.0
--[[
    File client/function.lua
    Project Gouvernement Job
    Created at 13/06/2022
    Credit : https://github.com/Marlo93
--]]

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, 'FMMC_KEY_TIP1', '', ExampleText, '', '', '', MaxStringLenght)
    blockinput = true
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end

function openBilling()
	local amount = KeyboardInput('Que voulez-vous faire ?', nil, 5)
	local player, distance = ESX.Game.GetClosestPlayer()
	if player ~= -1 and distance <= 3.0 then
		if amount == nil then
			ESX.ShowNotification('~r~Montant invalide !~s~')
		else
		local playerPed = PlayerPedId()
		TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TIME_OF_DEATH', 0, true)
		Citizen.Wait(5000)
			TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_gouvernement', ('gouvernement'), amount)
			ESX.ShowNotification('~g~Facture envoyée !~s~')
		end
	else
		ESX.ShowNotification('~r~Il n\'y a aucun joueur à proximité !~s~')
	end
end

function getInventory()
    ESX.TriggerServerCallback('gouvernement:playerinventory', function(inventory)
        all_items = inventory
    end)
end

function getStock()
    ESX.TriggerServerCallback('gouvernement:getStockItems', function(inventory)
        all_items = inventory
    end)
end

function resetPlayerOutfit()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        TriggerEvent('skinchanger:loadSkin', skin)
    end)
end

function applySkinOutfit(apply)
    TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		if skin.sex == 0 then
			uniformObject = apply.clothes['male']
		else
			uniformObject = apply.clothes['female']
		end
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		end
	end)
end

function refreshMoney()
    ESX.TriggerServerCallback('esx_society:getSocietyMoney', function(money)
        UpdateSocietygouvernementMoney(money)
    end, 'gouvernement')
end

function UpdateSocietygouvernementMoney(money)
    gouvernement_fond = ESX.Math.GroupDigits(money)
end