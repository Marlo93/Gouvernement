---@author Dylan Malandain.
---@version 1.0
--[[
    File config.lua
    Project Gouvernement Job
    Created at 13/06/2022
    Credit : https://github.com/Marlo93
--]]

Config = {
    getESX = "esx:getSharedObject",

    Settings = {
        ColorBanner = {r = 14, g = 173, b = 253, a = 170}, -- RGB / https://htmlcolorcodes.com/fr/
        showBlip = true, -- Afficher le blip. / Show the blip.
        showPed = true, -- Afficher le ped. / Show the ped.
        scenarioPed = true, -- Afficher le scenario du ped. / Show the scenario of the ped.
        scenarioName = 'WORLD_HUMAN_CLIPBOARD', -- Nom du scenario du ped. / Name of the scenario of the ped. --> https://wiki.rage.mp/index.php?title=Scenarios
        Marker = { -- https://docs.fivem.net/docs/game-references/markers/
            Type = 23,
            Size = {0.8, 0.8, 0.6},
            Color = {64, 9, 9},
            Rotation = true,
        },
        Zones = {
            Boss = {vector3(-547.2, -197.9, 70.0-0.95)},
            Garage = {vector3(-509.209, -251.177, 35.6258)},
            Actions = {vector3(-556.3, -182.9, 38.2-0.95)},
            Blip = {vector3(-547.2, -197.9, 70.0-0.95)}, -- Blip position. 
        },
        infoBlip = {
            Name = 'Gourvenement',
            Sprite = 419,
            Display = 4,	
            Scale = 0.6,
            Color = false,
            Range = true,
        },
        infoPed = {
            informationPed = {pedPos = vector3(-509.241, -251.133, 35.6265-1), heading = 118.2885, pedModel = 'a_m_m_business_01'}, -- Ped position. // https://docs.fivem.net/docs/game-references/ped-models/
        },
    },

    Client = {

        Armory = {
            {label = 'Pistolet de combat', item = 'weapon_combatpistol', type = 'weapon', ammo = 255}, 
            {label = 'Fusil de combat', item = 'weapon_combatpdw', type = 'weapon', ammo = 255},
        },

        Garage = {
            SpawnPointNotClear = '~r~Il y a déjà un véhicule ici !~s~', -- Notification lorsque le point de spawn est bloqué. / Notification when the spawn point is blocked.
            Vehicles = {
                {label = '4x4', name = 'baller6', spawnPoint = vector3(-504.4403, -259.1588, 35.4421), headingSpawn = 112.5726},
                {label = 'Limousine', name = 'stretch'; spawnPoint = vector3(-504.4403, -259.1588, 35.4421), headingSpawn = 112.5726},
            },
        },

        setOutfit = {
            [0] = {
                clothes = {
                    ['male'] = {
                        bags_1 = 0, bags_2 = 0,
                        tshirt_1 = 21, tshirt_2 = 0,
                        torso_1 = 29, torso_2 = 0,
                        arms = 4,
                        pants_1 = 24, pants_2 = 0,
                        shoes_1 = 10, shoes_2 = 0,
                        mask_1 = 0, mask_2 = 0,
                        bproof_1 = 0, bproof_2 = 0,
                        helmet_1 = -1, helmet_2 = 0,
                        chain_1 = 0, chain_2 = 0,
                        decals_1 = 0, decals_2 = 0,
                    },
                    ['female'] = {
                        bags_1 = 0, bags_2 = 0,
                        tshirt_1 = 39, tshirt_2 = 2,
                        torso_1 = 7, torso_2 = 0,
                        arms = 3,
                        pants_1 = 23, pants_2 = 10,
                        shoes_1 = 42, shoes_2 = 2,
                        mask_1 = 0, mask_2 = 0,
                        bproof_1 = 0, bproof_2 = 0,
                        helmet_1 = -1, helmet_2 = 0,
                        chain_1 = 0, chain_2 = 2,
                        decals_1 = 0, decals_2 = 0
                    },
                },
            },
        },

        Utilitary = {
            notificationActions = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder à différentes actions.', -- Notification lorsque le joueur est dans le menu. / Notification when the player is in the menu.
            notificationBoss = 'Appuyez sur ~INPUT_CONTEXT~ pour accéder à votre entreprise.',
            notificationGarage = 'Appuyez sur ~INPUT_CONTEXT~ pour sortir un véhicule.', -- Notification lorsque le joueur est dans le menu. / Notification when the player is in the menu.
        }
    },

    Server = {
        openNotification = '~g~Le gouvernement est ouvert !~s~', -- Notification lorsque le gouvernement est ouvert. / Notification when the government is open.
        closeNotification = '~r~Le gouvernement est fermé !~s~', -- Notification lorsque le gouvernement est fermé. / Notification when the government is closed.
        recruitmentNotification = '~o~Le gouvernement est en pleine séance de recrutement, ramenez-nous vos C.V !~s~', -- Notification lorsque le gouvernement recrute. / Notification when the government is recruiting.
        resetOutfit = 'Vous avez ~b~repris~s~ votre tenue initiale.', -- Notification lorsque vous avez récupéré votre tenue initiale. / Notification when you have reset your initial outfit.
        setOutfit = 'Vous avez ~g~enfilé~s~ votre tenue de service.', -- Notification lorsque vous avez enfilé votre tenue de service. / Notification when you have set your service outfit.
        putWeapons = 'Vous avez déposer toutes vos armes.',
        takeWeapons = 'Vous avez pris votre équipement.',
        noWeaponsOnPlayer = '~r~Vous n\'avez pas d\'armes de cette armurerie !~s~',
        noWeaponsInArmory = '~r~Vous avez déjà cette arme sur vous !~s~'
    },
}