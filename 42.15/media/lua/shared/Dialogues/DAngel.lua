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
        qst = "Who are you?",
        ans = "We met before. But you do not remember, do you?",
        anim = "Gest1",
        req = {"1"},
    },
    ["1.1.1"] = {
        qst = "Actually, I don't. I can't remember my past.",
        ans = "Would you like to know your past?",
        anim = "Gest1",
        req = {"1.1"},
    },
    ["1.1.1.1"] = {
        qst = "Yes, I suppose that would be helpful.",
        ans = "I can offer you that. But it is that your choice?",
        anim = "Gest1",
        req = {"1.1.1"},
    },
    ["1.1.1.1.1"] = {
        qst = "Yes. ",
        ans = "Wake up now.",
        anim = "Gest1",
        req = {"1.1.1.1"},
    },
}
