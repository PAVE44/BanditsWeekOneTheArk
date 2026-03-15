BWOAChat = BWOAChat or {}

local modal = nil

function splitSentences(text)
    local sentences = {}

    for sentence, ending in text:gmatch("([^%.%!%?]+)([%.%!%?])") do
        local s = (sentence .. ending):gsub("^%s+", ""):gsub("%s+$", "")
        table.insert(sentences, s)
    end

    return sentences
end

BWOAChat.last = {}

BWOAChat.talkDist = 5

BWOAChat.responseDelayMin = 1000 -- initial response delay

BWOAChat.personConf = BWOAChat.personConf or {}

BWOAChat.personConf["Emma_Robinson"] = {
    perLetter = 30, -- time per letter
    minimal = 850, -- minimal time per sentence
}

BWOAChat.personConf["Father_James"] = {
    perLetter = 50, -- time per letter
    minimal = 950, -- minimal time per sentence
}

BWOAChat.personConf["Angel"] = {
    perLetter = 50, -- time per letter
    minimal = 950, -- minimal time per sentence
}

BWOAChat.Give = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    if not params.item then return end

    local inv = player:getInventory()
    local pills = BanditCompatibility.InstanceItem(params.item)
    inv:AddItem(pills)

    if params.sound then
        player:playSound(params.sound)
    end
end

BWOAChat.AccomplishMission = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    if not params.missionId then return end

    BWOAMissions.Accomplish(params.missionId)
end

BWOAChat.RevealMission = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    if not params.missionId then return end

    BWOAMissions.Reveal(params.missionId)
end

BWOAChat.SwitchMission = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    if not params.missionAccomplishId then return end
    if not params.missionRevealId then return end

    BWOAMissions.Accomplish(params.missionAccomplishId)
    BWOAMissions.Reveal(params.missionRevealId)
end

--[[
BWOAChat.ChangeProgramStage = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local target = BanditUtils.GetClosestBanditLocationProgram(player, {params.programName})
    if target then
        local emma = BanditZombie.GetInstanceById(target.id)
        Bandit.SetProgramStage(emma, params.programStage)
    end
end
]]

BWOAChat.ChangeBrainParam = function(params)
    local player = getSpecificPlayer(0)
    if not player then return end

    local bandit = BanditZombie.GetInstanceById(params.target.id)
    local brain = BanditBrain.Get(bandit)
    brain[params.param] = params.value
end

BWOAChat.Say = function(qid, question, person)
    local player = getSpecificPlayer(0)
    if not player then return end

    BWOAEventControl.Add("SayPlayer", {txt = question}, 1)

    local tab
    if BWOAChat.last and question == "Can you repeat that?" then
        tab = BWOAChat.last[person]
        tab.txt = "Sure. " .. tab.txt
    else
        local answer = BWOADialogues.GetAnswer(person, question)
        if answer then
            local target = BanditUtils.GetClosestBanditLocationProgramStage(player, {"Emma", "James", "Angel"}, "Main")
            if target.dist < BWOAChat.talkDist then
                if not anim then 
                    anim = BanditUtils.Choice({"Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
                end
                tab = {id=target.id, txt=answer.ans, anim=answer.anim}
                BWOAChat.last[person] = tab
                BWOADialogues.MarkAsked(person, question)

                if answer.func then
                    answer.funcParams.target = target
                    BWOAChat[answer.func](answer.funcParams)
                end
            end
        end
    end

    if tab then
        local perLetter = BWOAChat.personConf[person].perLetter
        local minimal = BWOAChat.personConf[person].minimal
        local counter = BWOAChat.responseDelayMin
        local sentences = splitSentences(tab.txt)
        for i, sentence in ipairs(sentences) do
            local newtab = {}
            newtab.id = tab.id
            newtab.anim = tab.anim
            newtab.txt = sentence
            newtab.sound = "Dial_" .. person .. "_" .. qid .. "_" .. i
            local responseTime = perLetter * #sentence
            if responseTime < minimal then responseTime = minimal end
            print ("Response time: " .. responseTime)
            BWOAEventControl.Add("SayBandit", newtab, counter)
            counter = counter + responseTime
        end
    end
end

local emoteActions = {
    ["hey!"] = {
        needNPC = "Emma", 
        func = function(player, target)
            local tab = {}
            tab.id = target.id
            if target.dist < 2.1 then
                tab.anim = BanditUtils.Choice({"Spooked1", "Spooked2"})
                tab.txt = "You scared me!"
                BWOAEventControl.Add("SayBandit", tab, 1)
            else
                tab.anim = "WaveHi"
                tab.txt = "Hey!"
                tab.sound = "VoiceFemaleShoutHey"
                BWOAEventControl.Add("SayBandit", tab, 250)
            end
        end,
    },
    ["hey"] = {
        needNPC = "Emma", 
        func = function(player, target)
            local tab = {}
            tab.id = target.id
            if ZombRand(3) == 0 then
                tab.txt = "psst"
                tab.sound = "VoiceFemaleWhisperPsst"
            else
                tab.txt = "hey"
                tab.sound = "VoiceFemaleWhisperHey"
            end
            BWOAEventControl.Add("SayBandit", tab, 250)
        end,
    },
    ["wavehi"] = {
        needNPC = "Emma", 
        func = function(player, target)
            local tab = {}
            tab.id = target.id
            tab.anim = "WaveHi"
            tab.txt = "Hi!"
            tab.sound = "VoiceFemaleShoutHey"
            BWOAEventControl.Add("SayBandit", tab, 250)
        end,
    },
    ["followme"] = {
        needNPC = "Emma", 
        func = function(player, target)
            BWOANPC.ModBrain(player, target.id, "mode", "follow")
            local tab = {}
            tab.id = target.id
            tab.anim = "Yes"
            tab.txt = "Okay, let's go!"
            BWOAEventControl.Add("SayBandit", tab, 250)
        end,
    },
    ["stop"] = {
        needNPC = "Emma", 
        func = function(player, target)
            BWOANPC.ModBrain(target.id, "mode", nil)
            local tab = {}
            tab.id = target.id
            tab.anim = "Yes"
            tab.txt = "Okay!"
            BWOAEventControl.Add("SayBandit", tab, 250)
        end,
    },
    ["moveout"] = {
        needNPC = "Emma", 
        func = function(player, target)
            BWOANPC.ModBrain(target.id, "mode", "taggame")
            local tab = {}
            tab.id = target.id
            tab.txt = "Catch me if you can!"
            BWOAEventControl.Add("SayBandit", tab, 250)
        end,
    },
    ["dance"] = {
        needNPC = false, 
        func = function(player, target)
            local px, py, pz = player:getX(), player:getY(), player:getZ()
            local jukebox, dist = BWOAJukebox.FindClosest(px, py, pz)
            if jukebox and jukebox.on and dist < 21 then
                BWOAEventControl.Add("SayPlayer", {txt = "Let's dance!"}, 1)
                ISTimedActionQueue.add(TADance:new(player))
            else
                BWOAEventControl.Add("SayPlayer", {txt = "I need music to dance!"}, 1)
            end
        end
    },
}

local function onEmote(player, emote)
    local action = emoteActions[emote]
    if not action then return end

    if action.needNPC then
        local target = BanditUtils.GetClosestBanditLocationProgram(player, {action.needNPC}, "Main")
        if not target or target.dist > BWOAChat.talkDist then return end
        action.func(player, target)
    else
        action.func(player, nil)
    end
end

local function onKeyPressed(keynum)
    local player = getSpecificPlayer(0)
    if not player then return end

    local options = PZAPI.ModOptions:getOptions("BanditsWeekOneTheArk")
    local key = options:getOption("TALK"):getValue()

    if keynum == key then
        local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Emma", "James", "Angel"}, "Main")
        if target.dist < BWOAChat.talkDist then
            if modal then
                modal:removeFromUIManager()
            end
            modal = UIDialogue:new(0, 0, 400, 600, getSpecificPlayer(0), target.program)
            modal:initialise()
            modal:addToUIManager()
        else
            BWOAEventControl.Add("SayPlayer", {txt = "There is nobody around to speak to."}, 1)
        end
    elseif keynum == getCore():getKey("Shout") then
        if player:isSneaking() then
            onEmote(player, "hey")
        else
            onEmote(player, "hey!")
        end
    end
end

LuaEventManager.AddEvent("OnEmote")

Events.OnEmote.Remove(onEmote)
Events.OnEmote.Add(onEmote)

Events.OnKeyPressed.Remove(onKeyPressed)
Events.OnKeyPressed.Add(onKeyPressed)

