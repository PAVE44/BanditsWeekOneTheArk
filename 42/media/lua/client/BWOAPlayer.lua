BWOAPlayer = BWOPlayer or {}

BWOAPlayer.tick = 0

local roomRevealMap = {
    ["HYDROPONICS"] = {person = "Emma Robinson", qid = "100.3"},
    ["LIBRARY"]     = {person = "Emma Robinson", qid = "100.4"},
    ["CHAPEL"]      = {person = "Emma Robinson", qid = "100.5"},
    ["LABORATORY"]  = {person = "Emma Robinson", qid = "100.6"},
}

local traitRevealMap = {
    ["Smoker"]      = {person = "Emma Robinson", qid = "200.1"},
}

local onPlayerUpdate = function(player)
    if BWOAPlayer.tick >= 64 then
        BWOAPlayer.tick = 0
    end

    local px, py, pz = player:getX(), player:getY(), player:getZ()

    -- room discovery
    if BWOAPlayer.tick % 32 == 0 then
        local room = BWOAUtils.GetRoom(px, py, pz)
        if room then
            local revealData = roomRevealMap[room.name]
            if revealData then
                BWOADialogues.Reveal(revealData.person, revealData.qid)
            end
        end
    end

    -- player trait discovery
    if BWOAPlayer.tick == 1 then
        for trait, tab in pairs(traitRevealMap) do
            if player:HasTrait(trait) then
                BWOADialogues.Reveal(tab.person, tab.qid)
            end
        end
    end

    BWOAPlayer.tick = BWOAPlayer.tick + 1
end

Events.OnPlayerUpdate.Add(onPlayerUpdate)