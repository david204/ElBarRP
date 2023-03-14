Config = Config or {}

-- Dont forgot to setup the discord logs via the server.lua

Config.UseColors = false -- Want to use colors when player buys vehicle?

Config.UsePreviewMenuSync = true -- Sync for the prewview menu when player is inside the prewview menu other players cant get inside (can prevent bugs but not have to use)

Config.UseMarkerInsteadOfMenu = false -- Want to use the marker to return the vehice? if false you can do that by opening the menu

Config.SetVehicleTransparency = 'low' -- Want to make the vehicle more transparent? you have a lot of options to choose from: low, medium, high, none

Config.MS = 'high' -- MS for the script recommended using high if not the "close" will get a bit baggy. options high / low

Config.Job = 'police' --The job needed to open the menu

Config.CarItems = {
    [1] = {
        name = "empty_evidence_bag",
        amount = 10,
        info = {},
        type = "item",
        slot = 2,
    },
    [2] = {
        name = "police_stormram",
        amount = 1,
        info = {},
        type = "item",
        slot = 3,
    },
}

--You Can Add As Many As You Like
--DO NOT add vehicles that are not in your shared ! otherwise the nc-garages wont work
Config.Vehicles = {
    [1] = {
        ['vehiclename'] = "2005 Ford Crown Victoria", --Name
        ['vehicle'] = "npolvic", --Model
        ['price'] = 1000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [2] = {
        ['vehiclename'] = "2019 Ford Mustang", --Name
        ['vehicle'] = "npolstang", --Model
        ['price'] = 18000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [3] = {
        ['vehiclename'] = "2018 Dodge Challenger", --Name
        ['vehicle'] = "npolchal", --Model
        ['price'] = 7500, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [4] = {
        ['vehiclename'] = "2015 Dodge Charger", --Name
        ['vehicle'] = "npolchar", --Model
        ['price'] = 5000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    },
    [5] = {
        ['vehiclename'] = "2012 Prison Bus", --Name
        ['vehicle'] = "npolcoach", --Model
        ['price'] = 3000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    },  
    [6] = {
        ['vehiclename'] = "2016 Ford Explorer", --Name
        ['vehicle'] = "npolexp", --Model
        ['price'] = 5000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [7] = {
        ['vehiclename'] = "2014 Police Bike", --Name
        ['vehicle'] = "npolmm", --Model
        ['price'] = 3000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [8] = {
        ['vehiclename'] = "2013 Vapid", --Name
        ['vehicle'] = "npolretinue", --Model
        ['price'] = 1500, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [9] = {
        ['vehiclename'] = "2017 Chevrolet Corvette", --Name
        ['vehicle'] = "npolvette", --Model
        ['price'] = 25000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [10] = {
        ['vehiclename'] = "Unmarked Police Vehicle #1", --Name
        ['vehicle'] = "ucballer", --Model
        ['price'] = 1000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [11] = {
        ['vehiclename'] = "Unmarked Police Vehicle #2", --Name
        ['vehicle'] = "ucbanshee", --Model
        ['price'] = 1000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [12] = {
        ['vehiclename'] = "Unmarked Police Vehicle #3", --Name
        ['vehicle'] = "ucbuffalo", --Model
        ['price'] = 1000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [13] = {
        ['vehiclename'] = "Unmarked Police Vehicle #4", --Name
        ['vehicle'] = "uccomet", --Model
        ['price'] = 1000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [14] = {
        ['vehiclename'] = "Unmarked Police Vehicle #5", --Name
        ['vehicle'] = "ucrancher", --Model
        ['price'] = 1000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [15] = {
        ['vehiclename'] = "Unmarked Police Vehicle #6", --Name
        ['vehicle'] = "ucprimo", --Model
        ['price'] = 1000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
    [16] = {
        ['vehiclename'] = "Unmarked Police Vehicle #7", --Name
        ['vehicle'] = "ucwashington", --Model
        ['price'] = 1000, --Price
        ['r'] = 0, --Vehicle Color (Optional)
        ['g'] = 0,
        ['b'] = 0,
    }, 
}