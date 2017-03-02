local __FILE__ = debug.getinfo(1,'S').source:sub(2)
--__FILE__ = string.match(__FILE__, ".+/([^/]*%.%w+)$") -- *nix system  
--__FILE__ = "/data/wwwroot/huang.lua"

function dirname(str)  
    if str:match(".-/.-") then  
        local name = string.gsub(str, "(.*/)(.+)", "%1")  
        return name  
    elseif str:match(".-\\.-") then  
        local name = string.gsub(str, "(.*\\)(.+)", "%1")  
        return name  
    else  
        return ''  
    end  
end  

__FILE__ = dirname(__FILE__)
print(__FILE__)
print(__FILE__:sub(1, -2))
print(__FILE__:sub(1, -2))
print(__FILE__:sub(1, -2))
print(__FILE__:sub(1, -2))
print(__FILE__:sub(1, -2))
print(__FILE__:sub(1, -2))
