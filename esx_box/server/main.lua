ESX = exports["es_extended"]:getSharedObject()

local requestesbox = {}

RegisterServerEvent('esx_box:found')
AddEventHandler('esx_box:found', function(name)
	local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  local identifier = xPlayer.getIdentifier()
  local playerName = xPlayer.getName()

  MySQL.Async.execute(
    'INSERT INTO caja (identifier, cajaname) VALUES (@identifier, @name)',
    {
      ['@identifier'] = identifier,
      ['@name']   = name,
    }
  )
  
  for i=1, #requestesbox, 1 do
    requestesbox[i]=nil
  end

  -- Recorremos las 2 cajas que tenemos y asignamos su interior.
  for k,v in pairs(Config.Box) do
    if v.Name == name then
      table.insert(requestesbox, {
        name = v.Name,
        money = v.Money,
        items = v.Items,
        weapons = v.Weapons,
      })
    end
  end

  -- Este for lo usamos para dar los items / armas
  for i=1, #requestesbox, 1 do
    if requestesbox[i].money ~= 0 then
      if Config.IsMoneyDirtyMoney then
        xPlayer.addAccountMoney('black_money', requestesbox[i].money)
      else
        xPlayer.addMoney(tonumber(requestesbox[i].money))
      end
    end
    --Dar los items
    for f,j in pairs(requestesbox[i].items) do
      xPlayer.addInventoryItem(j.Name, j.Amount)
    end
    --Dar las armas
    for f,j in pairs(requestesbox[i].weapons) do
      xPlayer.addWeapon(j.Name,j.Ammo)
    end
  end

    if Config.OnePersonOpen then
      TriggerClientEvent('esx_box:checkcheck', -1)
    else
      TriggerClientEvent('esx_box:checkcheck', source)
    end
end)

ESX.RegisterServerCallback('esx_box:isTaken',function(source, cb, name)
	local xPlayer = ESX.GetPlayerFromId(source)
  local identifier = xPlayer.getIdentifier()
  local isTaken = 0

  --Busca en la base de datos, si ya ha looteado la caja
  if Config.OnePersonOpen then
    MySQL.Async.fetchAll(
    'SELECT cajaname FROM caja WHERE cajaname = @name',
    {
      ['@identifier'] = identifier,
      ['@name'] = name
    },
    
    function(result)
      isTakenResult(result)
    end)
  else -- Consulta a la base de datos si la caja ha sido looteada por el jugador
    MySQL.Async.fetchAll(
    'SELECT cajaname FROM caja WHERE identifier = @identifier AND cajaname = @name',
    {
      ['@identifier'] = identifier,
      ['@name'] = name
    },
    
    function(result)
      isTakenResult(result)
    end)
  end

  function isTakenResult(result)
      for i=1, #result, 1 do
        -- Si la caja ya ha sido looteada, actualiza la variable isTaken a 1
        if name == result[i].cajaname then
          isTaken = 1
        end
      end
    -- Llama al callback (cb) con el resultado (isTaken) para informar al cliente
    cb(isTaken)
  end
end)