local spriteFix = function(manager)

    local removeSolidTrans = {
        "furniture_bedding_01_64",
        "furniture_bedding_01_65",
        "furniture_bedding_01_68",
        "furniture_bedding_01_69",
    }

    for _, name in pairs(removeSolidTrans) do
        manager:getSprite(name):getProperties():unset(IsoFlagType.solidtrans)
    end
end

Events.OnLoadedTileDefinitions.Add(spriteFix)