Config = {}

Config.needCops = 0 -- How much cops.
Config.money = math.random(1000, 1800) --How much money(ATM).
Config.timeATM = 85 -- Seconds.
Config.timeTruck = 85 -- Seconds.

Config.TruckRob = {
    ["plastic"] = math.random(45,60),
    ["metalscrap"] = math.random(35,55),
    ["copper"] = math.random(35,55),
    ["aluminum"] = math.random(50,60),
    ["iron"] = math.random(45,60),
    ["steel"] = math.random(45,75),
    ["rubber"] = math.random(7,18),
    ["glass"] = math.random(45,70),
    ["gallary_skull"] = 1,
    ["gallary_egg"] = 1,
    ["sapphire"] = math.random(1,3),
    ["emerald"] = math.random(1,3),
    ["ruby"] = math.random(1,2),
    ["gallary_dragon"] = math.random(1,3),
    ["guitar"] = math.random(1,3),
    ["ruby_ring"] = math.random(1,3),
    ["diamond"] = math.random(1,3),
    ["gold_ring"] = math.random(1,3),
    ["sapphire_ring"] = math.random(1,3),
    ["emerald_ring"] = math.random(1,3),
    ["ruby_necklace"] = math.random(1,3),
    ["emerald_necklace"] = math.random(1,3),
    ["sapphire_necklace"] = math.random(1,3),
    ["diamond_necklace"] = math.random(1,3),
    ["goldchain"] = math.random(1,3),
    ["carbon"] = math.random(1,3),
    ["goldore"] = math.random(1,3),
    ["trophy"] = math.random(1,3),
    ["aquamarine_ring"] = math.random(1,3),
    ["citrine_ring"] = math.random(1,3),
    ["diamond_ring"] = math.random(1,3),
    ["jade_ring"] = math.random(1,3),
    ["onyx_ring"] = math.random(1,3),
    ["ruby_ring"] = math.random(1,3),
    ["tanzanite_ring"] = math.random(1,3),
    ["sapphire_ring"] = math.random(1,3),
}

Config.Ron = {}
for k,v in next,Config.TruckRob do 
    Config.Ron[#Config.Ron + 1] = k
end