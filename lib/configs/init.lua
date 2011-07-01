local configs = {
   gtk = require 'configs.gtk',
   xcolors = require 'configs.xcolors',
   acyl = require 'configs.acyl'
}

function configs.Apply ()
   for cfgname, cfg in pairs(configs) do
      if type(cfg) ~= "function" then
	 if cfg.cfg ~= nil then
	    cfg.Apply(cfg.cfg)
	 else print("Конфигурация " .. cfgname .. " отключена/пуста.") end
      end
   end
end

function configs.test ()

end

return configs