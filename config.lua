Config = Config or {}

Config.Cid = {
    '',
}

Config.Crafting = {
    ['GVJ40555'] = {
        [1] = {
            item = 'weapon_appistol',
            itemLabel = 'Glock 18C',
            requirmentsTxt = '80x MetalScrap, 100x plastic, 70x rubber, 120x steel',
            requiredItems = {
                ['metalscrap'] = {
                    amount = 80,
                },
            },
        },
        [2] = {
            item = 'advancedreparkit',
            itemLabel = 'Advanced Repair Kit',
            requirmentsTxt = 'TEXT',
            requiredItems = {
                ['metalscrap'] = {
                    amount = 200,
                },
                ['plastic'] = {
                    amount = 250,
                },
            },
        },
    }
}