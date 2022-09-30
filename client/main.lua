ESX                     = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint = 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local DriveErrors       = 0
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil
insert = false
elements = {}

dajPoen = function()
	DriveErrors = DriveErrors + 1
	ESX.ShowNotification(_U('errors', DriveErrors, Config.MaxErrors))
end 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function StartTheoryTest()
	CurrentTest = 'theory'

	SendNUIMessage({
		openQuestion = true
	})

	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

	TriggerServerEvent('revolucija_autoskola:plati', Config.Prices['dmv'])
end

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage({
		openQuestion = false
	})

	SetNuiFocus(false)

	if success then
		ESX.ShowNotification(_U('passed_test'))
		table.remove(elements, 1)
		table.insert(elements, {
			label = (('%s: <span style="color:green;">%s</span>'):format(_U('road_test_car'), _U('school_item', ESX.Math.GroupDigits(Config.Prices['drive'])))),
			value = 'drive_test',
			type = 'drive'
		})
	else
		ESX.ShowNotification(_U('failed_test'))
		currentZone = "DMVSchool"
	end
end



function spawnPed(pedName, coords, heading, isNetwork, bScriptHostPed) 
    local pedModelHash = GetHashKey(pedName)

    RequestModel(pedModelHash)
    while not HasModelLoaded(pedModelHash) do
        Wait(1)
    end
    
    local npcPedModel = CreatePed(2, pedModelHash, coords, heading, isNetwork, bScriptHostPed)
    return npcPedModel
end

InstructorPed = nil 

function StartDriveTest(type)
	ESX.Game.SpawnVehicle(Config.VehicleModels[type], vector3(284.70, -338.50, 43.91), 69.69, function(vehicle)

		ESX.Game.SetVehicleProperties(vehicle, {
			color1 = 28,
			color2 = 12, 
			modFrontBumper = 2,
			modRearBumper = 2,
		})

		InstructorPed = spawnPed("a_m_m_business_01", vector3(284.70, -338.50, 43.91), 69.69, true, true)

		CurrentTest       = 'drive'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = PlayerPedId()
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		TaskWarpPedIntoVehicle(InstructorPed, vehicle, 0)

	end)

	TriggerServerEvent('revolucija_autoskola:plati', Config.Prices[type])
end

function StopDriveTest(success)
	if success then
		table.remove(elements, 1)
		ESX.ShowNotification(_U('passed_test'))
		TriggerServerEvent('revolucija_autoskola:dajDozvolu', GetPlayerServerId(PlayerId()))
		currentZone = "DMVSchool"
	else
		ESX.ShowNotification(_U('failed_test'))
	end

	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
ESX.ShowNotification("Novo ogranicenje je " .. Config.SpeedLimits[type] .. " km/h.")
end

function OpenDMVSchoolMenu()

	ESX.TriggerServerCallback("revolucija_core:proveriItem", function(ima)
		if not ima then
      		if (insert == false) then
				table.insert(elements, {
					label = (('%s: <span style="color:green;">%s</span>'):format(_U('theory_test'), _U('school_item', ESX.Math.GroupDigits(Config.Prices['dmv'])))),
					value = 'theory_test'
				})
				insert = true
			end
		else
			TriggerEvent('panama_notifikacije:sendNotification', 'fas fa-id-card', 'Već imate vozačku!', 2000)
		end
  	end, 'vozackadozvolaa')

	while not insert do Wait(20) end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions', {
		css      = 'meni',
		title    = 'Auto Škola',
		elements = elements,
		align    = 'top-left'
	}, function(data, menu)
		if data.current.value == 'theory_test' then
			menu.close()
			StartTheoryTest()
		elseif data.current.value == 'drive_test' then
			StartDriveTest(data.current.type)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'dmvschool_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end)
end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})

	cb()
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb()
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb()
end)

AddEventHandler('esx_dmvschool:hasEnteredMarker', function(zone)
	if zone == 'DMVSchool' then
		CurrentAction     = 'dmvschool_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_dmvschool:hasExitedMarker', function(zone)
	CurrentAction = nil
	TriggerEvent('panama_notifikacije:sendFloatingText')
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(233.31, -410.41, 47.11)

	SetBlipSprite (blip, 498)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.7)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString('Auto Škola')
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        local letSleep = true
		local coords = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(6, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, -180, 0.0, 0.0, 1.5, 1.5, 1.5, 49, 105, 235, 100, false, true, 2, false, false, false, false)
				--DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, -180, 0.0, 0.0, 2.5, 2.5, 2.5, 49, 105, 235, 100, false, true, 2, false, false, false, false)
				letSleep = false
			end

			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end
		
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_dmvschool:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_dmvschool:hasExitedMarker', LastZone)
		end

		if letSleep then
			Citizen.Wait(2000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if CurrentTest == 'theory' then
			local playerPed = PlayerPedId()

			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if CurrentAction then
			TriggerEvent('panama_notifikacije:sendFloatingText', CurrentActionMsg)

			if IsControlJustReleased(0, 38) then
				if CurrentAction == 'dmvschool_menu' then
					OpenDMVSchoolMenu()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

-- Drive test
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentTest == 'drive' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.ShowNotification(_U('driving_test_complete'))

				if DriveErrors < Config.MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(1000)
		end
	end
end)

-- Speed / Damage control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'drive' then

			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							ESX.ShowNotification(_U('driving_too_fast', v))
							ESX.ShowNotification(_U('errors', DriveErrors, Config.MaxErrors))
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					ESX.ShowNotification(_U('you_damaged_veh'))
					ESX.ShowNotification(_U('errors', DriveErrors, Config.MaxErrors))

					-- avoid stacking faults
					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)
