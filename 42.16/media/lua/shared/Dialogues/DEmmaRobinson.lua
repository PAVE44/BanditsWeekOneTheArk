require "BWOADialogues"

BWOADialogues.dialogues = BWOADialogues.dialogues or {}

-- warning text here is only for reference, the actual text is taken from json
BWOADialogues.dialogues["Emma_Robinson"] = {
    ["1"] = {
        -- qst = "Who are you?",
        -- ans = "My name is Emma. I'm a survivor, just like you. I'm a doctor.",
        anim = "WaveHi",
        req = {},
    },
    ["1.1"] = {
        -- qst = "How did you get in here?",
        -- ans = "It's a long story. I was rescued, just like you.",
        anim = "Gest1",
        req = {"1"},
    },
    ["1.2"] = {
        -- qst = "Are there any other people here?",
        -- ans = "Yes, but they had to leave for various reasons.",
        anim = "Yes",
        req = {"1"},
    },
    ["1.2.1"] = {
        -- qst = "Why did the others have to leave?",
        -- ans = "This place requires maintenance, and we needed supplies. They went out to get them, but don't worry, things are under control.",
        anim = "Gest1",
        req = {"1.2", "2"},
    },
    ["1.2.1.1"] = {
        -- qst = "Can I help with any of the issues here?",
        -- ans = "Take your time and rest first. When you're ready, feel free to look around. We'll talk about the details later. I can promise, you'll not get bored.",
        anim = "Calm",
        req = {"1.2.1", "3.1"},
    },
    ["1.2.2"] = {
        -- qst = "When will the others come back?",
        -- ans = "Soon, I hope. Don't worry, we're in regular radio contact.",
        anim = "Calm",
        req = {"1.2"},
    },
    ["1.2.3"] = {
        -- qst = "How many of you live here?",
        -- ans = "It's me, four others and you.",
        anim = "Gest1",
        req = {"1.2", "2"},
    },
    ["1.2.3.1"] = {
        -- qst = "Who are the others living here?",
        -- ans = "There's David, Luke, Martha, and Eli.",
        anim = "Gest1",
        req = {"1.2.3", "2", "3"},
    },
    ["2.3.1.1.1"] = {
        -- qst = "Who's David?",
        -- ans = "David is our leader. He was the one that found me.",
        anim = "Gest1",
        req = {"1.2.3.1"},
    },
    ["1.2.3.1.2"] = {
        -- qst = "Who's Luke?",
        -- ans = "Luke is our scientist. He works with me in the lab.",
        anim = "Talk3",
        req = {"1.2.3.1"},
    },
    ["1.2.3.1.3"] = {
        -- qst = "Who's Martha?",
        -- ans = "Martha takes care of our crops and food supplies.",
        anim = "Gest1",
        req = {"1.2.3.1"},
    },
    ["1.2.3.1.4"] = {
        -- qst = "Who's Eli?",
        -- ans = "Eli's our mechanic. He keeps this place running.",
        anim = "Gest1",
        req = {"1.2.3.1"},
    },
    ["1.2.3.2"] = {
        -- qst = "Do we have enough supplies for everyone?",
        -- ans = "We have some scarce food reserves, but we also grow crops locally. It's not much, but we're managing.",
        anim = "Calm",
        req = {"1.2.3"},
    },
    ["1.2.3.2.1"] = {
        -- qst = "What about water supplies?",
        -- ans = "An Oligocene aquifer provides us with a steady water supply.",
        anim = "Gest1",
        req = {"1.2.3.1"},
    },
    ["2"] = {
        -- qst = "Where am I?",
        -- ans = "You're safe. Don't worry. You're in a shelter.",
        anim = "Calm",
        req = {},
    },
    ["2.1"] = {
        -- qst = "Are we really safe here?",
        -- ans = "Yes, as safe as we can be, given the circumstances, for now at least.",
        anim = "GestYes",
        req = {"2"},
    },
    ["2.2"] = {
        -- qst = "What is this place exactly?",
        -- ans = "We're not entirely sure. It's some kind of military bunker we were lucky to find. It seems to have been built by a strange organization for long-term survival.",
        anim = "Gest1",
        req = {"2"},
    },
    ["2.2.1"] = {
        -- qst = "Tell me more about the organization that built this place.",
        -- ans = "We have an archive with tapes you can listen to. They tell the history of this place.",
        anim = "Gest1",
        req = {"2.2", "1"},
    },
    ["3"] = {
        -- qst = "What happened to me?",
        -- ans = "We found you unconscious and brought you here. Relax, you're safe now.",
        anim = "Calm",
        req = {},
    },
    ["3.1"] = {
        -- qst = "How long was I unconscious?",
        -- ans = "This may be a shock to you... You were in a coma for a couple of months.",
        anim = "Gest1",
        req = {"3"},
    },
    ["3.1.1"] = {
        -- qst = "Where did you find me?",
        -- ans = "In the chaos of the last days. You were lucky we were there too.",
        anim = "Gest1",
        req = {"3.1"},
    },
    ["3.1.1.1"] = {
        -- qst = "How did you know you could trust me, that I wasn't dangerous?",
        -- ans = "We've all done things. But we all deserved a second chance.",
        anim = "Gest1",
        req = {"3.1.1", "1", "2"},
    },
    ["3.1.1.1.1"] = {
        -- qst = "So, you're not afraid of me?",
        -- ans = "No. I know Kung Fu!",
        anim = "GestNo",
        req = {"3.1.1.1"},
    },
    ["3.1.1.1.1.1"] = {
        -- qst = "Show me! (Kung-Fu)",
        -- ans = "Nah. I might still need you.",
        anim = "No",
        req = {"3.1.1.1.1"},
    },
    ["3.2"] = {
        -- qst = "Am I alright?",
        -- ans = "You had a head injury when we found you. You're lucky we had the equipment and the people to help. Your head may still ache, and your body might feel weak.",
        anim = "GestYes",
        req = {"3"},
    },
    ["3.2.1"] = {
        -- qst = "What exactly did you do to my head?",
        -- ans = "We had to perform a craniotomy to treat internal bleeding.",
        anim = "Gest1",
        req = {"3.2"},
    },
    ["3.2.1.1"] = {
        -- qst = "I still have a terrible headache.",
        -- ans = "Here, take some pills. I was worried your motor and speech functions might be affected, but you're fine. The headache will pass. ",
        anim = "Give",
        req = {"3.2.1"},
        func = "Give",
        funcParams = {item = "Base.Pills", sound="FirstAidTakePills"},
    },
    ["3.2.1.1.1"] = {
        -- qst = "I need more supplies.",
        -- ans = "Get some rest first. When you're ready, you can look around and take what you need.",
        anim = "Gest1",
        req = {"3.2.1.1"},
        func = "SwitchMission",
        funcParams = {missionAccomplishId = 1, missionRevealId = 2},
    },
    ["3.2.1.2"] = {
        -- qst = "I don't remember who I was.",
        -- ans = "That's normal in your situation. It will take time before memories come back to you.",
        anim = "GestYes",
        req = {"3.2.1"},
    },
    ["3.2.1.2.1"] = {
        -- qst = "Did I have anything with me that would help me remember who I was?",
        -- ans = "Nothing unique. We had to burn everything for safety reasons.",
        anim = "GestNo",
        req = {"3.2.1.2", "3.1.1"},
    },
    ["3.2.1.2.2"] = {
        -- qst = "I don't know what my name is.",
        -- ans = "Well, I hope your memories will come back to you. Anyway, you look like a Bob to me.",
        anim = "Gest1",
        req = {"3.2.1.2"},
    },
    ["3.2.2"] = {
        -- qst = "Am I infected?",
        -- ans = "According to your blood tests, you're not. You're also immune to the airborne strain of the virus.",
        anim = "GestNo",
        req = {"3.2"},
    },
    ["3.2.2.1"] = {
        -- qst = "How were you able to test my blood?",
        -- ans = "We have a lab here. And I'm a doctor, remember?",
        anim = "Gest1",
        req = {"3.2.2"},
    },
    ["3.2.2.2"] = {
        -- qst = "Are you immune too?",
        -- ans = "Yeah. At this point, everyone who's still human is considered immune.",
        anim = "GestYes",
        req = {"3.2.2"},
    },
    ["4"] = {
        -- qst = "Why are you following me?",
        -- ans = "Relax. You are in shock. Let's talk more and I'll leave you alone. ",
        anim = "Calm",
        req = {},
        hidden = true,
    },
    ["5"] = {
        -- qst = "Are there any other survivors outside the base?",
        -- ans = "Yes. There are some living underground. ",
        anim = "GestYes",
        req = {"2.2.1", "1.2.3.1", "3.1.1", "3.2.1.1.1"},
    },
    ["5.1"] = {
        -- qst = "Can we help other the people living outside?",
        -- ans = "We tried that, it's risky. It's been a long time since the event and most of them became very hostile.",
        anim = "GestNo",
        req = {"5"},
    },
    ["5.1.1"] = {
        -- qst = "Are those living outside a threat to us?",
        -- ans = "In fact they are. It's either us or them now, you know.",
        anim = "GestYes",
        req = {"5.1"},
    },
    ["5.1.1.1"] = {
        -- qst = "I want to go out and find other people. Where exactly should I go?",
        -- ans = "You would need to check the surrounding houses. Some of them have hidden entrances in the floor to the basements. Again, I need to warn you, this is dangerous. Don't go unless you are well prepared.",
        anim = "Gest1",
        req = {"5.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 4},
    },
    ["5.1.1.1.1"] = {
        -- qst = "I found a basement. What a mess!",
        -- ans = "I know, it's ugly. This is the reality now. ",
        anim = "Gest1",
        req = {"5.1.1.1"},
        hidden = true,
    },

    -- room reveal
    ["100.1"] = {
        -- qst = "I found a room with loud machinery.",
        -- ans = "Engineering room. That's where power generators and water pump is located.",
        anim = "GestYes",
        req = {"3.2.1.2"},
        hidden = true
    },
    ["100.1.1"] = {
        -- qst = "How do I use the water pump?",
        -- ans = "It's not connected to the central computer, so it has to be turned on and off manually. Eli tried to fix it, but he gave up.",
        anim = "Gest1",
        req = {"100.1", "1.2.3.1"},
    },
    ["100.1.2"] = {
        -- qst = "How do I use the power generators?",
        -- ans = "Generators are operated by Noah - a central computer. However, fuel is added manually through an inlet on the surface.",
        anim = "Gest1",
        req = {"100.1"},
    },
    ["100.1.2.1"] = {
        -- qst = "Why do we have two generators?",
        -- ans = "Redundancy for safety reasons. But also, we switch to backup one, when we need to fix the main one.",
        anim = "Gest1",
        req = {"100.1.2"},
    },
    ["100.1.2.2"] = {
        -- qst = "How much fuel do we have left?",
        -- ans = "The only way to check is to use Noah - the central computer.",
        anim = "Gest1",
        req = {"100.1.2"},
    },
    ["100.1.2.2.1"] = {
        -- qst = "What happens if we run out of fuel?",
        -- ans = "That would be a disaster. Central heating would shut down and we would freeze to death within hours.",
        anim = "Gest1",
        req = {"100.1.2.2"},
    },
    ["100.1.2.2.1.1"] = {
        -- qst = "How do we get more fuel?",
        -- ans = "Fuel is a scarce resource. Our intel shows that there is a fuel truck located on Dixie Highway leading to Muldraugh Ruins. Can you get it here?",
        anim = "Gest1",
        req = {"100.1.2.2.1"},
        func = "RevealMission",
        funcParams = {missionId = 6},
    },
    ["100.1.2.2.1.1.1"] = {
        -- qst = "I brought the truck, Emma. We have the fuel for the generator.",
        -- ans = "Amazing! I have to admit, I was worried about you a little. I'm happy that you made it, and I'm happy for the fuel too.",
        anim = "Talk3",
        req = {"100.1.2.2.1.1"},
        hidden = true,
    },
    ["100.2"] = {
        -- qst = "I found Noah, a computer of some kind.",
        -- ans = "Great find! Noah controls and monitors many systems in the base. I'd advise caution before changing anything.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.3"] = {
        -- qst = "I found a garden.",
        -- ans = "Perfect! Enjoy the food, but also take care of the plants.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.4"] = {
        -- qst = "I found a library.",
        -- ans = "Nice! Did you find anything interesting?",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.4.1"] = {
        -- qst = "What's your favorite book?",
        -- ans = "I like crime novels in general.",
        anim = "Gest1",
        req = {"100.4"},
    },
    ["100.5"] = {
        -- qst = "I found a chapel.",
        -- ans = "Yep. It's been here since before us.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.5.1"] = {
        -- qst = "How can you still believe after all of this?",
        -- ans = "To be honest, faith is all we might have left. ",
        anim = "Gest1",
        req = {"100.5"},
    },
    ["100.6"] = {
        -- qst = "I think I found a laboratory.",
        -- ans = "Yes! It's where we conduct our research.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.6.1"] = {
        -- qst = "What kind of research are you conducting?",
        -- ans = "Well. We are trying to understand the virus so maybe we can do something about it.",
        anim = "Gest1",
        req = {"100.6"},
    },
    ["100.6.1.1"] = {
        -- qst = "Are you saying you are looking for a cure?",
        -- ans = "I don't know. But we have to start somewhere.",
        anim = "Shrug",
        req = {"100.6.1"},
    },
    ["100.6.1.1.1"] = {
        -- qst = "I brought a zombie corpse to the lab.",
        -- ans = "Awesome. I will conduct the research soon. I hope it will bring us some useful insights.",
        anim = "Gest1",
        req = {"100.6.1.1", "400.1"},
        hidden = true, -- revealed by bringing a zombie corpse to the lab
    },
    ["100.6.2"] = {
        -- qst = "I brought a corpse of the non-infected to the lab.",
        -- ans = "Good. I will continue my research shortly. We need to understand why some of us remain uninfected.",
        anim = "Gest1",
        req = {"100.6.1.1", "400.2"},
        hidden = true, -- revealed by bringing a human corpse to the lab
    },
    ["100.7"] = {
        -- qst = "I found the bedroom. Can I sleep there?",
        -- ans = "Yes, choose the bed you want.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.7.1"] = {
        -- qst = "There are beds with personal items of more than 5 people in bedroom.",
        -- ans = "I knew you would notice that at some point. Yes, there were more of us. But they are dead, ok?",
        anim = "Gest1",
        req = {"100.7", "1.2.3"},
    },
    ["100.8"] = {
        -- qst = "I found the armory. Can I get some guns?",
        -- ans = "You bet! While it may not seem so, we're still in Kentucky.",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.8.1"] = {
        -- qst = "There are hazmat suits in the armory, why would we need them?",
        -- ans = "They are crucial when we need to go outside. They protect you from the radiation.",
        anim = "Gest1",
        req = {"108.8"},
        hidden = true
    },
    ["100.8.1.1"] = {
        -- qst = "What radiation are you speaking about?",
        -- ans = "Oh right, I forgot you don't remember things. It's the nuclear fallout. I'm sorry, but the world as you knew is now gone. When you're ready, you can go outside and see for yourself. Just be careful there!",
        anim = "Gest1",
        req = {"108.8.1"},
        hidden = true
    },
    ["100.9"] = {
        -- qst = "I found a decontamination chamber.",
        -- ans = "Yes. It's a crucial function of the Ark. Everything and everyone that comes from the outside must be decontaminated. ",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true
    },
    ["100.10"] = {
        -- qst = "I think we need more tools.",
        -- ans = "Good observation. We lost some of our tools during one of our recent scavenge missions. There is a bag full of tools in what is left of the Community Center in March Ridge. Can you get it back for us?",
        anim = "GestYes",
        req = {"1.2.1.1"},
        hidden = true,
        func = "RevealMission",
        funcParams = {missionId = 7},
    },
    ["100.10.1"] = {
        -- qst = "I found the tools, Emma.",
        -- ans = "Great news! Thanks! You never know when one of these will become handy, you know?",
        anim = "GestYes",
        req = {"100.10"},
        hidden = true,
    },

    -- trait reveal
    ["200.1"] = {
        -- qst = "Do you have a cigarette?",
        -- ans = "I quit. But, I do carry one last with me. Here, enjoy.",
        anim = "Give",
        req = {},
        hidden = true,
        func = "Give",
        funcParams = {item = "Base.CigaretteSingle"},
    },
    ["200.1.1"] = {
        -- qst = "Do you have a light?",
        -- ans = "Yes, here you go.",
        anim = "Give",
        req = {"200.1"},
        func = "Give",
        funcParams = {item = "Base.Lighter"},
    },
    ["200.1.2"] = {
        -- qst = "Why did you carry a cigarrete if you quit?",
        -- ans = "I planned to smoke it after getting bit. But it never happened.",
        anim = "Gest1",
        req = {"200.1"},
    },
    ["200.2"] = {
        -- qst = "I can barely see. Do you have my glasses?",
        -- ans = "Yes! Here you go.",
        anim = "Give",
        req = {},
        hidden = true,
        func = "Give",
        funcParams = {item = "Base.Glasses_Prescription_Aviators"},
    },

    -- stat reveal
     ["220.1"] = {
        -- qst = "I think I am infected!",
        -- ans = "No!!!",
        anim = "GestNo",
        req = {},
        hidden = true,
        func = "ChangeBrainParam",
        funcParams = {param = "sadness", value = 100},
    },
     ["220.2"] = {
        -- qst = "I feel depressed.",
        -- ans = "Take one of these pills. It will help you.",
        anim = "Give",
        req = {},
        hidden = true,
        func = "Give",
        funcParams = {item = "Base.PillsAntiDep", sound="FirstAidTakePills"},
    },
    ["220.3"] = {
        -- qst = "I'm bored.",
        -- ans = "Don't be a kid! There's a lot of things to do and keep you busy.",
        anim = "GestNo",
        req = {},
        hidden = true,
    },
    ["220.4"] = {
        -- qst = "I would kill for a cigarette.",
        -- ans = "Sounds like a plan! Go kill some zombies. With a little luck, you will find some cigarettes on them.",
        anim = "GestYes",
        req = {},
        hidden = true,
    },
    ["220.5"] = {
        -- qst = "I feel nauseous.",
        -- ans = "Dead corpses sickness. Get rid of the corpses, there's a chute in the exit corridor.",  
        anim = "GestYes",
        req = {},
        hidden = true,
    },

    -- event control reveal
    ["300.1"] = {
        -- qst = "Have you heard from the others?",
        -- ans = "Radio has been silent for some time now. I'm worried. Something is wrong. ",
        anim = "GestNo",
        req = {"1.2.2"},
        hidden = true,
    },
    ["300.1.1"] = {
        -- qst = "What's the last known location of Dave's group?",
        -- ans = "They were on their way back and they passed Rosewood Ruins already. They planned to make a final stop at one of the houses on the way here. ",
        anim = "Gest1",
        req = {"300.1", "1.2.3.1"},
        func = "RevealMission",
        funcParams = {missionId = 8},
    },
    ["300.1.1.1"] = {
        -- qst = "Emma, Dave and Martha are dead. I'm so sorry...",
        -- ans = "No!!!",
        anim = "GestNo",
        req = {"300.1.1"},
        hidden = true,
        func = "ChangeBrainParam",
        funcParams = {param = "sadness", value = 100},
    },
    ["300.1.1.1.1"] = {
        -- qst = "I will revenge Dave and Martha. I promise!",
        -- ans = "[speechless]",
        anim = "GestNo",
        req = {"300.1.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 9},
    },
    ["300.2"] = {
        -- qst = "Emma, I killed those bastards who killed Dave and Martha.",
        -- ans = "That's... that's good, I guess. But it won't bring them back...",
        anim = "Gest1",
        req = {},
        hidden = true,
        func = "ChangeBrainParam",
        funcParams = {param = "sadness", value = 0},
    },
    ["300.2.1"] = {
        -- qst = "I also found a working car.",
        -- ans = "Wow! That's great news! That seriously increases our range of operation.",
        anim = "GestYes",
        req = {"300.2"},
    },
    ["300.3"] = {
        -- qst = "I never had a chance to thank you for saving me.",
        -- ans = "Sure thing! Every soul counts.",
        anim = "GestYes",
        req = {"100.1.2.2.1.1.1"},
        hidden = true, -- unlocked by time
    },
    ["300.3.1"] = {
        -- qst = "Thanks for taking care of me while I was in coma.",
        -- ans = "You're welcome. I knew you'd wake up one day.",
        anim = "GestYes",
        req = {"300.3"},
    },
    ["300.4"] = {
        -- qst = "You've been here quite a bit. Aren't you bored?",
        -- ans = "I've been busy with various things most of the time. But I have to admit, I miss other fun activities.",
        anim = "Gest1",
        req = {},
        hidden = true, -- unlocked by time
    },
    ["300.4.1"] = {
        -- qst = "What fun activities are you missing in here?",
        -- ans = "Oh you know, I love books and I've been reading them here for some time. However I miss music and dancing. I used to go to clubs and dance the night away. I miss that a lot.",
        anim = "Gest1",
        req = {"300.4"},
    },
    ["300.4.1.1"] = {
        -- qst = "Why can't you dance in here?",
        -- ans = "I could, but without music, it's not the same. I wish we had music in here!",
        anim = "GestNo",
        req = {"300.4.1"},
        func = "RevealMission",
        funcParams = {missionId = 11},
    },
    ["300.4.1.2"] = {
        -- qst = "Besides books and clubbing, is there anything else you like to do for fun?",
        -- ans = "Piano. I used to play the piano. How I wish we had one here!",
        anim = "GestYes",
        req = {"300.4.1"},
        func = "RevealMission",
        funcParams = {missionId = 12},
    },
    ["300.4.1.3"] = {
        -- qst = "What about movies? Do you like to watch them too?",
        -- ans = "Sure. But we only have a few in here and I've already watched them millions of times. I wish we had more.",
        anim = "GestYes",
        req = {"300.4.1"},
        func = "RevealMission",
        funcParams = {missionId = 13},
    },
    ["300.5"] = {
        -- qst = "Emma, what would we do if we ever lose the Ark?",
        -- ans = "I hope it never comes to that. But if it does, we would have to find another shelter. My first stop would be the warehouses south-west from Muldraugh. ",
        anim = "Gest1",
        req = {},
        hidden = true, -- unlocked by time
    },
    ["300.5.1"] = {
        -- qst = "Why would you want to go to the warehouses south-west from Muldraugh?",
        -- ans = "My uncle used to work there when I was a kid. I know the place pretty well. I used to play in the underground there.",
        anim = "Gest1",
        req = {"300.5"},
    },

    -- research updates
    ["400.1"] = {
        -- qst = "What are your virus research results so far?",
        -- ans = "I'm still constructing a working model. This pathogen doesn't behave like anything in modern virology. It preserves certain functions while degrading others. It's almost selective in what it keeps. There's intent in the pattern, or something close to it. I need physical data to move forward.",
        anim = "Gest1",
        req = {"100.6.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 5},
        hidden = true, -- unlocked by research > 5%
    },
    ["400.2"] = {
        -- qst = "Any updates regarding your research?",
        -- ans = "I've completed the autopsy. The body is failing, but not entirely. Motor function persists despite catastrophic neural loss. There's no centralized brain activity that explains movement. It's as if something else has taken over coordination at a lower level. I don't understand how, but it's consistent. I need human specimen to continue.",
        anim = "Gest1",
        req = {"100.6.1.1.1"},
        func = "RevealMission",
        funcParams = {missionId = 14},
        hidden = true, -- unlocked by research > 25% (possible with zombie corpse)
    },
    ["400.3"] = {
        -- qst = "Any new updates regarding our research?",
        -- ans = "This subject is different. There are clear markers of exposure, but no full conversion. The organism was present, but it never took hold. Something prevented the transition entirely. I can confirm immunity—but I have no idea what caused it. We need new clues.",
        anim = "Gest1",
        req = {"100.6.2"},
        hidden = true, -- unlocked by research > 45% (possible with human corpse)
    },
    ["400.4"] = {
        -- qst = "How is the research going? Are we close?",
        -- ans = "I've analyzed the sample, it's the original strain, and I think I understand now. This version doesn't destroy the host, it integrates with it. The immune subject wasn't naturally resistant, they were pre-exposed. Injected, most likely. The symbiotic strain prevented the aggressive one from taking over.",
        anim = "Gest1",
        req = {"2000.6.4.1.2"},
        hidden = true, -- unlocked by research > 65% (possible with secret syringe)
    },
    ["400.4.1"] = {
        -- qst = "Would that mean that we were also pre-exposed? Injected with the symbiotic strain?",
        -- ans = "Now that is a very good question, Bob.",
        anim = "Gest1",
        req = {"400.4"},
    },
    ["400.5"] = {
        -- qst = "Got any news on the ongoing research?",
        -- ans = "Yep. You will not believe this. The comfrey extract is doing more than slowing the process, it's reversing it. At least in early-stage samples. Even post-exposure tissue is stabilizing. If this holds, it could work after a bite. But I need to be certain. This has to be tested on someone.",
        anim = "Gest1",
        req = {"2000.5.2"},
        hidden = true, -- unlocked by research > 85% (possible with comfrey)
    },
    ["400.6"] = {
        -- qst = "Have you completed the research?",
        -- ans = "This is it. I've completed the experimental counter to the infection. It doesn't remove the organism, but it forces it back into a stable state. In theory, it should work even after exposure. I've prepared couple of doses. ",
        anim = "GestYes",
        req = {},
        hidden = true, -- unlocked by research = 100%
    },
    ["400.6.1"] = {
        -- qst = "Are you sure it will work?",
        -- ans = "I can't be sure until it is tested. If any of us gets bitten we can try it on ourselves. ",
        anim = "GestYes",
        req = {"400.6"},
    },
    ["400.6.1.1"] = {
        -- qst = "I want to test it on myself.",
        -- ans = "No. Not now. That's unnecessary risk!",
        anim = "GestNo",
        req = {"400.6.1"},
        func = "RevealMission",
        funcParams = {missionId = 114},
    },
    ["400.6.2"] = {
        -- qst = "Emma, I'm bitten...",
        -- ans = "Oh no! How did this happen? ",
        anim = "Calm",
        req = {"400.6.1.1"},
        hidden = true, -- unlocked by being bitten
        func = "RevealMission",
        funcParams = {missionId = 115},
    },
    ["400.6.2.1"] = {
        -- qst = "It just happened. I need to take the counter now.",
        -- ans = "We have no choice. Gosh, I hope it works. Inject it immediately!",
        anim = "Give",
        req = {"400.6.2"},
        func = "Give",
        funcParams = {item = "Bandits.LabSyringeCure"},
    },

    -- base condition dependent
    ["1000.1"] = {
        -- qst = "Why is it so cold?",
        -- ans = "The central heating must be off. We should fix it before we freeze to death!",
        anim = "Gest1",
        req = {},
        hidden = true -- unlocked by base condition
    },
    ["1000.2"] = {
        -- qst = "Is the power out?",
        -- ans = "Shit! We need to check the generator and fuel levels!",
        anim = "GestYes",
        req = {},
        hidden = true -- unlocked by base condition
    },
    ["1000.3"] = {
        -- qst = "I feel sick. What's going on?",
        -- ans = "Gosh! It seems like radiation poisoning.",
        anim = "Gest1",
        req = {},
        hidden = true
    },
    ["1000.3.1"] = {
        -- qst = "How can we recover from radiation poisoning?",
        -- ans = "Take some potassioum iodine pills immediately!",
        anim = "Gest1",
        req = {"1000.3"},
    },
    ["1000.4"] = {
        -- qst = "I feel dizzy. What's happening?",
        -- ans = "Check the CO2 levels and make sure the ventilation is working!",
        anim = "Gest1",
        req = {},
        hidden = true, -- unlocked by base condition
    },
    ["1000.5"] = {
        -- qst = "I've noticed CO2 levels are rising despite ventilation being turn on!",
        -- ans = "We need to check the air intake on the surface!",
        anim = "Gest1",
        req = {"100.2"},
        hidden = true, -- unlocked by base condition
        func = "RevealMission",
        funcParams = {missionId = 3},
    },
    ["1000.5.1"] = {
        -- qst = "Vent is fixed!",
        -- ans = "Good! CO2 levels should be dropping now.",
        anim = "GestYes",
        req = {"1000.5"},
        hidden = true, -- unlocked by mission 3
    },

    -- dream related
    ["2000.1"] = {
        -- qst = "I had a terrible dream...",
        -- ans = "It's ok, it's just a dream. You're safe here.",
        anim = "Calm",
        req = {},
        hidden = true, -- unlocked by dream 1
    },
    ["2000.2"] = {
        -- qst = "I had a bad dream again. I am beginning to remember things...",
        -- ans = "Sorry to hear that, but on the bright side, your memories are returning.",
        anim = "Calm",
        req = {"2000.1"},
        hidden = true, -- unlocked by dream 2
    },
    ["2000.3"] = {
        -- qst = "Dream again. Now, I remember what happened to me.",
        -- ans = "What did you dream about exactly?",
        anim = "Calm",
        req = {"2000.2"},
        hidden = true, -- unlocked by dream 3
    },
    ["2000.3.1"] = {
        -- qst = "My last dream was about me surrounded by zombies with little chance of survival.",
        -- ans = "Yes, that's when we found you. You were moments away from getting bitten. Hopefully we got to you in time.",
        anim = "Yes",
        req = {"2000.3"},
    },
    ["2000.4"] = {
        -- qst = "My dreams are changing. I heard some voice.",
        -- ans = "Take it easy. Your mind may still need time to adjust.",
        anim = "Calm",
        req = {"2000.3.1"},
        hidden = true, -- unlocked by dream 4
    },
    ["2000.4.1"] = {
        -- qst = "I'm not crazy. My dreams are not my imagination. It felt very real.",
        -- ans = "Okay. What did the voice say to you?",
        anim = "Calm",
        req = {"2000.4"},
    },
    ["2000.4.1.1"] = {
        -- qst = "In my dream, the voice told me about a shattered seal... And about a judgement of some kind.",
        -- ans = "I'm a doctor, but not a shrink. ",
        anim = "GestNo",
        req = {"2000.4.1"},
    },
    ["2000.5"] = {
        -- qst = "I had another dream and... ",
        -- ans = "Stop! I don't want to hear that crazy stuff! You need to get back to reality!",
        anim = "Calm",
        req = {"2000.4.1.1"},
        hidden = true, -- unlocked by dream 5
    },
    ["2000.5.1"] = {
        -- qst = "Emma, I found a friendly survivor in Ekron.",
        -- ans = "Careful! It's better not to trust anyone!",
        anim = "Calm",
        req = {"2000.5"},
        hidden = true, -- unlocked by artifact sacred_incense
    },
    ["2000.5.1.1"] = {
        -- qst = "I know. He's a priest and he didn't want to come with me anyway.",
        -- ans = "A priest? Who would have thought that there would be a priest left in this world.",
        anim = "Gest1",
        req = {"2000.5.1"},
    },
    ["2000.5.1.1.1"] = {
        -- qst = "The priest pointed to some documents that speak about comfrey.",
        -- ans = "That plant? This seems unrelated to our cause. Honestly, waste of time.",
        anim = "GestNo",
        req = {"2000.5.1.1"},
    },
    ["2000.5.1.1.1.1"] = {
        -- qst = "I know, but you're the one who mentioned faith as the only thing you have left.",
        -- ans = "Okay. But what exactly do you want us to do regarding comfrey.",
        anim = "Gest1",
        req = {"2000.5.1.1.1"},
    },
    ["2000.5.1.1.1.1.1"] = {
        -- qst = "I am going to find it.",
        -- ans = "You're joking... The ecosystem has collapsed. You've seen the world, right?",
        anim = "GestNo",
        req = {"2000.5.1.1.1.1"},
    },
    ["2000.5.1.1.1.1.1.1"] = {
        -- qst = "If I can't find the plant, then I will find the seeds.",
        -- ans = "Theoretically, some seeds may have survived. You could grow it here. ",
        anim = "GestYes",
        req = {"2000.5.1.1.1.1.1"},
    },
    ["2000.5.2"] = {
        -- qst = "Took a while, but I managed to grow some comfrey.",
        -- ans = "I nearly forgot about that. Bring it to the lab. I will see what I can do with it.",
        anim = "GestYes",
        req = {"2000.5.1.1.1.1.1.1"},
        hidden = true, -- unlocked by artifact comfrey_seeds
    },
    ["2000.5.3"] = {
        -- qst = "I found out that Fallas Lake was not destroyed.",
        -- ans = "Correct. The city lies in a valley, so it was protected from the worst of the blast. It's a good place for foraging.",
        anim = "GestYes",
        req = {},
        hidden = true, -- unlocked by scene Fallas Church
    },
    ["2000.6.1"] = {
        -- qst = "Emma, my dreams led me to a secret laboratory, and I learned something important about the virus. ",
        -- ans = "What did you learn? Please, tell me.",
        anim = "Gest1",
        req = {},
        hidden = true, -- unlocked by artifact early_mortuary_practice
    },
    ["2000.6.1.1"] = {
        -- qst = "The virus isn't new. Ancient texts mention rituals that could be connected to it. ",
        -- ans = "Connected? How so?",
        anim = "Gest1",
        req = {"2000.6.1"},
    },
    ["2000.6.1.1.1"] = {
        -- qst = "The rituals weren't just symbolic. They had problems with the dead... ",
        -- ans = "What kind of problems?",
        anim = "Gest1",
        req = {"2000.6.1.1"},
    },
    ["2000.6.2"] = {
        -- qst = "I found out that Soviets investigated the area where the ancient culture performed the rituals. ",
        -- ans = "Interesting. What did they find?",
        anim = "Gest1",
        req = {"2000.6.1.1.1"},
        hidden = true, -- unlocked by artifact paleolithic_survey_group
    },
    ["2000.6.2.1"] = {
        -- qst = "The Soviets conducted excavations there. In the permafrost, they discovered some kind of preserved organism. ",
        -- ans = "And you think that's the same organism responsible for what happened here.",
        anim = "Gest1",
        req = {"2000.6.2"}, 
        hidden = true, -- unlocked by artifact supplementary_excavation_log
    },
    ["2000.6.2.1.1"] = {
        -- qst = "I know that the Soviet research was later studied here, in the lab I visited. ",
        -- ans = "Did you find anything more concrete in that lab? If not, it might be worth investigating further.",
        anim = "Gest1",
        req = {"2000.6.2.1"},
    },
    ["2000.6.3"] = {
        -- qst = "Emma, I saw the documents. I have proof they brought the virus here!",
        -- ans = "Shit! I knew it! There's always a bunch of assholes who screw everything up.",
        anim = "Gest1",
        req = {"2000.6.2.1.1"},
        hidden = true, -- unlocked by artifact 7-Q-17
    },
    ["2000.6.3.1"] = {
        -- qst = "Apparently, our government had an agent in the Soviet excavation group.",
        -- ans = "Well... that's taxpayer money at work. First the Soviets, now our own idiots. ",
        anim = "Gest1",
        req = {"2000.6.3"},
    },
    ["2000.6.4"] = {
        -- qst = "I have a list of all the assholes who worked at that lab.",
        -- ans = "Do you think this's relevant?",
        anim = "Gest1",
        req = {"2000.6.2.1.1"}, -- unlocked by artifact science_team
        hidden = true,
    },
    ["2000.6.4.1"] = {
        -- qst = "One of the doctors from the lab was named Cortman. He had a clinic in Muldraugh.",
        -- ans = "That super old rich prick? Interesting. I wonder if you should pay him a visit.",
        anim = "Gest1",
        req = {"2000.6.4"},
        func = "RevealMission",
        funcParams = {missionId = 111},
    },
    ["2000.6.4.1.1"] = {
        -- qst = "I found out that Cortman injected himself with some suspicious substance. ",
        -- ans = "Do you know what it was? Did you find any trace of that substance there?",
        anim = "Gest1",
        req = {"2000.6.4.1"},
        hidden = true, -- unlocked by artifact Dr. Andrew Cortman's Note
    },
    ["2000.6.4.1.2"] = {
        -- qst = "Cortman's house had a secret room and I think I might have found the substance he injected himself with.",
        -- ans = "I need to investigate it. Put it in the lab. This may lead us somewhere.",
        anim = "Gest1",
        req = {"2000.6.4.1.1"},
        hidden = true, -- unlocked by artifact LabSyringe
        func = "SwitchMission",
        funcParams = {missionAccomplishId = 112, missionRevealId = 113},
    },
    ["2000.7"] = {
        -- qst = "I think I know how it all started.",
        -- ans = "Let me guess. Another dream? Well, last time you were right, so I'm all ears.",
        anim = "GestYes",
        req = {"2000.6.4.1.2"},
        hidden = true, -- unlocked by dream 7
    },
    ["2000.7.1"] = {
        -- qst = "It's not just Cortman. There were others injecting themselves.",
        -- ans = "Oh. Who were they?",
        anim = "Gest1",
        req = {"2000.7"},
    },
    ["2000.7.1.1"] = {
        -- qst = "They were all part of some kind of cult.",
        -- ans = "We need to understand what that substance is.",
        anim = "Gest1",
        req = {"2000.7.1"},
    },
    ["2000.7.1.1.1"] = {
        -- qst = "Longevity. That's what that substance is all about.",
        -- ans = "It must be connected to the zombie outbreak.",
        anim = "GestYes",
        req = {"2000.7.1.1"},
    },
    ["2000.9"] = {
        -- qst = "Emma, I need to go to Louisville.",
        -- ans = "Are you crazy? You will never make it there alive! Why do you want to go there?",
        anim = "GestNo",
        req = {"2000.7.1.1.1"},
        hidden = true, -- unlocked by dream 9
        func = "RevealMission",
        funcParams = {missionId = 120},
    },
    ["2000.9.1"] = {
        -- qst = "I know that Finnegan's Research Group headquarters hide some secrets.",
        -- ans = "I won't stop you, will I? I'm going with you!",
        anim = "GestNo",
        req = {"2000.9"},
    },
    ["2000.9.1.1"] = {
        -- qst = "I need to go alone. You stay here.",
        -- ans = "I don't want you to go!",
        anim = "GestNo",
        req = {"2000.9.1"},
    },
    ["2000.9.1.1.1"] = {
        -- qst = "I need to go. I will come back. I promise.",
        -- ans = "I'll kick your ass if you don't!",
        anim = "Gest1",
        req = {"2000.9.1.1"},
    },
    ["2001.9"] = {
        -- qst = "Emma, I need to tell you something.",
        -- ans = "What is it?",
        anim = "GestYes",
        req = {"2000.6.4.1.2"},
        hidden = true, 
    },
    ["2001.9.1"] = {
        -- qst = "You know my dreams reveal the truth, right?",
        -- ans = "Yes. They were insightful.",
        anim = "GestYes",
        req = {"2001.9"},
    },
    ["2001.9.1.1"] = {
        -- qst = "I've just learned something difficult about my past.",
        -- ans = "Just... Tell me.",
        anim = "GestYes",
        req = {"2001.9.1"},
    },
    ["2001.9.1.1.1"] = {
        -- qst = "I remember who I was. I worked at Finnegan's.",
        -- ans = "Finnegan Research Group?",
        anim = "GestYes",
        req = {"2001.9.1.1"},
    },
    ["2001.9.1.1.1.1"] = {
        -- qst = "I was part of the team that produced the virus.",
        -- ans = "I don't believe you!",
        anim = "Cry1",
        req = {"2001.9.1.1.1"},
        func = "ChangeBrainParam",
        funcParams = {param = "wantToLeave", value = true},
    },
    ["2001.9.1.1.1.1.1"] = {
        -- qst = "I'm so sorry Emma!",
        -- ans = "Go away! I don't want to see you anymore!",
        anim = "Cry2",
        req = {"2001.9.1.1.1.1"},
    },

    -- plot related
    ["3000.1"] = {
        -- qst = "Enough of that bullshit. I'm taking you home.",
        -- ans = "I told you I wanted to be alone. Why did you come?",
        anim = "GestNo",
        req = {},
        hidden = true,
        func = "SwitchMission",
        funcParams = {missionAccomplishId = 50, missionRevealId = 51},
    },
    ["3000.1.1"] = {
        -- qst = "I came because I care about you. Let's go!",
        -- ans = "Just like you cared about everyone else when you killed them with your brilliant medicine?",
        anim = "GestNo",
        req = {"3000.1"},
    },
    ["3000.1.1.1"] = {
        -- qst = "I did what I did, I don't know why, and I'm sorry! ",
        -- ans = "Bullshit!",
        anim = "GestNo",
        req = {"3000.1.1"},
    },
    ["3000.1.1.1.1"] = {
        -- qst = "You said that everyone deserves a second chance. So here I am! ",
        -- ans = "That would be a third chance for you, you asshole. ",
        anim = "Gest1",
        req = {"3000.1.1.1", "100.1.2.2.1.1.1"},
    },
    ["3000.1.1.1.1.1"] = {
        -- qst = "Well that asshole just came to save you.",
        -- ans = "I would have handled it. ",
        anim = "GestNo",
        req = {"3000.1.1.1.1"},
    },
    ["3000.1.1.1.1.1.1"] = {
        -- qst = "You would not, you need me. And I need you.",
        -- ans = "Why do you need me?",
        anim = "Gest1",
        req = {"3000.1.1.1.1.1"},
    },
    ["3000.1.1.1.1.1.1.1"] = {
        -- qst = "You are the only reason I keep going.",
        -- ans = "And you were the only reason I kept going too. ",
        anim = "GestYes",
        req = {"3000.1.1.1.1.1.1"},
    },
    ["3000.1.1.1.1.1.1.1.1"] = {
        -- qst = "We'll talk later, we're heading home. Get ready.",
        -- ans = "Fine! Let's go. But you're still such an asshole. ",
        anim = "GestYes",
        req = {"3000.1.1.1.1.1.1.1"},
        func = "ChangeBrainParam",
        funcParams = {param = "program", value = {name = "Emma", stage = "Exterior"}},
    },
        
}
