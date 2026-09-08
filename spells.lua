local namespace = select(2,...)

namespace.SPELLS = {
    -- Racial and Items
    [26297] = 180, -- Berserking (Troll)
    [20594] = 120, -- Stoneform (Dwarf)
    [58984] = 120, -- Shadowmeld (Night Elf)
    [20589] = 90, -- Escape Artist (Gnome)
    [59752] = 120, -- Every Man for Himself (Human)
    [7744] = 120, -- Will of the Forsaken (Undead)
    [50613] = 120, -- Arcane Torrent (Blood Elf)
    [11876] = 120, -- War Stomp (Tauren)
    [42292] = 120, -- PvP Trinket
    [71607] = 120, -- Bauble of True Blood

    -- DEATH KNIGHT
    [49039] = 120, -- Lichborne
    [47476] = 120, -- Strangulate
    [48707] = 45, -- Anti-Magic Shell
    [49576] = 25, -- Death Grip
    [47528] = 10, -- Mind Freeze
    [49222] = 60, -- Bone Shield 
    [51052] = 120, -- Anti-Magic Zone
    [49203] = 60, -- Hungering Cold
    [48792] = 25, -- Icebound Fortitude
    [47481] = 60, -- Gnaw (pet)
    [48265] = 60, -- Death Coil
    [49028] = 60, -- Dancing Rune Weapon
    [49206] = 180, -- Summon Gargoyle
    [47482] = 30, -- Leap
    [48743] = 180, -- Death Pact

    -- DRUID
    [22812] = 60, -- Barkskin
    [16979] = 14, -- Feral Charge - Bear
    [49376] = 28, -- Feral Charge - Cat
    [61384] = 20, -- Typhoon
    [49802] = 10, -- Maim
    [53201] = 65, -- Starfall
    [8983] = 30, -- Bash
    [53312] = 60, -- Nature's Grasp
    [50334] = 180, -- Berserk

    -- HUNTER
    [65878] = 60, -- Wyvern Sting
    [3045] = 300, -- Rapid Fire
    [61006] = 15, -- Kill Shot
    [53271] = 60, -- Master's Call
    [19263] = 90, -- Deterrence
    [19503] = 30, -- Scatter Shot
    [34490] = 20, -- Silencing Shot
    [1543] = 20, -- Flare
    [19574] = 20, -- Bestial Wrath
    [781] = 16, -- Disengage
    [5384] = 25, -- Feign Death
    [1513] = 30, -- Scare Beast
    [19577] = 20, -- Intimidation
    [34600] = 28, -- Snake Trap

    -- HUNTER PETS
    [61685] = 25, -- Charge
    [50519] = 60, -- Sonic Blast
    [50245] = 40, -- Pin
    [50433] = 10, -- Ankle Crack
    [26090] = 30, -- Pummel
    [53543] = 60, -- Clench
    [53562] = 40, -- Ravage
    [54706] = 40, -- Venom Web Spray
    [4167] = 40, -- Web
    [50274] = 12, -- Spore Cloud
    [50271] = 10, -- Tendon Rip
    [50318] = 60, -- Serenity Dust
    [50285] = 40, -- Dust Cloud
    [55709] = 480, -- Heart of the Phoenix
    [53426] = 180, -- Lick Your Wounds
    [53476] = 30, -- Intervene
    [53480] = 60, -- Roar of Sacrifice
    [53478] = 360, -- Last Stand
    [53517] = 180, -- Roar of Recovery

    -- MAGE
    [2139] = 24, -- Counterspell
    [1953] = 15, -- Blink
    [45438] = 300, -- Ice Block
    [43039] = 24, -- Ice Barrier
    [44572] = 30, -- Deep Freeze
    [42945] = 30, -- Blast Wave
    [42950] = 20, -- Dragon's Breath
    [13018] = 30, -- Blast Wave (rank)
    [13019] = 30, -- Blast Wave (rank)
    [13020] = 30, -- Blast Wave (rank)
    [13021] = 30, -- Blast Wave (rank)
    [33933] = 30, -- Blast Wave (rank)
    [42944] = 30, -- Blast Wave (rank)
    [27133] = 30, -- Blast Wave (rank)
    [11113] = 30, -- Blast Wave (rank)
    [31661] = 20, -- Dragon's Breath (rank)
    [33042] = 20, -- Dragon's Breath (rank)
    [42949] = 20, -- Dragon's Breath (rank)
    [33041] = 20, -- Dragon's Breath (rank)
    [33043] = 20, -- Dragon's Breath (rank)
    [12042] = 84, -- Arcane Power
    [12043] = 84, -- Presence of Mind
    [12051] = 240, -- Evocation
    [11958] = 480, -- Cold Snap
    [122] = 20, -- Frost Nova
    [42917] = 20, -- Frost Nova
    [10230] = 20, -- Frost Nova
    [27088] = 20, -- Frost Nova
    [865] = 20, -- Frost Nova
    [6131] = 20, -- Frost Nova
    [11129] = 180, -- Combustion
    [12472] = 180, -- Icy Veins
    [31687] = 144, -- Summon Water Elemental
    [33395] = 25, -- Freeze (Water Elemental)
    [55342] = 180, -- Mirror Image

    -- PALADIN
    [1044] = 25, -- Hand of Freedom
    [10308] = 40, -- Hammer of Justice
    [20066] = 60, -- Repentance
    [642] = 300, -- Divine Shield
    [48825] = 5, -- Holy Shock
    [31884] = 180, -- Avenging Wrath
    [54428] = 60, -- Divine Plea
    [853] = 60, -- Hammer of Justice
    [5588] = 60, -- Hammer of Justice
    [5589] = 60, -- Hammer of Justice
    [10278] = 300, -- Hand of Protection
    [6940] = 120, -- Hand of Sacrifice
    [498] = 180, -- Divine Protection
    [1038] = 120, -- Hand of Salvation

    -- PRIEST
    [64044] = 120, -- Psychic Horror
    [10890] = 23, -- Psychic Scream
    [15487] = 45, -- Silence
    [47585] = 75, -- Dispersion
    [33206] = 180, -- Pain Suppression
    [10060] = 120, -- Power Infusion
    [586] = 15, -- Fade

    -- ROGUE
    [2094] = 120, -- Blind
    [1766] = 10, -- Kick
    [1769] = 10, -- Kick (rank)
    [1767] = 10, -- Kick (rank)
    [38768] = 10, -- Kick (rank)
    [31224] = 60, -- Cloak of Shadows
    [26889] = 120, -- Vanish
    [1856] = 120, -- Vanish (rank)
    [1857] = 120, -- Vanish (rank)
    [36554] = 20, -- Shadowstep
    [8643] = 20, -- Kidney Shot
    [408] = 20, -- Kidney Shot
    [51722] = 60, -- Dismantle
    [51713] = 60, -- Shadow Dance
    [11285] = 10, -- Gouge
    [11286] = 10, -- Gouge
    [1777] = 10, -- Gouge
    [8629] = 10, -- Gouge
    [38764] = 10, -- Gouge
    [14278] = 20, -- Ghostly Strike
    [14185] = 300, -- Preparation
    [26669] = 180, -- Evasion
    [5277] = 180, -- Evasion
    [13750] = 180, -- Adrenaline Rush
    [2983] = 180, -- Sprint
    [11305] = 180, -- Sprint
    [8696] = 180, -- Sprint
    [14177] = 180, -- Cold Blood
    [13877] = 120, -- Blade Flurry
    [45182] = 60, -- Cheating Death
    [14183] = 20, -- Premeditation
    [51690] = 120, -- Killing Spree

    -- SHAMAN
    [8177] = 13, -- Grounding Totem
    [57994] = 6, -- Wind Shear
    [59159] = 35, -- Thunderstorm
    [59156] = 35, -- Thunderstorm
    [59158] = 35, -- Thunderstorm
    [2484] = 10, -- Earthbind Totem
    [58582] = 20, -- Stoneclaw Totem
    [51514] = 45, -- Hex
    [8046] = 6, -- Earth Shock
    [10413] = 6, -- Earth Shock
    [8044] = 6, -- Earth Shock
    [49230] = 6, -- Earth Shock
    [49231] = 6, -- Earth Shock
    [10414] = 6, -- Earth Shock
    [25454] = 6, -- Earth Shock
    [8045] = 6, -- Earth Shock
    [8042] = 6, -- Earth Shock
    [10412] = 6, -- Earth Shock
    [59490] = 45, -- Book of Stars
    [2825] = 300, -- Bloodlust
    [32182] = 300, -- Heroism
    [16188] = 180, -- Nature's Swiftness
    [16166] = 180, -- Elemental Mastery
    [51533] = 180, -- Feral Spirit

    -- WARLOCK
    [47847] = 20, -- Shadowfury
    [47860] = 120, -- Death Coil
    [47859] = 120, -- Death Coil
    [6789] = 120, -- Death Coil
    [27223] = 120, -- Death Coil
    [17926] = 120, -- Death Coil
    [17962] = 10, -- Conflagrate
    [47891] = 30, -- Shadow Ward
    [5484] = 32, -- Howl of Terror
    [17928] = 32, -- Howl of Terror
    [54785] = 45, -- Demon Leap
    [48020] = 30, -- Demonic Circle: Teleport
    [17877] = 15, -- Shadowburn
    [59672] = 126, -- Metamorphosis
    [30283] = 20, -- Shadowfury
    [30414] = 20, -- Shadowfury
    [19647] = 24, -- Spell Lock (Felhunter)
    [19244] = 24, -- Spell Lock
    [47986] = 60, -- Sacrifice (Voidwalker)

    -- WARRIOR
    [47486] = 5, -- Mortal Strike
    [12292] = 144, -- Death Wish
    [11578] = 20, -- Charge
    [6552] = 10, -- Pummel
    [6554] = 10, -- Pummel
    [23920] = 10, -- Spell Reflection
    [676] = 60, -- Disarm
    [20252] = 25, -- Intercept
    [20616] = 25, -- Intercept
    [20617] = 25, -- Intercept
    [30194] = 25, -- Intercept
    [30198] = 25, -- Intercept
    [47996] = 25, -- Intercept
    [30151] = 25, -- Intercept
    [25272] = 25, -- Intercept
    [25275] = 25, -- Intercept
    [12809] = 30, -- Concussion Blow
    [72] = 12, -- Shield Bash
    [1671] = 12, -- Shield Bash
    [29704] = 12, -- Shield Bash
    [1672] = 12, -- Shield Bash
    [60970] = 30, -- Heroic Fury
    [46924] = 90, -- Bladestorm
    [871] = 300, -- Shield Wall
    [46968] = 17, -- Shockwave
    [3411] = 30, -- Intervene
    [30357] = 5, -- Revenge
    [2687] = 30, -- Bloodrage
    [2565] = 60, -- Shield Block
    [1719] = 300, -- Recklessness
    [55694] = 180, -- Enraged Regeneration
    [5246] = 180, -- Intimidating Shout
    [20230] = 300, -- Retaliation
}

-- ✅ MEJORA 1: RESETTERS CORREGIDO
-- Ahora mapea spell → lista de spells que resetea
namespace.RESETTERS = {
    -- Rogue: Preparation resetea varios CDs
    [14185] = {
        1766, 1769, 1767, 38768,  -- Kick (todas las ranks)
        26889, 1856, 1857,         -- Vanish (todas las ranks)
        2094,                      -- Blind
        36554,                     -- Shadowstep
        8643, 408,                 -- Kidney Shot
        51722,                     -- Dismantle
        11285, 11286, 1777, 8629, 38764, -- Gouge (todas las ranks)
        26669, 5277,               -- Evasion
        2983, 11305, 8696,         -- Sprint
        14183,                     -- Premeditation
    },
    
    -- Rogue: Cold Blood
    [14177] = {14177},
    
    -- Mage: Cold Snap resetea varios CDs
    [11958] = {
        45438,                     -- Ice Block
        1953,                      -- Blink
        122, 42917, 10230, 27088, 865, 6131, -- Frost Nova (ranks)
        43039,                     -- Ice Barrier
        44572,                     -- Deep Freeze
    },
    
    -- Warlock: Metamorphosis resetea Demon Leap
    [59672] = {54785},
    
    -- Shaman: Bloodlust/Heroism
    [2825] = {},
    [32182] = {},
}

-- ============================================================
-- SPELL_GROUPS: a que seccion pertenece cada hechizo.
--
-- Sale de los encabezados de comentario de SPELLS de aca arriba, que
-- en Lua no existen en tiempo de ejecucion. Se genero una vez con un
-- script; si agregas hechizos nuevos a mano, sumalos tambien aca o van
-- a caer en OTROS en la lista de filtros.
-- ============================================================
namespace.SPELL_GROUP_ORDER = {
    "RACIAL AND ITEMS",
    "DEATH KNIGHT",
    "DRUID",
    "HUNTER",
    "HUNTER PETS",
    "MAGE",
    "PALADIN",
    "PRIEST",
    "ROGUE",
    "SHAMAN",
    "WARLOCK",
    "WARRIOR",
}

namespace.SPELL_GROUPS = {
    -- RACIAL AND ITEMS
    [26297] = "RACIAL AND ITEMS",
    [20594] = "RACIAL AND ITEMS",
    [58984] = "RACIAL AND ITEMS",
    [20589] = "RACIAL AND ITEMS",
    [59752] = "RACIAL AND ITEMS",
    [7744] = "RACIAL AND ITEMS",
    [50613] = "RACIAL AND ITEMS",
    [11876] = "RACIAL AND ITEMS",
    [42292] = "RACIAL AND ITEMS",
    [71607] = "RACIAL AND ITEMS",
    -- DEATH KNIGHT
    [49039] = "DEATH KNIGHT",
    [47476] = "DEATH KNIGHT",
    [48707] = "DEATH KNIGHT",
    [49576] = "DEATH KNIGHT",
    [47528] = "DEATH KNIGHT",
    [49222] = "DEATH KNIGHT",
    [51052] = "DEATH KNIGHT",
    [49203] = "DEATH KNIGHT",
    [48792] = "DEATH KNIGHT",
    [47481] = "DEATH KNIGHT",
    [48265] = "DEATH KNIGHT",
    [49028] = "DEATH KNIGHT",
    [49206] = "DEATH KNIGHT",
    [47482] = "DEATH KNIGHT",
    [48743] = "DEATH KNIGHT",
    -- DRUID
    [22812] = "DRUID",
    [16979] = "DRUID",
    [49376] = "DRUID",
    [61384] = "DRUID",
    [49802] = "DRUID",
    [53201] = "DRUID",
    [8983] = "DRUID",
    [53312] = "DRUID",
    [50334] = "DRUID",
    -- HUNTER
    [65878] = "HUNTER",
    [3045] = "HUNTER",
    [61006] = "HUNTER",
    [53271] = "HUNTER",
    [19263] = "HUNTER",
    [19503] = "HUNTER",
    [34490] = "HUNTER",
    [1543] = "HUNTER",
    [19574] = "HUNTER",
    [781] = "HUNTER",
    [5384] = "HUNTER",
    [1513] = "HUNTER",
    [19577] = "HUNTER",
    [34600] = "HUNTER",
    -- HUNTER PETS
    [61685] = "HUNTER PETS",
    [50519] = "HUNTER PETS",
    [50245] = "HUNTER PETS",
    [50433] = "HUNTER PETS",
    [26090] = "HUNTER PETS",
    [53543] = "HUNTER PETS",
    [53562] = "HUNTER PETS",
    [54706] = "HUNTER PETS",
    [4167] = "HUNTER PETS",
    [50274] = "HUNTER PETS",
    [50271] = "HUNTER PETS",
    [50318] = "HUNTER PETS",
    [50285] = "HUNTER PETS",
    [55709] = "HUNTER PETS",
    [53426] = "HUNTER PETS",
    [53476] = "HUNTER PETS",
    [53480] = "HUNTER PETS",
    [53478] = "HUNTER PETS",
    [53517] = "HUNTER PETS",
    -- MAGE
    [2139] = "MAGE",
    [1953] = "MAGE",
    [45438] = "MAGE",
    [43039] = "MAGE",
    [44572] = "MAGE",
    [42945] = "MAGE",
    [42950] = "MAGE",
    [13018] = "MAGE",
    [13019] = "MAGE",
    [13020] = "MAGE",
    [13021] = "MAGE",
    [33933] = "MAGE",
    [42944] = "MAGE",
    [27133] = "MAGE",
    [11113] = "MAGE",
    [31661] = "MAGE",
    [33042] = "MAGE",
    [42949] = "MAGE",
    [33041] = "MAGE",
    [33043] = "MAGE",
    [12042] = "MAGE",
    [12043] = "MAGE",
    [12051] = "MAGE",
    [11958] = "MAGE",
    [122] = "MAGE",
    [42917] = "MAGE",
    [10230] = "MAGE",
    [27088] = "MAGE",
    [865] = "MAGE",
    [6131] = "MAGE",
    [11129] = "MAGE",
    [12472] = "MAGE",
    [31687] = "MAGE",
    [33395] = "MAGE",
    [55342] = "MAGE",
    -- PALADIN
    [1044] = "PALADIN",
    [10308] = "PALADIN",
    [20066] = "PALADIN",
    [642] = "PALADIN",
    [48825] = "PALADIN",
    [31884] = "PALADIN",
    [54428] = "PALADIN",
    [853] = "PALADIN",
    [5588] = "PALADIN",
    [5589] = "PALADIN",
    [10278] = "PALADIN",
    [6940] = "PALADIN",
    [498] = "PALADIN",
    [1038] = "PALADIN",
    -- PRIEST
    [64044] = "PRIEST",
    [10890] = "PRIEST",
    [15487] = "PRIEST",
    [47585] = "PRIEST",
    [33206] = "PRIEST",
    [10060] = "PRIEST",
    [586] = "PRIEST",
    -- ROGUE
    [2094] = "ROGUE",
    [1766] = "ROGUE",
    [1769] = "ROGUE",
    [1767] = "ROGUE",
    [38768] = "ROGUE",
    [31224] = "ROGUE",
    [26889] = "ROGUE",
    [1856] = "ROGUE",
    [1857] = "ROGUE",
    [36554] = "ROGUE",
    [8643] = "ROGUE",
    [408] = "ROGUE",
    [51722] = "ROGUE",
    [51713] = "ROGUE",
    [11285] = "ROGUE",
    [11286] = "ROGUE",
    [1777] = "ROGUE",
    [8629] = "ROGUE",
    [38764] = "ROGUE",
    [14278] = "ROGUE",
    [14185] = "ROGUE",
    [26669] = "ROGUE",
    [5277] = "ROGUE",
    [13750] = "ROGUE",
    [2983] = "ROGUE",
    [11305] = "ROGUE",
    [8696] = "ROGUE",
    [14177] = "ROGUE",
    [13877] = "ROGUE",
    [45182] = "ROGUE",
    [14183] = "ROGUE",
    [51690] = "ROGUE",
    -- SHAMAN
    [8177] = "SHAMAN",
    [57994] = "SHAMAN",
    [59159] = "SHAMAN",
    [59156] = "SHAMAN",
    [59158] = "SHAMAN",
    [2484] = "SHAMAN",
    [58582] = "SHAMAN",
    [51514] = "SHAMAN",
    [8046] = "SHAMAN",
    [10413] = "SHAMAN",
    [8044] = "SHAMAN",
    [49230] = "SHAMAN",
    [49231] = "SHAMAN",
    [10414] = "SHAMAN",
    [25454] = "SHAMAN",
    [8045] = "SHAMAN",
    [8042] = "SHAMAN",
    [10412] = "SHAMAN",
    [59490] = "SHAMAN",
    [2825] = "SHAMAN",
    [32182] = "SHAMAN",
    [16188] = "SHAMAN",
    [16166] = "SHAMAN",
    [51533] = "SHAMAN",
    -- WARLOCK
    [47847] = "WARLOCK",
    [47860] = "WARLOCK",
    [47859] = "WARLOCK",
    [6789] = "WARLOCK",
    [27223] = "WARLOCK",
    [17926] = "WARLOCK",
    [17962] = "WARLOCK",
    [47891] = "WARLOCK",
    [5484] = "WARLOCK",
    [17928] = "WARLOCK",
    [54785] = "WARLOCK",
    [48020] = "WARLOCK",
    [17877] = "WARLOCK",
    [59672] = "WARLOCK",
    [30283] = "WARLOCK",
    [30414] = "WARLOCK",
    [19647] = "WARLOCK",
    [19244] = "WARLOCK",
    [47986] = "WARLOCK",
    -- WARRIOR
    [47486] = "WARRIOR",
    [12292] = "WARRIOR",
    [11578] = "WARRIOR",
    [6552] = "WARRIOR",
    [6554] = "WARRIOR",
    [23920] = "WARRIOR",
    [676] = "WARRIOR",
    [20252] = "WARRIOR",
    [20616] = "WARRIOR",
    [20617] = "WARRIOR",
    [30194] = "WARRIOR",
    [30198] = "WARRIOR",
    [47996] = "WARRIOR",
    [30151] = "WARRIOR",
    [25272] = "WARRIOR",
    [25275] = "WARRIOR",
    [12809] = "WARRIOR",
    [72] = "WARRIOR",
    [1671] = "WARRIOR",
    [29704] = "WARRIOR",
    [1672] = "WARRIOR",
    [60970] = "WARRIOR",
    [46924] = "WARRIOR",
    [871] = "WARRIOR",
    [46968] = "WARRIOR",
    [3411] = "WARRIOR",
    [30357] = "WARRIOR",
    [2687] = "WARRIOR",
    [2565] = "WARRIOR",
    [1719] = "WARRIOR",
    [55694] = "WARRIOR",
    [5246] = "WARRIOR",
    [20230] = "WARRIOR",
}
