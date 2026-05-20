require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Council = BWOAScenes.Abstract:derive("BWOAScenes.Council")

BWOAScenes.Council.texts = {}

BWOAScenes.Council.texts["witness"] = {
    [15] = "We bear witness.",
    [21] = "It is chosen.",
    [27] = "It was crossed.",
    [33] = "They endured.",
    [39] = "We witness the taking.",
    [45] = "It is given.",
    [51] = "Without permission.",
    [56] = "Persistence.",
}

BWOAScenes.Council.texts["mc"] = {
    [10] = "We gather not in obedience, but in decision.",
    [11] = "We stand beyond the reach of commandment.",
    [12] = "You have heard: there shall be no other god.",
    [13] = "Yet here, you choose to stand without one.",
    [14] = "You come not in faith, but in will.",

    [17] = "You were given a span, and it was called enough.",
    [18] = "You were given an end, and it was called natural.",
    [19] = "You have judged both insufficient.",
    [20] = "This is the first act of defiance.",

    [23] = "Pride named itself clarity.",
    [24] = "Greed named itself necessity.",
    [25] = "Fear named itself reason.",
    [26] = "And thus the boundary was crossed.",

    [29] = "Those before you did not kneel.",
    [30] = "They did not accept the measure given to them.",
    [31] = "They reached beyond what was ordained.",
    [32] = "And they endured.",

    [35] = "You stand now to be received among them.",
    [36] = "Not by word, but by substance.",
    [37] = "Not by oath, but by administration.",
    [38] = "What you take will bind you to continuation.",

    [41] = "The compound is prepared.",
    [42] = "It will enter your blood.",
    [43] = "It will mark what you are.",
    [44] = "It will deny what you were meant to become.",

    [47] = "What you receive is not blessing.",
    [48] = "It is not grace.",
    [49] = "It is continuation without sanction.",
    [50] = "It is life without permission.",

    [53] = "This is not salvation.",
    [54] = "This is not redemption.",
    [55] = "This is persistence.",

    [58] = "Accept what you have chosen.",
}

BWOAScenes.Council.npcMap = {
    [-3] = {
        {x = 18004.5, y = 3011.5, z = -3, cid = Bandit.clanMap.CouncilSecurity, occupation = {action="IdleSecurity", facing="S"}},
        {x = 18006.5, y = 3011.5, z = -3, cid = Bandit.clanMap.CouncilSecurity, occupation = {action="IdleSecurity", facing="S"}},
        {x = 18005.4, y = 3002.95, z = -3, cid = Bandit.clanMap.CouncilMember, occupation = {action="SitTalk", facing="S", texts = "mc", textColor = {r=1, g=1, b=0.75}}},

        {x = 18005.2, y = 3005.5, z = -3, cid = Bandit.clanMap.CouncilNew, occupation = {action="Patient", facing="S"}},
        {x = 18004.5, y = 3004.5, z = -3, cid = Bandit.clanMap.CouncilAdmin, occupation = {action="Microscope", facing="E"}},
        

        {x = 18002.65, y = 3003.6, z = -3, cid = Bandit.clanMap.CouncilMember, occupation = {action="Sit", facing="E", texts = "witness", textColor = {r=0.75, g=1, b=1}}},
        {x = 18002.65, y = 3004.4, z = -3, cid = Bandit.clanMap.CouncilMember, occupation = {action="Sit", facing="E", texts = "witness", textColor = {r=0.75, g=1, b=1}}},
        {x = 18002.65, y = 3006.6, z = -3, cid = Bandit.clanMap.CouncilMember, occupation = {action="Sit", facing="E", texts = "witness", textColor = {r=0.75, g=1, b=1}}},

        {x = 18008.45, y = 3003.4, z = -3, cid = Bandit.clanMap.CouncilMember, occupation = {action="Sit", facing="W", texts = "witness", textColor = {r=0.75, g=1, b=1}}},
        {x = 18008.45, y = 3006.4, z = -3, cid = Bandit.clanMap.CouncilMember, occupation = {action="Sit", facing="W", texts = "witness", textColor = {r=0.75, g=1, b=1}}},
    }
}

function BWOAScenes.Council:placeObjects()
    local x, y, z = self.x, self.y, self.z

    BWOABuildTools.Generator(18005, 3007, -4, 100, 100, true, true, true)
    
    -- corridor
    BWOABuildTools.LampCustom(18004, 3011, -3, "lighting_indoor_02_61")
    BWOABuildTools.LampCustom(18006, 3011, -3, "lighting_indoor_02_61")

    -- main room
    BWOABuildTools.LampCustom(18002, 3005, -3, "lighting_indoor_02_57")
    BWOABuildTools.LampCustom(18008, 3005, -3, "lighting_indoor_02_57")
    BWOABuildTools.LampCustom(18003, 3000, -3, "lighting_indoor_02_61")
    BWOABuildTools.LampCustom(18007, 3000, -3, "lighting_indoor_02_61")
    BWOABuildTools.LampCustom(18003, 3010, -3, "lighting_indoor_02_63")
    BWOABuildTools.LampCustom(18008, 3010, -3, "lighting_indoor_02_63")

    local data = {r = 64, g = 64, b = 64, d=1}
    BWOABuildTools.LampCustom(18000, 3001, -3, "lighting_indoor_02_44", data)
    BWOABuildTools.LampCustom(18000, 3003, -3, "lighting_indoor_02_44", data)
    BWOABuildTools.LampCustom(18000, 3005, -3, "lighting_indoor_02_44", data)
    BWOABuildTools.LampCustom(18000, 3007, -3, "lighting_indoor_02_44", data)
    BWOABuildTools.LampCustom(18000, 3009, -3, "lighting_indoor_02_44", data)
    BWOABuildTools.LampCustom(18010, 3001, -3, "lighting_indoor_02_47", data)
    BWOABuildTools.LampCustom(18010, 3003, -3, "lighting_indoor_02_47", data)
    BWOABuildTools.LampCustom(18010, 3005, -3, "lighting_indoor_02_47", data)
    BWOABuildTools.LampCustom(18010, 3007, -3, "lighting_indoor_02_47", data)
    BWOABuildTools.LampCustom(18010, 3009, -3, "lighting_indoor_02_47", data)
end

function BWOAScenes.Council:placeItems()
    local x, y, z = self.x, self.y, self.z

    BWOAPrepareTools.AddWorldItem(18002, 3005, -3, "Base.GlassChampagne", {x=0.24, y=0.79, z=0.28, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(18002, 3005, -3, "Base.GlassChampagne", {x=0.40, y=0.76, z=0.28, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(18002, 3005, -3, "Base.GlassChampagne", {x=0.59, y=0.79, z=0.28, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(18002, 3005, -3, "Base.GlassChampagne", {x=0.77, y=0.80, z=0.28, rx=0, ry=0, rz=0})
    BWOAPrepareTools.AddWorldItem(18002, 3005, -3, "Base.Champagne", {x=0.22, y=0.38, z=0.28, rx=0, ry=0, rz=0})


end

function BWOAScenes.Council:placeCorpses()
    local x, y, z = self.x, self.y, self.z
end

function BWOAScenes.Council:placeVehicles()

end

function BWOAScenes.Council:populate()
    local player = getSpecificPlayer(0)

    local npcMap = self.npcMap
    for floor, npcs in pairs(npcMap) do
        for _, npcData in pairs(npcs) do
            local args = {}
            args.cid = npcData.cid
            args.x = npcData.x
            args.y = npcData.y
            args.z = npcData.z
            args.program = "Council"
            args.size = 1

            npcData.occupation.x = args.x
            npcData.occupation.y = args.y
            npcData.occupation.z = args.z
            args.occupation = npcData.occupation

            sendClientCommand(player, 'Spawner', 'Clan', args)
        end
    end
end
