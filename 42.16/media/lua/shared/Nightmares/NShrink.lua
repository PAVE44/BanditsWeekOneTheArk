BWOANightmares = BWOANightmares or {}

BWOANightmares.Shrink = {}

local cycle = 1
local cycleNumber = 100000
local returnData = {}

local function predicateAll(item)
	return true
end

BWOANightmares.Shrink.onEnter = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.returnData = {
        x = 9967,
        y = 12623,
        z = -4
    }

    BWOAEventControl.Add("FadeOut", {time = 0}, 0)
    BWOAEventControl.Add("FadeIn", {time = 5}, 3400)
 
    player:setX(18003.5)
    player:setY(4203.5)
    player:setZ(-3)
    player:setLastX(18003.5)
    player:setLastY(4203.5)
    player:setLastZ(-3)

    local wornItems = player:getWornItems()
    local inventory = player:getInventory()
    local clothes = {
        "Base.Socks_Ankle_Black",
        "Base.Shoes_Black",
        "Base.Shirt_FormalWhite",
        "Base.Trousers_Denim",
        "Base.Suit_Jacket",
    }

    for _, item in pairs(clothes) do
        local clothingItem = BanditCompatibility.InstanceItem(item)
        inventory:AddItem(clothingItem)
        wornItems:setItem(clothingItem:getBodyLocation(), clothingItem)
    end
    player:setWornItems(wornItems)

    local humanVisual = player:getHumanVisual()
    humanVisual:removeBlood()
    humanVisual:removeDirt()

    getWorld():update()
end

BWOANightmares.Shrink.onCycle = function(player)
    local gmd = GetBWOAModData()
    local cycle = gmd.nightmares.cycle or 1

    if cycle > 600 and cycle % 8 == 0 then
        BanditUtils.ClearZombies(17950, 18050, 4150, 4250)
    end

    getWorld():getClimateManager():stopWeatherAndThunder()

    gmd.nightmares.cycle = cycle + 1
end

BWOANightmares.Shrink.ShouldExit = function(player)

    if player:getX() > 18006.1 and player:getY() < 4203 then
        return true
    end

    return false
end

BWOANightmares.Shrink.onExit = function(player)
    local gmd = GetBWOAModData()

    local wornItems = player:getWornItems()
    local inventory = player:getInventory()
    inventory:clear()
    wornItems:clear()

    local clothes = {
        "Base.HospitalGown",
    }

    for _, item in pairs(clothes) do
        local clothingItem = BanditCompatibility.InstanceItem(item)
        inventory:AddItem(clothingItem)
        wornItems:setItem(clothingItem:getBodyLocation(), clothingItem)
    end
    player:setWornItems(wornItems)

    player:setX(gmd.nightmares.returnData.x)
    player:setY(gmd.nightmares.returnData.y)
    player:setZ(gmd.nightmares.returnData.z)
    player:setLastX(gmd.nightmares.returnData.x)
    player:setLastY(gmd.nightmares.returnData.y)
    player:setLastZ(gmd.nightmares.returnData.z)
    getWorld():update()
end

BWOANightmares.Shrink.onPost = function(player)
    local gmd = GetBWOAModData()
    gmd.nightmares.cycle = 1
    gmd.nightmares.returnData = nil

    BWOASequence.Epilogue()
end
