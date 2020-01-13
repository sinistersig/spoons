# Spoons for [Hammerspoon](https://www.hammerspoon.org/)

Example init.lua
```
local ws = hs.loadSpoon("WindowSnap")

local keyMapping = {}
local mash = { 'ctrl', 'alt', 'cmd' }

-- Map keys to default dimensions
keyMapping["right50"] = {mash, 'right'}
keyMapping["left50"] = {mash, 'left'}
keyMapping["top50"] = {mash, 'up'}
keyMapping["bottom50"] = {mash, 'down'}
keyMapping["maximum"] = {mash, 'm'}

ws:bindHotkeys(keyMapping)
```
