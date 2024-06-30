#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Focus ChatGPT Tab in Brave
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.author Jesús Serrano
# @raycast.authorURL https://github.com/Tyrbok

osascript <<EOD
tell application "System Events"
    set braveIsRunning to (name of processes) contains "Brave Browser"
end tell

if braveIsRunning then
    tell application "Brave Browser"
        set windowList to every window
        repeat with aWindow in windowList
            set tabList to every tab of aWindow
            repeat with i from 1 to count of tabList
                set atab to item i of tabList
                if URL of atab contains "chatgpt.com" then
                    set active tab index of aWindow to i
                    set index of aWindow to 1
                    activate
                    return
                end if
            end repeat
        end repeat
    end tell
else
    display dialog "Brave Browser is not running."
end if
EOD