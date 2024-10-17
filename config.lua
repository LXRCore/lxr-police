Config = {}

-- Blip and Job Configuration
Config.ShowBlips = true

-- Job Roles and Permissions
Config.EvidenceJobs = {
    police = true
}
Config.BlipsJobs = {
    police = true, 
    ambulance = true
}
Config.Law = {
    police = true, 
    sheriff = true
}

-- Evidence System
Config.EvidenceRange = 2.5

-- Object Props Configuration
Config.Objects = {
    cone = { model = "prop_roadcone02a", freeze = false },
    barrier = { model = "prop_barrier_work06a", freeze = true },
    roadsign = { model = "prop_snow_sign_road_06g", freeze = true },
    tent = { model = "prop_gazebo_03", freeze = true },
    light = { model = "prop_worklight_03b", freeze = true }
}

-- Handcuff Item Definition
Config.HandCuffItem = 'handcuffs'

-- Rank required for License Access
Config.LicenseRank = 2

-- Location Data for Police Activities
Config.Locations = {
    duty = {
        vector3(1362.05, -1301.83, 77.77),  -- Valentine
        vector3(2507.53, -1301.41, 48.95),  -- Saint Denis
        vector3(-768.03, -1266.37, 44.05),  -- Blackwater
        vector3(-1812.03, -354.09, 164.65)  -- Strawberry
    },
    stash = {
        vector3(1359.24, -1299.65, 77.76),
        vector3(2497.01, -1301.2, 48.96),
        vector3(-766.55, -1271.61, 44.05),
        vector3(-1812.43, -355.87, 164.65)
    },
    armory = {
        vector3(1361.16, -1305.7, 77.76),
        vector3(2494.53, -1304.32, 48.95),
        vector3(-764.86, -1272.43, 44.04),
        vector3(-1813.93, -354.78, 164.65)
    },
    evidence = {
        vector3(1361.39, -1303.77, 77.77),
        vector3(2494.44, -1313.39, 48.95),
        vector3(-761.98, -1272.62, 44.05),
        vector3(-1807.17, -348.29, 164.66)
    },
    stations = {
        { label = "Sheriff", coords = vector3(1360.88, -1301.53, 77.77) },
        { label = "Saint Denis Police Dept. HQ", coords = vector3(2501.83, -1309.04, 48.95) },
        { label = "Blackwater Police Dept.", coords = vector3(-760.47, -1269.14, 44.04) },
        { label = "Strawberry Sheriff", coords = vector3(-1810.57, -350.91, 164.66) }
    }
}

-- Weapon Hashes and Whitelisted Items
Config.WeaponHashes = {}
Config.ArmoryWhitelist = {}
Config.WhitelistedVehicles = {}

-- Armory Items
Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        {
            name = "weapon_revolver_cattleman",
            price = 0,
            amount = 1,
            info = { serie = "" },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = { 0, 1, 2, 3, 4 }
        },
        {
            name = "weapon_repeater_winchester",
            price = 0,
            amount = 1,
            info = { serie = "" },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = { 0, 1, 2, 3, 4 }
        },
        {
            name = "weapon_melee_lantern",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 3,
            authorizedJobGrades = { 0, 1, 2, 3, 4 }
        },
        {
            name = "weapon_lasso",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = { 0, 1, 2, 3, 4 }
        },
        {
            name = "ammo_revolver",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = { 0, 1, 2, 3, 4 }
        },
        {
            name = "ammo_repeater",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
            authorizedJobGrades = { 0, 1, 2, 3, 4 }
        }
    }
}
