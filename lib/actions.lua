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

-- Выплняет xrdb -merge для каждого файла конфигурации
function actions.XRDBmerge (cfg)
   for num, cfgfile in pairs(cfg.files) do
      io.write("Attempting to update XRDB with " .. cfgfile .. " ... ")
      local cmd = "xrdb -merge " .. cfgfile
      io.write("\nExecuting " .. cmd)
      awful.util.spawn_with_shell(cmd)
      io.write(" ... Done.\n")
   end
end

-- Экспортирует переменные окружения (не тестировалось)
function actions.exportEnv (cfg)
   if cfg.env then
      io.write("Exporting environment ... \n")
      for name, value in pairs(cfg.env) do
	 cmd = "export " .. name .. "=" .. value
	 awful.utils.spawn_with_shell(cmd)
	 io.write("    " .. name .. " = " .. value .. "\n")
      end
      io.write("... Done.\n")
   else
      io.write("Nothing to export.\n")
   end
end

return actions