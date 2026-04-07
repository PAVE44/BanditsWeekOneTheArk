ZombiePrograms = ZombiePrograms or {}

ZombiePrograms.Emma = {}

ZombiePrograms.name = "Emma_Robinson"
ZombiePrograms.Emma.Prepare = function(bandit)
    local tasks = {}

    Bandit.ForceStationary(bandit, false)
  
    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.mainSchedule = {
    --[[
    shower = {
        hourMin = 16,
        hourMax = 16,
        minuteMin = 0,
        minuteMax = 40
    },
    sleep1 = {
        hourMin = 23,
        hourMax = 24,
        minuteMin = 20,
        minuteMax = 60
    },    ]]
    sleep2 = {
        hourMin = 0,
        hourMax = 6,
        minuteMin = 0,
        minuteMax = 60
    },
    jog = {
        hourMin = 6,
        hourMax = 7,
        minuteMin = 15,
        minuteMax = 60
    },
    lab1 = {
        hourMin = 7,
        hourMax = 10,
        minuteMin = 0,
        minuteMax = 60
    },
    radio = {
        hourMin = 10,
        hourMax = 12,
        minuteMin = 0,
        minuteMax = 60,
        waMin = 0.5,
        waMax = 32
    },
    readbook = {
        hourMin = 12,
        hourMax = 13,
        minuteMin = 0,
        minuteMax = 60
    },
    playpiano = {
        hourMin = 13,
        hourMax = 17,
        minuteMin = 0,
        minuteMax = 60
    },
    lab2 = {
        hourMin = 17,
        hourMax = 19,
        minuteMin = 0,
        minuteMax = 60
    },
    watchtv = {
        hourMin = 19,
        hourMax = 23,
        minuteMin = 0,
        minuteMax = 60
    },
}

local switchStage = function(bandit)
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    if brain.sadness and brain.sadness > 50 then
        if brain.program.stage ~= "Cry" then
            return "Cry"
        end
    elseif bz > -4 or (bx < 9950 and by > 12621 and by < 12629) then
        if brain.program.stage ~= "Exterior" then
            brain.program.stage = "Exterior"
            return "Exterior"
        end
    elseif BWOABaseAPI.alarm then
        if brain.program.stage ~= "Defend" then
            brain.program.stage = "Defend"
            return "Defend"
        end
    else
        if brain.program.stage ~= "Main" then
            brain.program.stage = "Main"
            return "Main"
        end
    end
end

local switchOutfit = function(bandit, expectedBid)
    local brain = BanditBrain.Get(bandit)
    
    if expectedBid ~= brain.bid then
        local task = {
            action = "Transform", 
            anim = "BandageUpperBody",
            bid = expectedBid,
            cid = Bandit.clanMap.Emma,
            time = 150
        }
        return task
    end
end

ZombiePrograms.Emma.Main = function(bandit)

    local tasks = {}
    local cell = getCell()
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    bandit:setVariable("RunSpeed", 0.91)
    
    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    if brain.mode and brain.mode == "follow" then
        local subTasks = BWOAPrograms.FollowMaster(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
    elseif brain.mode and brain.mode == "taggame" then
        local subTasks = BWOAPrograms.TagGame(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
    else

        -- basic needs
        if brain.bladder and brain.bladder > 20 then
            bandit:addLineChatElement("ACTIVITY: TOILET", 1, 0, 1)
            local obj, dist = BWOABaseObjects.FindClosestObject({"Toilet"}, {x=bx, y=by})
            if obj then
                local task = {action="UseToiletStanding", time=300}
                local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
            end
        elseif brain.hunger and brain.hunger >= 50 then
            -- bandit:addLineChatElement("ACTIVITY: FOOD HUNT", 1, 0, 1)
            local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Bunker)
            if reoutfitTask then
                table.insert(tasks, reoutfitTask)
                return {status=true, next="Main", tasks=tasks}
            end

            local foodConf = BWOAPermaInv.GetClass(bandit, "food")
            if not foodConf then
                foodConf = BWOAPermaInv.GetClass(bandit, "food_packaged")
            end
            if foodConf then
                local task = {action="Eat", time=300}
                table.insert(tasks, task)
                return {status=true, next="Main", tasks=tasks}
            end

            local item, dist = BWOABaseObjects.FindClosestItemClass("food", {x=bx, y=by})
            if not item then
                item, dist = BWOABaseObjects.FindClosestItemClass("food_packaged", {x=bx, y=by})
            end
            if item then
                local task = {action="Collect", time=300, item=item}
                local subTasks = BWOAPrograms.GoAndDo(bandit, item, task)
                if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
            end
        end

        -- timed activities
        local schedule = ZombiePrograms.Emma.mainSchedule
        local activity = BanditUtils.GetScheduledActivity(schedule)
        if activity then
            if activity == "shower" then
                bandit:addLineChatElement("ACTIVITY: SHOWER", 1, 0, 1)
                local obj, dist = BWOABaseObjects.FindClosestObject({"Shower"}, {x=bx, y=by})
                if obj then
                    local task = {action="UseToiletStanding", time=300}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                end
            elseif activity == "sleep1" or activity == "sleep2" then
                bandit:addLineChatElement("ACTIVITY: SLEEP", 1, 0, 1)
                local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Bunker)
                if reoutfitTask then
                    table.insert(tasks, reoutfitTask)
                    return {status=true, next="Main", tasks=tasks}
                end
                local obj, dist = BWOABaseObjects.FindClosestObject({"Beds", "Bed"}, {x=bx, y=by})
                if obj then
                    local bed = BWOABaseObjects.GetIsoObject(obj)
                    if bed then
                        local facing = bed:getSprite():getProperties():get("Facing")
                        -- local eoffset = bed:getSprite():getProperties():get("Eoffset")
                        local task = {action="SleepLong", x=obj.x, y=obj.y, z=obj.z, facing=facing, time=3000}
                        local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                    end
                end
            elseif activity == "jog" then
                bandit:addLineChatElement("ACTIVITY: JOG", 1, 0, 1)
                local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Sport)
                if reoutfitTask then
                    table.insert(tasks, reoutfitTask)
                    return {status=true, next="Main", tasks=tasks}
                end
                local subTasks = BWOAPrograms.Jog(bandit)
                if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
            elseif activity == "radio" then
                -- bandit:addLineChatElement("ACTIVITY: RADIO", 1, 0, 1)
                local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Bunker)
                if reoutfitTask then
                    table.insert(tasks, reoutfitTask)
                    return {status=true, next="Main", tasks=tasks}
                end
                local obj, dist = BWOABaseObjects.FindClosestObject({"Radio"}, {x=bx, y=by})
                if obj then
                    local task = {action="UseRadio", time=500, fx=obj.x, fy=obj.y}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                end
            elseif activity == "readbook" then
                bandit:addLineChatElement("ACTIVITY: READ BOOK", 1, 0, 1)
                local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Bunker)
                if reoutfitTask then
                    table.insert(tasks, reoutfitTask)
                    return {status=true, next="Main", tasks=tasks}
                end
                local obj, dist = BWOABaseObjects.FindClosestObject({"Couch"}, {x=bx, y=by})
                if obj then
                    local task = {action="SitInChair", anim="SitInChairRead", sound="PageFlipBook", item="Bandits.Book", left=true, x=obj.x, y=obj.y, z=obj.z, facing=obj.f, time=1000}
                    local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                end
            elseif activity == "watchtv" then
                bandit:addLineChatElement("ACTIVITY: WATCH TV", 1, 0, 1)
                local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Bunker)
                if reoutfitTask then
                    table.insert(tasks, reoutfitTask)
                    return {status=true, next="Main", tasks=tasks}
                end
                local obj, dist = BWOABaseObjects.FindClosestObject({"Television"}, {x=bx, y=by})
                if obj then
                    local tv = BWOABaseObjects.GetIsoObject(obj)
                    if tv then
                        local dd = tv:getDeviceData()
                        local md = dd:getMediaData()
                        if md then
                            if dd:getIsTurnedOn() and dd:isPlayingMedia() then
                                local obj, dist = BWOABaseObjects.FindClosestObject({"Couch"}, {x=bx, y=by})
                                if obj and dist < 10 then
                                    local task = {action="SitInChair", anim="SitInChairTalk", x=obj.x, y=obj.y, z=obj.z, facing=obj.f, time=1000}
                                    local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                                    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                                else
                                    bandit:faceLocationF(obj.x, obj.y)
                                end
                            else
                                local task = {action="PlayVHS", time=600, obj=obj}
                                local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                                if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                            end
                        else
                            local hasVHS = BWOAPermaInv.HasType(bandit, "Base.VHS_Retail")
                            if hasVHS then
                                local task = {action="InsertVHS", time=600, obj=obj}
                                local subTasks = BWOAPrograms.GoAndDo(bandit, obj, task)
                                if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                            else
                                local item, dist = BWOABaseObjects.FindClosestItemTypes({"Base.VHS_Retail"}, {x=bx, y=by}, {})
                                if item then
                                    local task = {action="Collect", time=300, item=item}
                                    local subTasks = BWOAPrograms.GoAndDo(bandit, item, task)
                                    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                                end
                            end
                        end
                    end
                end
            elseif activity == "playpiano" then
                -- bandit:addLineChatElement("ACTIVITY: PLAY PIANO", 0, 0, 1)
                local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Bunker)
                if reoutfitTask then
                    table.insert(tasks, reoutfitTask)
                    return {status=true, next="Main", tasks=tasks}
                end
                local piano, pianoDist = BWOABaseObjects.FindClosestObject({"Piano"}, {x=bx, y=by})
                if piano then
                    local pianoIso = BWOABaseObjects.GetIsoObject(piano)
                    if pianoIso then
                        local stoolPos = {
                            ["recreational_01_8"] = {x = 1, y = 1, ox = 0.1, oy = 0.27, f="N"},
                            ["recreational_01_9"] = {x = 0, y = 1, ox = 0.1, oy = 0.27, f="N"},
                            ["recreational_01_28"] = {x = 1, y = -1, ox = 0.1, oy = 0.53, f="S"},
                            ["recreational_01_29"] = {x = 0, y = -1, ox = 0.1, oy = 0.53, f="S"},
                            ["recreational_01_12"] = {x = 1, y = 0, ox = 0.27, oy = 0.1, f="W"},
                            ["recreational_01_13"] = {x = 1, y = 1, ox = 0.27, oy = 0.1, f="W"},
                            ["recreational_01_30"] = {x = -1, y = 0, ox = 0.53, oy = 0.1, f="E"},
                            ["recreational_01_31"] = {x = -1, y = 1, ox = 0.53, oy = 0.1, f="E"},
                        }
                        local spriteName = pianoIso:getSprite():getName()
                        local stoolData = stoolPos[spriteName]
                        local stool = {
                            x = piano.x + stoolData.x,
                            y = piano.y + stoolData.y,
                            z = piano.z,
                            cn = "Stool",
                        }

                        local stoolIso = BWOABaseObjects.GetIsoObject(stool)

                        if stoolIso then
                            local fx, fy = BanditUtils.GetCordsByFacing(bandit:getX(), bandit:getY(), stoolData.f)
                            local task = {action="Generic", anim="SitPiano", looped=true, voice="InstrumentPiano1", fx = fx, fy = fy, ox = stool.x + stoolData.ox, oy = stool.y + stoolData.oy, time=200}
                            local subTasks = BWOAPrograms.GoAwndDo(bandit, stool, task, 0.7)
                            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                        end
                    end
                end
            elseif activity == "lab1" or activity == "lab2" then
                -- bandit:addLineChatElement("ACTIVITY: LAB WORK", 1, 0, 1)
                local computer, computerDist = BWOABaseObjects.FindClosestObject({"Computer"}, {x=bx, y=by})
                local microscope, microscopeDist = BWOABaseObjects.FindClosestObject({"Microscope"}, {x=bx, y=by})
                if computer and microscope then

                    local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Lab)
                    if reoutfitTask then
                        table.insert(tasks, reoutfitTask)
                        return {status=true, next="Main", tasks=tasks}
                    end

                    local gt = getGameTime()
                    local minute = gt:getMinutes()

                    if minute < 30 then
                        local computerIso = BWOABaseObjects.GetIsoObject(computer)
                        if computerIso then
                            local chairPos = {
                                ["appliances_com_01_72"] = {x = 0, y = 1, ox = 0.50, oy = 0.23, f="N"},
                                ["appliances_com_01_73"] = {x = 1, y = 0, ox = 0.27, oy = 0.50, f="W"},
                                ["appliances_com_01_74"] = {x = 0, y = -1, ox = 0.50, oy = 0.77, f="S"},
                                ["appliances_com_01_75"] = {x = -1, y = 0, ox = 0.77, oy = 0.50, f="E"},

                            }
                            local spriteName = computerIso:getSprite():getName()
                            local chairData = chairPos[spriteName]
                            local chair = {
                                x = computer.x + chairData.x,
                                y = computer.y + chairData.y,
                                z = computer.z,
                                cn = "Chair",
                            }

                            local chairIso = BWOABaseObjects.GetIsoObject(chair)

                            if chairIso then
                                local fx, fy = BanditUtils.GetCordsByFacing(bandit:getX(), bandit:getY(), chairData.f)
                                local task = {action="Research", anim="SitComputer", looped=true, voice="ComputerKeyboard", fx = fx, fy = fy, ox = chair.x + chairData.ox, oy = chair.y + chairData.oy, time=200}
                                local subTasks = BWOAPrograms.GoAndDo(bandit, chair, task, 0.7)
                                if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                            end
                        end
                    else
                        local microscopeIso = BWOABaseObjects.GetIsoObject(microscope)
                        if microscopeIso then
                            local standingPos = {
                                ["location_community_medical_01_136"] = {x = 0, y = 1, ox = 0.50, oy = 0.10, f="N"},
                                ["location_community_medical_01_137"] = {x = 1, y = 0, ox = 0.10, oy = 0.50, f="W"},
                                ["location_community_medical_01_139"] = {x = 0, y = -1, ox = 0.50, oy = 0.90, f="S"},
                                ["location_community_medical_01_138"] = {x = -1, y = 0, ox = 0.90, oy = 0.50, f="E"},
                            }

                            local spriteName = microscopeIso:getSprite():getName()
                            local standingData = standingPos[spriteName]
                            local standing = {
                                x = microscope.x + standingData.x,
                                y = microscope.y + standingData.y,
                                z = microscope.z,
                            }

                            local fx, fy = BanditUtils.GetCordsByFacing(bandit:getX(), bandit:getY(), standingData.f)
                            local task = {action="Research", anim="Microscope", looped=true, fx = fx, fy = fy, ox = standing.x + standingData.ox, oy = standing.y + standingData.oy, time=200}
                            local subTasks = BWOAPrograms.GoAndDo(bandit, standing, task, 0.7)
                            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
                        end
                    end
                end
            end
        end

        local config = {}
        config.mustSee = false
        config.hearDist = 50

        if not BWOAMissions.IsAccomplished(1) then
            local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Bunker)
            if reoutfitTask then
                table.insert(tasks, reoutfitTask)
                return {status=true, next="Main", tasks=tasks}
            end

            local closestPlayer = BanditUtils.GetClosestPlayerLocation(bandit, config)

            if closestPlayer.x and closestPlayer.y and closestPlayer.z and closestPlayer.dist > 4 then
                Bandit.Say(bandit, "WAITTALK")
                BWOADialogues.Reveal(ZombiePrograms.name, "4")
                table.insert(tasks, BanditUtils.GetMoveTask(0, closestPlayer.x, closestPlayer.y, closestPlayer.z, "Walk", closestPlayer.dist, false))
                return {status=true, next="Main", tasks=tasks}
            else
                local subTasks = BWOAPrograms.IdleEmma(bandit)
                if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
            end
        end
    end

    local jukebox, dist = BWOAJukebox.FindClosest(bx, by, bz)
    if jukebox and dist < 21 then
        local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Dance)
        if reoutfitTask then
            table.insert(tasks, reoutfitTask)
            return {status=true, next="Main", tasks=tasks}
        end
        if dist < 6 then
            local anim = BanditUtils.Choice({"Dance1", "Dance2", "Dance3", "Dance4"})
            local task = {action="Single", time=500, anim=anim}
            local subTasks = BWOAPrograms.GoAndDo(bandit, jukebox, task)
            if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
        else
            table.insert(tasks, BanditUtils.GetMoveTask(0, jukebox.x, jukebox.y, jukebox.z, "Walk", dist, false))
            return {status=true, next="Main", tasks=tasks}
        end
    end

    local reoutfitTask = switchOutfit(bandit, Bandit.banditMap.Emma.Bunker)
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Main", tasks=tasks}
    end

    local idleTasks = BWOAPrograms.IdleEmma(bandit)
    if #idleTasks > 0 then return {status=true, next="Main", tasks=idleTasks} end

    return {status=true, next="Main", tasks=tasks}
end

ZombiePrograms.Emma.Defend = function(bandit)
    local tasks = {}
    local cell = getCell()
    local brain = BanditBrain.Get(bandit)
    local weapons = Bandit.GetWeapons(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()
    local player = getSpecificPlayer(0)
    local px, py, pz = player:getX(), player:getY(), player:getZ()

    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    local expectedBid = Bandit.banditMap.Emma.Defend
    local reoutfitTask = switchOutfit(bandit, expectedBid)
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Defend", tasks=tasks}
    end

    local primary = bandit:getPrimaryHandItem()
    if not primary then
        local itemName
        if weapons.primary and weapons.primary.name then
            itemName = weapons.primary.name
        elseif weapons.secondary and weapons.secondary.name then
            itemName = weapons.secondary.name
        elseif weapons.melee then
            itemName = weapons.melee
        end
        if itemName then
            local new = BanditCompatibility.InstanceItem(itemName)
            if new then
                local sound = new:getEquipSound()
                local task = {action="Equip", sound=sound, itemPrimary=itemName}
                table.insert(tasks, task)
                return {status=true, next="Main", tasks=tasks}
            end
        end
    end

    if brain.follow then
        local subTasks = BWOAPrograms.FollowMaster(bandit)
        if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end
    end

    local config = {}
    config.mustSee = false
    config.hearDist = 70
    config.levelDiff = 0

    
    local target, enemy = BanditUtils.GetTarget(bandit, config)
    
    -- engage with target
    if target.x and target.y and target.z and target.z == -4 then
        local targetSquare = cell:getGridSquare(target.x, target.y, target.z)
        if targetSquare then
            Bandit.SayLocation(bandit, targetSquare)
        end

        local tx, ty, tz = target.x, target.y, target.z
    
        if enemy then
            if target.fx and target.fy and (enemy:isRunning()  or enemy:isSprinting()) then
                tx, ty = target.fx, target.fy
            end

            local playerDist = BanditUtils.DistTo(px, py, tx, ty)

            if pz == bz and target.dist > playerDist and target.dist > 4 then
                local walkType = "WalkAim"
                table.insert(tasks, BanditUtils.GetMoveTaskTarget(endurance, tx, ty, tz, target.id, target.player, walkType, target.dist))
                return {status=true, next="Main", tasks=tasks}
            else
                local task = {action="FaceLocation", anim="AimRifle", x = tx, y = ty, time=50}
                table.insert(tasks, task)

                return {status=true, next="Main", tasks=tasks}
            end
        end
    end

    local subTasks = BWOAPrograms.IdleEmma(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    return {status=true, next="Defend", tasks=tasks}
end

ZombiePrograms.Emma.Exterior = function(bandit)
    local tasks = {}
    local cell = getCell()
    local brain = BanditBrain.Get(bandit)
    local bx, by, bz = bandit:getX(), bandit:getY(), bandit:getZ()

    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    local expectedBid = Bandit.banditMap.Emma.Hazmat
    local reoutfitTask = switchOutfit(bandit, expectedBid)
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Exterior", tasks=tasks}
    end

    local subTasks = BWOAPrograms.FollowMaster(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    local subTasks = BWOAPrograms.IdleEmma(bandit)
    if #subTasks > 0 then return {status=true, next="Main", tasks=subTasks} end

    return {status=true, next="Exterior", tasks=tasks}
end

ZombiePrograms.Emma.Cry = function(bandit)
    local tasks = {}
    
    local newStage = switchStage(bandit)
    if newStage then
        return {status=true, next=newStage, tasks=tasks}
    end

    local task = {action="Cry", time=200}
    table.insert(tasks, task)

    return {status=true, next="Cry", tasks=tasks}
end

ZombiePrograms.Emma.Prison = function(bandit)
    local tasks = {}
    
    local expectedBid = Bandit.banditMap.Emma.Prison
    local reoutfitTask = switchOutfit(bandit, expectedBid)
    if reoutfitTask then
        table.insert(tasks, reoutfitTask)
        return {status=true, next="Prison", tasks=tasks}
    end

    local task = {action="Cry", time=200}
    table.insert(tasks, task)

    return {status=true, next="Prison", tasks=tasks}
end



