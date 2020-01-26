local obj={}
obj.__index = obj

-- Metadata
obj.name = "WindowSnap"
obj.version = "0.0.1"
obj.author = "Sigismond McLaughlin <1987997+sinistersig@users.noreply.github.comg>"
obj.homepage = "https://github.com/sinistersig/spoons"
obj.license = "MIT - https://opensource.org/licenses/MIT"

--- WindowSnap.logger
--- Variable
--- Logger object used within the Spoon. Can be accessed to set the default log level for the messages coming from the Spoon.
obj.logger = hs.logger.new('WindowSnap', 'debug')

--- WindowSnap.dimensions
--- Variable
--- Table containing a list of arguments to be passed to grid.setGrid(). Each element in the table is itself a table with 1-3 arguments as defined for [hs.grid.setGrid()](http://www.hammerspoon.org/docs/hs.grid.html#setGrid). Defaults to an empty list, which results in the default 3x3 grid for all screen from `hs.grid`.
obj.defaultDimensions = {}

-- Default dimensions are provided but can be overriden using configDimensions
obj.defaultDimensions["right50"]= { x = 0.50, y = 0.00, w = 0.50, h = 1.00 }
obj.defaultDimensions["left50"] = { x = 0.00, y = 0.00, w = 0.50, h = 1.00 }
obj.defaultDimensions["top50"] = { x = 0.00, y = 0.00, w = 1.00, h = 0.50 }
obj.defaultDimensions["bottom50"] = { x = 0.00, y = 0.50, w = 1.00, h = 0.50 }
obj.defaultDimensions["maximum"] = { x = 0.00, y = 0.00, w = 1.00, h = 1.00 }
obj.defaultDimensions["center"] = { x = 0.25, y = 0.00, w = 0.25, h = 1.00 }


--- WindowSnap:configureDimensions(dimensions)
--- Method
--- Configures spoon with map of keys to dimensions
function obj:config(dimensions)
  self.dimensions = dimensions
end

-- TODO: document this
function obj:bindHotkeys(mapping)
  local dimensions = self.defaultDimensions
  if self.dimensions then
    dimensions = self.dimensions
  end

-- TODO: log errors where dimensions do not have a corresponding mapping
  for i,v in pairs(dimensions) do
    hs.hotkey.bindSpec(mapping[i], function() hs.window.focusedWindow():move(v, nil, true) end)
  end

  if mapping["next"] then
    hs.hotkey.bindSpec(mapping["next"], nextKey, function()
      local win = hs.window.focusedWindow()
      local screen = win:screen()

      win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
    end)
  end

end

return obj
