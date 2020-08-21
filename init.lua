-- Spectacle replacement 
-- https://github.com/scottwhudson/Lunette
hs.loadSpoon("Lunette")
customBindings = {
    leftHalf = {
        {{"ctrl", "cmd"}, "j"},
    },
    rightHalf = {
        {{"ctrl", "cmd"}, "k"},
    },
    fullScreen = {
        {{"ctrl", "cmd"}, "return"},
    },
    center = {
        {{"ctrl", "cmd"}, "c"},
    },
    nextDisplay = {
        {{"ctrl", "shift", "cmd"}, "j"},
    },
    prevDisplay = {
        {{"ctrl", "shift", "cmd"}, "k"},
    },
    enlarge = {
        {{"ctrl", "cmd"}, "="},
    },
    shrink = {
        {{"ctrl", "cmd"}, "-"},
    },
    undo = {
        {{"ctrl", "cmd"}, "delete"},
    },
    redo = false,
    topHalf = false,
    bottomHalf = false,
    topLeft = false,
    topRight = false,
    bottomLeft = false,
    bottomRight = false,
    nextThird = false,
    prevThird = false,
}
spoon.Lunette:bindHotkeys(customBindings)


-- Fancy config reload
function reloadConfig(files)
    doReload = false
    for _, file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/dotfiles/init.lua", reloadConfig):start()
hs.notify.new({title = "Hammerspoon", informativeText = "Config loaded"}):send()


-- Application keybinding
function open(name)
    return function()
        hs.application.launchOrFocus(name)
        -- if name == 'Finder' then
        --   hs.appfinder.appFromName(name):activate()
        -- end
    end
end

hs.hotkey.bind({"cmd", "ctrl"}, "w", open("Messages"))
hs.hotkey.bind({"cmd", "ctrl"}, "p", open("Preview"))
-- hs.hotkey.bind({"cmd", "ctrl"}, "w", open("Telegram"))
hs.hotkey.bind({"cmd", "ctrl"}, "s", open("Safari"))
-- hs.hotkey.bind({"cmd", "ctrl"}, "a", open("Visual Studio Code"))
hs.hotkey.bind({"cmd", "ctrl"}, "i", open("Alacritty"))
hs.hotkey.bind({"cmd", "ctrl"}, "e", open("Amazon Chime"))
hs.hotkey.bind({"cmd", "ctrl"}, "r", open("Finder"))
hs.hotkey.bind({"cmd", "ctrl"}, "[", open("Calendar"))
hs.hotkey.bind({"cmd", "ctrl"}, "]", open("Notes"))
-- hs.hotkey.bind({"cmd", "ctrl"}, "u", open("Mindnode"))
hs.hotkey.bind({"cmd", "ctrl"}, "x", open("IntelliJ IDEA"))
hs.hotkey.bind({"cmd", "ctrl"}, "y", open("Google Chrome"))
hs.hotkey.bind({"cmd", "ctrl"}, "m", open("Microsoft Outlook"))


-- Defeating paste blocking
hs.hotkey.bind({"cmd", "alt"}, "v", function()
    hs.eventtap.keyStrokes(hs.pasteboard.getContents())
end)


-- Airpods
hs.hotkey.bind({"cmd", "alt", "shift"}, "a", function()
    local cmd = "/usr/local/bin/bluetoothConnector -c 40-70-f5-c6-ba-42 --notify"
    hs.execute(cmd)
end)


-- Merge all windows
hs.hotkey.bind({"cmd", "alt"}, "m", function()
    local cmd =  [[
    tell application "System Events"
        click menu item "Merge All Windows" of menu "Window" of menu bar item "Window" of menu bar 1 of application process "Finder" of application "System Events"
        click menu item "Merge All Windows" of menu "Window" of menu bar item "Window" of menu bar 1 of application process "Safari" of application "System Events"
    end tell
    ]]
    hs.applescript(cmd)
end)


-- Google selected text
-- hs.hotkey.bind({"cmd", "alt"}, "g", function()
--     local text = hs.uielement.focusedElement():selectedText()
--     print(text)
--     -- local cmd = "open -a Safari.app 'https://www.google.com/search?q='" .. text
--     hs.execute(text)
-- end)
