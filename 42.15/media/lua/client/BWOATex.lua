BWOATex = BWOATex or {}

BWOATex.tex = getTexture("media/textures/blast_n.png")
BWOATex.alpha = 0.4
BWOATex.speed = 0.05
BWOATex.mode = "full"
BWOATex.screenWidth = getCore():getScreenWidth()
BWOATex.screenHeight = getCore():getScreenHeight()

BWOATex.Blast = function()
    if not isIngameState() then return end
    if BWOATex.alpha == 0 then return end

    local player = getSpecificPlayer(0)
    if not player then return end

    -- if not player:isOutside() then return end

    local speed = BWOATex.speed * getGameSpeed()
    -- local zoom = getCore():getZoom(player:getPlayerNum())
    -- zoom = PZMath.clampFloat(zoom, 0.0, 1.0)

    local alpha = BWOATex.alpha
    if alpha > 1 then alpha = 1 end

    if BWOATex.mode == "full" then
        UIManager.DrawTexture(BWOATex.tex, 0, 0, BWOATex.screenWidth, BWOATex.screenHeight, alpha)
    elseif BWOATex.mode == "center" then
        local xc = BWOATex.screenWidth / 2
        local x1 = xc - BWOATex.tex:getWidth()
        -- local x2 = xc + (BWOATex.tex:getWidth() / 2)

        local yc = BWOATex.screenHeight / 2
        local y1 = yc - BWOATex.tex:getHeight()
        -- local y2 = yc + (BWOATex.tex:getHeight() / 2)
        UIManager.DrawTexture(BWOATex.tex, x1, y1, BWOATex.tex:getWidth() * 2, BWOATex.tex:getHeight() * 2, alpha)
    end
    
    BWOATex.alpha = BWOATex.alpha - speed
    if BWOATex.alpha < 0 then BWOATex.alpha = 0 end
end

BWOATex.SizeChange = function (n, n2, x, y)
    BWOATex.screenWidth = x
    BWOATex.screenHeight = y
end

Events.OnPreUIDraw.Add(BWOATex.Blast)
Events.OnResolutionChange.Add(BWOATex.SizeChange)
