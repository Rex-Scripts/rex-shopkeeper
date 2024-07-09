local RSGCore = exports['rsg-core']:GetCoreObject()

---------------------------------
-- blips
---------------------------------
CreateThread(function()
    for _,v in pairs(Config.ShopkeeperLocations) do
        if v.showblip == true then    
            local ShopkeeperBlip = BlipAddForCoords(1664425300, v.coords)
            SetBlipSprite(ShopkeeperBlip, joaat(v.blipsprite), true)
            SetBlipScale(ShopkeeperBlip, v.blipscale)
            SetBlipName(ShopkeeperBlip, v.blipname)
        end
    end
end)

---------------------------------------------
-- get correct menu
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:openshopkeeper', function(shopkeeperid, jobaccess, name)
    RSGCore.Functions.TriggerCallback('rex-shopkeeper:server:getshopkeeperdata', function(result)
        local owner = result[1].owner
        local status = result[1].status
        if owner ~= 'vacant' then
            local PlayerData = RSGCore.Functions.GetPlayerData()
            local playerjob = PlayerData.job.name
            if playerjob == jobaccess then
                TriggerEvent('rex-shopkeeper:client:openjobmenu', shopkeeperid, status)
            else
                TriggerEvent('rex-shopkeeper:client:opencustomermenu', shopkeeperid, status)
            end
        else
            TriggerEvent('rex-shopkeeper:client:rentshopkeeper', shopkeeperid, name)
        end
    end, shopkeeperid)
end)

---------------------------------------------
-- shopkeeper job menu
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:openjobmenu', function(shopkeeperid, status)
    if status == 'open' then
        lib.registerContext({
            id = 'shopkeeper_job_menu',
            title = Lang:t('client.lang_1'),
            options = {
                {
                    title = Lang:t('client.lang_2'),
                    icon = 'fa-solid fa-store',
                    event = 'rex-shopkeeper:client:ownerviewitems',
                    args = { shopkeeperid = shopkeeperid },
                    arrow = true
                },
                {
                    title = Lang:t('client.lang_3'),
                    icon = 'fa-solid fa-circle-plus',
                    iconColor = 'green',
                    event = 'rex-shopkeeper:client:newstockitem',
                    args = { shopkeeperid = shopkeeperid },
                    arrow = true
                },
                {
                    title = Lang:t('client.lang_4'),
                    icon = 'fa-solid fa-circle-minus',
                    iconColor = 'red',
                    event = 'rex-shopkeeper:client:removestockitem',
                    args = { shopkeeperid = shopkeeperid },
                    arrow = true
                },
                {
                    title = Lang:t('client.lang_5'),
                    icon = 'fa-solid fa-sack-dollar',
                    event = 'rex-shopkeeper:client:withdrawmoney',
                    args = { shopkeeperid = shopkeeperid },
                    arrow = true
                },
                {
                    title = Lang:t('client.lang_6'),
                    icon = 'fa-solid fa-box',
                    event = 'rex-shopkeeper:client:ownerstoragemenu',
                    args = { shopkeeperid = shopkeeperid },
                    arrow = true
                },
                {
                    title = Lang:t('client.lang_7'),
                    icon = 'fa-solid fa-box',
                    event = 'rex-shopkeeper:client:craftingmenu',
                    args = { shopkeeperid = shopkeeperid },
                    arrow = true
                },
                {
                    title = Lang:t('client.lang_8'),
                    icon = 'fa-solid fa-box',
                    event = 'rex-shopkeeper:client:rentmenu',
                    args = { shopkeeperid = shopkeeperid },
                    arrow = true
                },
                {
                    title = Lang:t('client.lang_9'),
                    icon = 'fa-solid fa-user-tie',
                    event = 'rsg-bossmenu:client:mainmenu',
                    arrow = true
                },
            }
        })
        lib.showContext('shopkeeper_job_menu')
    else
        lib.registerContext({
            id = 'shopkeeper_job_menu',
            title = Lang:t('client.lang_1'),
            options = {
                {
                    title = Lang:t('client.lang_8'),
                    icon = 'fa-solid fa-box',
                    event = 'rex-shopkeeper:client:rentmenu',
                    args = { shopkeeperid = shopkeeperid },
                    arrow = true
                },
            }
        })
        lib.showContext('shopkeeper_job_menu')
    end
end)

---------------------------------------------
-- shopkeeper customer menu
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:opencustomermenu', function(shopkeeperid, status)
    if status == 'closed' then
        lib.notify({ title = Lang:t('client.lang_10'), type = 'error', duration = 7000 })
        return
    end
    lib.registerContext({
        id = 'shopkeeper_customer_menu',
        title = Lang:t('client.lang_11'),
        options = {
            {
                title = Lang:t('client.lang_12'),
                icon = 'fa-solid fa-store',
                event = 'rex-shopkeeper:client:customerviewitems',
                args = { shopkeeperid = shopkeeperid },
                arrow = true
            },
            {
                title = Lang:t('client.lang_13'),
                icon = 'fa-solid fa-box',
                event = 'rex-shopkeeper:client:storageplayershare',
                args = { shopkeeperid = shopkeeperid },
                arrow = true
            },
        }
    })
    lib.showContext('shopkeeper_customer_menu')
end)

---------------------------------------------
-- shopkeeper rent money menu
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:rentmenu', function(data)

    RSGCore.Functions.TriggerCallback('rex-shopkeeper:server:getshopkeeperdata', function(result)
    
        local rent = result[1].rent
        if rent > 50  then rentColorScheme = 'green' end
        if rent <= 50 and rent > 10 then rentColorScheme = 'yellow' end
        if rent <= 10 then rentColorScheme = 'red' end
        
        lib.registerContext({
            id = 'shopkeeper_rent_menu',
            title = Lang:t('client.lang_14'),
            menu = 'shopkeeper_job_menu',
            options = {
                {
                    title = Lang:t('client.lang_15')..rent,
                    progress = rent,
                    colorScheme = rentColorScheme,
                },
                {
                    title = Lang:t('client.lang_16'),
                    icon = 'fa-solid fa-dollar-sign',
                    event = 'rex-shopkeeper:client:payrent',
                    args = { shopkeeperid = data.shopkeeperid },
                    arrow = true
                },
            }
        })
        lib.showContext('shopkeeper_rent_menu')

    end, data.shopkeeperid)
    
end)

-------------------------------------------------------------------------------------------
-- job : view shopkeeper items
-------------------------------------------------------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:ownerviewitems', function(data)

    RSGCore.Functions.TriggerCallback('rex-shopkeeper:server:checkstock', function(result)

        if result == nil then
            lib.registerContext({
                id = 'shopkeeper_no_inventory',
                title = Lang:t('client.lang_17'),
                menu = 'shopkeeper_job_menu',
                options = {
                    {
                        title = Lang:t('client.lang_18'),
                        icon = 'fa-solid fa-box',
                        disabled = true,
                        arrow = false
                    }
                }
            })
            lib.showContext('shopkeeper_no_inventory')
        else
            local options = {}
            for k,v in ipairs(result) do
                options[#options + 1] = {
                    title = RSGCore.Shared.Items[result[k].item].label..' ($'..result[k].price..')',
                    description = Lang:t('client.lang_19')..result[k].stock,
                    icon = 'fa-solid fa-box',
                    event = 'rex-shopkeeper:client:buyitem',
                    icon = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    image = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    args = {
                        item = result[k].item,
                        stock = result[k].stock,
                        price = result[k].price,
                        label = RSGCore.Shared.Items[result[k].item].label,
                        shopkeeperid = result[k].shopkeeperid
                    },
                    arrow = true,
                }
            end
            lib.registerContext({
                id = 'shopkeeper_inv_menu',
                title = Lang:t('client.lang_17'),
                menu = 'shopkeeper_job_menu',
                position = 'top-right',
                options = options
            })
            lib.showContext('shopkeeper_inv_menu')
        end
    end, data.shopkeeperid)

end)

-------------------------------------------------------------------------------------------
-- customer : view shopkeeper items
-------------------------------------------------------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:customerviewitems', function(data)
    RSGCore.Functions.TriggerCallback('rex-shopkeeper:server:checkstock', function(result)
        if result == nil then
            lib.registerContext({
                id = 'shopkeeper_no_inventory',
                title = Lang:t('client.lang_17'),
                menu = 'shopkeeper_customer_menu',
                options = {
                    {
                        title = Lang:t('client.lang_18'),
                        icon = 'fa-solid fa-box',
                        disabled = true,
                        arrow = false
                    }
                }
            })
            lib.showContext('shopkeeper_no_inventory')
        else
            local options = {}
            for k,v in ipairs(result) do
                options[#options + 1] = {
                    title = RSGCore.Shared.Items[result[k].item].label..' ($'..result[k].price..')',
                    description = Lang:t('client.lang_19')..result[k].stock,
                    icon = 'fa-solid fa-box',
                    event = 'rex-shopkeeper:client:buyitem',
                    icon = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    image = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    args = {
                        item = result[k].item,
                        stock = result[k].stock,
                        price = result[k].price,
                        label = RSGCore.Shared.Items[result[k].item].label,
                        shopkeeperid = result[k].shopkeeperid
                    },
                    arrow = true,
                }
            end
            lib.registerContext({
                id = 'shopkeeper_inv_menu',
                title = Lang:t('client.lang_17'),
                menu = 'shopkeeper_customer_menu',
                position = 'top-right',
                options = options
            })
            lib.showContext('shopkeeper_inv_menu')
        end
    end, data.shopkeeperid)

end)

-------------------------------------------------------------------
-- sort table function
-------------------------------------------------------------------
local function compareNames(a, b)
    return a.value < b.value
end

-------------------------------------------------------------------
-- add / update stock item
-------------------------------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:newstockitem', function(data)

    local items = {}

    for k,v in pairs(RSGCore.Functions.GetPlayerData().items) do
        local content = { value = v.name, label = v.label..' ('..v.amount..')' }
        items[#items + 1] = content
    end

    table.sort(items, compareNames)

    local item = lib.inputDialog(Lang:t('client.lang_20'), {
        { 
            type = 'select',
            options = items,
            label = Lang:t('client.lang_21'),
            required = true
        },
        { 
            type = 'input',
            label = Lang:t('client.lang_22'),
            placeholder = '0',
            icon = 'fa-solid fa-hashtag',
            required = true
        },
        { 
            type = 'input',
            label = Lang:t('client.lang_23'),
            placeholder = '0.00',
            icon = 'fa-solid fa-dollar-sign',
            required = true
        },
    })
    
    if not item then 
        return 
    end
    
    local hasItem = RSGCore.Functions.HasItem(item[1], item[2])
    
    if hasItem then
        TriggerServerEvent('rex-shopkeeper:server:newstockitem', data.shopkeeperid, item[1], tonumber(item[2]), tonumber(item[3]))
    else
        lib.notify({ title = Lang:t('client.lang_24'), type = 'error', duration = 7000 })
    end

end)

-------------------------------------------------------------------------------------------
-- remove stock item
-------------------------------------------------------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:removestockitem', function(data)
    RSGCore.Functions.TriggerCallback('rex-shopkeeper:server:checkstock', function(result)
        if result == nil then
            lib.registerContext({
                id = 'shopkeeper_no_stock',
                title = Lang:t('client.lang_25'),
                menu = 'shopkeeper_owner_menu',
                options = {
                    {
                        title = Lang:t('client.lang_26'),
                        icon = 'fa-solid fa-box',
                        disabled = true,
                        arrow = false
                    }
                }
            })
            lib.showContext('shopkeeper_no_stock')
        else
            local options = {}
            for k,v in ipairs(result) do
                options[#options + 1] = {
                    title = RSGCore.Shared.Items[result[k].item].label,
                    description = Lang:t('client.lang_19')..result[k].stock,
                    icon = 'fa-solid fa-box',
                    serverEvent = 'rex-shopkeeper:server:removestockitem',
                    icon = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    image = "nui://" .. Config.Img .. RSGCore.Shared.Items[tostring(result[k].item)].image,
                    args = {
                        item = result[k].item,
                        shopkeeperid = result[k].shopkeeperid
                    },
                    arrow = true,
                }
            end
            lib.registerContext({
                id = 'shopkeeper_stock_menu',
                title = Lang:t('client.lang_25'),
                menu = 'shopkeeper_job_menu',
                position = 'top-right',
                options = options
            })
            lib.showContext('shopkeeper_stock_menu')
        end
    end, data.shopkeeperid)
end)

-------------------------------------------------------------------------------------------
-- withdraw money 
-------------------------------------------------------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:withdrawmoney', function(data)
    RSGCore.Functions.TriggerCallback('rex-shopkeeper:server:getmoney', function(result)
        local input = lib.inputDialog(Lang:t('client.lang_27'), {
            { 
                type = 'input',
                label = Lang:t('client.lang_28')..result.money,
                icon = 'fa-solid fa-dollar-sign',
                required = true
            },
        })
        if not input then
            return 
        end
        local withdraw = tonumber(input[1])
        if withdraw <= result.money then
            TriggerServerEvent('rex-shopkeeper:server:withdrawfunds', withdraw, data.shopkeeperid)
        else
            lib.notify({ title = Lang:t('client.lang_29'), type = 'error', duration = 7000 })
        end
    end, data.shopkeeperid)
end)

---------------------------------------------
-- buy item amount
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:buyitem', function(data)
    local input = lib.inputDialog(Lang:t('client.lang_30')..data.label, {
        { 
            label = Lang:t('client.lang_31'),
            type = 'input',
            required = true,
            icon = 'fa-solid fa-hashtag'
        },
    })
    if not input then
        return
    end
    
    local amount = tonumber(input[1])
    
    if data.stock >= amount then
        local newstock = (data.stock - amount)
        TriggerServerEvent('rex-shopkeeper:server:buyitem', amount, data.item, newstock, data.price, data.label, data.shopkeeperid)
    else
        lib.notify({ title = Lang:t('client.lang_32'), type = 'error', duration = 7000 })
    end
end)

---------------------------------------------
-- rent shopkeeper
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:rentshopkeeper', function(shopkeeperid, name)
    
    local input = lib.inputDialog(Lang:t('client.lang_33')..name, {
        {
            label = Lang:t('client.lang_34')..Config.RentStartup,
            type = 'select',
            options = {
                { value = 'yes', label = Lang:t('client.lang_35') },
                { value = 'no',  label = Lang:t('client.lang_36') }
            },
            required = true
        },
    })

    -- check there is an input
    if not input then
        return 
    end

    -- if no then return
    if input[1] == 'no' then
        return
    end

    RSGCore.Functions.TriggerCallback('rsg-multijob:server:checkjobs', function(canbuy)
        if not canbuy then
            lib.notify({ title = Lang:t('client.lang_50'), type = 'error', duration = 7000 })
            return
        end
    end)

    RSGCore.Functions.TriggerCallback('rex-shopkeeper:server:countowned', function(result)

        if result >= Config.MaxShopkeepers then
            lib.notify({ title = Lang:t('client.lang_48'), description = Lang:t('client.lang_49'), type = 'error', duration = 7000 })
            return
        end

        -- check player has a licence
        if Config.LicenseRequired then
            local hasItem = RSGCore.Functions.HasItem('shopkeeperlicence', 1)

            if hasItem then
                TriggerServerEvent('rex-shopkeeper:server:rentshopkeeper', shopkeeperid)
            else
                lib.notify({ title = Lang:t('client.lang_37'), type = 'error', duration = 7000 })
            end
        else
            TriggerServerEvent('rex-shopkeeper:server:rentshopkeeper', shopkeeperid)
        end
        
    end)

end)

-------------------------------------------------------------------------------------------
-- pay rent
-------------------------------------------------------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:payrent', function(data)

        local input = lib.inputDialog(Lang:t('client.lang_38'), {
            { 
                label = Lang:t('client.lang_39'),
                type = 'input',
                icon = 'fa-solid fa-dollar-sign',
                required = true
            },
        })
        if not input then
            return 
        end
        
        TriggerServerEvent('rex-shopkeeper:server:addrentmoney', input[1], data.shopkeeperid)

end)

---------------------------------------------
-- owner shopkeeper storage menu
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:ownerstoragemenu', function(data)
    lib.registerContext({
        id = 'owner_storage_menu',
        title = Lang:t('client.lang_43'),
        menu = 'shopkeeper_job_menu',
        options = {
            {
                title = Lang:t('client.lang_40'),
                icon = 'fa-solid fa-box',
                event = 'rex-shopkeeper:client:storageplayershare',
                args = { shopkeeperid = data.shopkeeperid },
                arrow = true
            },
            {
                title = Lang:t('client.lang_41'),
                icon = 'fa-solid fa-box',
                event = 'rex-shopkeeper:client:storagecrafting',
                args = { shopkeeperid = data.shopkeeperid },
                arrow = true
            },
            {
                title = Lang:t('client.lang_42'),
                icon = 'fa-solid fa-box',
                event = 'rex-shopkeeper:client:storagestock',
                args = { shopkeeperid = data.shopkeeperid },
                arrow = true
            },
        }
    })
    lib.showContext('owner_storage_menu')
end)

---------------------------------------------
-- player share storage
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:storageplayershare', function(data)
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'share_'..data.shopkeeperid, {
        maxweight = Config.ShopTrayMaxWeight,
        slots = Config.ShopTrayMaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'share_'..data.shopkeeperid)
end)

---------------------------------------------
-- crafting storage
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:storagecrafting', function(data)
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local playerjob = PlayerData.job.name
    if playerjob == data.shopkeeperid then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", 'crafting_'..data.shopkeeperid, {
            maxweight = Config.CraftingMaxWeight,
            slots = Config.CraftingMaxSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", 'crafting_'..data.shopkeeperid)
    end
end)

---------------------------------------------
-- stock storage
---------------------------------------------
RegisterNetEvent('rex-shopkeeper:client:storagestock', function(data)
    local PlayerData = RSGCore.Functions.GetPlayerData()
    local playerjob = PlayerData.job.name
    if playerjob == data.shopkeeperid then
        TriggerServerEvent("inventory:server:OpenInventory", "stash", 'stock_'..data.shopkeeperid, {
            maxweight = Config.StockMaxWeight,
            slots = Config.StockMaxSlots,
        })
        TriggerEvent("inventory:client:SetCurrentStash", 'stock_'..data.shopkeeperid)
    end
end)
