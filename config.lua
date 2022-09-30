Config                 = {}
Config.DrawDistance    = 10.0
Config.MaxErrors       = 6
Config.SpeedMultiplier = 3.4
Config.Locale          = 'en'

Config.Prices = {
	dmv         = 200,
	drive       = 500
}

Config.VehicleModels = {
	drive = 'cheburek'
}


Config.SpeedLimits = {
	residence = 50,
	town      = 80,
	freeway   = 130
}

local manevar = false

Config.Zones = {

	DMVSchool = {
		Pos   = {x = 233.31, y = -410.41, z = 47.11, h = 150.37},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 9, b = 255},
		Type  = 23
	},

	VehicleSpawnPoint = {
		Pos   = {x = 206.2, y = -356.01, z = 43.45, h = 252.03}, -- vector3(206.2, -356.01, 43.45)
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 0, g = 9, b = 255},
		Type  = -1
	}

}

Config.CheckPoints = {

	{
		Pos = {x = 209.50, y = -345.82, z = 42.52}, -- 209.50735473633,-345.82284545898,43.525169372559
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Dobrodosao na ispit voznje! Izadji sa parkinga i skreni levo!", 5000)
		end
	},

	{
		Pos = {x = 280.7, y = -385.6, z = 43.4}, -- 280.66796875,-385.65878295898,44.466453552246
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Sada skreni desno!", 5000)
		end
	},

	{
		Pos = {x = 293.73, y = -457.06, z = 41.65}, -- 293.73358154297,-457.06509399414,42.650310516357
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Skreni levo i ukljuci se na autoput!", 5000)
			setCurrentZoneType('freeway')
		end
	},

	{
		Pos = {x = 76.57, y = -477.94, z = 32.32}, -- 76.57120513916,-477.94842529297,33.326526641846
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Iskljuci se kod petlje u blizini Bahame i studija!", 5000)
		end
	},

	{
		Pos = {x = -1038.55, y = -566.38, z = 16.69}, -- -1038.5538330078,-566.38470458984,17.69931602478
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Uspori i stani na semafor!", 5000)
		end
	},

	{
		Pos = {x = -1159.94, y = -633.80, z = 20.95}, -- -1159.943359375,-633.80334472656,21.958505630493
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Skreni desno!", 5000)
			setCurrentZoneType('town')
		end
	},

	{
		Pos = {x = -1214.09, y = -605.28, z = 25.53}, -- -1214.0906982422,-605.28643798828,26.536508560181
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Sada levo!", 5000)
			setCurrentZoneType('residence')
		end
	},

	{
		Pos = {x = -1419.42, y = -731.77, z = 21.92}, -- -1419.4270019531,-731.77770996094,22.923864364624
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Idi levo u ovaj bulevar. Zar nije lepo ovde?", 5000)
			setCurrentZoneType('town')
		end
	},

	{
		Pos = {x = -1360.42, y = -833.05, z = 16.15}, -- -1360.4255371094,-833.05151367188,17.155054092407
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Skreni desno!", 5000)
			setCurrentZoneType('residence')
		end
	},

	{
		Pos = {x = -1398.95, y = -899.17, z = 9.77}, -- -1398.9577636719,-899.17938232422,10.779403686523
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Opet desno!", 5000)
		end
	},

	{
		Pos = {x = -1539.66, y = -851.96, z = 8.53}, -- -1539.6688232422,-851.96496582031,9.533899307251
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Ovde moras levo!", 5000)
		end
	},


	-- ---------------------------------------------- 	POLIGON ----------------------------------------

	-- prvo do kraja u prvoj
	--onda rikverc promeni traku prvo u levu pa posle u desnu
	-- onda do kraja u drugoj
	-- tri manevra
	-- paralelno parkiranje
	-- poprecno parkiranje


	{
		Pos = {x = -1610.20, y = -894.22, z = 7.67}, -- -1610.2020263672,-894.22619628906,8.6752901077271
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Udji na poligon!", 5000)
			setCurrentZoneType("town")
		end
	},

	{
		Pos = {x = -1661.65, y = -850.45, z = 7.67}, -- -1661.6547851563,-850.45617675781,8.6720705032349 PRVA DO KRAJA
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Ovde do kraja moras prvu, pazi da mi ne sjebes lamelu!", 5000)
			local rotation = GetEntityHeading(vehicle)
			print(rotation)
			if not ((rotation < 80) and (rotation > 20)) then 
				print("nije")
				dajPoen()
			else print("jeste")
			end 
		end
	},

	{
		Pos = {x = -1647.90, y = -866.92, z = 7.57}, -- -1647.9020996094,-866.92932128906,8.5774440765381 RIKVERC LEVA
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Sada idi u rikverc i prebaci se u drugu traku!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 80) and (rotation > 20)) then 
				print("nije")
				dajPoen()
			else print("jeste")
			end 
			
		end
	},

	{
		Pos = {x = -1628.06, y = -878.46, z = 7.71}, -- -1628.0672607422,-878.46490478516,8.7163963317871 rikverc mdesna
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Idalje se u rikverc vrati nazad u tvoju prvobitnu desnu traku!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 80) and (rotation > 20)) then
				dajPoen()
			else print("jeste")
			end
		end
	},

	{
		Pos = {x = -1610.20, y = -894.22, z = 7.67}, -- -1610.2020263672,-894.22619628906,8.6752901077271
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Sada idi do kraja i prebaci ga bar u drugu!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 80) and (rotation > 20)) then
				dajPoen()
			else print("jeste")
			end
		end
	},

	{
		Pos = {x = -1661.65, y = -850.45, z = 7.67}, -- DRUGA DO KRAJA
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Sada se okreni polukruzno u 3 manevra!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 80) and (rotation > 20)) then 
				dajPoen()
			end

			-- poruka da se pali 3 manevra
			--[[CreateThread(function()
				local manevarWSCount = -1
				local manevarADCount = -1
				local lastWS = nil 
				local lastAD = nil
				while manevar do 
					if IsControlJustPressed(0, 77) then -- W
						print("napred")
						if ((lastWS == "s") or (not lastWS)) then 
							lastWS = "w"
							manevarWSCount = manevarWSCount + 1
							if manevarWSCount > 3 then 
								--notifikacija da je usro
								dajPoen()
								manevar = false
							end
						end 
					end 

					if IsControlJustPressed(0, 78) then -- s
						print("nazad")
						if ((lastWS == "w") or (not lastWS)) then 
							lastWS = "s"
							manevarWSCount = manevarWSCount + 1
							if manevarWSCount > 3 then 
								--notifikacija da je usro
								dajPoen()
								manevar = false
							end
						end 
					end


					if IsControlJustPressed(0, 278) then -- a
						print("levo")
						if ((lastAD == "d") or (not lastAD)) then 
							lastAD = "a"
							manevarADCount = manevarADCount + 1
							if manevarADCount > 3 then 
								--notifikacija da je usro
								dajPoen()
								manevar = false
							end
						end 
					end 

					if IsControlJustPressed(0, 279) then -- d
						print("desno")
						if ((lastAD == "a") or (not lastAD)) then 
							lastAD = "d"
							manevarADCount = manevarADCount + 1
							if manevarADCount > 3 then 
								--notifikacija da je usro
								dajPoen()
								manevar = false
							end
						end 
					end 


					Wait(50)
				end 
			end)]]

		end
	},

	{
		Pos = {x = -1661.19, y = -854.93, z = 7.58}, -- -1661.1993408203,-854.93487548828,8.584490776062 polukruzno u 3 manevra
		Action = function(playerPed, vehicle, setCurrentZoneType)
			manevar = false
			DrawMissionText("~g~Instruktor~w~: Sada idi do mesta za paralelno parkiranje!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 260) and (rotation > 200)) then
				dajPoen()
			end
		end
	},

	{
		Pos = {x = -1652.83, y = -862.73, z = 7.57}, -- -1652.8366699219,-862.73974609375,8.5743112564087 ISPRED PARALELNOG
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Sada se parkiraj unutra!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 260) and (rotation > 200)) then 
				dajPoen()
			end
		end
	},

	{
		Pos = {x = -1659.08, y = -861.75, z = 7.50}, -- -1659.0825195313,-861.75524902344,8.5085601806641 paralelno unutra
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Imas tacno 5 sekundi da izvrsis korekciu, inace gubis poen!", 5000)
			Wait(5000)
			DrawMissionText("~g~Instruktor~w~: Sada se isparkiraj, i idi do mesta za uzduzno parkiranje!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 230) and (rotation > 220)) then
				dajPoen()
			end
		end
	},

	{
		Pos = {x = -1643.91, y = -870.60, z = 7.56}, -- -1643.9116210938,-870.60577392578,8.5628881454468 ispred uzduznog
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Sada se parkiraj unutra!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 260) and (rotation > 200)) then 
				dajPoen()
			end

		end
	},

	{
		Pos = {x = -1647.24, y = -874.67, z = 7.46}, -- -1647.2413330078,-874.67761230469,8.4694471359253 U UZDUZNOM
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Imas tacno 5 sekundi da izvrsis korekciu, inace gubis poen!", 5000)
			Wait(5000)
			DrawMissionText("~g~Instruktor~w~: Sada se isparkiraj, i idi do mesta za kretanje na uzbrdici pod rucnom!", 5000)
			local rotation = GetEntityHeading(vehicle)
			if not ((rotation < 325) and (rotation > 315)) then 
				dajPoen()
			end
		end
	},

	{
		Pos = {x = -1631.86, y = -880.88, z = 8.31}, -- -1631.8640136719,-880.88244628906,9.3162260055542 na rampi
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Podgnuta ti je rucna, sacekaj par sekundi!", 3000)
			-- FREZANJE
			FreezeEntityPosition(vehicle, true)
			Wait(3000)
			FreezeEntityPosition(vehicle, false)
			DrawMissionText("~g~Instruktor~w~: Sada kreni!", 5000)
		end
	},

	{
		Pos = {x = -1612.25, y = -897.11, z = 7.57}, -- -1612.2554931641,-897.11163330078,8.5752048492432 kraj poligona
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText("~g~Instruktor~w~: Izadji sa poligona i skreni levo!", 5000)
		end
	},

	-- ---------------------------------------------------------------------------------------------------

	{
		Pos = {x = -1564.07, y = -857.79, z = 8.53}, -- -1564.0769042969,-857.79772949219,9.5311269760132
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = -1369.19, y = -985.44, z = 7.29}, -- -1369.1923828125,-985.44195556641,8.295786857605
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = -1237.34, y = -1355.39, z = 2.44}, -- -1237.3411865234,-1355.3999023438,3.4484663009644
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
			setCurrentZoneType("town")
		end
	},

	{
		Pos = {x = -787.57, y = -1135.44, z = 9.02}, -- -787.57373046875,-1135.4490966797,10.027517318726
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = -647.83, y = -1297.71, z = 9.09}, -- -647.83752441406,-1297.7121582031,10.09664440155
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = -540.84, y = -1181.37, z = 17.14}, -- -540.84564208984,-1181.3723144531,18.148410797119
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = -241.47, y = -1435.69, z = 29.78}, -- -241.47964477539,-1435.6909179688,30.780567169189
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = -124.20, y = -1381.56, z = 27.86}, -- -124.2049407959,-1381.5646972656,28.868743896484
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 129.48, y = -1387.18, z = 27.72}, -- 129.48837280273,-1387.1828613281,28.722875595093
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 442.43, y = -1618.90, z = 27.76}, -- 442.43728637695,-1618.9068603516,28.769180297852
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 544.66, y = -1553.32, z = 27.66}, -- 544.6630859375,-1553.3214111328,28.66802406311
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
			setCurrentZoneType("residence")
		end
	},
	{
		Pos = {x = 503.21, y = -840.78, z = 23.35}, -- 503.21472167969,-840.78283691406,24.356599807739
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 424.14, y = -822.27, z = 27.49}, -- 424.14068603516,-822.27319335938,28.498765945435
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 403.54, y = -834.73, z = 28.68}, -- 403.54510498047,-834.73498535156,28.687738418579
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 312.69, y = -854.88, z = 27.77}, -- 312.69390869141,-854.88610839844,28.772260665894
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 200.08, y = -817.02, z = 29.40}, -- 200.08087158203,-817.02777099609,30.409170150757
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 311.17, y = -410.62, z = 43.56}, -- 311.1780090332,-410.62808227539,44.561981201172
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	
	{
		Pos = {x = 284.70, y = -338.50, z = 43.91}, -- 284.70248413086,-338.50857543945,44.91987991333
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
			DeleteEntity(InstructorPed)
		end
	},

}
