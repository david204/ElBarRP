Config = {}

Config.webhook = "https://discord.com/api/webhooks/1041399669806333952/r1sdFsDd7bv2cjhDKGGHm31mURWEpEz-mtI-3m6BHK3ayl9c8UD3zT3hl9UU2oHUsYTP" --Your webhook address for the discord channel where the Bodycam recordings will be sent
 
Config.resolutions = "720p" -- or "1080p" , "480p" , "360p" /  Image quality of the video to be recorded.

Config.timeout = 30000 -- In milliseconds, the amount of seconds the video will be divided so that it does not exceed the Discord loading size

Config.bodycamitem = "bodycam" -- The name of the item you will use my body for
 
Config.command = "" --If you want to use a command key instead of the item, enter a command key , else = ""

Config.openui = "bcrecords" --Command to open the user interface to view recordings

Config.jobs = {"police" , "sheriff"}

Config.boss = "C.O.P" -- The rank in which you will be authorized to delete records
