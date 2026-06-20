local spriteFix = function(manager)

    local removeSolidTrans = {
        "furniture_bedding_01_64",
        "furniture_bedding_01_65",
        "furniture_bedding_01_68",
        "furniture_bedding_01_69",
        "fixtures_bathroom_01_4",
        "fixtures_bathroom_01_5",
        "fixtures_bathroom_01_6",
        "fixtures_bathroom_01_7",
    }

    for _, name in pairs(removeSolidTrans) do
        manager:getSprite(name):getProperties():unset(IsoFlagType.solidtrans)
    end

    local addSolidTrans = {
        "appliances_com_01_52"
    }

    for _, name in pairs(addSolidTrans) do
        manager:getSprite(name):getProperties():set(IsoFlagType.solidtrans)
    end
end

Events.OnLoadedTileDefinitions.Add(spriteFix)