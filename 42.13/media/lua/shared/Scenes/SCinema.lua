require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Cinema = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Cinema:placeObjects()

    -- VHS shelves
    BWOABuildTools.Generic(10186, 12633, -1, "location_entertainment_theatre_01_120")
    BWOABuildTools.Generic(10187, 12633, -1, "location_entertainment_theatre_01_121")
    --[[
    BWOABuildTools.Generic(10186, 11635, -1, "location_entertainment_theatre_01_128")
    BWOABuildTools.Generic(10187, 11635, -1, "location_entertainment_theatre_01_129")

    BWOABuildTools.Generic(10184, 11635, -1, "location_entertainment_theatre_01_123")
    BWOABuildTools.Generic(10184, 11636, -1, "location_entertainment_theatre_01_122")
    ]]

end

function BWOAScenes.Cinema:placeItems()
    
    local tapes = {
        {id="07b0cd73-7563-4699-9fb4-99316a0fc0bd"}, -- Carzone E1
        {id="7b192b30-ea36-4395-a5e4-ac2d825d3b91"}, -- Carzone E2
        {id="313fa630-d448-44ab-b1f0-7cff1d1db830"}, -- Carzone E3
        {id="dedd4e83-6e3b-4f4f-9c9b-72a5ed08969d"}, -- Woodcraft E1
        {id="c2d01da8-8e04-4889-8676-bb633e98df2d"}, -- Woodcraft E2
        {id="3e9c5cf0-bf40-40eb-bcd7-4fd6c5ae58ca"}, -- Woodcraft E3
        {id="0627a89a-a32b-4e80-9926-815aa9d22b2b"}, -- Woodcraft E4
        {id="2bf49f71-0d46-43aa-bbfd-f311e5bda9b2"}, -- Woodcraft E5
        {id="968591cd-d4aa-4ef1-9632-7771a1f5b9ab"}, -- Woodcraft E6
        {id="01dedfea-62eb-4ae6-a4bc-5e629b7ba54b"}, -- Woodcraft E7
        {id="ccfd97d7-6b57-432c-bca7-f9a271f8012f"}, -- Exposure Survival E1
        {id="6f1be5b5-d871-4ebf-bc44-2657f7c89bb5"}, -- Exposure Survival E2
        {id="7402fb83-b5b3-4b08-99f9-82bc67f4572b"}, -- Exposure Survival E3
        {id="a628a723-ac78-4bcb-927a-f84ad8c6c286"}, -- Exposure Survival E4
        {id="1123df57-5e9b-4d61-88f1-7561949132e3"}, -- Exposure Survival E5
        {id="75928dcd-c613-4a1e-afb5-20c4c671b835"}, -- Exposure Survival E6
        {id="2dcd687b-ac76-4b33-b0b7-79ddfba2feb4"}, -- Exposure Survival E7
        {id="f74df7fc-20ae-4600-b2d2-f504d9355440"}, -- Exposure Survival E8

        -- Media: VHS: Carzone E1 [id: 07b0cd73-7563-4699-9fb4-99316a0fc0bd]
        -- Media: VHS: Carzone E2 [id: 7b192b30-ea36-4395-a5e4-ac2d825d3b91]
        -- Media: VHS: Carzone E3 [id: 313fa630-d448-44ab-b1f0-7cff1d1db830]
        -- Media: VHS: Woodcraft E1 [id: dedd4e83-6e3b-4f4f-9c9b-72a5ed08969d]
        -- Media: VHS: Woodcraft E2 [id: c2d01da8-8e04-4889-8676-bb633e98df2d]
        -- Media: VHS: Woodcraft E3 [id: 3e9c5cf0-bf40-40eb-bcd7-4fd6c5ae58ca]
        -- Media: VHS: Woodcraft E4 [id: 0627a89a-a32b-4e80-9926-815aa9d22b2b]
        -- Media: VHS: Woodcraft E5 [id: 2bf49f71-0d46-43aa-bbfd-f311e5bda9b2]
        -- Media: VHS: Woodcraft E6 [id: 968591cd-d4aa-4ef1-9632-7771a1f5b9ab]
        -- Media: VHS: Woodcraft E7 [id: 01dedfea-62eb-4ae6-a4bc-5e629b7ba54b]
        -- Media: VHS: Exposure Survival E1 [id: ccfd97d7-6b57-432c-bca7-f9a271f8012f]
        -- Media: VHS: Exposure Survival E2 [id: 6f1be5b5-d871-4ebf-bc44-2657f7c89bb5]
        -- Media: VHS: Exposure Survival E3 [id: 7402fb83-b5b3-4b08-99f9-82bc67f4572b]
        -- Media: VHS: Exposure Survival E4 [id: a628a723-ac78-4bcb-927a-f84ad8c6c286]
        -- Media: VHS: Exposure Survival E5 [id: 1123df57-5e9b-4d61-88f1-7561949132e3]
        -- Media: VHS: Exposure Survival E6 [id: 75928dcd-c613-4a1e-afb5-20c4c671b835]
        -- Media: VHS: Exposure Survival E7 [id: 2dcd687b-ac76-4b33-b0b7-79ddfba2feb4]
        -- Media: VHS: Exposure Survival E8 [id: f74df7fc-20ae-4600-b2d2-f504d9355440]
    }
    
    local mediaRecorder = ZomboidRadio.getInstance():getRecordedMedia()
    local preserve = false
    for _, tapeConf in pairs(tapes) do
        local item = BanditCompatibility.InstanceItem("Base.VHS_Retail")
        local mediaData = mediaRecorder:getMediaData(tapeConf.id)
        item:setRecordedMediaData(mediaData)
        BWOAPrepareTools.AddItemsToContainer(10186, 12633, -1, {item}, "Shelves", preserve)
        preserve = true
    end

end

function BWOAScenes.Cinema:placeCorpses()
    
end

function BWOAScenes.Cinema:placeVehicles()

end

function BWOAScenes.Cinema:populate()
    
end
