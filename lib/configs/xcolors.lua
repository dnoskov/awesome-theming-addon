local utils = require 'pl.utils'
local awful = {
   util = require 'awful.util'
} 

local xcolors = {}
local test = {
   file = { os.getenv("HOME") .. "/.Xcolors" },
   data = {
      ["foreground"] = "#dbe1ee",
      ["background"] = "#1b1e21",
      ["color0"] = "#1b1e21",
      ["color8"] = "#16141e",
      ["color1"] = "#b04734",
      ["color9"] = "#c9756a",
      ["color2"] = "#234c19",
      ["color10"] = "#5ea02f",
      ["color3"] = "#b09a34",
      ["color11"] = "#c9b56a",
      ["color4"] = "#1e445e",
      ["color12"] = "#6caabf",
      ["color5"] = "#501b39",
      ["color13"] = "#a6409d",
      ["color6"] = "#637287",
      ["color14"] = "#b1bacb",
      ["color7"] = "#dbe1ee",
      ["color15"] = "#ffffff",
   }
}


local function getString (data)
   cfgstr = ""
   for k, v in pairs(data) do
      cfgstr = cfgstr .. "*" .. k .. ":" .. tostring(v) .. "\n"
   end
   return cfgstr
end

function mergeXRDB (file)
   awful.util.spawn_with_shell("xrdb -m " .. file)
end

function xcolors.test ()
   print(getString(test.data))
end

function xcolors.Apply (cfg)
   utils.writefile(cfg.file, getString(cfg.data))
   mergeXRDB(cfg.file)
end

return xcolors