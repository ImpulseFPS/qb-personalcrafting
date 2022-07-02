local QBCore = exports['qb-core']:GetCoreObject()

local function IsAuthorized(CitizenId)
    local retval = false
    for _, cid in pairs(Config.Cid) do
        if cid == CitizenId then
            retval = true
            break
        end
    end
    return retval
end

local function hasCraftItems(source, CostItems)
	local Player = QBCore.Functions.GetPlayer(source)
	for k, v in pairs(CostItems) do
		if Player.Functions.GetItemByName(k) ~= nil then
			if Player.Functions.GetItemByName(k).amount < v.amount then
				return false
			end
		else
			return false
		end
	end
	return true
end

RegisterServerEvent('qb-personalCrafting:server:OpenCraftingMenu', function()
    local _src = source
    if not _src then return end
    local Player = QBCore.Functions.GetPlayer(_src)
    if not Player then return end

    --code

    local CraftMenu = {
        {
            header = Player.PlayerData.citizenid..' Private Crafting',
            isMenuHeader = true
        }
    }

    if IsAuthorized(Player.PlayerData.citizenid) then
        for k,v in pairs(Config.Crafting[Player.PlayerData.citizenid]) do
            CraftMenu[#CraftMenu + 1] = {
                header = v.itemLabel,
                txt = v.requirmentsTxt,
                params = {
                    isServer = true,
                    event = 'qb-personalCrafting:server:Checkitems',
                    args = {
                        req = v.requiredItems,
                        item = v.item,
                    }
                }
            }
        end
        TriggerClientEvent('qb-menu:client:openMenu', _src, CraftMenu)
    else
        TriggerClientEvent('QBCore:Notify', _src, 'You are not allowed to use this.', 'error')
    end
end)

RegisterServerEvent('qb-personalCrafting:server:Checkitems', function(data)
    local _src = source 
    if not _src then return end
    local Player = QBCore.Functions.GetPlayer(_src)
    if not Player then return end
    --args
    local costs = data.req
    local item = data.item

    --
    if hasCraftItems(_src, costs) then
        TriggerClientEvent('qb-personlaCrafting:client:CraftItem', _src, item, costs)
    else
        TriggerClientEvent('QBCore:Notify',_src, 'You dont have the right items.', 'error')
    end
end)



RegisterServerEvent('qb-personalCrafting:server_RemoveItems', function(costs)
    local _src = source
    if not _src then return end
    local Player = QBCore.Functions.GetPlayer(_src)
    if not Player then return end

    --code 

    for k,v in pairs(costs) do
        Player.Functions.RemoveItem(k, v.amount)
        TriggerClientEvent("inventory:client:ItemBox",_src, QBCore.Shared.Items[k], "remove", v.amount)
    end
end)

RegisterServerEvent('qb-personalCrafting:server_AddItem', function(item, amount)
    local _src = source
    if not _src then return end
    local Player = QBCore.Functions.GetPlayer(_src)
    if not Player then return end
    if item then
        if amount then
            Player.Functions.AddItem(item, amount)
            TriggerClientEvent("inventory:client:ItemBox", _src, QBCore.Shared.Items[item], "add", amount)
        end
    end
end)

RegisterServerEvent('qb-personalCrafting:server_RemoveItem', function(item, amount)
    local _src = source
    if not _src then return end
    local Player = QBCore.Functions.GetPlayer(_src)
    if not Player then return end
    if item then
        if amount then
            Player.Functions.RemoveItem(item, amount)
            TriggerClientEvent("inventory:client:ItemBox", _src, QBCore.Shared.Items[item], "remove", amount)
        end
    end
end)


QBCore.Functions.CreateUseableItem('crafting_table', function(source, item)
    local _src = source
    local Player = QBCore.Functions.GetPlayer(_src)

    TriggerClientEvent('qb-personalcrafting:createBeanch', _src)
end)