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

    local fx, fx = player:getX(), player:getY()
    if occupation then
        if occupation.facing then
            if occupation.facing == "N" then
                fx, fy = bandit:getX(), bandit:getY() - 2
            elseif occupation.facing == "S" then
                fx, fy = bandit:getX(), bandit:getY() + 2
            elseif occupation.facing == "E" then
                fx, fy = bandit:getX() + 2, bandit:getY()
            elseif occupation.facing == "W" then
                fx, fy = bandit:getX() - 2, bandit:getY()
            end
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
        if occupation.texts then
            if BWOAScenes.Finnegan.texts[occupation.texts] then
                texts = BWOAScenes.Finnegan.texts[occupation.texts]
                local gameTime = getGameTime()
                local minute = gameTime:getMinutes()
                if texts[minute] then
                    text = texts[minute]
                end
            end
        end

        -- local task = {action="Talk", anim=params.anim, txt=params.txt, voice=params.sound, x=player:getX(), y=player:getY(), time=2000}

        if occupation.action == "Making" then
            local anim = BanditUtils.Choice({"UnPackBox", "UnPackBoxSmall", "GestYes", "UnPackSack", "Making", "Making", "UnPackBagSmall"})
            local task = {action="Generic", anim=anim, primaryItem=occupation.itemPrimary, secondaryItem=occupation.itemSecondary, looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "IdleSecurity" then
            local task = {action="Generic", anim="IdleSecurity", looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "Talk" then
            local anim = BanditUtils.Choice({"Talk1", "Talk2", "Talk3", "Talk4", "Talk5"})
            local task = {action="Talk", anim=anim, txt=text, x = fx, y = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "Smoke" then
            local task = {action="Generic", anim="Smoke", txt=text, looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "WashHands" then
            local task = {action="Generic", anim="washFace", looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "Sit" then
            local task = {action="SitInChair", anim="SitInChair1", looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "SitTalk" then
            local task = {action="SitInChair", anim="SitInChairTalk", txt=text, looped=true, fx = fx, fy = fy, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "SitEat" then
            local task = {action="SitInChair", anim="SitInChairEat", looped=true, fx = fx, fy = fy, item = occupation.itemPrimary, right=true, time=200}
            table.insert(tasks, task)
        elseif occupation.action == "DrinkPopCan" then
            local task = {action="Generic", anim="DrinkPopCan", looped=true, fx = fx, fy = fy, secondaryItem = occupation.itemSecondary, time=200}
            table.insert(tasks, task)
        else
            local task = {action="FaceLocation", anim="IdleFemale", x = player:getX(), y = player:getY(), time=200}
            table.insert(tasks, task)
        end
    end

    return {status=true, next="Main", tasks=tasks}
end

