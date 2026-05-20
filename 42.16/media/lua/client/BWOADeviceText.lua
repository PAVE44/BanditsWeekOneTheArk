local function onDeviceText(guid, codes, x, y, z, text, device)

    local dd = device:getDeviceData()
    if not dd then return end

    dd:cleanSoundsAndEmitter()

    local audio = guid
    local tab = {
        dd = dd,
        sound = guid
    }

    BWOASound.PlayDevice(tab)
end

Events.OnDeviceText.Remove(onDeviceText)
Events.OnDeviceText.Add(onDeviceText)