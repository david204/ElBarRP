-- [[ Variables ]] --
local discord = {
    ['name'] = 'sm-10system',
    ['webhook'] = '', -- Webhook link
    ['image'] = 'https://cdn.discordapp.com/attachments/900282783409250335/954884931350323251/Screenshot_4.png'
}

-- [[ Functions ]] --
function SendLog(name, Text)
    local data = {
        {
            ["color"] = '5555555',
            ["title"] = "**SM-10System - Management**",
            ["description"] = name .. " ".. Text .. " at " .. os.date(),
        }
    }
    PerformHttpRequest(discord['webhook'], function(err, text, headers) end, 'POST', json.encode({username = discord['name'], embeds = data, avatar_url = discord['image']}), { ['Content-Type'] = 'application/json' })
end