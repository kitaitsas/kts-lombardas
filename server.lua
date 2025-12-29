ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('redt-lombardas:canAccess', function(source, cb)
    local players = ESX.GetPlayers()
    for i = 1, #players do
        local xPlayer = ESX.GetPlayerFromId(players[i])
        if xPlayer.job.name == Config.JobName then
            cb(false)
            return
        end
    end
    cb(true)
end)

RegisterNetEvent('redt-lombardas:buyItemWithMethod', function(item, price, method)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if method == 'cash' then
        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
        else
            TriggerClientEvent('redt-lombardas:showNotify', src, 'Klaida', 'Nepakanka grynųjų', 'error')
            return
        end
    elseif method == 'bank' then
        if xPlayer.getAccount('bank').money >= price then
            xPlayer.removeAccountMoney('bank', price)
        else
            TriggerClientEvent('redt-lombardas:showNotify', src, 'Klaida', 'Nepakanka pinigų banke', 'error')
            return
        end
    end

    xPlayer.addInventoryItem(item, 1)
    TriggerClientEvent('redt-lombardas:showNotify', src, 'Sėkmingai', 'Prekė nusipirkta sėkmingai!', 'success')
end)