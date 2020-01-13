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

-- TODO: remove this
function dump(o)
	if type(o) == 'table' then
		 local s = '{ '
		 for k,v in pairs(o) do
				if type(k) ~= 'number' then k = '"'..k..'"' end
				s = s .. '['..k..'] = ' .. dump(v) .. ','
		 end
		 return s .. '} '
	else
		 return tostring(o)
	end
end

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
  self.logger.i(dump(dimensions))

  for i,v in pairs(mapping) do
    hs.hotkey.bindSpec(v, function() hs.window.focusedWindow():move(dimensions[i], nil, true) end)
  end
end

return obj
