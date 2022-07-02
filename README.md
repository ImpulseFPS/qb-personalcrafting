# qb-personalcrafting
 personal crafting used with QBCore framework

# preview
https://streamable.com/javedk

### How to give players access to the bench
```lua
Config.Cid = { -- CitizenID = CID for short
    'INSERT CID HERE',
    'INSERT CID HERE',
    'INSERT CID HERE',
    'INSERT CID HERE',
    'INSERT CID HERE',
    'INSERT CID HERE',
}
```

### How to add items for players to craft
```lua
Config.Crafting = {
    ['INSERT CID HERE'] = {-- only player with this CID(CitizenId) will have access to items listed belove
        [1] = {
            item = 'weapon_appistol', -- item name that is in qb-core/shared/items.lua
            itemLabel = 'Glock 18C', -- item label that will be displayed in the crafting menu
            requirmentsTxt = '80x MetalScrap, 100x plastic, 70x rubber, 120x steel', -- text that will tell player what he needs to craft that item
            requiredItems = { -- required items to craft the specific item from crafting bench
                ['metalscrap'] = {
                    amount = 80, -- amount of items required to craft the specific item.
                },
                ['NEW ITEM'] = {
                    amount = 20,
                },
                                ['NEW ITEM'] = {
                    amount = 40,
                },
                -- And so on
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
```