# nc-speedcameras
Originally converted from an esx script by WEEZOOKA - Re-written & Optimised  
**Original script** >> [esx_speedcamera](https://github.com/P4NDAzzGaming/esx_speedcamera)

- Has a few pre-setup cameras. Additional camera locations can be added easily in to the config.lua. 
- Will not fine police or EMS. Additional jobs can be added into the client.lua.

## Requirements
[qb-phone](https://github.com/qbcore-framework/qb-phone)  
[nc-banking](https://github.com/qbcore-framework/nc-banking)

## Config
```lua
Config = {}

Config.MPH = true                 -- bool: false for KMH / true for MPH
Config.useCameraSound = true      -- bool: Makes a camera shutter sound effect
Config.useFlashingScreen = true   -- bool: Flashes screen white for a brief moment
Config.useBlips = true            -- bool: Turns blips on/off
Config.alertPolice = true         -- bool: Whether to alert police above certain speed
Config.alertSpeed = 130           -- number: Alerts police when caught above this speed
Config.useBilling = true          -- bool: Bills player by fineAmount automatically if true - Only change if you know what you're doing
Config.OnlyBillIfOwned = false    -- bool: Only bill the player if they own the vehicle they are driving
Config.showNotification = false   -- bool: Shows a notification when caught
Config.sendEmail = true           -- bool: Sends an email when caught, false shows a notification

Config.ignoredJobs = {            -- table: Table of jobs that wll not get fined by the cameras when on duty
Config.Cameras = {}               -- table: List of cameras
```
