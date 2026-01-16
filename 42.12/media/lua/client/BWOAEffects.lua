BWOAEffects = BWOAEffects or {}

BWOAEffects.tab = {}
BWOAEffects.tick = 0

BWOAEffects.Add = function(effect)
    table.insert(BWOAEffects.tab, effect)
end

BWOAEffects.Process = function()
    if not isIngameState() then return end
    if isServer() then return end

    local player = getSpecificPlayer(0)
    if player == nil then return end
    local playerNum = player:getPlayerNum()
    local zoom = getCore():getZoom(playerNum)
    local immuneList = BWOAEffects.immuneList

    local cell = getCell()
    for i = #BWOAEffects.tab, 1, -1 do
        local effect = BWOAEffects.tab[i]

        local square = cell:getGridSquare(effect.x, effect.y, effect.z)
        if square then

            if effect.repCnt == nil then effect.repCnt = 1 end
            if effect.rep == nil then effect.rep = 1 end
            if effect.offsetx == nil then effect.offsetx = 0 end
            if effect.offsety == nil then effect.offsety = 0 end

            if effect.movx then
                effect.offsetx = effect.offsetx + effect.movx
            end
            if effect.movy then
                effect.offsety = effect.offsety + effect.movy
            end
            
            local size = effect.size / zoom
            local offset = size / 2
            local tx = isoToScreenX(playerNum, effect.x + effect.offsetx, effect.y + effect.offsety, effect.z) - offset
            local ty = isoToScreenY(playerNum, effect.x + effect.offsetx, effect.y + effect.offsety, effect.z) - offset

            if not effect.frame then 
                if effect.frameRnd then
                    effect.frame = 1 + ZombRand(effect.frameCnt)
                else
                    effect.frame = 1
                end
            end

            if effect.frame > effect.frameCnt and effect.rep >= effect.repCnt then
                if effect.infinite then
                    effect.rep = 1
                    effect.offsetx = 0
                    effect.offsety = 0 
                else 
                    table.remove(BWOAEffects.tab, i)
                    return
                end
            end

            if effect.frame > effect.frameCnt then
                effect.rep = effect.rep + 1
                effect.frame = 1
            end

            local alpha 

            if effect.alpha then
                alpha = effect.alpha
            elseif effect.oscilateAlpha then
                local frameCnt = effect.frameCnt or 1
                local repCnt = effect.repCnt or 1
                local totalFrames = frameCnt * repCnt
                if totalFrames <= 0 then
                    alpha = 0
                else
                    -- number of full cycles across the total lifetime (default 1)
                    local cycles = effect.oscCycles or 1
            
                    -- progress in [0,1). Use (effect.frame - 1) so first frame => progress == 0
                    local currentFrame = ( (effect.rep - 1) * frameCnt ) + (effect.frame - 1)
                    local progress = currentFrame / totalFrames
                    -- clamp just in case
                    if progress < 0 then progress = 0 end
                    if progress > 1 then progress = 1 end
            
                    -- cosine-based oscillation that starts at 0, peaks at 1 at halfway, returns to 0 at end
                    alpha = (1 - math.cos(progress * 2 * math.pi * cycles)) / 2
                end
            else
                alpha = (1 + effect.repCnt - effect.rep) / effect.repCnt
            end

            local frameStr = string.format("%03d", effect.frame)
            local tex = getTexture("media/textures/FX/" .. effect.name .. "/" .. frameStr .. ".png")
            if tex then
                UIManager.DrawTexture(tex, tx, ty, size, size, alpha)
            end

            effect.frame = effect.frame + 1

        else
            table.remove(BWOAEffects.tab, i)
        end
    end
end

local onServerCommand = function(mod, command, args)
    if mod == "BWOEffects" then
        BWOEffects[command](args)
    end
end

Events.OnServerCommand.Add(onServerCommand)
Events.OnPreUIDraw.Add(BWOAEffects.Process)