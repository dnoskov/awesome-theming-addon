function replaceFile (file, string)
   file = io.open(file, "w")
   file:write(string)
   file:flush()
   file:close()
end
