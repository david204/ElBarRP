local QBCore = exports['qb-core']:GetCoreObject()

local display = false
local displayos = false

local rnRegiID

RegisterNetEvent("fs-storerob:c:startRob", function()
  QBCore.Functions.TriggerCallback('fs-storerob:s:hasLockpick', function(HasLockpick)
    if HasLockpick then 
      local ped = PlayerPedId()
      local pos = GetEntityCoords(ped)
      for k, v in pairs(Config.Registers) do
        local dist = #(pos - Config.Registers[k][1])
        if dist <= 0.5 then
          if not Config.Registers[k].robbed then
            rnRegiID= k
            if math.random(1,3) == 2 then
              TriggerServerEvent("fs-storerob:server:removeLockpick")
            end
            SetDisplay(not display)
          else
            QBCore.Functions.Notify("Look's empty!", "error")
          end
        end
      end
    else
      QBCore.Functions.Notify("You need a lockpick!", "error", 3000)
    end
  end)
end)

--[[exports['qb-target']:AddBoxZone("b2-str try", vector3(28.19, -1338.43, 29.5), 1, 1, {
  name="b2-str try",
  heading=0,
  --debugPoly=true,
  minZ=28.5,
  maxZ=32.5
}, {
  options = {
      {
          type = "client",
          event = "fs-storerob:c:osp",
          icon = "fas fa-award",
          label = "Open Safe",
      },
  },
  distance = 2.0
})--]]


RegisterCommand("stry", function(source, args)
  print(2)
  SetDisplay(not display)
end)

RegisterCommand("strs", function(source, args)
  print(2)
  SetDisplayos(not display)
end)
local rnSafeID=-1

RegisterNetEvent("fs-storerob:c:osp", function()
  local pos = GetEntityCoords(PlayerPedId())
  for safe,_ in pairs(Config.Safes) do
    local dist = #(pos - Config.Safes[safe][1].xyz)
    if dist < 1.0 then
        if Config.Safes[safe].robbed then
            QBCore.Functions.Notify("Look's empty!", "error")
        elseif not Config.Safes[safe].robbed then
            rnSafeID= safe
            SetDisplayos(not display)
        end
    end
end
end)

RegisterNUICallback("safes", function(data)
    TriggerServerEvent("fs-storerob:server:setSafeStatus", rnSafeID)
end)

RegisterNUICallback("regi", function(data)
  print(2)
  TriggerServerEvent("fs-storerob:server:setRegisterStatus", rnRegiID)
end)

RegisterNUICallback("exit", function(data)
  SetNuiFocus(false, false)
  display =false
  displayos= false
end)


RegisterNUICallback("safe", function(data)
  display = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "game",
        status = true,
        cardCode= cardCode,
        gtype="safe"
    })
end)
RegisterNUICallback("nsn", function(data)
  SetNuiFocus(false, false)
  QBCore.Functions.Notify("Your code was wrong", "error", 3000)
end)

exports["qb-target"]:AddTargetModel(GetHashKey('prop_till_01'), {
  options = {
      {   
          event = 'fs-storerob:c:startRob',
          type = 'client',
          icon = "fa-solid fa-sack-dollar",
          label = "Rob register cash",
      },
  }, distance = 1.0,
})

function takeAnim()
  local ped = PlayerPedId()
  while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
      RequestAnimDict("amb@prop_human_bum_bin@idle_b")
      Wait(100)
  end
  TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "idle_d", 8.0, 8.0, -1, 50, 0, false, false, false)
  Wait(2500)
  TaskPlayAnim(ped, "amb@prop_human_bum_bin@idle_b", "exit", 8.0, 8.0, -1, 50, 0, false, false, false)
end

CreateThread(function()
  for k, _ in pairs(Config.Registers) do
    exports['qb-target']:AddCircleZone(Config.Registers[k], vector3(Config.Registers[k][1].xyz), 1.0, {
        name = Config.Registers[k],
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "fs-storerob:c:startRob",
                icon = "fas fa-lock",
                label = "Search Register",
            },
        },
        distance = 2.0
    })
  end
  for k, _ in pairs(Config.Safes) do
    exports['qb-target']:AddCircleZone(Config.Safes[k], vector3(Config.Safes[k][1].xyz), 1.0, {
        name = Config.Safes[k],
        debugPoly = false,
    }, {
        options = {
            {
                type = "client",
                event = "fs-storerob:c:osp",
                icon = "fas fa-lock",
                label = "Open safe",
            },
        },
        distance = 2.0
    })
end
end)

--[[exports["qb-target"]:AddTargetModel(GetHashKey('prop_till_01_dam'), {
  options = {
      {
          event = 'bb-storerob:c:start:register',
          type = 'client',
          icon = "fa-solid fa-face-sad-cry",
          label = "Register is empty",
      },
  }, distance = 1.0,
})]]
RegisterNetEvent('fs-storerob:client:setRegisterStatus', function(regi, bool)
    Config.Registers[regi].robbed= bool
end)  

RegisterNetEvent('fs-storerob:client:setSafeStatus', function(safe, bool)
  Config.Safes[safe].robbed = bool
end)

local cardCode= 111111
RegisterNUICallback("gcard", function(data)
  TriggerServerEvent("fs-robstore:s:gsnote", data.cardCode)
  cardCode= data.cardCode
end)

RegisterNUICallback("gcash", function(data)
  exports['progressbar']:Progress({
    name = 'bb_storerobcashreg',
    duration = 3000,
    label = 'Robbing ' .. data.balance .. '$',
    useWhileDead = false,
    canCancel = false,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },
    animation = {
        animDict = "veh@break_in@0h@p_m_one@",
        anim = "low_force_entry_ds",
        flags = 16,
    },
    prop = {},
    propTwo = {},
})
  TriggerServerEvent("fs-robstore:s:gcash", data.balance)
  
end)






  --[[ ////////////////////////////////////////// ]]

  function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "game",
        status = bool,
        cardCode= cardCode,
        gtype="register"
    })
end

function SetDisplaysg(bool)
  display = bool
  SetNuiFocus(bool, bool)
  SendNUIMessage({
      type = "game",
      status = bool,
      cardCode= cardCode,
      gtype="safe"
  })
end

function SetDisplayos(bool)
  displayos = bool
  SetNuiFocus(bool, bool)
  SendNUIMessage({
      type = "safe",
      status = bool,
      cardCode= cardCode,
  })
end


RegisterNUICallback("print", function()
    print(343)
end)

RegisterNUICallback("main", function(data)
  chat(data.text, {0,255,0})
  SetDisplay(false)
end)

CreateThread(function()
  SendNUIMessage({
    type = "first",
    status = false,
    
})
end)


  Citizen.CreateThread(function()
    while display do
        Citizen.Wait(1000)
        -- https://runtime.fivem.net/doc/natives/#_0xFE99B66D079CF6BC
        --[[ 
            inputGroup -- integer , 
	        control --integer , 
            disable -- boolean 
        ]]
        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)