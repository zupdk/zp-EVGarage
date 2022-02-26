Config = {}

Config.PoliceLocations = {
    ["lspd"] = {
        label = "MRPD - LSPD",
		ped = "ig_trafficwarden",
        coords = vector4(460.06, -986.66, 25.7, 87.52),
		spawn = vector4(445.99, -988.64, 25.29, 267.95),
    },
	["lscs"] = {
        label = "BCSD - BCSO",
		ped = "ig_prolsec_02",
        coords = vector4(1863.8, 3690.61, 34.27, 299.33),
		spawn = vector4(1869.18, 3696.18, 33.55, 209.16),
    }
}

Config.PoliceVehicles = {
	["police"] = "Police Car",
	["police2"] = "Police Car2"
}

Config.EMSLocations = {
    ["phillbox"] = {
        label = "Phillbox - EMS",
		ped = "s_m_m_paramedic_01",
        coords = vector4(336.37, -589.75, 28.8, 339.85),
		spawn = vector4(330.19, -588.1, 28.57, 339.36),
    },
	["sandy"] = {
        label = "SSMC - EMS",
		ped = "s_m_m_paramedic_01",
        coords = vector4(1830.74, 3693.05, 34.22, 33.11),
		spawn = vector4(1841.09, 3702.04, 32.63, 303.02),
    }
}

Config.EMSVehicles = {
	["ambulance"] = "Ambulance"
}