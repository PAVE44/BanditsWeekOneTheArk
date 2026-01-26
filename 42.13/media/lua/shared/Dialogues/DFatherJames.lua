BWOADialogues.dialogues = BWOADialogues.dialogues or {}

BWOADialogues.dialogues["Father James"] = {
    ["1"] = {
        qst = "Who are you?",
        ans = "My name is Father James. I'm a catholic priest. If have nothing to give. You can have my life, that is all I have left to give.",
        anim = "Pray",
        req = {},
    },
    ["2"] = {
        qst = "What are you doing here?",
        ans = "Praying. Lord is my shepherd.",
        anim = "Pray",
        req = {},
    },
    ["3"] = {
        qst = "Father, you don't need to be here. We have a shelter. Come with me!",
        ans = "This place is where I belong.",
        anim = "Pray",
        req = {"1", "2"},
    },
    ["3.1"] = {
        qst = "Father James. Please, allow yourself to be saved!",
        ans = "We are already saved by our Lord. I need not more salvation. Why are you here?",
        anim = "Pray",
        req = {"3"},
    },
    ["3.1.1"] = {
        qst = "I was guided by a voice speaking about the sin and a shattered seal.",
        ans = "Continue.",
        anim = "Pray",
        req = {"3.1"},
    },
    ["3.1.1.1"] = {
        qst = "It spoke about something about a judgement and a dark end.",
        ans = "You have been through a lot my child. ",
        anim = "Pray",
        req = {"3.1.1"},
    },
    ["3.1.1.1.1"] = {
        qst = "I believe that my dreams hold a greater meaning",
        ans = "It's not a coincidence you are here. Truely you are guided.",
        anim = "Pray",
        req = {"3.1.1.1"},
    },
    ["3.1.1.1.1.1"] = {
        qst = "What should I do father?",
        ans = "The answer must be here. Seek and you shall find.",
        anim = "Pray",
        req = {"3.1.1.1.1"},
    },
    ["3.1.1.1.2"] = {
        qst = "I lost my memory, I was in a coma.",
        ans = "Maybe it had to be that way.",
        anim = "Pray",
        req = {"3.1.1.1.1"},
    },
    ["3.1.1.1.3"] = {
        qst = "I have seen terrible things Father.",
        ans = "We all did, trust in the Lord and protect what you hold dear.",
        anim = "Pray",
        req = {"3.1.1.1.1"},
    },
    ["3.1.1.1.3.1"] = {
        qst = "Actually Father. There is someone I need to protect now.",
        ans = "Save her and you will save the world.",
        anim = "Pray",
        req = {"3.1.1.1.3"},
    },
    ["3.1.1.1.3.1.1"] = {
        qst = "How did you know it's her?",
        ans = "Son, I see it in your eyes. You are in love. That is why you will win.",
        anim = "Pray",
        req = {"3.1.1.1.3.1"},
    },
    ["4"] = {
        qst = "Thank you father, I must go now.",
        ans = "God bless you on your journey my son!",
        anim = "Pray",
        req = {"3.1.1.1.3.1", "3.1.1.1.2", "3.1.1.1.1.1"},
    },

}