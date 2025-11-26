require "ISUI/ISEmoteRadialMenu"

local actionEmote = ISEmoteRadialMenu.emote

function ISEmoteRadialMenu:emote(emote)
    actionEmote(self, emote)
    triggerEvent("OnEmote", self.character, emote)
end


local radialMenu = ISEmoteRadialMenu.init

function ISEmoteRadialMenu:init()
    -- radialMenu(self)

    ISEmoteRadialMenu.defaultMenu = {}

    ISEmoteRadialMenu.defaultMenu["shout"] = {}
	ISEmoteRadialMenu.defaultMenu["shout"].name = getText("IGUI_Emote_Shout")
    ISEmoteRadialMenu.defaultMenu["movement"] = {}
	ISEmoteRadialMenu.defaultMenu["movement"].name = getText("Movement")
	ISEmoteRadialMenu.defaultMenu["movement"].subMenu = {}
	ISEmoteRadialMenu.defaultMenu["movement"].subMenu["stop"] = "Don't follow"
	ISEmoteRadialMenu.defaultMenu["movement"].subMenu["followme"] = "Follow me"
    
    ISEmoteRadialMenu.variants = {}

    ISEmoteRadialMenu.icons = {}
    ISEmoteRadialMenu.icons["shout"] = getTexture("media/ui/Traits/trait_talkative.png")
    ISEmoteRadialMenu.icons["movement"] = getTexture("media/ui/emotes/followme.png")
    ISEmoteRadialMenu.icons["stop"] = getTexture("media/ui/emotes/comehere.png")
    ISEmoteRadialMenu.icons["followme"] = getTexture("media/ui/emotes/followme.png")

    ISEmoteRadialMenu.menu = ISEmoteRadialMenu.defaultMenu

end