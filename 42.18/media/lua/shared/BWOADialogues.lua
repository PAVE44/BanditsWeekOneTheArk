BWOADialogues = BWOADialogues or {}

BWOADialogues.dialogues = BWOADialogues.dialogues or {}

BWOADialogues.GetQuestions = function(person)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    local ret = {}

    -- retro patch
    if dialogues["2000.6.1"] then
        dialogues["2000.6.1"].req = {}
    end

    if dialogues["400.2"] then
        dialogues["400.2"].req = {"100.6.1.1.1"}
    end

    if dialogues["400.3"] then
        dialogues["400.3"].req = {"100.6.2"}
    end

    if dialogues["400.4"] then
        dialogues["400.4"].req = {"2000.6.4.1.2"}
    end

    if dialogues["400.5"] then
        dialogues["400.5"].req = {"2000.5.2"}
    end

    if dialogues["400.6"] then
        dialogues["400.6"].req = {}
    end

    if dialogues then
        for id, dialogue in pairs(dialogues) do
            if not dialogue.asked and not dialogue.hidden then
                local add = true
                if dialogue.req then
                    for _, r in pairs(dialogue.req) do
                        if not dialogues[r].asked then
                            add = false
                            break
                        end
                    end
                end
                if add then
                    ret[id] = dialogue
                end
            end 
        end
    end
    return ret
end

BWOADialogues.GetByKey = function(person, key)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    if dialogues then
        for id, dialogue in pairs(dialogues) do
            if id == key and not dialogue.asked and not dialogue.hidden then
                local ret = {}
                for k, v in pairs(dialogue) do
                    ret[k] = v
                end
                ret.qst = getText("IGUI_Dial_" .. person .. "_" .. id .. "_Q")
                ret.ans = getText("IGUI_Dial_" .. person .. "_" .. id .. "_A")
                return ret
            end
        end
    end
end

BWOADialogues.MarkAsked = function(person, key)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    -- dialogues["400.5"].asked = true
    if dialogues then
        for id, dialogue in pairs(dialogues) do
            if id == key then
                dialogue.asked = true
                return
            end
        end
    end
end

BWOADialogues.Reveal = function(person, key)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    if dialogues then
        if dialogues[key] then
            dialogues[key].hidden = nil
        end
    end
end

BWOADialogues.Hide = function(person, key)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    if dialogues then
        if dialogues[key] then
            dialogues[key].hidden = true
        end
    end
end
