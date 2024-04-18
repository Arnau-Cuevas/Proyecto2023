Config              = {}
Config.DrawDistance = 100.0
Config.IsMoneyDirtyMoney = false -- Si ponemos true, el dinero que da la caja sera sucio, al estar en falso, no da dinero sucio.
Config.ShowBlips = true -- Para enseñar el blip en el mapa
Config.ContainerModel = "prop_box_wood02a_mws" -- Modelo de la caja
Config.OnePersonOpen = false -- Al ponerlo falso, la caja la puede abrir cada persona una sola vez, si queremos que solo la primera persona quiera lootearla, ponemos true.
Config.MarkerCircle = 1 -- Establecemos la area que queremos.

Config.Box = {
	Box1 = {
		Name = "Caja de Prueba item",
		Pos = {x = 160.7930, y = -789.7488, z = 30.20}, -- Coordenadas
		Size = {x = 5.0, y = 5.0, z = 1.0}, -- El tamaño del area (circulo)
		Type = Config.MarkerCircle, -- Guardamos el tipo de circulo, que lo hemos declarado arriba
		Money = 5000,
		Items = { -- Por si queremos que de varios items, usamos esta array
			Item1 = {
				Name = 'water',
				Amount = 5,
			},
			Item2 = {
				Name = 'bread',
				Amount = 5,
			},
		},
		Weapons = {
		},
	},
	Box2 = {
		Name = "Caja de Prueba arma",
		Pos = {x = 168.3456, y = -772.3141, z = 31.0185},
		Size = {x = 5.0, y = 5.0, z = 1.0},
		Type = Config.MarkerCircle,
		Money = 5000,
		Items = {
		},
		Weapons = { -- Por si queremos dar varias armas pues usamos esta array
			Weapon1 = { 
				Name = 'WEAPON_APPISTOL',
				Ammo = 80,
			},
			Weapon2 = {
				Name= 'weapon_specialcarbine',
				Ammo = 60,
			},
			Weapon3 = {
				Name= 'weapon_molotov',
				Ammo = 2,
			},
		},
	},
}