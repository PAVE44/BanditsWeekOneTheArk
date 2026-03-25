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
    voiceId = 21,
}

Bandit.raidCarLootItems = {
    "Base.PetrolCan",
    "Base.PetrolCan",
    "Base.PetrolCan",
    "Base.Bullets44Carton",
    "Base.Bullets45Carton",
    "Base.Bullets45Carton",
    "Base.556Carton",
    "Base.308Carton",
    "Base.TinnedBeans_Box",
    "Base.CannedCarrots_Box",
    "Base.CannedChili_Box",
    "Base.CannedCorn_Box",
    "Base.CannedCornedBeef_Box",
    "Base.CannedMilk_Box",
    "Base.CannedPeas_Box",
    "Base.CannedPotato_Box",
    "Base.CannedSardines_Box",
    "Base.CannedBolognese_Box",
    "Base.CannedBolognese_Box",
    "Base.CannedTomato_Box",
    "Base.BandageBox",
    "Base.BatteryBox",
    "Base.DuctTapeBox",
    "Base.BoxOfJars",
    "Base.LightBulbBox",
    "Base.ScrewsBox",
}

Bandit.clanMap = Bandit.clanMap or {}
Bandit.clanMap.Emma = "0b0c0c24-a9f7-4b04-a3e2-72f33b3d82ce"
Bandit.clanMap.James = "cb8880f8-d45c-4051-acb3-a9d7b7d598a7"
Bandit.clanMap.Angel = "7f6bc195-edc6-4eb8-92ce-a40fc47de85f"
Bandit.clanMap.Demon = "6b884749-39be-42a3-9fbf-c79a78d4f2af"
Bandit.clanMap.BasementGeneric = "7830522d-7139-40f7-977e-f665bff000ee"
Bandit.clanMap.BasementWicked = "a0ee0049-ee12-403e-9148-172d9029cc7c"
Bandit.clanMap.BasementCannibals = "8ab03e52-9394-4ff4-a6a4-5640b6597e5e"
Bandit.clanMap.BasementPreppers = "55da7b22-d9d5-49bd-9d76-a39459cb69e4"

Bandit.clanMap.FinneganGeneric = "f472d9ba-dd9e-4245-bd18-9c465dc11937"
Bandit.clanMap.FinneganToilet = "8da26dbc-16e4-4391-8763-989b80e71442"
Bandit.clanMap.FinneganSecurity = "c42d3f7c-fac1-4d4a-a8f0-d1401384f341"
Bandit.clanMap.FinneganLab = "f0faba8c-168f-4ea5-8543-4365446fb176"
Bandit.clanMap.FinneganMercer = "17bf7c19-3a01-41b5-8804-6288bc5e5738"  
Bandit.clanMap.FinneganHale = "cc08ed54-1254-4063-a310-25182bef8c5e"
Bandit.clanMap.FinneganJim = "d6b1d039-6b06-409b-b7dd-d491437df931"

Bandit.clanMap.CouncilMember = "706934a3-ce88-45c6-aef2-44dc1278b4d9"
Bandit.clanMap.CouncilSecurity = "3e449dfa-01bb-43aa-b4fc-59d64c102b8f"
Bandit.clanMap.CouncilNew = "d689071d-46a5-4dd5-9955-bbe2268459f6"
Bandit.clanMap.CouncilAdmin = "2522e514-fb66-42c5-b242-e03ca8f8e9f2"

Bandit.clanMap.Surface1 = "2464da7c-5a04-4739-8237-e7b23f5ffa4a" -- deathsquad
Bandit.clanMap.Surface2 = "06419731-fb8f-463f-98a3-d99c1fa0ef58" -- scba
Bandit.clanMap.Surface3 = "4724a709-f1ac-499c-9b14-85f3a3a1b81f" -- robeclan
Bandit.clanMap.Surface4 = "17519d85-03ee-4cb3-b8b3-579a31d0f6b3" -- old school sweepers

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
Bandit.banditMap.Emma.Sport =  "2e682bd5-8bc3-4380-a302-02d7201b8aeb"
Bandit.banditMap.Emma.Dance =  "19a4a644-5029-4343-ae6d-271bf11bb906"

-- maps AI to dialogues
Bandit.prg2person = {}
Bandit.prg2person["Emma"] = "Emma_Robinson"
Bandit.prg2person["James"] = "Father_James"
Bandit.prg2person["Angel"] = "Angel"

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