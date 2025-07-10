BWOABaseAPI = BWOABaseAPI or {}

BWOABaseAPI.power = true
BWOABaseAPI.alarm = false

BWOABaseAPI.PowerUp = function()
    -- enable generators, lights should be enabled automatically

    -- disable red emergency lights, battery operated, 
end

BWOABaseAPI.PowerDown = function()
    -- disable generators, lights should be disabled automatically

    -- enable red emergency lights, battery operated, make it happen after delay
end

BWOABaseAPI.AlarmOn = function()
    if not BWOABaseAPI.alarm then
        BWOABaseAPI.alarm = true
        BWOASound.AddGlobal({sound="AmbientAlarmGlobal"})
        BWOASound.AddToObject({x=9961, y=12622, z=-4, sound="AmbientAlarmLocal"})
    end
end

BWOABaseAPI.AlarmOff = function()
    BWOASound.RemoveGlobal({sound="AmbientAlarmGlobal"})
    BWOASound.RemoveFromObject({x=9961, y=12622, z=-4, sound="AmbientAlarmLocal"})
    BWOABaseAPI.alarm = false
end

BWOABaseAPI.ExitProcedure = function()
    -- open interior gate
    -- if player is inside
    -- check if hazmat suit is worn
    -- close interior door
end

BWOABaseAPI.EnterProcedure = function()
end