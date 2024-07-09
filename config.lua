Config = {}

---------------------------------
-- settings
---------------------------------
Config.Keybind         = 'J'
Config.Img             = "rsg-inventory/html/images/"
Config.Money           = 'cash' -- 'cash', 'bank' or 'bloodmoney'
Config.ServerNotify    = true
Config.LicenseRequired = false

---------------------------------
-- rent settings
---------------------------------
Config.MaxShopkeepers     = 1
Config.RentStartup        = 100
Config.RentPerHour        = 1
Config.ShopkeeperCronJob  = '0 * * * *' -- cronjob runs every hour (0 * * * *)
Config.MaxRent            = 100

---------------------------------
-- storage settings
---------------------------------
Config.ShopTrayMaxWeight  = 4000000
Config.ShopTrayMaxSlots   = 4
Config.CraftingMaxWeight = 4000000
Config.CraftingMaxSlots  = 48
Config.StockMaxWeight    = 4000000
Config.StockMaxSlots     = 48

---------------------------------
-- npc settings
---------------------------------
Config.DistanceSpawn = 20.0
Config.FadeIn = true

---------------------------------
-- shopkeeper locations
---------------------------------
Config.ShopkeeperLocations = {
    { 
        name = 'Valentine General Store',
        shopkeeperid = 'valshopkeeper',
        coords = vector3(-324.16, 803.59, 117.88),
        npcmodel = `u_m_m_valgenstoreowner_01`,
        npccoords = vector4(-324.16, 803.59, 117.88, 300.44),
        jobaccess = 'valshopkeeper',
        blipname = 'General Store',
        blipsprite = 'blip_shop_store',
        blipscale = 0.2,
        showblip = true
    },
    { 
        name = 'Strawberry General Store',
        shopkeeperid = 'strshopkeeper',
        coords = vector3(-1789.82, -388.17, 160.33),
        npcmodel = `u_m_m_valgenstoreowner_01`,
        npccoords = vector4(-1789.82, -388.17, 160.33, 62.35),
        jobaccess = 'strshopkeeper',
        blipname = 'General Store',
        blipsprite = 'blip_shop_store',
        blipscale = 0.2,
        showblip = true
    },
    { 
        name = 'Annesburg General Store',
        shopkeeperid = 'annshopkeeper',
        coords = vector3(2931.14, 1365.87, 45.20),
        npcmodel = `u_m_m_valgenstoreowner_01`,
        npccoords = vector4(2931.14, 1365.87, 45.20, 265.64),
        jobaccess = 'annshopkeeper',
        blipname = 'General Store',
        blipsprite = 'blip_shop_store',
        blipscale = 0.2,
        showblip = true
    },
    { 
        name = 'StDenis General Store',
        shopkeeperid = 'stdshopkeeper',
        coords = vector3(2859.31, -1202.21, 49.59),
        npcmodel = `u_m_m_valgenstoreowner_01`,
        npccoords = vector4(2859.31, -1202.21, 49.59, 14.59),
        jobaccess = 'stdshopkeeper',
        blipname = 'General Store',
        blipsprite = 'blip_shop_store',
        blipscale = 0.2,
        showblip = true
    },
    { 
        name = 'Tumbleweed General Store',
        shopkeeperid = 'tumshopkeeper',
        coords = vector3(-5485.99, -2938.03, -0.40),
        npcmodel = `u_m_m_valgenstoreowner_01`,
        npccoords = vector4(-5485.99, -2938.03, -0.40, 131.39),
        jobaccess = 'tumshopkeeper',
        blipname = 'General Store',
        blipsprite = 'blip_shop_store',
        blipscale = 0.2,
        showblip = true
    },
    { 
        name = 'Armadillo General Store',
        shopkeeperid = 'armshopkeeper',
        coords = vector3(-3687.35, -2623.48, -13.43),
        npcmodel = `u_m_m_valgenstoreowner_01`,
        npccoords = vector4(-3687.35, -2623.48, -13.43, 279.15),
        jobaccess = 'armshopkeeper',
        blipname = 'General Store',
        blipsprite = 'blip_shop_store',
        blipscale = 0.2,
        showblip = true
    },
    { 
        name = 'Blackwater General Store',
        shopkeeperid = 'blkshopkeeper',
        coords = vector3(-785.79, -1322.25, 43.88),
        npcmodel = `u_m_m_valgenstoreowner_01`,
        npccoords = vector4(-785.79, -1322.25, 43.88, 184.31),
        jobaccess = 'blkshopkeeper',
        blipname = 'General Store',
        blipsprite = 'blip_shop_store',
        blipscale = 0.2,
        showblip = true
    },
    { 
        name = 'Van-Horn General Store',
        shopkeeperid = 'vanshopkeeper',
        coords = vector3(3025.62, 562.46, 44.72),
        npcmodel = `u_m_m_valgenstoreowner_01`,
        npccoords = vector4(3025.62, 562.46, 44.72, 264.98),
        jobaccess = 'vanshopkeeper',
        blipname = 'General Store',
        blipsprite = 'blip_shop_store',
        blipscale = 0.2,
        showblip = true
    },
-- 3025.62, 562.46, 44.72, 264.98
}

---------------------------------
-- shopkeeper crafting
---------------------------------
Config.ShopkeeperCrafting = {

    {   category = 'Food',
        crafttime = 30000,
        ingredients = {
            [1] = { item = 'flour', amount = 1 },
            [2] = { item = 'water', amount = 1 },
            [3] = { item = 'yeast', amount = 1 },
        },
        receive = 'bread',
        giveamount = 10
    },

}
