--[[----------------------------------------------------------------------------

  LiteMount/SpellInfo.lua

  Constants for mount spell information.

  Copyright 2011-2014 Mike Battersby

----------------------------------------------------------------------------]]--

-- These used to match the returns from the old API function GetCompanionInfo,
-- plus more of my own. But since 6.0 that was replaced with C_MountJournal
-- and specific type numbers.

LM_FLAG_BIT_RUN = 1
LM_FLAG_BIT_FLY = 2
LM_FLAG_BIT_FLOAT = 4
LM_FLAG_BIT_SWIM = 8
LM_FLAG_BIT_JUMP = 16
LM_FLAG_BIT_WALK = 32
LM_FLAG_BIT_AQ = 128
LM_FLAG_BIT_VASHJIR = 256
LM_FLAG_BIT_NAGRAND = 512

LM_SPELL_TRAVEL_FORM = 783
LM_SPELL_GHOST_WOLF = 2645
LM_SPELL_BLUE_QIRAJI_TANK = 25953
LM_SPELL_GREEN_QIRAJI_TANK = 26054
LM_SPELL_RED_QIRAJI_TANK = 26055
LM_SPELL_YELLOW_QIRAJI_TANK = 26056
LM_SPELL_FLIGHT_FORM = 165962
LM_SPELL_FLYING_BROOM = 42667
LM_SPELL_TURBO_CHARGED_FLYING_MACHINE = 44151
LM_SPELL_FLYING_MACHINE = 44153
LM_SPELL_MAGIC_BROOM = 47977
LM_SPELL_BRONZE_DRAKE = 59569
LM_SPELL_MAGNIFICENT_FLYING_CARPET = 61309
LM_SPELL_FLYING_CARPET = 61451
LM_SPELL_LOANED_GRYPHON = 64749
LM_SPELL_LOANED_WIND_RIDER = 64762
LM_SPELL_FROSTY_FLYING_CARPET = 75596
LM_SPELL_RUNNING_WILD = 87840
LM_SPELL_TARECGOSAS_VISAGE = 101641
LM_SPELL_RED_FLYING_CLOUD = 130092
LM_SPELL_FROSTWOLF_WAR_WOLF = 164222
LM_SPELL_TELAARI_TALBUK = 165803
LM_SPELL_MOONFANG = 145133
LM_SPELL_CREEPING_CARPET = 169952
LM_SPELL_DUSTMANE_DIREWOLF = 171844

LM_ITEM_FLYING_BROOM = 33176
LM_ITEM_MAGIC_BROOM = 37011
LM_ITEM_LOANED_GRYPHON_REINS = 44221
LM_ITEM_LOANED_WIND_RIDER_REINS = 44229
LM_ITEM_DRAGONWRATH_TARECGOSAS_REST = 71086
LM_ITEM_SHIMMERING_MOONSTONE = 101675


-- Type, type class create args
LM_MOUNT_SPELLS = {
    { "RunningWild", LM_SPELL_RUNNING_WILD },
    { "FlightForm", LM_SPELL_FLIGHT_FORM },
    { "GhostWolf", LM_SPELL_GHOST_WOLF },
    { "TravelForm", LM_SPELL_TRAVEL_FORM },
    { "Nagrand", LM_SPELL_FROSTWOLF_WAR_WOLF },
    { "Nagrand", LM_SPELL_TELAARI_TALBUK },
    { "ItemSummoned",
        LM_ITEM_LOANED_GRYPHON_REINS, LM_SPELL_LOANED_GRYPHON,
        bit.bor(LM_FLAG_BIT_FLY)
    },
    { "ItemSummoned",
        LM_ITEM_LOANED_WIND_RIDER_REINS, LM_SPELL_LOANED_WIND_RIDER,
        bit.bor(LM_FLAG_BIT_FLY)
    },
    { "ItemSummoned",
        LM_ITEM_FLYING_BROOM, LM_SPELL_FLYING_BROOM,
        bit.bor(LM_FLAG_BIT_FLY),
    },
    { "ItemSummoned",
        LM_ITEM_MAGIC_BROOM, LM_SPELL_MAGIC_BROOM,
        bit.bor(LM_FLAG_BIT_RUN, LM_FLAG_BIT_FLY),
    },
    { "ItemSummoned",
        LM_ITEM_DRAGONWRATH_TARECGOSAS_REST, LM_SPELL_TARECGOSAS_VISAGE,
        bit.bor(LM_FLAG_BIT_FLY)
    },
    { "ItemSummoned",
        LM_ITEM_SHIMMERING_MOONSTONE, LM_SPELL_MOONFANG,
        bit.bor(LM_FLAG_BIT_RUN),
    },
}

-- Skill Lines from select(7, GetProfessionInfo(i))
--      164 Blacksmithing
--      165 Leatherworking
--      171 Alchemy
--      182 Herbalism
--      185 Cooking
--      186 Mining
--      197 Tailoring
--      202 Engineering
--      333 Enchanting
--      393 Skinning
--      755 Jewelcrafting
--      773 Inscription

LM_PROFESSION_MOUNT_REQUIREMENTS = {  -- = { skillLine, minSkillLevel }
    [LM_SPELL_FLYING_MACHINE] = { 202, 300 },
    [LM_SPELL_TURBO_CHARGED_FLYING_MACHINE] = { 202, 375 },
    [LM_SPELL_MAGNIFICENT_FLYING_CARPET] = { 197, 425 },
    [LM_SPELL_FROSTY_FLYING_CARPET] = { 197, 425 },
    [LM_SPELL_FLYING_CARPET] = { 197, 300 },
    [LM_SPELL_CREEPING_CARPET] = { 197, 300 },
    [LM_SPELL_DUSTMANE_DIREWOLF] = { 165, 300 },
}
