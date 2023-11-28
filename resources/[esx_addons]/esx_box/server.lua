-- Función para generar un número aleatorio
function generarNumeroAleatorio()
    -- Puedes ajustar estos valores según tus necesidades
    local min = 1
    local max = 3
    local numRandom = 0
    local numRandom2 = 0

    numRandom = math.random(min, max)

    if (numRandom > 2) then
        numRandom2 = math.random(min, max)
    else 
        numRandom2 = numRandom
    end
    return numRandom2
end
print(generarNumeroAleatorio())



-- Función para generar el contenido de la caja
function generarContenidoCaja()
    local itemAleatorio = Config.itemsCaja[generarNumeroAleatorio(1, #Config.itemsCaja)]
    return {name = itemAleatorio, count = 1}
end
-- Evento para crear la caja misteriosa
RegisterNetEvent('esx_box:crearCaja')
AddEventHandler('esx_box:crearCaja', function()
    local contenidoCaja = generarContenidoCaja()
    -- Crea la entidad de la caja en las coordenadas especificadas
    local cajaObject = CreateObjectNoOffset(GetHashKey('prop_box_wood02a_pu'), Config.coordenadasCaja.x, Config.coordenadasCaja.y, Config.coordenadasCaja.z, true, true, true)
    
    -- Asocia los datos de la caja con el contenido
    SetEntityData(cajaObject, 'item', contenidoCaja)

    TriggerClientEvent('esx_box:showNotification', source, '¡Has encontrado una caja misteriosa!')
end)

-- Evento para saquear la caja misteriosa
RegisterNetEvent('esx_box:saquearCaja')
AddEventHandler('esx_box:saquearCaja', function()
    local player = source
    local cajaObject = ESX.Game.GetClosestObject(Config.coordenadasCaja)
    if DoesEntityExist(cajaObject) then
        local contenidoCaja = GetEntityData(cajaObject, 'item')

        -- Añade el ítem al inventario del jugador
        if contenidoCaja then
            TriggerEvent('esx_addoninventory:getSharedInventory', 'society_police', function(inventory)
                inventory.addItem('item', contenidoCaja.name, contenidoCaja.count)
            end)

            TriggerClientEvent('esx_box:showNotification', player, '¡Has saqueado la caja y encontraste ' .. contenidoCaja.count .. ' ' .. contenidoCaja.name .. '!')
            DeleteObject(cajaObject)  -- Elimina la caja después de ser saqueada
        else
            TriggerClientEvent('esx_box:showNotification', player, 'La caja está vacía.')
        end
    else
        TriggerClientEvent('esx_box:showNotification', player, 'No hay ninguna caja cercana.')
    end
end)
