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
        anim = "Gest1",
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
        anim = "Gest1",
        req = {"1.2", "2"},
    },
    ["1.2.1.1"] = {
        qst = "Can I help with any of the issues here?",
        ans = "Take your time and rest first. When you're ready, feel free to look around. We'll talk about the details later. I can promise, you'll not get bored with me.",
        anim = "Calm",
        req = {"1.2.1", "3.1"},
    },
    ["1.2.2"] = {
        qst = "When will the others come back?",
        ans = "Soon, I hope. Don't worry, we're in regular radio contact.",
        anim = "Calm",
        req = {"1.2"},
    },
    ["1.2.3"] = {
        qst = "How many of you live here?",
        ans = "It's me, four others and you.",
        anim = "Gest1",
        req = {"1.2", "2"},
    },
    ["1.2.3.1"] = {
        qst = "Who are the others living here?",
        ans = "There's David, Luke, Martha, and Eli.",
        anim = "Gest1",
        req = {"1.2.3", "2", "3"},
    },
    ["2.3.1.1.1"] = {
        qst = "Who's David?",
        ans = "David is our leader. He was the one that found me.",
        anim = "Gest1",
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
        anim = "Gest1",
        req = {"1.2.3.1"},
    },
    ["1.2.3.1.4"] = {
        qst = "Who's Eli?",
        ans = "Eli's our mechanic. He keeps this place running.",
        anim = "Gest1",
        req = {"1.2.3.1"},
    },
    ["1.2.3.2"] = {
        qst = "Do we have enough supplies for everyone?",
        ans = "We have some scarce food reserves, but we also grow crops locally. It's not much, but we're managing.",
        anim = "Calm",
        req = {"1.2.3"},
    },
    ["1.2.3.2.1"] = {
        qst = "What about water supplies?",
        ans = "An Oligocene aquifer provides us with a steady water supply.",
        anim = "Gest1",
        req = {"1.2.3.1"},
    },
    ["2"] = {
        qst = "Where am I?",
        ans = "You're safe. Don't worry. You're in a shelter.",
        anim = "Calm",
        req = {},
    },
    ["2.1"] = {
        qst = "Are we really safe here?",
        ans = "Yes, as safe as we can be, given the circumstances, for now at least.",
        anim = "GestYes",
        req = {"2"},
    },
    ["2.2"] = {
        qst = "What is this place exactly?",
        ans = "We're not entirely sure. It's some kind of military bunker we were lucky to find. It seems to have been built by a strange organization for long-term survival.",
        anim = "Gest1",
        req = {"2"},
    },
    ["2.2.1"] = {
        qst = "Tell me more about the organization that built this place.",
        ans = "We have an archive with tapes you can listen to. They tell the history of this place.",
        anim = "Gest1",
        req = {"2.2", "1"},
    },
    ["3"] = {
        qst = "What happened to me?",
        ans = "We found you unconscious and brought you here. Relax, you're safe now.",
        anim = "Calm",
        req = {},
    },
    ["3.1"] = {
        qst = "How long was I unconscious?",
        ans = "This may be a shock to you... You were in a coma for a couple of months.",
        anim = "Gest1",
        req = {"3"},
    },
    ["3.1.1"] = {
        qst = "Where did you find me?",
        ans = "In the chaos of the last days. You were lucky we were there too.",
        anim = "Gest1",
        req = {"3.1"},
    },
    ["3.1.1.1"] = {
        qst = "How did you know you could trust me, that I wasn't dangerous?",
        ans = "We've all done things, but we all deserved a second chance.",
        anim = "Gest1",
        req = {"3.1.1", "1", "2"},
    },
    ["3.1.1.1.1"] = {
        qst = "So, you're not afraid of me?",
        ans = "No. I know Kung Fu!",
        anim = "GestNo",
        req = {"3.1.1.1"},
    },
    ["3.1.1.1.1.1"] = {
        qst = "Show me! (Kung-Fu)",
        ans = "Nah... I might still need you.",
        anim = "No",
        req = {"3.1.1.1.1"},
    },
    ["3.2"] = {
        qst = "Am I alright?",
        ans = "You had a head injury when we found you. You're lucky we had the equipment and the people to help. Your head may still ache, and your body might feel weak.",
        anim = "GestYes",
        req = {"3"},
    },
    ["3.2.1"] = {
        qst = "What exactly did you do to my head?",
        ans = "We had to perform a craniotomy to treat internal bleeding.",
        anim = "Gest1",
        req = {"3.2"},
    },
    ["3.2.1.1"] = {
        qst = "I still have a terrible headache.",
        ans = "Here, take some pills. I was worried your motor and speech functions might be affected, but you're fine. The headache will pass. ",
        anim = "Give",
        req = {"3.2.1"},
        func = "Give",
        funcParams = {item = "Base.Pills", sound="FirstAidTakePills"},
    },
    ["3.2.1.1.1"] = {
        qst = "I need more supplies.",
        ans = "Get some rest first. When you're ready, you can look around and take what you need.",
        anim = "Gest1",
        req = {"3.2.1.1"},
        func = "SwitchMission",
        funcParams = {missionAccomplishId = 1, missionRevelaId = 2},
    },
    ["3.2.1.2"] = {
        qst = "I don't remember who I was.",
        ans = "That's normal in your situation. It will take time before memories come back to you.",
        anim = "GestYes",
        req = {"3.2.1"},
    },
    ["3.2.1.2.1"] = {
        qst = "Did I have anything with me that would help me remember who I was?",
        ans = "Nothing unique. We had to burn everything for safety reasons.",
        anim = "GestNo",
        req = {"3.2.1.2", "3.1.1"},
    },
    ["3.2.1.2.2"] = {
        qst = "I don't know what my name is.",
        ans = "Well, I hope your memories will come back to you. Anyway, you look like a Bob to me.",
        anim = "Gest1",
        req = {"3.2.1.2"},
    },
    ["3.2.2"] = {
        qst = "Am I infected?",
        ans = "According to your blood tests, you're not. You're also immune to the airborne strain of the virus.",
        anim = "GestNo",
        req = {"3.2"},
    },
    ["3.2.2.1"] = {
        qst = "How were you able to test my blood?",
        ans = "We have a lab here. And I'm a doctor, remember?",
        anim = "Gest1",
        req = {"3.2.2"},
    },
    ["3.2.2.1"] = {
        qst = "Are you immune too?",
        ans = "Yeah. At this point, everyone who's still human is considered immune.",
        anim = "GestYes",
        req = {"3.2.2"},
    },
    ["4"] = {
        qst = "Why are you following me?",
        ans = "Relax. You are in shock. Let's talk more and I'll leave you alone. ",
        anim = "Calm",
        req = {},
        hidden = true,
    },
    ["5"] = {
        qst = "Are there any other survivors outside the base?",
        ans = "Yes, there are some living underground. ",
        anim = "GestYes",
        req = {"2.2.1", "1.2.3.1", "3.1.1", "3.2.1.1.1"},
    },
    ["5.1"] = {
        qst = "Can we help other the people living outside?",
        ans = "We tried that, it's risky. It's been a long time since the event and most of them became very hostile.",
        anim = "GestNo",
        req = {"5"},
    },
    ["5.1.1"] = {
        qst = "Are those living outside a threat to us?",
        ans = "In fact they are. It's either us or them now, you know.",
        anim = "GestYes",
        req = {"5.1"},
    },
    ["5.1.1.1"] = {
        qst = "I want to go out and find other people. Where exactly should I go?",
        ans = "You would need to check the surrounding houses. Some of them have hidden entrances in the floor to the basements. Again, I need to warn you, this is dangerous. Don't go unless you are well prepared.",
        anim = "Gest1",
        req = {"5.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 4},
    },
    ["5.1.1.1.1"] = {
        qst = "I found the basement. What a mess!",
        ans = "I know, it's ugly. This is the reality now. ",
        anim = "Gest1",
        req = {"5.1.1.1"},
        hidden = true,
    },

    -- room reveal
    ["100.1"] = {
        qst = "I found a room with loud machinery.",
        ans = "Engineering room. That's where power generators and water pump is located.",
        anim = "GestYes",
        req = {"3.2.1.2"},
        hidden = true
    },
    ["100.1.1"] = {
        qst = "How do I use the water pump?",
        ans = "It's not connected to the central computer, so it has to be turned on and off manually. Eli tried to fix it, but he gave up.",
        anim = "Gest1",
        req = {"100.1", "1.2.3.1"},
    },
    ["100.1.2"] = {
        qst = "How do I use the power generators?",
        ans = "Generators are operated by Noah, a central computer. However fuel is added manually through an inlet on the surface.",
        anim = "Gest1",
        req = {"100.1"},
    },
    ["100.1.2.1"] = {
        qst = "Why do we have two generators?",
        ans = "Redundancy for safety reasons. But also we switch to backup one, when we need to fix the main one.",
        anim = "Gest1",
        req = {"100.1.2"},
    },
    ["100.1.2.2"] = {
        qst = "How much fuel do we have left?",
        ans = "The only way to check is to use Noah, the central computer.",
        anim = "Gest1",
        req = {"100.1.2"},
    },
    ["100.1.2.2.1"] = {
        qst = "What happens if we run out of fuel?",
        ans = "That would be a disaster. Central heating would shut down and we would freeze to death within hours.",
        anim = "Gest1",
        req = {"100.1.2.2"},
    },
    ["100.1.2.2.1.1"] = {
        qst = "How do we get more fuel?",
        ans = "Fuel is a scarse resource. Our intel shows that there is a fuel truck located on Dixie Highway leading to Muldraugh Ruins. Can you get it here?",
        anim = "Gest1",
        req = {"100.1.2.2.1"},
        func = "RevealMission",
        funcParams = {missionId = 6},
    },
    ["100.1.2.2.1.1.1"] = {
        qst = "I brought the truck, Emma. We have the fuel for the generator.",
        ans = "Amazing! I have to admit, I was worried about you a little. I'm happy that you made it, and I'm happy for the fuel too.",
        anim = "Talk3",
        req = {"100.1.2.2.1.1"},
        hidden = true,
    },
    ["100.2"] = {
        qst = "I found Noah, a computer of some kind.",
        ans = "Great find! Noah controls and monitors many systems in the base. I'd advise caution before changing anything.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.3"] = {
        qst = "I found a garden.",
        ans = "Perfect! Enjoy the food, but also take care of the plants, Martha's gone now.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.4"] = {
        qst = "I found a library.",
        ans = "Nice! Did you find anything interesting?",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.4.1"] = {
        qst = "What's your favorite book?",
        ans = "I like crime novels in general.",
        anim = "Gest1",
        req = {"100.4"},
    },
    ["100.5"] = {
        qst = "I found a chapel.",
        ans = "Yep. It's been here since before us.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.5.1"] = {
        qst = "How can you still believe after all of this?",
        ans = "To be honest, faith is all I have left. ",
        anim = "Gest1",
        req = {"100.5"},
    },
    ["100.6"] = {
        qst = "I think I found a laboratory.",
        ans = "Yes! It's where we conduct our research.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.6.1"] = {
        qst = "What kind of research are you conducting?",
        ans = "Well. We are trying to understand the virus so maybe we can do something about it.",
        anim = "Gest1",
        req = {"100.6"},
    },
    ["100.6.1.1"] = {
        qst = "Are you saying you are looking for a cure?",
        ans = "I don't know, but we have to start somewhere.",
        anim = "Shrug",
        req = {"100.6.1"},
    },
    ["100.6.1.1.1"] = {
        qst = "What are your virus research results so far?",
        ans = "I need fresh specimen to continue my research.",
        anim = "Gest1",
        req = {"100.6.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 5},
    },
    ["100.7"] = {
        qst = "I found the bedroom. Can I sleep there?",
        ans = "Yes, choose the bed you want.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.7.1"] = {
        qst = "There are beds with personal items of more than 5 people in bedroom.",
        ans = "I knew you would notice that at some point. Yes, there were more of us. But they are dead, ok?",
        anim = "Gest1",
        req = {"100.7", "1.2.3"},
    },
    ["100.8"] = {
        qst = "I found the armory. Can I get some guns?",
        ans = "You bet! While it may not seem so, we're still in Kentucky.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.8.1"] = {
        qst = "There are hazmat suits in the armory, why would we need them?",
        ans = "They are crucial when we need to go outside. They protect you from the radiation.",
        anim = "Gest1",
        req = {"108.8"},
        hidden = true
    },
    ["100.8.1.1"] = {
        qst = "What radiation are you speaking about?",
        ans = "Oh right, I forgot you don't remember things. It's the nuclear fallout. I'm sorry, but the world as you knew is now gone. When you're ready, you can go outside and see for yourself. Just be careful there!",
        anim = "Gest1",
        req = {"108.8.1"},
        hidden = true
    },
    ["100.9"] = {
        qst = "I found a decontamination chamber.",
        ans = "Yes. It's a crucial function of the Ark. Everything and everyone that comes from the outside must be decontaminated. ",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.10"] = {
        qst = "I think we need more tools.",
        ans = "Good observation. We lost some of our tools during one of our recent scavenge missions. There is a bag full of tools in what is left of the Community Center in March Ridge. Can you get it back for us?",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true,
        func = "RevealMission",
        funcParams = {missionId = 7},
    },
    ["100.10.1"] = {
        qst = "I found the tools, Emma.",
        ans = "Great news! Thanks! You never know when one of these will become handy, you know?",
        anim = "GestYes",
        req = {"100.10"},
        hidden = true,
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
        anim = "Gest1",
        req = {"200.1"},
    },

    -- event control reveal
    ["300.1"] = {
        qst = "Have you heard from the others?",
        ans = "Radio has been silent for some time now. I'm worried. Something is wrong. ",
        anim = "GestNo",
        req = {"1.2.2"},
        hidden = true,
    },
    ["300.1.1"] = {
        qst = "What's the last known location of Dave's group?",
        ans = "They were on their way back and they passed Rosewood Ruins already. They planned to make a final stop at one of the houses on the way here. ",
        anim = "Gest1",
        req = {"300.1", "1.2.3.1"},
        func = "RevealMission",
        funcParams = {missionId = 8},
    },
    ["300.1.1.1"] = {
        qst = "Emma, Dave and Martha are dead. I'm so sorry...",
        ans = "No!!!",
        anim = "GestNo",
        req = {"300.1.1"},
        hidden = true,
        func = "ChangeBrainParam",
        funcParams = {param = "sadness", value = 100},
    },
    ["300.1.1.1.1"] = {
        qst = "I will revenge Dave & Martha. I promise!",
        ans = "[speechless]",
        anim = "GestNo",
        req = {"300.1.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 9},
    },
    ["300.2"] = {
        qst = "Emma, I killed those bastards who killed Dave and Martha.",
        ans = "That's... that's good, I guess. But it won't bring them back...",
        anim = "Gest1",
        req = {},
        hidden = true,
        func = "ChangeBrainParam",
        funcParams = {param = "sadness", value = 0},
    },
    ["300.2.1"] = {
        qst = "I also found a working car.",
        ans = "Wow! That's great news! That seriously increases our range of operation.",
        anim = "GestYes",
        req = {"300.2"},
    },
    ["300.3"] = {
        qst = "I never had a chance to thank you for saving me.",
        ans = "Sure thing! Every sould counts",
        anim = "GestYes",
        req = {"100.1.2.2.1.1.1"},
        hidden = true,
    },
    ["300.3.1"] = {
        qst = "Thanks for taking care of me while I was in coma.",
        ans = "You're welcome. I knew you'd wake up one day.",
        anim = "GestYes",
        req = {"300.3"},
    },


    -- base condition dependent
    ["1000.1"] = {
        qst = "Why is it so cold?",
        ans = "The central heating must be off. We should fix it before we freeze to death!",
        anim = "Gest1",
        req = {},
        hidden = true
    },
    ["1000.2"] = {
        qst = "Is the power out?",
        ans = "Yes. We need to check the generator and fuel levels.",
        anim = "GestYes",
        req = {},
        hidden = true
    },
    ["1000.3"] = {
        qst = "I feel sick. What's going on?",
        ans = "Gosh! It seems like radiation poisoning.",
        anim = "Gest1",
        req = {},
        hidden = true
    },
    ["1000.3.1"] = {
        qst = "How can we recover from radiation poisoning?",
        ans = "Take a shower and some potassioum iodine pills immediately!",
        anim = "Gest1",
        req = {"1000.3"},
    },
    ["1000.4"] = {
        qst = "I feel dizzy. What's happening?",
        ans = "Check the CO2 levels and make sure the ventilation is working!",
        anim = "Gest1",
        req = {},
        hidden = true,
    },
    ["1000.5"] = {
        qst = "I've noticed CO2 levels are rising despite ventilation being turn on!",
        ans = "We need to check the air intake on the surface!",
        anim = "Gest1",
        req = {"100.2"},
        hidden = true,
        func = "RevealMission",
        funcParams = {missionId = 3},
    },
    ["1000.5.1"] = {
        qst = "Vent is fixed!",
        ans = "Good! CO2 levels should be dropping now.",
        anim = "GestYes",
        req = {"1000.5"},
        hidden = true,
    },

    -- dream related
    ["2000.1"] = {
        qst = "I had a terrible dream...",
        ans = "It's ok, just a dream. You're safe here.",
        anim = "Calm",
        req = {},
        hidden = true,
    },
    ["2000.2"] = {
        qst = "I had a bad dream again. I am beginning to remember things...",
        ans = "Sorry to hear that, but on the bright side, your memories are returning.",
        anim = "Calm",
        req = {},
        hidden = true,
    },
    ["2000.3"] = {
        qst = "Dream again. Now, I remember what happened to me.",
        ans = "What did you dream about exactly?.",
        anim = "Calm",
        req = {},
        hidden = true,
    },
    ["2000.3.1"] = {
        qst = "My last dream was about me surrounded by zombies with little chance of survival.",
        ans = "Yes, that's when found you. You were moments away from getting bitten. Hopefully we got to you in time.",
        anim = "Yes",
        req = {"2000.3"},
    },
    ["2000.4"] = {
        qst = "My dreams are changing. I heard some voices.",
        ans = "Take it easy. Your mind may still need time to adjust.",
        anim = "Calm",
        req = {},
        hidden = true,
    },
    ["2000.4.1"] = {
        qst = "I'm not crazy. My dreams are not my imagination. It felt very real.",
        ans = "Okay. What did the voice said to you?",
        anim = "Calm",
        req = {"2000.4"},
    },
    ["2000.4.1.1"] = {
        qst = "In my dream, the voice told me about a shattered seal... And about a judgement of some kind.",
        ans = "I'm a doctor, but not a shirnk. ",
        anim = "GestNo",
        req = {"2000.4.1"},
    },
    ["2000.5"] = {
        qst = "I had another dream and... ",
        ans = "Stop! I don't want to hear that crazy stuff! You need to get back to reality!",
        anim = "Calm",
        req = {"2000.4.1.1"},
        hidden = true,
    },
    ["2000.6"] = {
        qst = "I know you don't want to hear about my dreams, but... ",
        ans = "Stop! Get it togheter, ok? This is not helping anyone!",
        anim = "Calm",
        req = {"2000.5"},
        hidden = true,
    },
}

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
