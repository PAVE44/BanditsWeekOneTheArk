require "BWOADialogues"

BWOADialogues.dialogues = BWOADialogues.dialogues or {}

BWOADialogues.dialogues["Angel"] = {
    ["1"] = {
        qst = "Am I dead?",
        ans = "Do not be afraid. Your time has not come yet.",
        anim = "WaveHi",
        req = {},
    },
    ["1.1"] = {
        qst = "You are an angel.",
        ans = "Surprised?",
        anim = "Gest1",
        req = {"1"},
    },
    ["1.1.1"] = {
        qst = "Who are you?",
        ans = "We met before. But you do not remember, do you? I am the architect of your dreams.",
        anim = "Gest1",
        req = {"1.1"},
    },

    ["1.1.1"] = {
        qst = "Surprised?",
        ans = "Well, not in hell, hopefully. You are dreaming. This place is for you. It's time you face the truth. Are you ready to learn it?",
        anim = "Gest1",
        req = {"1.1"},
    },
    ["1.1.1.1"] = {
        qst = "You bet I am.",
        ans = "Then you will find the answers you are looking for.",
        anim = "Gest1",
        req = {"1.1.1"},
    },
}
