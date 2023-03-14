CreateThread(function()
	SetWeaponDamageModifier(`WEAPON_UNARMED`, 0.2) -- Melee
	SetWeaponDamageModifier(`WEAPON_BOTTLE`, 0.3) -- Melee
	SetWeaponDamageModifier(`WEAPON_FLASHLIGHT`, 0.1) -- Melee
	SetWeaponDamageModifier(`WEAPON_KNUCKLE`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_NIGHTSTICK`, 0.0) -- Melee
	SetWeaponDamageModifier(`WEAPON_HAMMER`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_CROWBAR`, 0.1) -- Melee
	SetWeaponDamageModifier(`WEAPON_POOLCUE`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_GOLFCLUB`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_BAT`, 0.4) -- Melee
	SetWeaponDamageModifier(`WEAPON_KNIFE`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_DAGGER`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_SWITCHBLADE`, 0.6) -- Melee
	SetWeaponDamageModifier(`WEAPON_REVOLVER`, 1.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_REVOLVER_MK2`, 1.0) -- Pistol / Melee
	SetWeaponDamageModifier(`WEAPON_MACHETE`, 0.7) -- Melee
	SetWeaponDamageModifier(`WEAPON_HATCHET`, 0.7) -- 
	SetWeaponDamageModifier(`WEAPON_MICROSMG`, 1.0)
	SetWeaponDamageModifier(`WEAPON_MACHINEPISTOL`, 0.8)
	SetWeaponDamageModifier(`WEAPON_MINISMG`, 1.0)
	SetWeaponDamageModifier(`WEAPON_ASSAULTSMG`, 1.13)
	SetWeaponDamageModifier(`WEAPON_SMG`, 1.10)
	SetWeaponDamageModifier(`WEAPON_SMG_MK2`, 1.13)
	SetWeaponDamageModifier(`WEAPON_COMBATPDW`, 1.02)
	SetWeaponDamageModifier(`WEAPON_GUSENBERG`, 1.05)
	SetWeaponDamageModifier(`WEAPON_APPISTOL`, 0.9)
	SetWeaponDamageModifier(`WEAPON_COMBATPISTOL`,1.0)
	SetWeaponDamageModifier(`WEAPON_VINTAGEPISTOL`, 1.0)
	SetWeaponDamageModifier(`WEAPON_HEAVYPISTOL`, 1.08)
	SetWeaponDamageModifier(`WEAPON_PISTOL`, 0.8)
	SetWeaponDamageModifier(`WEAPON_SNSPISTOL`, 0.7)
	SetWeaponDamageModifier(`WEAPON_PISTOL_MK2`, 0.9)
	SetWeaponDamageModifier(`WEAPON_DOUBLEACTION`, 0.8)
   	SetWeaponDamageModifier(`WEAPON_STUNGUN`, 0.0) -- Pistol / Melee
	   SetWeaponDamageModifier(`WEAPON_PLASMAP`, 0.0) -- Pistol / Melee
	-- SetWeaponDamageModifier(`WEAPON_SMOKEGRENADE`, 0.1) -- Utility
	SetWeaponDamageModifier(`WEAPON_SNOWBALL`, 0.0) -- Utility
	SetWeaponDamageModifier(`WEAPON_HIT_BY_WATER_CANNON`, 0.0) -- Fire Truck Cannon

	
	SetWeaponDamageModifier(`weapon_bullpuprifle`, 1.10)
	SetWeaponDamageModifier(`weapon_assaultrifle`, 1.10)
	SetWeaponDamageModifier(`weapon_compactrifle`, 0.9)
	SetWeaponDamageModifier(`weapon_carbinerifle`, 1.0)
	SetWeaponDamageModifier(`weapon_smg`, 1.0)
	SetWeaponDamageModifier(`weapon_smg`, 1.0)

	while true do
		Wait(0)
		SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
		SetPedSuffersCriticalHits(PlayerPedId(), true)
	end
end)