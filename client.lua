local ESX = exports['es_extended']:getSharedObject()

function openLombardMenu()
    local options = {}

    for _, v in pairs(Config.Items) do
        options[#options+1] = {
            title = v.label,
            description = 'Kaina: $' .. v.price,
            icon = 'fas fa-box',
            onSelect = function()
                openPaymentMenu(v.item, v.price)
            end
        }
    end

    exports.lation_ui:registerMenu({
        id = 'lombard_menu',
        title = 'Lombardas',
        subtitle = 'Pasirinkite prekę',
        options = options
    })

    exports.lation_ui:showMenu('lombard_menu')
end

function openPaymentMenu(item, price)
    exports.lation_ui:registerMenu({
        id = 'payment_menu',
        title = 'Atsiskaitymo būdas',
        subtitle = 'Pasirinkite mokėjimo būdą',
        menu = 'lombard_menu',
        options = {
            {
                title = 'Grynaisiais',
                description = '$' .. price,
                icon = 'fas fa-money-bill-wave',
                onSelect = function()
                    TriggerServerEvent('redt-lombardas:buyItemWithMethod', item, price, 'cash')
                end
            },
            {
                title = 'Banku',
                description = '$' .. price,
                icon = 'fas fa-university',
                onSelect = function()
                    TriggerServerEvent('redt-lombardas:buyItemWithMethod', item, price, 'bank')
                end
            }
        }
    })

    exports.lation_ui:showMenu('payment_menu')
end

CreateThread(function()
    for _, v in pairs(Config.NPC) do
        local model = `cs_bankman`
        RequestModel(model)
        while not HasModelLoaded(model) do Wait(0) end

        local ped = CreatePed(4, model, v.coords.x, v.coords.y, v.coords.z - 1.0, v.coords.w, false, true)
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)

        local blip = AddBlipForCoord(v.coords.x, v.coords.y, v.coords.z)
        SetBlipSprite(blip, 605)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Lombardas")
        EndTextCommandSetBlipName(blip)

        exports.ox_target:addLocalEntity(ped, {
            {
                name = 'lombard_action',
                icon = 'fa-solid fa-store',
                label = 'Atidaryti lombardą',
                distance = 2.0,
                onSelect = function(entity)
                    ESX.TriggerServerCallback('redt-lombardas:canAccess', function(can)
                        if can then
                            openLombardMenu()
                        else
                            exports.lation_ui:notify({
                                title = 'Klaida',
                                message = 'Šiuo metu yra dirbančių lombardo darbuotojų, apsilankyk pas juos',
                                type = 'error'
                            })
                        end
                    end)
                end
            }
        })
    end
end)

RegisterNetEvent('redt-lombardas:showNotify', function(title, message, type)
    exports.lation_ui:notify({
        title = title,
        message = message,
        type = type
    })
end)