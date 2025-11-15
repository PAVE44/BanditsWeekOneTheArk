BWOADialogues = BWOADialogues or {}

BWOADialogues.dialogues = {}

BWOADialogues.dialogues["Emma Robinson"] = {
    ["1"] = {
        qst = "Who are you?",
        ans = "My name is Emma. I'm a survivor, just like you. I'm a doctor.",
        anim = "WaveHi",
        req = {},
    },
    ["1.1"] = {
        qst = "How did you get in here?",
        ans = "It's a long story. I was rescued, just like you.",
        anim = "Talk3",
        req = {"1"},
    },
    ["1.2"] = {
        qst = "Are there any other people here?",
        ans = "Yes, but they had to leave for various reasons.",
        anim = "Yes",
        req = {"1"},
    },
    ["1.2.1"] = {
        qst = "Why did the others have to leave?",
        ans = "This place requires maintenance, and we needed supplies. They went out to get them, but don't worry, things are under control.",
        anim = "Talk3",
        req = {"1.2", "2"},
    },
    ["1.2.1.1"] = {
        qst = "Can I help with any of the issues here?",
        ans = "Take your time and rest first. When you're ready, feel free to look around. We'll talk about the details later. I can promise, you'll not get bored with me.",
        anim = "Talk3",
        req = {"1.2.1", "3.1"},
    },
    ["1.2.2"] = {
        qst = "When will the others come back?",
        ans = "Soon, I hope. Don't worry, we're in regular radio contact.",
        anim = "Talk3",
        req = {"1.2"},
    },
    ["1.2.3"] = {
        qst = "How many of us live here?",
        ans = "It's you, me, and four others.",
        anim = "Talk3",
        req = {"1.2", "2"},
    },
    ["1.2.3.1"] = {
        qst = "Who are the others living here?",
        ans = "There's David, Luke, Martha, and Eli.",
        anim = "Talk3",
        req = {"1.2.3", "2", "3"},
    },
    ["1.2.3.1.1"] = {
        qst = "Who's David?",
        ans = "David is our leader, ex-military.",
        anim = "Talk3",
        req = {"1.2.3.1"},
    },
    ["1.2.3.1.2"] = {
        qst = "Who's Luke?",
        ans = "Luke is our scientist. He works in the lab.",
        anim = "Talk3",
        req = {"1.2.3.1"},
    },
    ["1.2.3.1.3"] = {
        qst = "Who's Martha?",
        ans = "Martha takes care of our crops and food supplies.",
        anim = "Talk3",
        req = {"1.2.3.1"},
    },
    ["1.2.3.1.4"] = {
        qst = "Who's Eli?",
        ans = "Eli's our mechanic. He keeps this place running.",
        anim = "Talk3",
        req = {"1.2.3.1"},
    },
    ["1.2.3.2"] = {
        qst = "Do we have enough supplies for everyone?",
        ans = "We have some scarce food reserves, but we also grow crops locally. It's not much, but we're managing.",
        anim = "Talk3",
        req = {"1.2.3"},
    },
    ["1.2.3.2.1"] = {
        qst = "What about water supplies?",
        ans = "An Oligocene aquifer provides us with a steady water supply.",
        anim = "Talk3",
        req = {"1.2.3.1"},
    },
    ["2"] = {
        qst = "Where am I?",
        ans = "You're safe. Don't worry. You're in a shelter.",
        anim = "Talk3",
        req = {},
    },
    ["2.1"] = {
        qst = "Are we really safe here?",
        ans = "Yes, as safe as we can be, given the circumstances, for now at least.",
        anim = "Yes",
        req = {"2"},
    },
    ["2.2"] = {
        qst = "What is this place exactly?",
        ans = "We're not entirely sure. It's some kind of military bunker we were lucky to find. It seems to have been built by a strange organization for long-term survival.",
        anim = "Talk2",
        req = {"2"},
    },
    ["2.2.1"] = {
        qst = "Tell me more about the organization that built this place.",
        ans = "We have an archive with tapes you can listen to. They tell the history of this place.",
        anim = "Talk2",
        req = {"2.2", "1"},
    },
    ["3"] = {
        qst = "What happened to me?",
        ans = "We found you unconscious and brought you here. Relax, you're safe now.",
        anim = "Talk3",
        req = {},
    },
    ["3.1"] = {
        qst = "How long was I unconscious?",
        ans = "This may be a shock to you... You were in a coma for a couple of months.",
        anim = "Talk3",
        req = {"3"},
    },
    ["3.1.1"] = {
        qst = "Where did you find me?",
        ans = "In the chaos of the last days. You were lucky we were there too.",
        anim = "Talk3",
        req = {"3.1"},
    },
    ["3.1.1.1"] = {
        qst = "How did you know you could trust me, that I wasn't dangerous?",
        ans = "We've all done things, but we all deserved a second chance.",
        anim = "Talk3",
        req = {"3.1.1", "1", "2"},
    },
    ["3.1.1.1.1"] = {
        qst = "So, you're not afraid of me?",
        ans = "No. I know Kung Fu!",
        anim = "Talk3",
        req = {"3.1.1.1"},
    },
    ["3.1.1.1.1.1"] = {
        qst = "Show me!",
        ans = "Nah... I might still need you.",
        anim = "Talk3",
        req = {"3.1.1.1.1"},
    },
    ["3.2"] = {
        qst = "Am I alright?",
        ans = "You had a head injury when we found you. You're lucky we had the equipment and the people to help. Your head may still ache, and your body might feel weak.",
        anim = "Yes",
        req = {"3"},
    },
    ["3.2.1"] = {
        qst = "What exactly did you do to my head?",
        ans = "We had to perform a craniotomy to treat internal bleeding.",
        anim = "Talk3",
        req = {"3.2"},
    },
    ["3.2.1.1"] = {
        qst = "I still have a terrible headache.",
        ans = "I was worried your motor and speech functions might be affected, but you're fine. The headache will pass. Here, take some pills.",
        anim = "Talk3",
        req = {"3.2.1"},
        func = "Give",
        funcParams = {item = "Base.Pills", sound="FirstAidTakePills"},
    },
    ["3.2.1.1.1"] = {
        qst = "I need more supplies.",
        ans = "Get some rest first. When you're ready, you can look around and take what you need.",
        anim = "Talk3",
        req = {"3.2.1.1"},
        func = "SwitchMission",
        funcParams = {missionAccomplishId = 1, missionRevelaId = 2},
    },
    ["3.2.1.2"] = {
        qst = "I don't remember who I was.",
        ans = "That's normal in your situation. It will take time before memories come back to you.",
        anim = "Talk3",
        req = {"3.2.1"},
    },
    ["3.2.1.2.1"] = {
        qst = "Did I have anything with me that would help me remember who I was?",
        ans = "Nothing unique. We had to burn everything for safety reasons.",
        anim = "Talk3",
        req = {"3.2.1.2", "3.1.1"},
    },
    ["3.2.1.2.2"] = {
        qst = "I don't know what my name is.",
        ans = "Well, I hope your memories will come back to you. Anyway, you look like a Bob to me.",
        anim = "Talk3",
        req = {"3.2.1.2"},
    },
    ["3.2.2"] = {
        qst = "Am I infected?",
        ans = "According to your blood tests, you're not. You're also immune to the airborne strain of the virus.",
        anim = "No",
        req = {"3.2"},
    },
    ["3.2.2.1"] = {
        qst = "How were you able to test my blood?",
        ans = "We have a lab here. And I'm a doctor, remember?",
        anim = "Talk3",
        req = {"3.2.2"},
    },
    ["3.2.2.1"] = {
        qst = "Are you immune too?",
        ans = "Yeah. At this point, everyone who's still human is considered immune.",
        anim = "Yes",
        req = {"3.2.2"},
    },
    ["4"] = {
        qst = "Why are you following me?",
        ans = "Relax. You are in shock. Let's talk more and I'll leave you alone. ",
        anim = "Talk3",
        req = {},
        hidden = true,
    },
    ["5"] = {
        qst = "Are there any other survivors outside the base?",
        ans = "Yes, there are some living underground. ",
        anim = "Talk3",
        req = {"2.2.1", "1.2.3.1", "3.1.1", "3.2.1.1.1"},
    },
    ["5.1"] = {
        qst = "Can we help other the people living outside?",
        ans = "We tried that, it's risky. It's been a long time since the event and most of them became very hostile.",
        anim = "Talk3",
        req = {"5"},
    },
    ["5.1.1"] = {
        qst = "Are those living outside a threat to us?",
        ans = "In fact they are. It's either us or them now, you know.",
        anim = "Talk3",
        req = {"5.1"},
    },
    ["5.1.1.1"] = {
        qst = "I want to go out and find other people. Where exactly should I go?",
        ans = "You would need to check the surrounding houses. Some of them has hidden entrances in the floor to the basements. Again, I need to warn you, this is danegerous. Don't go unless you are well prepared.",
        anim = "Talk3",
        req = {"5.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 4},
    },

    -- room reveal
    ["100.1"] = {
        qst = "I found a room with loud machinery.",
        ans = "Engineering room. That's where power generators and water pump is located.",
        anim = "Talk3",
        req = {"3.2.1.2"},
        hidden = true
    },
    ["100.1.1"] = {
        qst = "How do I use the water pump?",
        ans = "It's not connected to the central computer, so it has to be turned on and off manually. Eli tried to fix it, but he gave up.",
        anim = "Talk3",
        req = {"100.1", "1.2.3.1"},
    },
    ["100.1.2"] = {
        qst = "How do I use the power generators?",
        ans = "Generators are operated by Noah, a central computer. However fuel is added manually through an inlet on the surface.",
        anim = "Talk3",
        req = {"100.1"},
    },
    ["100.1.2.1"] = {
        qst = "Why do we have two generators?",
        ans = "Redundancy for safety reasons. But also we switch to backup one, when we need to fix the main one.",
        anim = "Talk3",
        req = {"100.1.2"},
    },
    ["100.1.2.2"] = {
        qst = "How much fuel do we have left?",
        ans = "The only way to check is to use Noah, the central computer.",
        anim = "Talk3",
        req = {"100.1.2"},
    },
    ["100.1.2.2.1"] = {
        qst = "What happens if we run out of fuel?",
        ans = "That would be a disaster. Central heating would shut down and we would freeze to death within hours.",
        anim = "Talk3",
        req = {"100.1.2.2"},
    },
    ["100.2"] = {
        qst = "I found Noah, a computer of some kind.",
        ans = "Great find! Noah controls and monitors many systems in the base. I'd advise caution before changing anything.",
        anim = "Talk3",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.3"] = {
        qst = "I found a garden.",
        ans = "Perfect! Enjoy the food, but also take care of the plants, Martha's gone now.",
        anim = "Talk3",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.4"] = {
        qst = "I found a library.",
        ans = "Nice! Did you find anything interesting?",
        anim = "Talk3",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.4.1"] = {
        qst = "What's your favorite book?",
        ans = "I like crime novels in general.",
        anim = "Talk3",
        req = {"100.4"},
    },
    ["100.5"] = {
        qst = "I found a chapel.",
        ans = "Yep. It's been here since before us.",
        anim = "Talk3",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.5.1"] = {
        qst = "How can you still believe after all of this?",
        ans = "To be honest, faith is all I have left. ",
        anim = "Talk3",
        req = {"100.5"},
    },
    ["100.6"] = {
        qst = "I think I found a laboratory.",
        ans = "Yes! It's where we conduct our research.",
        anim = "Talk3",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.6.1"] = {
        qst = "What kind of research are you conducting?",
        ans = "Well. We are trying to understand the virus so maybe we can do something about it.",
        anim = "Talk3",
        req = {"100.6"},
    },
    ["100.6.1.1"] = {
        qst = "Are you saying you are looking for a cure?",
        ans = "I don't know, but we have to start somewhere.",
        anim = "Talk3",
        req = {"100.6.1"},
    },
    ["100.6.1.1.1"] = {
        qst = "What are your virus research results so far?",
        ans = "I need fresh specimen to continue my research.",
        anim = "Talk3",
        req = {"100.6.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 5},
    },
    ["100.7"] = {
        qst = "I found the bedroom. Can I sleep there?",
        ans = "Yes, choose the bed you want.",
        anim = "Talk3",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.7.1"] = {
        qst = "There are beds with personal items of more than 5 people in bedroom.",
        ans = "I knew you would notice that at some point. Yes, there were more of us. But they are dead, ok?",
        anim = "Talk3",
        req = {"100.7", "1.2.3"},
    },
    ["100.8"] = {
        qst = "I found the armory. Can I get some guns?",
        ans = "You bet! While it may not seem so, we're still in Kentucky.",
        anim = "Talk3",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.8.1"] = {
        qst = "There are hazmat suits in the armory, why would we need them?",
        ans = "They are crucial when we need to go outside. They protect you from the radiation.",
        anim = "Talk3",
        req = {"108.8"},
        hidden = true
    },
    ["100.9"] = {
        qst = "I found a decontamination chamber.",
        ans = "Yes. It's a crucial function of the Ark. Everything and everyone that comes from the outside must be decontaminated. ",
        anim = "Talk3",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.8.1.1"] = {
        qst = "What radiation are you speaking about?",
        ans = "Oh right, I forgot you don't remember things. It's the nuclear fallout. I'm sorry, but the world as you knew is now gone. When you're ready, you can go outside and see for yourself. Just be careful there!",
        anim = "Talk3",
        req = {"108.8.1"},
        hidden = true
    },

    -- trait reveal
    ["200.1"] = {
        qst = "Do you have a cigarette?",
        ans = "I quit. But I do carry one last with me. Here, enjoy.",
        anim = "Yes",
        req = {},
        hidden = true,
        func = "Give",
        funcParams = {item = "Base.CigaretteSingle"},
    },
    ["200.1.1"] = {
        qst = "Do you have a light?",
        ans = "Yes, here you go.",
        anim = "Yes",
        req = {"200.1"},
        func = "Give",
        funcParams = {item = "Base.Lighter"},
    },
    ["200.1.2"] = {
        qst = "Why did you carry a cigarrete if you quit?",
        ans = "I planned to smoke it after getting bit, but it never happened.",
        anim = "Yes",
        req = {"200.1"},
    },

    -- base condition dependent
    ["1000.1"] = {
        qst = "Why is it so cold?",
        ans = "The central heating must be off. We should fix it before we freeze to death!",
        anim = "Talk3",
        req = {},
        hidden = true
    },
    ["1000.2"] = {
        qst = "Is the power out?",
        ans = "Yes. We need to check the generator and fuel levels.",
        anim = "Talk3",
        req = {},
        hidden = true
    },
    ["1000.3"] = {
        qst = "I feel sick. What's going on?",
        ans = "Gosh! It seems like radiation poisoning.",
        anim = "Talk3",
        req = {},
        hidden = true
    },
    ["1000.3.1"] = {
        qst = "How can we recover from radiation poisoning?",
        ans = "Take a shower and some potassioum yodine pills immediately!",
        anim = "Talk3",
        req = {"1000.3"},
    },
    ["1000.4"] = {
        qst = "I feel dizzy. What's happening?",
        ans = "Check the CO2 levels and make sure the ventilation is working!",
        anim = "Talk3",
        req = {},
        hidden = true,
    },
    ["1000.5"] = {
        qst = "I've noticed CO2 levels are rising despite ventilation being turn on!",
        ans = "We need to check the air intake on the surface!",
        anim = "Talk3",
        req = {"100.2"},
        hidden = true,
        func = "RevealMission",
        funcParams = {missionId = 3},
    },
}

BWOADialogues.LoadDialogues = function()
    local gmd = GetBWOAModData()
    gmd.dialogues = BWOADialogues.dialogues
end

BWOADialogues.GetQuestions = function(person)
    local gmd = GetBWOAModData()
    local dialogues = gmd.dialogues[person]
    local ret = {}

    if dialogues then
        for id, dialogue in pairs(dialogues) do
            if not dialogue.asked and not dialogue.hidden then
                local add = true
                for _, r in pairs(dialogue.req) do
                    if not dialogues[r].asked then
                        add = false
                        break
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
