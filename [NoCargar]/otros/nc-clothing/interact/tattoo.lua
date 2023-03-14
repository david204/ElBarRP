local i = 0;

local function AddBoxZone(name, center, length, width, options)
    i = i + 1;
    exports['qb-target']:AddBoxZone(("%s-%s"):format(name, i), center, length, width, options, {
        options = {
            {
                ['icon'] = "fas fa-yin-yang",
                ['label'] = "Change Tattoos",
                ['event'] = 'clothing:interact',
                ['arg'] = 'tattoomenu'
            },
        },
        job = {"all"},
        distance = 10.0
    });
end

local function Interact()
	AddBoxZone("tattoo_shop", vector3(-588.7077, -603.2379, 41.430255), 4.2, 6.8, {
		heading=199,
		minZ=40.43,
		maxZ=42.43
	})
end

-- CreateThread(Interact);
-- RegisterNetEvent("nc-interact:ready", Interact);