config = {

	-- Blip/Color: --
	-- https://docs.fivem.net/docs/game-references/blips/ --
	
	zones = {
    {coords = {x = -1849.88 , y = -1225.26, z = 128.91}, radius = 400.0, color = 2},
	},
	
	timer = 30, -- How often will the zone change (In Seconds).
	
	draw_blip = true, -- If "true" it will draw a blip in center of zone.
	
	draw_route = false, -- "draw_blip" must be "true" for this to work. If "true" then it will draw a GPS route to the zone.
	
	blip_text = "Evant", -- "draw_blip" must be "true" for this to work. This will change the name of the blip on the map
	
	blip_id = 357 -- "draw_blip" must be "true" for this to work. This will change the blip icon.
	
}