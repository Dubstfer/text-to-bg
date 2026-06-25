#!/usr/bin/env lua                                                                                                                                                                                                                                     
                                                                                                        
                                                                                     
--Config Vars                                                                        
local user = os.getenv("USER")                                                       
local project_dir = "/home/"..user.."/.text-to-bg"                                   
local bg_text = project_dir.."/bg.txt"                                               
local output_img = project_dir.."/bg.png"                                            
                                                                                     
local w = 1920
local h = 1080
local backgroundColor = "#2b303b"                                                    
local textColor = "#f6b511"

--Verify if the art file exists                                              
local f = io.open(bg_text, "r")                                                     
if not f then                                                                       
        print("No text file found at "..bg_text)                                         
        os.exit(1)                                                                  
end                                                                                 
f:close()                                                                           

-- 1. Construct the pipeline command using pango
local pipeline_cmd = string.format(
[[magick -size %dx%d! -background "%s" -fill "%s" -font "Noto-Znamenny-Musical-Notation-Regular" -pointsize 15 -gravity Center pango:@"%s" "%s"]],
w, h, backgroundColor, textColor, bg_text, output_img
)

-- 2. Construct the Swaybg Reload Command
local swaybg_cmd = "pkill swaybg; swaybg -m fill -i '" .. output_img .. "' > /dev/null 2>&1 &"

-- 4. Execute the pipeline
print("Piping text through engine...")                                                   
os.execute(pipeline_cmd)                                       
os.execute(swaybg_cmd)
