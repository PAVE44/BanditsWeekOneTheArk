require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Cinema = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Cinema:placeObjects()

    -- VHS shelves
    BWOABuildTools.Generic(10186, 12633, -1, "location_entertainment_theatre_01_120")
    BWOABuildTools.Generic(10187, 12633, -1, "location_entertainment_theatre_01_121")

    BWOABuildTools.Fireplace (10187, 12636, -1, "appliances_cooking_01_19")

    -- desk
    BWOABuildTools.Generic(10187, 12637, -1, "furniture_tables_high_01_29")
    BWOABuildTools.Generic(10187, 12638, -1, "furniture_tables_high_01_28")
    BWOABuildTools.LampBattery(10187, 12637, -1, "lighting_indoor_02_15")
    BWOABuildTools.Generic(10186, 12637, -1, "furniture_seating_indoor_02_1")

    --rug
    BWOABuildTools.Generic(10184, 12638, -1, "floors_rugs_01_14")
    BWOABuildTools.Generic(10185, 12638, -1, "floors_rugs_01_13")
    BWOABuildTools.Generic(10186, 12638, -1, "floors_rugs_01_15")
    BWOABuildTools.Generic(10184, 12639, -1, "floors_rugs_01_10")
    BWOABuildTools.Generic(10185, 12639, -1, "floors_rugs_01_85")
    BWOABuildTools.Generic(10186, 12639, -1, "floors_rugs_01_11")
    BWOABuildTools.Generic(10184, 12640, -1, "floors_rugs_01_10")
    BWOABuildTools.Generic(10185, 12640, -1, "floors_rugs_01_85")
    BWOABuildTools.Generic(10186, 12640, -1, "floors_rugs_01_11")
    BWOABuildTools.Generic(10184, 12641, -1, "floors_rugs_01_8")
    BWOABuildTools.Generic(10185, 12641, -1, "floors_rugs_01_12")
    BWOABuildTools.Generic(10186, 12641, -1, "floors_rugs_01_9")

    -- TV
    BWOABuildTools.Generic(10185, 12639, -1, "furniture_tables_low_01_13")
    BWOABuildTools.TV(10185, 12639, -1, "appliances_television_01_1")

    -- couch
    BWOABuildTools.Generic(10185, 12641, -1, "furniture_tables_low_01_30")
    BWOABuildTools.Generic(10186, 12641, -1, "furniture_seating_indoor_02_31")



    

    --[[
    BWOABuildTools.Generic(10186, 11635, -1, "location_entertainment_theatre_01_128")
    BWOABuildTools.Generic(10187, 11635, -1, "location_entertainment_theatre_01_129")

    BWOABuildTools.Generic(10184, 11635, -1, "location_entertainment_theatre_01_123")
    BWOABuildTools.Generic(10184, 11636, -1, "location_entertainment_theatre_01_122")
    ]]

end

function BWOAScenes.Cinema:placeItems()
    
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.location_entertainment_theatre_01_123", {x=0.59, y=0.75, z=0.00, rx=0, ry=0, rz=196})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.20, y=0.61, z=0.00, rx=0, ry=0, rz=88})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.91, y=0.70, z=0.00, rx=0, ry=0, rz=19})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.77, y=0.15, z=0.00, rx=0, ry=0, rz=208})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.17, y=0.66, z=0.00, rx=0, ry=0, rz=206})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.39, y=0.26, z=0.00, rx=0, ry=0, rz=223})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.68, y=0.22, z=0.04, rx=90, ry=0, rz=196})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.01, y=0.20, z=0.05, rx=276, ry=0, rz=84})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.59, y=0.21, z=0.00, rx=0, ry=0, rz=278})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.33, y=0.67, z=0.03, rx=75, ry=45, rz=156})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.04, y=0.60, z=0.00, rx=0, ry=0, rz=50})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.72, y=0.42, z=0.00, rx=0, ry=0, rz=238})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.57, y=0.58, z=0.00, rx=0, ry=0, rz=79})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.33, y=0.11, z=0.00, rx=0, ry=0, rz=301})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.38, y=0.51, z=0.00, rx=0, ry=0, rz=59})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.TinCanEmpty", {x=0.87, y=0.72, z=0.03, rx=0, ry=90, rz=261})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop2Empty", {x=0.77, y=0.28, z=0.00, rx=0, ry=0, rz=21})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop2Empty", {x=0.33, y=0.63, z=0.00, rx=0, ry=0, rz=56})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop2Empty", {x=0.34, y=0.64, z=0.00, rx=0, ry=0, rz=263})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop2Empty", {x=0.92, y=0.29, z=0.02, rx=260.90557861328125, ry=198.02467346191406, rz=15.280332565307617})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop2Empty", {x=0.58, y=0.49, z=0.00, rx=81, ry=0, rz=6})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop3Empty", {x=0.28, y=0.47, z=0.00, rx=0, ry=0, rz=164})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop3Empty", {x=0.64, y=0.73, z=0.00, rx=0, ry=0, rz=4})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop3Empty", {x=0.92, y=0.58, z=0.00, rx=0, ry=0, rz=291})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop3Empty", {x=0.54, y=0.30, z=0.00, rx=0, ry=0, rz=139})
    BWOAPrepareTools.AddWorldItem(10184, 12635, -1, "Base.Pop3Empty", {x=0.83, y=0.11, z=0.00, rx=0, ry=0, rz=95})

    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.TinCanEmpty", {x=0.38, y=0.66, z=0.00, rx=0, ry=0, rz=348})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.TinCanEmpty", {x=0.75, y=0.67, z=0.00, rx=0, ry=0, rz=336})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.PopEmpty", {x=0.20, y=0.59, z=0.00, rx=0, ry=0, rz=161})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.PopEmpty", {x=0.82, y=0.34, z=0.00, rx=0, ry=0, rz=187})

    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.TinCanEmpty", {x=0.38, y=0.66, z=0.00, rx=0, ry=0, rz=348})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.TinCanEmpty", {x=0.75, y=0.67, z=0.03, rx=92.99999237060547, ry=1.8623303503773059E-6, rz=336.4751892089844})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.PopEmpty", {x=0.20, y=0.59, z=0.00, rx=0, ry=0, rz=161})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.PopEmpty", {x=0.82, y=0.34, z=0.00, rx=0, ry=0, rz=187})

    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.TinCanEmpty", {x=0.38, y=0.66, z=0.02, rx=72, ry=108, rz=348})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.TinCanEmpty", {x=0.75, y=0.67, z=0.03, rx=92.99999237060547, ry=1.8623303503773059E-6, rz=336.4751892089844})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.PopEmpty", {x=0.20, y=0.59, z=0.00, rx=0, ry=0, rz=161})
    BWOAPrepareTools.AddWorldItem(10185, 12635, -1, "Base.PopEmpty", {x=0.82, y=0.34, z=0.00, rx=0, ry=0, rz=187})

    BWOAPrepareTools.AddWorldItem(10184, 12634, -1, "Base.Bucket", {x=0.74, y=0.55, z=0.00, rx=0, ry=0, rz=66})
    BWOAPrepareTools.AddWorldItem(10184, 12634, -1, "Base.ToiletPaper", {x=0.99, y=0.07, z=0.00, rx=0, ry=0, rz=190})
    BWOAPrepareTools.AddWorldItem(10184, 12634, -1, "Base.ToiletPaper", {x=0.65, y=0.26, z=0.00, rx=0, ry=0, rz=149})

    local notebook = BanditCompatibility.InstanceItem("Bandits.NoteBook")
    notebook:setCanBeWrite(false)
    notebook:setName("Cinema Diary")
    local md = notebook:getModData()
    md.printContent = "notebook_cinema"
    BWOAPrepareTools.AddWorldItemSpecial(10187, 12637, -1, notebook, {x=0.33, y=0.89, z=0.32, rx=0, ry=0, rz=270})
    BWOAPrepareTools.AddWorldItem(10187, 12637, -1, "Base.Pencil", {x=0.37, y=0.79, z=0.32, rx=0, ry=0, rz=40})


    local tapesExp = {
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
        {id="e6fd44a9-1774-4204-ab45-9b316301aa2b"}, -- The Cook Show E1
        {id="a754fdaf-5bac-40cd-9a69-da90e8a0cac7"}, -- The Cook Show E2
        {id="7933a371-a8a6-4c31-8886-7a97d89f2c7e"}, -- The Cook Show E3
        {id="4cc3b806-4630-4dfc-a935-efa700fbd7fb"}, -- The Cook Show E4
        {id="2695eb00-ee79-4b39-833a-1023a28ce397"}, -- The Cook Show E5
        {id="01b3d832-602c-4566-b8d6-c2b74a4a0b00"}, -- The Cook Show E6
        {id="2c2a052d-097c-4507-85f4-7fda90f3e3d1"}, -- The Cook Show E7
    }

    local tapesMovies = {
        {id="929a2ae1-a7f1-4fe5-9b4e-7779a4483091"}, -- Breaking Points
        {id="e50928ac-f472-43d9-bae0-2c27e3187567"}, -- Man on the Run
        {id="ab77e300-a0be-4c54-a514-50d44b543489"}, -- Pleistocene Land
        {id="c6224369-5973-4ec9-817c-76d2aa07f553"}, -- Eagle Down
        {id="d778665f-21b1-475e-a530-7233c95c2d0f"}, -- Home Invaders 2
        {id="53c7fa63-ec5d-40de-8875-a0f474ef49a6"}, -- Blood in the Hood
        {id="9822e2c7-b5c2-4600-bf2c-3c1543e6fa70"}, -- Lives Taken
        {id="1ef8dff0-952f-49db-9312-2e363764160e"}, -- Sordid Client
        {id="25df99f3-2866-498e-8016-9b005df1d250"}, -- Dime Diamonds
        {id="1d57ab8f-61e9-4bb1-9d6f-d3d9d1146ea1"}, -- Satin and Silk
        {id="fc734b68-487c-46fa-8b73-ddb1450366e0"}, -- Three Deaths and a Divorce
        {id="8c204a6e-f1a2-4dd5-a91a-7358acb0d677"}, -- Train Bomb
        {id="620997ad-5f62-4498-b589-8bcd412a7cc1"}, -- You Are Dead
        {id="5a504f00-584b-4330-9752-b213784097c7"}, -- War Front
        {id="d46ebbd8-2eb1-48c5-b18c-71d61febd36c"}, -- All Over Again
        {id="d7715bdb-f363-47cb-8c04-6a156906fcfc"}, -- CyberKiller 2
        {id="be64169e-3ed9-4cf8-90fa-b36283f9c2eb"}, -- Strange
        {id="e311d6ae-9271-40fc-be4b-fba27317d5fc"}, -- Operation Fort Knox
        {id="01940222-8880-4757-be51-9b919bfc0f5c"}, -- Dying Strike
        {id="4d2ed157-ca09-47aa-bde5-8acb4db6bf5b"}, -- Marriage License
        {id="d006671e-9d60-4634-8cda-27a28abbc164"}, -- The Crying of the Foxes
        {id="05f702e8-3c94-4cb4-a93e-b07f88bb5b17"}, -- Cosa Nostra
        {id="462ca6e0-fd5e-4bf9-9748-12b3480ece26"}, -- The Danger in Your Bed
        {id="d544e324-b554-42e2-a36e-de7e09b32a2c"}, -- Loveheart
        {id="0454442e-ce08-4d01-bba5-6a8822bf86d1"}, -- Squad Down
        {id="17596597-5bae-4814-927c-c8673b7739af"}, -- Return of the Nightporter
        {id="473bb1b2-3fd0-4d4b-8e8f-42d3bd01b929"}, -- Fred and Ali's Radical Journey
        {id="526534f0-0bcd-4cca-a30c-5bc37c359fbe"}, -- Dog Goblin II
        {id="092a6643-cc78-4b99-bd8f-deb68814078d"}, -- Dog Goblin III
        {id="77facb85-3606-460c-ac75-f82a31ce25f1"}, -- Dog Goblin IV
        {id="be51ed1d-e0dd-4836-8a18-7273f1545fc6"}, -- Ghoul Stoppers
        {id="254ce9f9-2f49-497c-8914-c64f28bf8bce"}, -- Slow Descent
        {id="9a18b23e-e597-449e-adbd-81dacae59b93"}, -- Dark Agent
        {id="eab285a7-1fd2-4748-9911-0dacfa7b9a40"}, -- Timbergap Manor
        {id="037fc8e4-9cac-4817-a4ae-4972c405b68c"}, -- Ace Pilot
        {id="9953e7f7-396c-4400-82d7-0fc24fbfe0b7"}, -- Tired in Toronto
        {id="31a726b7-0ee6-408b-8599-95c80aa8a6c5"}, -- Dead Wrong
        {id="9ec23879-13eb-4b6a-ab44-e9038952104f"}, -- Mother's Boy
        {id="7bdb6cb5-1d76-4928-a784-d0ec97a98fd3"}, -- Tangier
        {id="d3b8c97d-d3a7-4268-88bc-7e4a6bf24d6e"}, -- Molly Brown
        {id="9fd2da4a-9130-4fac-a49e-8811b8968939"}, -- Paris in the Rain
        {id="75c5a4a9-4e4b-4825-9db7-a371899e58b1"}, -- The Janitor
        {id="9fcadfea-5b3b-4c72-ac30-d03839a3e86d"}, -- Survival Instinct
        {id="21411665-0ce7-4200-83a1-43ae2e6cbbb3"}, -- The Dog Goblin
        {id="0bac9338-28c4-4a72-94fe-9d47cf956f7b"}, -- Global Warrior
    }

    local tapesSeries = {
        {id="d8644aea-9694-4234-b40f-a0d780c644e9"}, -- Washington High S5.01
        {id="3633446b-54f4-463b-9305-45d9c0876d36"}, -- Washington High S5.02
        {id="c36c34f8-4c6c-4bec-852c-120c20ca9984"}, -- Washington High S5.03
        {id="47d9170a-fe9d-42f6-8a20-def16f3955b7"}, -- Washington High S5.04
        {id="b9d78079-738f-4304-906e-8c4d5a5a1f25"}, -- Washington High S5.05
        {id="9b8500f2-2288-4497-b85a-eacbda615a03"}, -- Strangely True S2.01
        {id="4b60b0ce-0ee2-4d4b-b31e-c6cfd0b8bd01"}, -- Strangely True S2.02
        {id="7e713c4c-5ae5-4c16-89ff-6ff5191401b3"}, -- Strangely True S2.03
        {id="8e792270-84c1-4fc3-b4b8-2a500c522347"}, -- Strangely True S2.04
        {id="1f13efd4-42db-4889-9695-9b74d39dcdf7"}, -- Strangely True S2.05
        {id="f3e24301-7b24-4daf-ab00-e9502d8dfb22"}, -- Ballincoolin S1.01
        {id="1a5d1e8a-67a0-4526-a216-92641fe98009"}, -- Ballincoolin S1.02
        {id="b2575483-a742-46b3-939a-6f3690ecb8a0"}, -- Ballincoolin S1.03
        {id="0ee453da-77c9-4ce3-a0c8-2d9d981be645"}, -- Ballincoolin S1.04
        {id="8812702d-9d7e-46e3-a8d7-3a580b5fb107"}, -- Ballincoolin S1.05
        {id="a3189d19-73db-41f8-8865-ef478eebd58a"}, -- Space Crew S3.01
        {id="30ef3e9e-6270-441c-acbb-77191dbe073b"}, -- Space Crew S3.02
        {id="074d0c6d-f387-4472-b41b-fe73ce2132da"}, -- Space Crew S3.03
        {id="4a0838f5-b881-4c94-9dfa-66b655870395"}, -- Space Crew S3.04
        {id="e34b5a15-f058-495f-b16e-482c704d3b52"}, -- Space Crew S3.05
        {id="4638a251-4bbe-4d91-a555-2e46eb790f8c"}, -- The Thompsons S3.01
        {id="cddde004-4ee4-48dc-8454-83123ad8d534"}, -- The Thompsons S3.02
        {id="2f5f43fd-8d17-4ef0-ba60-dd4b7591c512"}, -- The Thompsons S3.03
        {id="cc884f89-a56d-4d8a-9e75-24c417c14276"}, -- The Thompsons S3.04
        {id="a84da6ea-c350-4304-8746-a84acc059d10"}, -- The Thompsons S3.05
        {id="932853dc-0a71-4671-bf48-c5bfd126f367"}, -- Dead Wrong S2.01
        {id="8b07e425-fe72-44b5-8635-db6ab6128bb7"}, -- Dead Wrong S2.02
        {id="145c607e-0358-4a20-8d6b-49278af92272"}, -- Dead Wrong S2.03
        {id="38cc7ba3-a100-475d-83a3-9c17525c1dd7"}, -- Dead Wrong S2.04
        {id="26d31e43-e3a0-4758-95e9-afdd6d90e012"}, -- Dead Wrong S2.05
        {id="a2ed359c-9462-4159-9aba-10e859ae71bb"}, -- The Moderators S2.01
        {id="3a6e9627-47fd-40d5-b7ff-f0d9ff78f4ff"}, -- The Moderators S2.02
        {id="22b33878-8089-4bc7-81c0-c0825ba0d85e"}, -- The Moderators S2.03
        {id="c79ef837-974d-448e-9e0c-9e563cac847f"}, -- The Moderators S2.04
        {id="255cccad-36c7-435d-b01e-cf9d7811382e"}, -- The Moderators S2.05
        {id="05f9056b-914e-4810-9a6a-9267249e9bcf"}, -- The Magical Woodland E1
        {id="03885118-50f5-4b05-b586-07d512a40cbe"}, -- The Magical Woodland E2
        {id="b5a52c62-47f7-4715-9665-24e6826d88e0"}, -- The Magical Woodland E3
        {id="fd334e37-e3db-43b7-afd8-010f4e9042f9"}, -- The Magical Woodland E4
        {id="38580dcf-3da0-469a-b35f-57c2720de3b1"}, -- The Magical Woodland E5
        {id="b68b207a-026e-4af2-9227-38277df51e41"}, -- Z-Squad S2.01
        {id="4255a86b-d9f7-45e3-bf9f-060c8a35858d"}, -- Z-Squad S2.02
        {id="4f3f30d6-df77-4e85-b1cb-4ca7e67addd9"}, -- Z-Squad S2.03
        {id="72f5baec-e382-48ca-817a-594c619d35c8"}, -- Z-Squad S2.04
        {id="ac4302bc-c9c1-433a-a8cd-4609d0bde968"}, -- Z-Squad S2.05
        {id="26437711-f5e5-47a7-b958-438e3202449a"}, -- The Omega Department S3.01
        {id="c30b6008-84c5-413f-836c-ae2f6a0f70b1"}, -- The Omega Department S3.02
        {id="8b5aafc8-16ad-4a41-8be8-6ca094adb5af"}, -- The Omega Department S3.03
        {id="ac791ef2-40b8-421c-984b-d8b3258b5833"}, -- The Omega Department S3.04
        {id="35991256-3806-4d78-a06d-b71c516d193f"}, -- The Omega Department S3.05
        {id="b6777358-7f94-4104-8c3e-9175dc77faf9"}, -- The Omega Department S5.01
        {id="23e9dec5-8183-46dc-9f3f-5c5bda49f4ba"}, -- The Omega Department S5.02
        {id="bd31c750-cb0b-4e80-98e7-4bb71a386d1a"}, -- The Omega Department S5.03
        {id="6f03e034-4fac-460e-ace6-e86c4e34e791"}, -- The Omega Department S5.04
        {id="68b564ed-0f80-4f79-a799-67c11797bac6"}, -- The Omega Department S5.05
        {id="d8779c82-0cff-423d-944f-16c4f468a556"}, -- Albert Wellen QC S2.01
        {id="4467d917-1e90-4901-8531-e148f1fc40c7"}, -- Albert Wellen QC S2.02
        {id="23c075cf-bd66-4bfd-9b6f-b94e4a063055"}, -- Albert Wellen QC S2.03
        {id="ce2d2ae4-b097-49a7-9f4d-2b6f3e2e2f3d"}, -- Albert Wellen QC S2.04
        {id="53015c80-6096-4c1c-adef-e6da20db518e"}, -- Albert Wellen QC S2.05w
        {id="3297434d-f2b0-47cf-b00c-038a937ddce5"}, -- Simon's Fitness Club E1
        {id="f87aee3b-2749-4c76-a1be-471c8a9229b3"}, -- Simon's Fitness Club E2
        {id="d27e7cd9-537e-4c5c-aabc-c37a7abbb214"}, -- Simon's Fitness Club E3
        {id="ebd9a190-456a-4ffe-b9f5-eeaedca68661"}, -- Simon's Fitness Club E4
        {id="98406d57-3f55-4f36-afc4-b78554acc0aa"}, -- Simon's Fitness Club E5
    }
    
    local mediaRecorder = ZomboidRadio.getInstance():getRecordedMedia()
    local preserve = false
    for _, tapeConf in pairs(tapesMovies) do
        local item = BanditCompatibility.InstanceItem("Base.VHS_Retail")
        local mediaData = mediaRecorder:getMediaData(tapeConf.id)
        item:setRecordedMediaData(mediaData)
        BWOAPrepareTools.AddItemsToContainer(10186, 12633, -1, {item}, "Shelves", preserve)
        preserve = true
    end

    preserve = false
    for _, tapeConf in pairs(tapesSeries) do
        local item = BanditCompatibility.InstanceItem("Base.VHS_Retail")
        local mediaData = mediaRecorder:getMediaData(tapeConf.id)
        item:setRecordedMediaData(mediaData)
        BWOAPrepareTools.AddItemsToContainer(10187, 12633, -1, {item}, "Shelves", preserve)
        preserve = true
    end

end

function BWOAScenes.Cinema:placeCorpses()
    local clothing = {
        {bl = ItemBodyLocation.PANTS, itemType = "Base.Trousers_Denim"},
        {bl = ItemBodyLocation.JACKET_HAT_BULKY, itemType = "Base.Jacket_Padded"},
        {bl = ItemBodyLocation.TANK_TOP, itemType = "Base.Vest_DefaultTEXTURE_TINT"},
        {bl = ItemBodyLocation.TSHIRT, itemType = "Base.Tshirt_WhiteTINT"},
        {bl = ItemBodyLocation.SHIRT, itemType = "Base.Shirt_Denim"},
        {bl = ItemBodyLocation.SOCKS, itemType = "Base.Socks_Ankle"},
        {bl = ItemBodyLocation.SHOES, itemType = "Base.Shoes_TrainerTINT"},
    }

    local inventory = {
        "Base.Bleach",
        "Base.Remote",
    }

    BWOAPrepareTools.AddHumanCorpseDetail(10185, 12640, -1, false, clothing, inventory)
end

function BWOAScenes.Cinema:placeVehicles()

end

function BWOAScenes.Cinema:populate()
    
end
