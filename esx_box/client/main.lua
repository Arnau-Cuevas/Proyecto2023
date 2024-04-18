ESX = nil
local PlayerData              	= {}
local currentZone               = ''
local LastZone                  = ''
local CurrentAction             = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local CurrentActionName         = ''
local boxes                     = {}

ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  PlayerData = xPlayer
  TriggerEvent('esx_box:checkcheck')
end)

AddEventHandler('onResourceStart', function()
  TriggerEvent('esx_box:checkcheck')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('esx_box:checkcheck')
AddEventHandler('esx_box:checkcheck', function()
  checkIfTaken()
end)

function checkIfTaken()
  --Vacia la caja en caso de estar looteada
  for i=1, #boxes, 1 do
    boxes[i]=nil
  end

  --Actualiza las cajas, incluso si ya estan looteadas
  for k,v in pairs(Config.Box) do
    Wait(500) 
    ESX.TriggerServerCallback('esx_box:isTaken', function(isTaken)
      if isTaken == 0 then
        table.insert(boxes, {
          name = v.Name,
          posx = v.Pos.x,
          posy = v.Pos.y,
          posz = v.Pos.z,
          type = v.Type,
          size = v.Size,
        })
      end
    end, v.Name)
  end
end
-- Mostramos el mensaje al entrar en la zona para abrir la caja
AddEventHandler('esx_box:hasEnteredMarker', function(zone, name)
  if LastZone == 'containerzone' then
    CurrentAction     = 'open_container'
    CurrentActionMsg  = 'Pulsa ~INPUT_CONTEXT~ para abrir la caja'
    CurrentActionData = {zone = zone}
    CurrentActionName = name
  end
end)
-- Quitamos el mensaje al salir de la zona
AddEventHandler('esx_box:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Aqui conseguimos las coords del jugador, si esta en la zona, buscamos la caja que hay en esas coords y asignamos los items
Citizen.CreateThread(function()
  while true do
		Wait(0)
    -- Obtiene las coordenadas del jugador
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil
    
    -- Itera sobre todas las cajas para verificar la distancia entre el jugador y cada una
    for i=1,#boxes,1 do
      if(GetDistanceBetweenCoords(coords, boxes[i].posx, boxes[i].posy, boxes[i].posz, true) < 3) then
        isInMarker  = true
        currentZone = 'containerzone'
        LastZone    = 'containerzone'
        currentName = boxes[i].name
      end
    end

    -- Verificamos si el jugador ha entrado o salido de un marcador
    if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_box:hasEnteredMarker', currentZone, currentName)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_box:hasExitedMarker', LastZone)
		end
	end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if CurrentAction ~= nil then
      SetTextComponentFormat('STRING')
      AddTextComponentString(CurrentActionMsg)

      -- Mostramos lo que es la notificacion de arriba a la izquierda
      DisplayHelpTextFromStringLabel(0, 0, 1, -1)
      -- Esto es para ver si ha presionado ya la tecla (E)
      if IsControlJustReleased(0, 38) then
        if CurrentAction == 'open_container' then
          TriggerServerEvent('esx_box:found', CurrentActionName)
        end
        CurrentAction = nil
      end
    end
  end
end)

Citizen.CreateThread(function()
  while true do
    Wait(0)
    local coords = GetEntityCoords(GetPlayerPed(-1))
-- Dibuja el marcador usando la función DrawMarker con los parámetros proporcionados en 'boxes'
    for i=1,#boxes,1 do
			if (boxes[i].type ~= -1 and GetDistanceBetweenCoords(coords, boxes[i].posx, boxes[i].posy, boxes[i].posz, true) < Config.DrawDistance) then
				DrawMarker(boxes[i].type, boxes[i].posx, boxes[i].posy, boxes[i].posz, 0.0, 0.0, 0.0, 0, 0.0, 0.0, boxes[i].size.x, boxes[i].size.y, boxes[i].size.z, 100, false, true, 2, false, false, false, false)
      end
		end
  end
end)

-- Añadir el modelo caja al las coordenadas indicadas.
Citizen.CreateThread(function()
  for k,v in pairs(Config.Box) do
    RequestModel(Config.ContainerModel)
    while not HasModelLoaded(Config.ContainerModel) do
      RequestModel(Config.ContainerModel)
      Wait(1)
    end
    crate = CreateObjectNoOffset(Config.ContainerModel, v.Pos.x, v.Pos.y, v.Pos.z, false, true, false)
  end
end)

-- Esto es todo para el blip, asignamos el color, el tipo de radio, las coordenadas ...
Citizen.CreateThread(function()
  if Config.ShowBlips then
    for k,info in pairs(Config.Box) do
      info.blip = AddBlipForCoord(info.Pos.x, info.Pos.y, info.Pos.z)
      SetBlipSprite(info.blip, 66)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, 47)
      SetBlipAsShortRange(info.blip, true)
      BeginTextCommandSetBlipName("STRING")
      AddTextComponentString('Caja')
      EndTextCommandSetBlipName(info.blip)
    end
  end
end)
