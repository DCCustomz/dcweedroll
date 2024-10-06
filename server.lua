if Config.Framework == 'ESX' then
	ESX = exports["es_extended"]:getSharedObject()
elseif Config.Framework == 'QBCore' then
	QBCore = exports['qb-core']:GetCoreObject()
end

local function contains(table, val)
    for i=1,#table do
        if table[i] == val then 
            return true
        end
    end
    return false
end

local function sendNotification(source, message, type)
    if Config.Notify == 'ox' then
        TriggerClientEvent('ox_lib:notify', source, {description = message, type = type})
    elseif Config.Notify == 'qb' then
        TriggerClientEvent('QBCore:Notify', source, message, type)
    elseif Config.Notify == 'esx' then
        TriggerClientEvent('esx:showNotification', source, message)
    elseif Config.Notify == 'custom' then
		-- Add your own here
	else	
        print('Notification:', message)
    end
end

local function processItem(source, itemName)
    local xPlayer = nil
    if Config.Framework == 'ESX' then
        xPlayer = ESX.GetPlayerFromId(source)
    elseif Config.Framework == 'QBCore' then
        xPlayer = QBCore.Functions.GetPlayer(source)
    end

    if xPlayer then
        local item = nil
        if Config.Framework == 'ESX' then
            item = xPlayer.getInventoryItem(itemName)
        elseif Config.Framework == 'QBCore' then
            item = xPlayer.Functions.GetItemByName(itemName)
        end

        if item and ((item.count and item.count > 0) or (item.amount and item.amount > 0)) then
            local found = false
            for categoryName, items in pairs(Config.RollableItems) do
                for _, rollable in ipairs(items) do
                    local rollableItem = nil
                    if Config.Framework == 'ESX' then
                        rollableItem = xPlayer.getInventoryItem(rollable)
                    elseif Config.Framework == 'QBCore' then
                        rollableItem = xPlayer.Functions.GetItemByName(rollable)
                    end

                    if rollableItem and ((rollableItem.count and rollableItem.count >= 1) or (rollableItem.amount and rollableItem.amount >= 1)) then
                        -- Send notification that rolling has started
                        sendNotification(source, "Started rolling", "success")

                        -- Trigger the appropriate animation based on the category
                        if categoryName == "blunts" then
                            TriggerClientEvent("dc_weedroll:rollblunt", source)
                        elseif categoryName == "joints" then
                            TriggerClientEvent("dc_weedroll:rollpaper", source)
                        end

                        -- Remove items from player
                        if Config.Framework == 'ESX' then
                            xPlayer.removeInventoryItem(itemName, 1)
                            xPlayer.removeInventoryItem(rollable, 1)
                        elseif Config.Framework == 'QBCore' then
                            xPlayer.Functions.RemoveItem(itemName, 1)
                            xPlayer.Functions.RemoveItem(rollable, 1)
                        end

                        -- Wait for the rolling animation to complete
                        Citizen.Wait(24600)

                        -- Add the rolled item to the player's inventory
                        local rolledItemName = Config.UsableItems[itemName][rollable]
                        if Config.Framework == 'ESX' then
                            xPlayer.addInventoryItem(rolledItemName, 1)
                            -- Get the label of the rolled item
                            local rolledItem = xPlayer.getInventoryItem(rolledItemName)
                            local rolledItemLabel = rolledItem and rolledItem.label or rolledItemName
							sendNotification(source, "Rolled up a " .. rolledItemLabel, "success")
                        elseif Config.Framework == 'QBCore' then
                            xPlayer.Functions.AddItem(rolledItemName, 1)
                            -- Get the label of the rolled item
                            local rolledItem = QBCore.Shared.Items[rolledItemName]
                            local rolledItemLabel = rolledItem and rolledItem.label or rolledItemName
							sendNotification(source, "Rolled up a " .. rolledItemLabel, "success")
                        end

                        found = true
                        break
                    end
                end
                if found then
                    break
                end
            end

            if not found then
                -- Send notification if player lacks necessary items
                sendNotification(source, "Not enough rollup items", "error")
            end
        end
    end
end



for itemName, _ in pairs(Config.UsableItems) do
	if Config.Framework == 'ESX' then
		ESX.RegisterUsableItem(itemName, function(source)
			processItem(source, itemName)
		end)
	elseif Config.Framework == 'QBCore' then
		QBCore.Functions.CreateUseableItem(itemName, function(source)
			processItem(source, itemName)
		end)
	end	
end
