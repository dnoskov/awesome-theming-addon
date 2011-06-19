local configs = {
   gtk = require 'configs.gtk',
   xcolors = require 'configs.xcolors',
   acyl = require 'configs.acyl'
}

function configs.Apply ()
   for cfgname, cfg in pairs(configs) do
      if type(cfg) ~= "function" then
	 cfg.Apply(cfg.cfg)
      end
   end
end

function configs.test ()

end

return configs