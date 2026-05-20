ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Finnegan = {}
ZombiePrograms.Finnegan.Stages = {}

ZombiePrograms.Finnegan.Init = function(bandit)
end

ZombiePrograms.Finnegan.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Finnegan.Main = function(bandit)
    local tasks = {}
    local player = getSpecificPlayer(0)

    local brain = BanditBrain.Get(bandit)
    local occupation = brain.occupation

    
    if occupation then
        local fx, fy = player:getX(), player:getY()
        if occupation.facing then
            fx, fy = BanditUtils.GetCordsByFacing(bandit:getX(), bandit:getY(), occupation.facing)
        end
        if occupation.x then
            bandit:setX(occupation.x)
        end
        if occupation.y then
            bandit:setY(occupation.y)
        end
        if occupation.z then
            bandit:setZ(occupation.z)
        end

        local text
        local textColor
        local voice
        if occupation.texts and occupation.textColor then
            if BWOAScenes.Finnegan.texts[occupation.texts] then
                texts = BWOAScenes.Finnegan.texts[occupation.texts]
                textColor = occupation.textColor
                local gameTime = getGameTime()
                local minute = gameTime:getMinutes()
                if texts[minute] then
                    text = texts[minute]
                    -- voice = occupation.texts .. "_" .. minute
                end
            end
        end

        -- local task = {action="Talk", anim=params.anim, txt=params.txt, voice=params.sound, x=player:getX(), y=player:getY(), time=2000}

        if occupation.action == "Making" then
            local anim = BanditUtils.Choice({"UnPackBox", "UnPackBoxSmall", "GestYes", "UnPackSack", "Making", "Making", "UnPackBagSmall"})
            local task = {action="Generic", anim=anim, txt=text, txtColor=textColor, voice=voice, primaryItem=occupation.itemPrimary, secondaryItem=occupation.itemSecondary, looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "IdleSecurity" then
            local task = {action="Generic", anim="IdleSecurity", looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "Talk" then
            local anim = BanditUtils.Choice({"Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
            local task = {action="Talk", anim=anim, txt=text, txtColor=textColor, voice=voice, x = fx, y = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "Smoke" then
            local task = {action="Generic", anim="Smoke", txt=text, txtColor=textColor, voice=voice, looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "WashHands" then
            local task = {action="Generic", anim="washFace", looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "Sit" then
            local task = {action="SitInChair", anim="SitInChair1", looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "SitComputer" then
            local task = {action="SitInChair", anim="SitComputer2", sound="ComputerKeyboard", looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "SitWrite" then
            local task = {action="Generic", anim="SitWrite", looped=true, fx = fx, fy = fy, primaryItem= "Base.Pencil", time=200}
            table.insert(tasks, task)
        elseif occupation.action == "Microscope" then
            local task = {action="Generic", anim="Microscope", looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "SitTalk" then
            local task = {action="SitInChair", anim="SitInChairTalk", txt=text, txtColor=textColor, voice=voice, looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "SitEat" then
            local task = {action="SitInChair", anim="SitInChairEat", txt=text, txtColor=textColor, voice=voice, looped=true, fx = fx, fy = fy, item = occupation.itemPrimary, right=true, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "DrinkPopCan" then
            local task = {action="Generic", anim="DrinkPopCan", txt=text, txtColor=textColor, voice=voice, looped=true, fx = fx, fy = fy, secondaryItem = occupation.itemSecondary, time=200}
            table.insert(tasks, task)
        else
            local task = {action="FaceLocation", anim="IdleFemale", x = player:getX(), y = player:getY(), time=200}
            table.insert(tasks, task)
        end
    end

    return {status=true, next="Main", tasks=tasks}
end

