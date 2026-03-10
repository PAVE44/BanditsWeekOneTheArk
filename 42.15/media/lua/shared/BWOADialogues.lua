BWOADialogues = BWOADialogues or {}

BWOADialogues.dialogues = BWOADialogues.dialogues or {}

BWOADialogues.GetQuestions = function(person)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    local ret = {}

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

BWOADialogues.GetAnswer = function(person, question)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    if dialogues then
        for id, dialogue in pairs(dialogues) do
            if dialogue.qst == question and not dialogue.asked and not dialogue.hidden then
                return dialogue
            end
        end
    end
end

BWOADialogues.MarkAsked = function(person, question)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    if dialogues then
        for id, dialogue in pairs(dialogues) do
            if dialogue.qst == question then
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
