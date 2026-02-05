require "BWOADialogues"

BWOADialogues.dialogues = BWOADialogues.dialogues or {}

BWOADialogues.dialogues["Father_James"] = {
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
    ["2.1"] = {
        qst = "How long have you been here?",
        ans = "I'm not sure really.",
        anim = "Pray",
        req = {"2"},
    },
    ["2.1.1"] = {
        qst = "This place was sealed, how did you get in here?",
        ans = "I bricked up the entrance and myself in here.",
        anim = "Pray",
        req = {"2.1"},
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
        qst = "I read a note that led me here.",
        ans = "I see.",
        anim = "Pray",
        req = {"1", "2"},
    },
    ["4.1"] = {
        qst = "What kind of meetings were held in this place?",
        ans = "We tried to stop it, but we failed. May God have mercy on our souls.",
        anim = "Pray",
        req = {"4"},
    },
    ["4.1.1"] = {
        qst = "How exactly did you try to stop it?",
        ans = "We studied old documents. We suspected this was not the first time. We searched for a way to prevent it—but we failed. May God have mercy on our souls.",
        anim = "Pray",
        req = {"4.1"},
    },
    ["4.1.1.1"] = {
        qst = "Please tell me more, Father. What documents? Can I do something?",
        ans = "The Eastern Church wrote of it. We believed it to be a syncretism of faith and local tradition, but it carried a deeper meaning. All signs pointed to cleansing rituals using herbs, most notably comfrey. They used it because they struggled with the dead. Do you understand?",
        anim = "Pray",
        req = {"4.1.1"},
    },
    ["4.1.1.1.1"] = {
        qst = "Comfrey? Why comfrey?",
        ans = "I am no scientist, my child. But if you still have hope, what I have said may guide you. Look at the note on the table.",
        anim = "Pray",
        req = {"4.1.1.1"},
    },
    ["5"] = {
        qst = "Thank you, Father. I must go now.",
        ans = "May God bless you on your journey, my son.",
        anim = "Pray",
        req = {"3.1.1.1.3.1", "3.1.1.1.2", "3.1.1.1.1.1"},
    },
}