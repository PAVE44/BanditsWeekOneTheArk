require "Scenes/SAbstract"

BWOAScenes = BWOAScenes or {}

BWOAScenes.Excavation = BWOAScenes.Abstract:derive("BWOAScenes.Abstract")

function BWOAScenes.Excavation:placeObjects()
    local x, y, z = self.x, self.y, self.z

    BWOABuildTools.ClearAll(x + 2, y, z)
    BWOABuildTools.ClearAll(x + 3, y, z)
    BWOABuildTools.ClearAll(x + 4, y, z)

    local l1_map = {
        ['0'] = {sprite="underground_01_0"},
        ['1'] = {sprite="fixtures_stairs_01_3"},
        ['2'] = {sprite="fixtures_stairs_01_4"},
        ['3'] = {sprite="fixtures_stairs_01_5"},
        ['4'] = {sprite="industry_01_39"},
        ['5'] = {sprite="walls_logs_98"},
        ['6'] = {sprite="walls_logs_97"},
        ['7'] = {sprite="walls_logs_96"},
        ['8'] = {sprite="floors_exterior_street_01_0"},
    }

    local l1 = "4432144\n"
    l1 = l1 .. "4444444\n"

    local w1 = "56666667\n"
    w1 = w1 .. "7      7\n"
    w1 = w1 .. "7      7\n"
    w1 = w1 .. "  7    7\n"
    w1 = w1 .. "   7   7\n"
    w1 = w1 .. "   7   7\n"
    w1 = w1 .. "    7  7\n"
    w1 = w1 .. "     7 7\n"
    w1 = w1 .. "      77\n"

    BWOABuildTools.BuildMap(x, y, z-1, l1, l1_map)
    BWOABuildTools.BuildMap(x, y, z-1, w1, l1_map)

    local l2 = "4432144\n"
    l2 = l2 .. "4444444\n"

    local w2 = "5666666\n"
    w2 = w2 .. "7      \n"
    w2 = w2 .. "7      \n"
    w2 = w2 .. "  7    \n"
    w2 = w2 .. "   7   \n"
    w2 = w2 .. "   7   \n"
    w2 = w2 .. "    7  \n"
    w2 = w2 .. "     7 \n"
    w2 = w2 .. "      7\n"

    BWOABuildTools.BuildMap(x, y, z-2, l2, l1_map)
    BWOABuildTools.BuildMap(x, y, z-2, w2, l1_map)

    local l3 = "8888888\n"
    l3 = l3 .. "8888888\n"
    l3 = l3 .. "8888888\n"
    l3 = l3 .. "  88888\n"
    l3 = l3 .. "   8888444444448888\n"
    l3 = l3 .. "   8888444444448888\n"
    l3 = l3 .. "    888\n"
    l3 = l3 .. "     88\n"
    l3 = l3 .. "      8\n"

    local l3e =  "  321  \n"

    local w3 = "56666667\n"
    w3 = w3 .. "7      7\n"
    w3 = w3 .. "7      7\n"
    w3 = w3 .. "  7    7\n"
    w3 = w3 .. "   7           6666\n"
    w3 = w3 .. "   7    \n"
    w3 = w3 .. "    7  7\n"
    w3 = w3 .. "     7 7\n"
    w3 = w3 .. "      77\n"

    BWOABuildTools.BuildMap(x, y, z-3, l3, l1_map)
    BWOABuildTools.BuildMap(x, y, z-3, l3e, l1_map)
    BWOABuildTools.BuildMap(x, y, z-3, w3, l1_map)
end

function BWOAScenes.Excavation:placeItems()
    local x, y, z = self.x, self.y, self.z
end

function BWOAScenes.Excavation:placeCorpses()
    
end

function BWOAScenes.Excavation:placeVehicles()
    
end

function BWOAScenes.Excavation:populate()

end
