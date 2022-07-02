local QBCore = exports['qb-core']:GetCoreObject()
local crafting = false


CreateThread(function()
    exports['qb-target']:AddTargetModel('prop_tool_bench02_ld', { 
        options = {
            {
                type = 'server',
                event = "qb-personalCrafting:server:OpenCraftingMenu",
                icon = "fas fa-hammer",
                label = "Crafting",
            },
            {
                type = 'client',
                event = "qb-personalCrafting:client:RemoveBench",
                icon = "fas fa-hammer",
                label = "Remove the bench",
                canInteract = function(data)
					if not crafting then return true
                    end
				end,
            },
        },
        distance = 1.5,
    })
end)

RegisterNetEvent('qb-personalcrafting:createBeanch', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local offSet = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
    local bench = 'prop_tool_bench02_ld'
    RequestModel(bench)
    if IsPedInAnyVehicle(ped) then return end
    TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
    QBCore.Functions.Progressbar("recycle", "Bench", 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- success
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        CreateBench = CreateObject(bench, offSet.x, offSet.y, offSet.z, false, false, false)
        PlaceObjectOnGroundProperly(CreateBench)
        FreezeEntityPosition(CreateBench)
        TriggerServerEvent('qb-personalCrafting:server_RemoveItem', 'crafting_table', 1)
    end, function()  -- cancle
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)


RegisterNetEvent('qb-personlaCrafting:client:CraftItem', function(itemData, rItems)
    crafting = true
    local ped = PlayerPedId()
    if IsPedInAnyVehicle(ped) then return end
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic"})
    QBCore.Functions.Progressbar("recycle", "Crafting", 18000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- success
        crafting = false
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('qb-personalCrafting:server_AddItem', itemData, 1)
        TriggerServerEvent('qb-personalCrafting:server_RemoveItems', rItems)
    end, function()  -- cancle
        crafting = false
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)


RegisterNetEvent('qb-personalCrafting:client:RemoveBench', function()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local checkItem = QBCore.Functions.HasItem('crafting_table')

    TriggerEvent('animations:client:EmoteCommandStart', {"pickup"})
    QBCore.Functions.Progressbar("recycle", "Bench", 1000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function() -- success
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        if DoesEntityExist(CreateBench) then 
            DeleteObject(CreateBench)
            SetEntityAsNoLongerNeeded(CreateBench)
            if not checkItem then
                TriggerServerEvent('qb-personalCrafting:server_AddItem', 'crafting_table', 1)
            end
        end
    end, function()  -- cancle
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify("Canceled", "error")
    end)
end)