Bandit = Bandit or {}

Bandit.SoundTab.WAITTALK = {prefix = "BWOAWaitTalk_", chance = 100, randMax = 4, length = 5}
Bandit.SoundTab.CRY = {prefix = "BWOACry_", chance = 100, randMax = 6, length = 5}
Bandit.SoundTab.RADIOCALL = {prefix = "BWOARadioCall_", chance = 100, randMax = 10, length = 5}

Bandit.playerStart = {
    x = 9966,
    y = 12622,
    z = -4,
}

Bandit.emmaStart = {
    x = 9971,
    y = 12615,
    z = -4,
}

Bandit.clanMap = Bandit.clanMap or {}
Bandit.clanMap.Emma = "0b0c0c24-a9f7-4b04-a3e2-72f33b3d82ce"
Bandit.clanMap.James = "cb8880f8-d45c-4051-acb3-a9d7b7d598a7"
Bandit.clanMap.BasementGeneric = "7830522d-7139-40f7-977e-f665bff000ee"
Bandit.clanMap.BasementWicked = "a0ee0049-ee12-403e-9148-172d9029cc7c"
Bandit.clanMap.BasementCannibals = "8ab03e52-9394-4ff4-a6a4-5640b6597e5e"
Bandit.clanMap.BasementPreppers = "55da7b22-d9d5-49bd-9d76-a39459cb69e4"

Bandit.clanMap.Surface1 = "2464da7c-5a04-4739-8237-e7b23f5ffa4a"
Bandit.clanMap.Surface2 = "06419731-fb8f-463f-98a3-d99c1fa0ef58" -- scba
Bandit.clanMap.Surface3 = "4724a709-f1ac-499c-9b14-85f3a3a1b81f" -- robe

-- the only clans that are allowed to spawn using bandits mod spawner
Bandit.spawnWhitelist = {
    Bandit.clanMap.Surface1,
    Bandit.clanMap.Surface2,
    Bandit.clanMap.Surface3,
}

Bandit.banditMap = {}
Bandit.banditMap.Emma = {}
Bandit.banditMap.Emma.Bunker = "d944d8a7-9ad6-4f65-87e6-0a2d55eac4cb"
Bandit.banditMap.Emma.Hazmat = "d3564264-60ca-4629-ae2f-574ea772df23"
Bandit.banditMap.Emma.Defend = "e97500bf-0534-401a-822a-7891dc8881d5"

-- maps AI to dialogues
Bandit.prg2person = {}
Bandit.prg2person["Emma"] = "Emma_Robinson"
Bandit.prg2person["James"] = "Father_James"

Bandit.EnsureWhitelistedBandits = function()
    local clanData = BanditCustom.clanData
    local whiteList = Bandit.spawnWhitelist
    for clanId, clan in pairs(clanData) do
        local found = false
        for _, allowedId in ipairs(whiteList) do
            if clanId == allowedId then
                found = true
                break
            end
        end
        if not found then
            if clan.spawn then
                clan.spawn.spawnChance = 0
            end
        end
    end
end