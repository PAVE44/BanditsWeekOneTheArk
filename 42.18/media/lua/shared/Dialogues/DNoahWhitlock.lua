require "BWOADialogues"

BWOADialogues.dialogues = BWOADialogues.dialogues or {}

BWOADialogues.dialogues["Noah_Whitlock"] = {
    ["1"] = {
        -- qst = "Am I dead?",
        -- ans = "Welcome back Mr Keller. How are you feeling?",
        anim = "SitInChair1",
        req = {},
    },
    ["2"] = {
        -- qst = "I feel confused. Who the hell are you?",
        -- ans = "I'm dr Noah Whitlock. I've been helping you.",
        anim = "SitInChair1",
        req = {"1"},
    },
    ["3"] = {
        -- qst = "I don't recognize this place. Where are we?",
        -- ans = "We're outside now. ",
        anim = "SitInChair1",
        req = {"2"},
    },

    ["4"] = {
        -- qst = "That's not possible. There's nothing outside the Ark...",
        -- ans = "Mr Keller. I'm going to walk you through this, step by step. You've been through a lot.",
        anim = "SitInChair1",
        req = {"3"},
    },
    ["5"] = {
        -- qst = "If we were really outside, there would be...",
        -- ans = "Destruction. Infection. The dead. Radiation. You've told me about all of it.",
        anim = "SitInChair1",
        req = {"4"},
    },
    ["6"] = {
        -- qst = "Was I here before?",
        -- ans = "Yes. Many times. It's alright if you don't remember. Each time, we make a little more progress. But you always choose to go back.",
        anim = "SitInChair1",
        req = {"5"},
    },
    ["7"] = {
        -- qst = "So this is another shelter?",
        -- ans = "For a long time, the Ark was the only one you had.",
        anim = "SitInChair1",
        req = {"6"},
    },
    ["8"] = {
        -- qst = "This doesn't feel real. I must be dreaming again.",
        -- ans = "This place is real, and everything you are experiencing now is real.",
        anim = "SitInChair1",
        req = {"7"},
    },
    ["9"] = {
        -- qst = "If this is real then how did I get in here?",
        -- ans = "You came back. More precisely, your mind did.",
        anim = "SitInChair1",
        req = {"8"},
    },
    ["10"] = {
        -- qst = "I don't understand. Just tell me clearly.",
        -- ans = "Alright. The Ark is something created to protect you. A place to hide from what happened.",
        anim = "SitInChair1",
        req = {"9"},
    },
    ["11"] = {
        -- qst = "What happened?",
        -- ans = "Bob... I need you to stay with me now. This will hurt. You lost your family. Months ago. Your mind buried that memory. It couldn't carry it. This was a self defense mechanism. ",
        anim = "SitInChair1",
        req = {"10"},
    },
    ["12"] = {
        -- qst = "No... that's not true.",
        -- ans = "That's a natural response. Last time, this is where you shut down. But now, you're still here.",
        anim = "SitInChair1",
        req = {"11"},
    },
    ["13"] = {
        -- qst = "Wait... the dreams... I remember... God...",
        -- ans = "Take your time. You're doing well.",
        anim = "SitInChair1",
        req = {"12"},
    },
    ["13.1"] = {
        -- qst = "So the Ark isn't real?",
        -- ans = "It's very real, to you. I have constructed it for you. Not as an engineer, but as your doctor. The Ark acts like a shelter for your trauma, where the healing process takes place. ",
        anim = "SitInChair1",
        req = {"13"},
    },
    ["13.2"] = {
        -- qst = "I think... my family was murdered...",
        -- ans = "That is correct. It happened at your house. You weren't there. You were working late. The guilt became too much and it lead to your condition. ",
        anim = "SitInChair1",
        req = {"13"},
    },
    ["14"] = {
        -- qst = "Emma... what about Emma?",
        -- ans = "She's your daughter. When you lost your family, you lost the whole world. The destroyed world pictures that. But you couldn't let her go. So you brought her with you. You gave her a role. Someone who could guide you. Keep you alive.",
        anim = "SitInChair1",
        req = {"13.1", "13.2"},
    },
    ["15"] = {
        -- qst = "So... all of this... is a therapy?",
        -- ans = "Yes. We tried many approaches. In one, we gave you a mission to stop the nuclear attack. But it did not work. You needed a world that matched how you felt. ",
        anim = "SitInChair1",
        req = {"14"},
    },
    ["15.1"] = {
        -- qst = "And the zombies?",
        -- ans = "They are the other people. Monsters who killed your family. Maybe other people you could no longer trust. You dehumanized them. Maybe except for one. ",
        anim = "SitInChair1",
        req = {"15"},
    },
    ["15.1.1"] = {
        -- qst = "A priest...",
        -- ans = " Yes, Father James. He also tried to help you. ",
        anim = "SitInChair1",
        req = {"15.1"},
    },
    ["15.2"] = {
        -- qst = "Finnegan...",
        -- ans = "Your job. You blamed yourself, but also them for what happened. ",
        anim = "SitInChair1",
        req = {"15"},
    },
    ["15.3"] = {
        -- qst = "The radiation, it's been falling.",
        -- ans = "That's the healing process. ",
        anim = "SitInChair1",
        req = {"15"},
    },
    ["16"] = {
        -- qst = "What happens now?",
        -- ans = "That's up to you. When you leave this room... you may return to the Ark. Or you may stay here. Your mind will make that choice for you. If you go back, you'll forget this again. But the pain will be less. And we'll meet again. Just like we always do.",
        anim = "SitInChair1",
        req = {"15.1.1", "15.2", "15.3"},
    },
}
