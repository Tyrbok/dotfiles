#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Fichaje Factorial
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖

tell application "System Events"
    key code 48 -- Simula Tabulador
    keystroke "9"
    keystroke "0"
    key code 48 -- Simula Tabulador
    keystroke "1"
    keystroke "4"
    keystroke "0"
    key code 48 -- Simula Tabulador
    delay 0.1
    key code 48 -- Simula Tabulador (dos veces)
    delay 0.1
    key code 36 -- Simula Intro
    delay 1
    key code 36 -- Simula Intro
    delay 0.1
    key code 48 -- Simula Tabulador
    delay 0.3
    keystroke "1"
    keystroke "5"
    delay 0.1
    key code 48 -- Simula Tabulador
    keystroke "1"
    keystroke "8"
    keystroke "0"
    key code 48 -- Simula Tabulador
    delay 0.1
    key code 48 -- Simula Tabulador (dos veces)
    delay 0.1
    key code 36 -- Simula Intro
end tell
