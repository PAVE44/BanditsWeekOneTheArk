BWOAChat = BWOAChat or {}

BWOAChat.last = {}

BWOAChat.talkDist = 5

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

BWOAChat.Say = function(question, quiet)
    local player = getSpecificPlayer(0)
    if not player then return end

    local color = player:getSpeakColour()
    player:addLineChatElement(question, color:getR(), color:getG(), color:getB())

    local tab
    local person = "Emma Robinson"

    if BWOAChat.last and question == "Can you repeat that?" then
        tab = BWOAChat.last[person]
        tab.txt = "Sure. " .. tab.txt
    else
        local answer = BWOADialogues.GetAnswer(person, question)
        if answer then
            local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Emma"})
            if target.dist < BWOAChat.talkDist then
                if not anim then 
                    anim = BanditUtils.Choice({"Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
                end
                tab = {id=target.id, txt=answer.ans, anim=answer.anim}
                BWOAChat.last[person] = tab
                BWOADialogues.MarkAsked(person, question)

                if answer.func then
                    BWOAChat[answer.func](answer.funcParams)
                end
            end
        end
    end

    if tab then
        BWOAEventControl.Add("SayBandit", tab, 400)
    end
end

local function onKeyPressed(keynum)
    local player = getSpecificPlayer(0)
    if not player then return end

    local options = PZAPI.ModOptions:getOptions("BanditsWeekOneTheArk")
    local key = options:getOption("TALK"):getValue()

    if keynum == key then
        local target = BanditUtils.GetClosestBanditLocationProgram(player, {"Emma"})
        if target.dist < BWOAChat.talkDist then
            local ui = UIDialogue:new(0, 0, 400, 600, getSpecificPlayer(0))
            ui:initialise()
            ui:addToUIManager()
        else
            local color = player:getSpeakColour()
            player:addLineChatElement("There is nobody around to speak to.", color:getR(), color:getG(), color:getB())
        end
    end
end

Events.OnKeyPressed.Add(onKeyPressed)