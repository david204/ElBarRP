NCConfig = {}

NCConfig.NewCore = true -- if you are using the exports versin set true
NCConfig.Core = "QBCore" -- Your core name
NCConfig.Exports = "nchub" -- Your core script name

NCConfig.WhitelistedJobs = { --add job for adding an employee list for the current job and pick how to sort it
    -- Example:
    --[[
        ['jobname'] = {
            ['SortBy'] = 'tag' / 'job' -> how to sort players on the list.
        },
    ]]

    ["police"] = {
        ["SortBy"] = "tag"--how to sort players on the list.
    },
    ["ambulance"] = {
        ["SortBy"] = 'job'--how to sort players on the list.
    }
} -- example: 

NCConfig.ShowOnOffDuty = false -- true = show the list when a player is off duty.

NCConfig.ShowJob = true -- shows the player job grade in the list

NCConfig.UpdateChannelEvent = 'nc-10system:server:updateChannel' -- your uptade channel event for updating the chanel in the list //YOU HAVE TO CHANGE IT!!!

NCConfig.UpdateTalkingEvent = 'nc-10system:server:updateTalking' -- your uptade talking event for updating if you are talking // YOU HAVE TO CHANGE IT!!!

NCConfig.DefaultCodename = "None" -- Default code if the player didn't define one yet
