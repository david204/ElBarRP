Config = {}

Config.Jobs = {
    ["electrician"] = "Electrician"
}

Config.Locations = {
    jobs = {
        ["electrician"] = {
            [1] = {
                coords = vector4(1598.12, 2552.08, 45.9, 74.33)
            },
            [2] = {
                coords = vector4(1625.05, 2581.91, 45.88, 315.99)
            },
            [3] = {
                coords = vector4(1694.72, 2469.62, 45.98, 235.01)
            },
            [4] = {
                coords = vector4(1755.58, 2502.97, 45.9, 245.29)
            },
            [5] = {
                coords = vector4(1766.86, 2531.26, 45.37, 211.63)
            },
            [6] = {
                coords = vector4(1775.15, 2553.65, 45.5, 263.89)
            },
            [7] = {
                coords = vector4(1763.61, 2565.8, 45.75, 9.01)
            }
        }
    },
    ["freedom"] = {
        coords = vector4(1775.96, 2491.45, 50.43, 207.76)
    },
    ["outside"] = {
        coords = vector4(1847.19, 2585.78, 45.67, 269.08)
    },
    ["yard"] = {
        coords = vector4(1765.67, 2565.91, 45.56, 1.5)
    },
    ["middle"] = {
        coords = vector4(1643.62, 2607.1, 45.46, 269.12)
    },
    ["shop"] = {
        coords = vector4(1780.92, 2559.08, 45.76, 0.06)
    },
    spawns = {
        [1] = {
            animation = "bumsleep",
            coords = vector4(1753.68, 2496.23, 45.82, 213.46)
        },
        [2] = {
            animation = "lean",
            coords = vector4(1747.53, 2492.76, 45.82, 209.68)
        },
        [3] = {
            animation = "lean",
            coords = vector4(1744.64, 2491.12, 45.82, 208.05)
        },
        [4] = {
            animation = "lean",
            coords = vector4(1741.89, 2489.33, 45.82, 212.38)
        },
        [5] = {
            animation = "sitchair4",
            coords = vector4(1753.11, 2468.57, 45.81, 30.75)
        },
        [6] = {
            animation = "lean",
            coords = vector4(1756.31, 2470.31, 45.81, 30.5)
        },
        [7] = {
            animation = "lean",
            coords = vector4(1759.37, 2472.0, 45.81, 32.46)
        },
        [8] = {
            animation = "finger2",
            coords = vector4(1765.2, 2475.51, 45.81, 27.65)
        },
        [9] = {
            animation = "smoke",
            coords = vector4(1768.15, 2477.15, 45.82, 30.98)
        }
        -- [10] = {
        --     animation = "smoke",
        --     coords = vector4(1768.33, 2566.08, 45.56, 176.83)
        -- },
        -- [11] = {
        --     animation = "smoke",
        --     coords = vector4(1696.09, 2469.4, 45.56, 1.4)
        -- }
    }
}

Config.CanteenItems = {
    [1] = {
        name = "sandwich",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 1
    },
    [2] = {
        name = "water_bottle",
        price = 4,
        amount = 50,
        info = {},
        type = "item",
        slot = 2
    }
}
