Config = {}

Config.Money = math.random(450, 895)
Config.randomNumber = math.random(1, 2)

Config.pedMenu = {
    {
        coords = vec3(-1083.0610, -245.7139, 37.7632),  -- Updated coordinates for the ped interaction area
        pedCoords = vec3(-1083.0610, -245.7139, 36.7632),  -- Ped's position, adjusted slightly (1 unit lower)
        spawnCoords = vec3(-953.3488, -1285.1317, 5.0335),  -- Vehicle spawn location (unchanged)
        spawnHeading = 317.2913,  -- Direction vehicle faces when spawned (unchanged)
        size = vec3(1.0, 1.0, 1.0),  -- Interaction size (unchanged)
        heading = 212.6496,  -- Ped heading (unchanged)
        pedHash = 'ig_lifeinvad_02',  -- Ped model hash (unchanged)
        pedName = 'ig_lifeinvad_02',  -- Ped name (unchanged)
        label = 'Цонко Флашката',  -- "Start Work"
        icon = 'fa-solid fa-warehouse',  -- Ped icon (unchanged)
        groups = 'itjob',  -- Updated job group to 'itjob'
        distance = 5.5  -- Distance for player interaction
    }
}

Config.vehiclePacket = {
    {
        label = 'Вземи Инструменти',  -- "Take Package"
        icon = 'fa-solid fa-box',
        groups = 'itjob'  -- Updated job group to 'itjob'
    }
}

Config.Locations = {
    [1] = {vector3 = {-227.2313, -2000.2030, 24.6854, 77.7314}}, --арена
    [2] = {vector3 = {258.5564, -1076.9930, 29.2943, 93.5423}}, --община
    [3] = {vector3 = {-587.2784, -583.4031, 34.6818, 213.4402}}, -- молл
    [4] = {vector3 = {-709.5755, -905.1635, 19.2156, 106.1662}}, --бензиостанция
    [5] = {vector3 = {-777.0447, 5595.9565, 33.7408, 56.2434}}, --ловен
    [6] = {vector3 = {-67.8204, 6254.0293, 31.0901, 216.0234}}, -- кланица 1
    [7] = {vector3 = {-86.8401, 6237.2998, 31.0903, 19.9039}}, --кланице 2
    [8] = {vector3 = {-68.0804, 6253.8540, 31.0902, 227.0881}}, --кланице 3
    [9] = {vector3 = {1735.1659, 6420.4653, 35.0372, 305.6912}}, -- бензиостанция палето
    [10] = {vector3 = {1706.8706, 4920.9502, 42.0636, 328.2386}}, -- бензиостанция санди 1
    [11] = {vector3 = {2527.2473, 4119.7568, 38.9182, 168.4379}}, -- санди шоп
    [12] = {vector3 = {545.8228, 2662.8784, 42.1565, 168.0534}}, -- санди магазин 2
    [13] = {vector3 = {1186.7325, 2637.3193, 38.4019, 2.2117}}, -- санди гараж
    [14] = {vector3 = {1902.1047, 2605.7441, 45.9662, 19.9258}}, -- затвор 1
    [15] = {vector3 = {1840.1493, 2574.6326, 46.0143, 187.6095}}, -- затвор 2
    [16] = {vector3 = {2549.7620, 386.6251, 108.6229, 81.1718}}, -- магистрала 
    [17] = {vector3 = {1159.8885, -315.0780, 69.2050, 107.9497}}, -- миррор парк 
    [18] = {vector3 = {-347.6874, -128.7016, 39.0097, 64.4571}}, -- механици
    [19] = {vector3 = {570.8788, -3123.5261, 18.7686, 269.1801}}, -- докове
    [20] = {vector3 = {-1144.1248, -2001.1426, 13.1803, 315.2194}}, -- летище



}
