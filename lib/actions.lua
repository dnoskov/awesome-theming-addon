
local actions = {}

local test = {
   files   = { os.getenv("HOME") .. "/foo", os.getenv("HOME") .. "/bar" },
   strings = { "foo", "bar" },
   funcs   = { "configs.getXcolorsString", "replaceFile", "configs.xcolorsApply" }
}

-- Переписывает содержимое файлов cfg.files[x] полностью,
-- заменяя содержимое каждого из них на cfg.string[x].
-- Т.е. i-тая строка записывается в i-й файл.
function actions.writeFiles (cfg)
   for i, file in pairs(cfg.files) do
      cfgfile = io.open(file, "w")
      io.write("Attempting to write " .. file .. " ... ")
      cfgfile:write(cfg.strings[i])
      cfgfile:flush()
      cfgfile:close()
      io.write("Done. File closed.\n")
   end
end

return actions