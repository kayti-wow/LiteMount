--[[----------------------------------------------------------------------------

  LiteMount/Actions.lua

  Mounting actions.

  Copyright 2011 Mike Battersby

----------------------------------------------------------------------------]]--

local _, LM = ...

local L = LM.Localize

--@debug@
if LibDebug then LibDebug() end
--@end-debug@

--
-- This is the support for saving and restoring druid forms which is all done
-- in the Dismount action. Form IDs that you put here must be cancelled
-- automatically on mounting (otherwise trying to restore them when you are
-- already in them will cancel them).
--
-- See: https://wow.gamepedia.com/API_GetShapeshiftFormID
--

local savedFormName = nil

local restoreFormIDs = {
    [1] = true,     -- Cat Form
    [5] = true,     -- Bear Form
    [8] = true,     -- Bear Form (Classic)
    [31] = true,    -- Moonkin Form
    [35] = true,    -- Moonkin Form
    [36] = true,    -- Treant Form
}

local FLOWCONTROLS = { }

FLOWCONTROLS['IF'] =
    function (args, context, isTrue)
        LM.Debug('  * IF test is ' .. tostring(isTrue))
        local trueCount = isTrue and 1 or 0
        table.insert(context.flowControl, trueCount)
    end

FLOWCONTROLS['ELSEIF'] =
    function (args, context, isTrue)
        local trueCount  = context.flowControl[#context.flowControl]
        trueCount = trueCount + ( isTrue and 1 or 0 )
        LM.Debug('  * ELSEIF test is ' .. tostring(trueCount == 1))
        context.flowControl[#context.flowControl] = trueCount
    end

FLOWCONTROLS['ELSE'] =
    function (args, context, isTrue)
        local trueCount  = context.flowControl[#context.flowControl]
        trueCount = trueCount + 1
        LM.Debug('  * ELSE test is ' .. tostring(trueCount == 1))
        context.flowControl[#context.flowControl] = trueCount
    end

FLOWCONTROLS['END'] =
    function (args, context, isTrue)
        table.remove(context.flowControl)
    end

local ACTIONS = { }

-- Modifies the list of usable mounts so action list lines after this one
-- get the restricted list. Always returns no action.

ACTIONS['Limit'] = {
    handler =
        function (args, context)
            LM.Debug("  * Add limits: " .. args:ToString())
            table.insert(context.limits, args)
        end
}

-- These ones are really just for user rules.  The whole syntax of the Limit
-- args is a mess and doesn't parse well. If I had my time again I would
-- probably use & and | which are more obvious. Or, you know, start with a proper
-- grammar-based parser.

ACTIONS['LimitSet'] = {
    name = L.LM_LIMIT_MOUNTS,
    description = L.LM_LIMITSET_DESCRIPTION,
    argType = 'expression',
    toDisplay = LM.RuleArguments.ToDisplay,
    handler =
        function (args, context)
            ACTIONS.Limit.handler(args:Prepend('='), context)
        end,
}

ACTIONS['LimitInclude'] = {
    name = L.LM_INCLUDE_MOUNTS,
    description = L.LM_LIMITINCLUDE_DESCRIPTION,
    argType = 'expression',
    toDisplay = LM.RuleArguments.ToDisplay,
    handler =
        function (args, context)
            ACTIONS.Limit.handler(args:Prepend('+'), context)
        end,
}

ACTIONS['LimitExclude'] = {
    name = L.LM_EXCLUDE_MOUNTS,
    description = L.LM_LIMITEXCLUDE_DESCRIPTION,
    argType = 'expression',
    toDisplay = LM.RuleArguments.ToDisplay,
    handler =
        function (args, context)
            ACTIONS.Limit.handler(args:Prepend('-'), context)
        end,
}

ACTIONS['Endlimit'] = {
    argType = 'none',
    handler =
        function (args, context)
            local args = table.remove(context.limits)
            if args then
                LM.Debug("  * removed limits: " .. args:ToString())
            end
        end,
}

local function GetUsableSpell(arg)
    -- You can look up any spell from any class by number so we have to
    -- test numbers to see if we know them
    local argN = tonumber(arg)
    if argN and not IsSpellKnown(argN) then
        return
    end

    -- For names, GetSpellInfo returns nil if it's not in your spellbook
    -- so we don't need to call IsSpellKnown
    local name, _, _, _, _, _, spellID = GetSpellInfo(argN or arg)
    if not name then
        return
    end

    -- Glide won't cast while mounted
    if spellID == 131347 and IsMounted() then
        return
    end

    -- Zen Flight only works if you can fly
    if spellID == 125883 and not LM.Environment:CanFly() then
        return
    end

    -- Some spells share names (e.g., Surge Forward is both an Evoker ability
    -- and a Dragonriding ability). If the spell has a subtext it can be
    -- distinguished by bracketing it after the name. This only works if you
    -- pass the spell in by ID since otherwise you'll get whichever one
    -- GetSpellInfo(name) decides to return.

    local subtext = GetSpellSubtext(argN or arg)
    local nameWithSubtext = string.format('%s(%s)', name, subtext or "")

    if name and IsUsableSpell(name) and GetSpellCooldown(name) == 0 then
        return name, spellID, nameWithSubtext
    end
end

local function SpellArgsToDisplay(args)
    local out = {}
    for _, v in ipairs(args:ParseList()) do
        local name, _, _, _, _, _, id = GetSpellInfo(v)
        if name then
            table.insert(out, string.format("%s (%d)", name, id))
        else
            table.insert(out, v)
        end
    end
    return out
end

ACTIONS['Spell'] = {
    name = L.LM_SPELL_ACTION,
    description = L.LM_SPELL_DESCRIPTION,
    argType = 'list',
    toDisplay = SpellArgsToDisplay,
    handler =
        function (args, context)
            for _, arg in ipairs(args:ParseList()) do
                LM.Debug('  * trying spell: ' .. tostring(arg))
                local name, id, nameWithSubtext = GetUsableSpell(arg)
                if nameWithSubtext then
                    LM.Debug("  * setting action to spell " .. nameWithSubtext)
                    return LM.SecureAction:Spell(nameWithSubtext, context.rule.unit)
                end
            end
        end
}

-- Buff is the same as Spell but checks if you have a matching aura and
-- doesn't recast. Note that it checks only for buffs on the assumption
-- that you can't cast a debuff on yourself, and that it checks by name
-- because for some spells (e.g., Levitate) the ID doesn't match.

ACTIONS['Buff'] = {
    toDisplay = SpellArgsToDisplay,
    argType = 'list',
    handler =
        function (args, context)
            for _, arg in ipairs(args:ParseList()) do
                LM.Debug('  * trying buff: ' .. tostring(arg))
                local name, id, nameWithSubtext = GetUsableSpell(arg)
                if name and not LM.UnitAura(context.rule.unit or 'player', name) then
                    LM.Debug("  * setting action to spell " .. nameWithSubtext)
                    return LM.SecureAction:Spell(nameWithSubtext, context.rule.unit)
                end
            end
        end
}

-- Set context.precast to a spell name to try to macro in before mounting journal
-- mounts. This is a bit less strict than Spell and Buff because the macro
-- still works even if the spell isn't usable, and has the advantage of
-- avoiding the IsUsableSpell failures when targeting others.

ACTIONS['PreCast'] = {
    name = L.LM_PRECAST_ACTION,
    description = L.LM_PRECAST_DESCRIPTION,
    argType = 'list',
    toDisplay = SpellArgsToDisplay,
    handler =
        function (args, context)
            for _, arg in ipairs(args:ParseList()) do
                local name, _, _, castTime, _, _, id = GetSpellInfo(arg)
                if name and IsPlayerSpell(id) and castTime == 0 then
                    LM.Debug("  * setting preCast to spell " .. name)
                    context.preCast = name
                    return
                end
            end
        end
}

ACTIONS['CancelAura'] = {
    toDisplay = SpellArgsToDisplay,
    argType = 'list',
    handler =
        function (args, context)
            for _, arg in ipairs(args:ParseList()) do
                local name, _,_,_,_,_, source, _,_,_, canApplyAura = LM.UnitAura('player', arg)
                if name then
                    -- Levitate (for example) is marked canApplyAura == false so this is a
                    -- half-workaround. You still won't cancel Levitate somone else put on you.
                    if canApplyAura or (source == 'player' and GetSpellInfo(name)) then
                        return LM.SecureAction:CancelAura(name)
                    end
                end
            end
        end
}

-- In vehicle -> exit it
ACTIONS['LeaveVehicle'] = {
    argType = 'none',
    handler =
        function (args, context)
            if CanExitVehicle() then
                LM.Debug("  * setting action to leavevehicle")
                return LM.SecureAction:LeaveVehicle()
            end
        end
}

local function GetFormNameWithSubtext()
    local idx = GetShapeshiftForm()
    if idx and idx > 0 then
        local spellID = select(4, GetShapeshiftFormInfo(idx))
        local n = GetSpellInfo(spellID)
        local s = GetSpellSubtext(spellID) or ''
        return string.format('%s(%s)', n, s)
    end
end

-- This includes dismounting from mounts and also canceling other mount-like
-- things such as shapeshift forms. The logic here is torturous.

ACTIONS['Dismount'] = {
    name = BINDING_NAME_DISMOUNT,
    argType = 'none',
    handler =
        function (args, context)
            local action

            -- Shortcut dismount from journal mounts. This has the (wanted) side
            -- effect of dismounting you even from mounts that aren't enabled,
            -- and the (wanted) side effect of dismounting while in moonkin form
            -- without cancelling it.

            if IsMounted() then
                LM.Debug("  * setting action to dismount")
                action = LM.SecureAction:Macro(SLASH_DISMOUNT1)
                -- action = LM.SecureAction:Execute(Dismount)
            else
                -- Otherwise we look for the mount from its buff and return the cancel
                -- actions.
                local m = LM.MountRegistry:GetActiveMount()
                if m and m:IsCancelable() then
                    LM.Debug("  * setting action to cancel " .. m.name)
                    action = m:GetCancelAction()
                end
            end

            if action and savedFormName and savedFormName ~= GetFormNameWithSubtext() then
                -- Without the /cancelform the "Auto Dismount in Flight" setting stops
                -- this from working.
                LM.Debug("  * override action to restore form: " .. savedFormName)
                local macroText = string.format("/cancelform\n/cast %s", savedFormName)
                action = LM.SecureAction:Macro(macroText)
            end

            if action then
                savedFormName = nil
                return action
            elseif LM.Options:GetOption('restoreForms') then
                -- Save current form, if any
                local currentFormID = GetShapeshiftFormID()
                if currentFormID and restoreFormIDs[currentFormID] then
                    savedFormName = GetFormNameWithSubtext()
                    LM.Debug("  * saving current form " .. savedFormName)
                end
            end
        end
}

-- CancelForm has been absorbed into Dismount
ACTIONS['CancelForm'] = {
    argType = 'none',
    handler = function (args, context) end
}

-- Got a player target, try copying their mount
ACTIONS['CopyTargetsMount'] = {
    argType = 'none',
    handler =
        function (args, context)
            local unit = context.rule.unit or "target"
            if LM.Options:GetOption('copyTargetsMount') and UnitIsPlayer(unit) then
                LM.Debug("  * trying to clone %s's mount", unit)
                local m = LM.MountRegistry:GetMountFromUnitAura(unit)
                if m and m:IsCastable() then
                    LM.Debug("  * setting action to mount %s", m.name)
                    return m:GetCastAction(context)
                end
            end
        end
}

ACTIONS['ApplyRules'] = {
    argType = 'none',
    handler =
        function (args, context)
            local ruleSet = LM.Options:GetCompiledRuleSet(context.id)
            LM.Debug("  * checking %d rules for button %d", #ruleSet, context.id)
            local act, n = ruleSet:Run(context)
            if act then
                LM.Debug("  * found matching rule %d", n)
                return act
            end
            LM.Debug("  * no rules matched")
        end
}

local mawCastableArg = LM.RuleArguments:Get("MAWUSABLE", ",", "CASTABLE")
local castableArg = LM.RuleArguments:Get("CASTABLE")

local smartActions = {
    {
        condition   = "[submerged]",
        arg         = LM.RuleArguments:Get('SWIM'),
        debug       = "Aquatic Mount (underwater)",
    },
    {
        condition   = "[dragonridable]",
        arg         = LM.RuleArguments:Get('DRAGONRIDING'),
        debug       = "Dragonriding Mount",
    },
    {
        condition   = "[flyable]",
        arg         = LM.RuleArguments:Get('FLY'),
        debug       = 'Flying Mount',
    },
    {
        condition   = "[floating,nowaterwalking]",
        arg         = LM.RuleArguments:Get('SWIM'),
        debug       = "Aquatic Mount (on the surface)",
    },
    {
        condition   = "[]",
        arg         = LM.RuleArguments:Get('RUN', ',', '~', 'SLOW'),
        debug       = "Ground Mount",
    },
    {
        condition   = "[]",
        arg         = LM.RuleArguments:Get('RUN', ',', 'SLOW'),
        debug       = "Slow Ground Mount",
    },
}

ACTIONS['Mount'] = {
    name = L.LM_MOUNT_ACTION,
    description = L.LM_MOUNT_DESCRIPTION,
    argType = 'expression',
    toDisplay = LM.RuleArguments.ToDisplay,
    handler =
        function (args, context)
            local limits = CopyTable(context.limits)
            if LM.Conditions:Check("[maw]", context) then
                table.insert(limits, mawCastableArg)
            else
                table.insert(limits, castableArg)
            end
            if #args > 0 then
                table.insert(limits, args)
            end
            local filteredList = LM.MountRegistry:Limit(limits)

            LM.Debug("  * args: " .. args:ToString())
            LM.Debug("  * limits:")
            for i, l in ipairs(limits) do
                LM.Debug("    % 2d. %s", i, l:ToString())
            end
            LM.Debug("  * filtered list contains " .. #filteredList .. " mounts")

            if next(filteredList) == nil then return end

            local randomStyle = context.rule.priority and LM.Options:GetOption('randomWeightStyle')

            local m

            if context.rule.smart then
                for _, info in ipairs(smartActions) do
                    if not m and LM.Conditions:Check(info.condition, context) then
                        LM.Debug("  * trying " .. info.debug)
                        local expr = info.arg:ParseExpression()
                        local mounts = filteredList:ExpressionSearch(expr)
                        LM.Debug("  * found " .. #mounts .. " mounts.")
                        m = mounts:Random(context.random, randomStyle)
                        if context.rule.strict and info.condition ~= '[]' and not m then
                            return
                        end
                    end
                end
            else
                m = filteredList:Random(context.random, randomStyle)
            end

            if m then
                LM.Debug("  * setting action to mount %s", m.name)
                return m:GetCastAction(context), m
            end
        end
}

ACTIONS['SmartMount'] = {
    name = L.LM_SMARTMOUNT_ACTION,
    description = L.LM_SMARTMOUNT_DESCRIPTION,
    argType = 'expression',
    toDisplay = LM.RuleArguments.ToDisplay,
    handler =
        function (args, context)
            context.rule.priority = true
            context.rule.smart = true
            return ACTIONS.Mount.handler(args, context)
        end
}

ACTIONS['PriorityMount'] = {
    name = L.LM_PRIORITYMOUNT_ACTION,
    description = L.LM_PRIORITYMOUNT_DESCRIPTION,
    argType = 'expression',
    toDisplay = LM.RuleArguments.ToDisplay,
    handler =
        function (args, context)
            context.rule.priority = true
            return ACTIONS.Mount.handler(args, context)
        end
}

ACTIONS['Macro'] = {
    argType = 'none',
    handler =
        function (args, context)
            local macrotext = LM.Options:GetOption('unavailableMacro')
            if macrotext ~= "" then
                LM.Debug("  * setting action to unavailable macro")
                return LM.SecureAction:Macro(macrotext)
            end
        end
}

ACTIONS['Script'] = {
    argType = 'macrotext',
    handler =
        function (args, context)
            local macroText = args:ToString()
            LM.Debug("  * setting action to script line: " .. macroText)
            return LM.SecureAction:Macro(macroText)
        end
}

ACTIONS['CantMount'] = {
    argType = 'none',
    handler =
        function (args, context)
            -- This isn't a great message, but there isn't a better one that
            -- Blizzard have already localized. See FrameXML/GlobalStrings.lua.
            -- LM.Warning("You don't know any mounts you can use right now.")
            LM.Warning(SPELL_FAILED_NO_MOUNTS_ALLOWED)

            LM.Debug("  * setting action to can't mount now")
            return LM.SecureAction:Macro("")
        end
}

-- In a theoretical world these could be rules, but the number of times you can do
-- something at all useful in combat at the moment is 1. It's hard to imagine
-- anything else useful you'd want to do in combat that isn't covered by the much
-- simpler combatMacro. If that were done it would need some way to override the normal
-- CASTABLE check for mounts since they won't be castable right away.
--
-- E.g, Mount [map:2234] DRAGONRIDING

local CombatHandlerOverride = {
    {
        -- Tindral Sageswift, Amirdrassil (Dragonflight)
        handler =
            function (args, context)
                if LM.Environment:IsMapInPath(2234) then
                    local id, name = LM.Environment:GetEncounterInfo()
                    if id and name then
                        LM.Debug("  * matched encounter %s (%d)", name, id)
                    end
                    local mounts = LM.MountRegistry:FilterSearch('DRAGONRIDING', 'COLLECTED')
                    local randomStyle = LM.Options:GetOption('randomWeightStyle')
                    local m = mounts:Random(context.random, randomStyle)
                    if m then
                        return m:GetCastAction()
                    end
                end
            end,
    },
}

ACTIONS['Combat'] = {
    argType = 'none',
    handler =
        function (args, context)
            -- If specific combat macro is set always use it
            if LM.Options:GetOption('useCombatMacro') then
                LM.Debug("  * setting action to options combat macro")
                local macrotext = LM.Options:GetOption('combatMacro')
                return LM.SecureAction:Macro(macrotext)
            end
            -- Check for an override combat setting
            for _, info in ipairs(CombatHandlerOverride) do
                local act = info.handler(args, context)
                if act then
                    LM.Debug("  * setting action to %s", act:GetDescription())
                    return act
                end
            end
            -- Otherwise use the default actions
            LM.Debug("  * setting action to default combat macro")
            local macrotext = LM.Actions:DefaultCombatMacro()
            return LM.SecureAction:Macro(macrotext)
        end
}

ACTIONS['Stop'] = {
    argType = 'none',
    handler =
        function (args, context)
            -- return true and set up to do nothing
            LM.Debug("  * setting action to nothing for stop")
            return LM.SecureAction:Macro("")
        end
}

local function IsCastableItem(itemID)
    if not itemID then
        return false
    end

    if PlayerHasToy(itemID) then
        if not C_ToyBox.IsToyUsable(itemID) then
            return false
        end
    elseif not IsUsableItem(itemID) then
        return false
    elseif IsEquippableItem(itemID) and not IsEquippedItem(itemID) then
        return false
    end

    local s, d, e = GetItemCooldown(itemID)
    if s == 0 and (e == true or e == 1) then
        return true
    end

    return false
end

-- A derpy version of SecureCmdItemParse that doesn't support bags but does
-- support item IDs as well as slot names. The assumption is that if you have
-- the item then GetItemInfo will always return values immediately.

local function UsableItemParse(arg)
    local name, itemID, slotNum

    local slotOrID = tonumber(arg)
    if slotOrID and slotOrID <= INVSLOT_LAST_EQUIPPED then
        slotNum = slotOrID
    elseif slotOrID then
        name = GetItemInfo(slotOrID)
        itemID = slotOrID
    else
        local slotName = "INVSLOT_"..arg:upper()
        if _G[slotName] then
            slotNum = _G[slotName]
        else
            name = arg
            itemID = GetItemInfoInstant(arg)
        end
    end

    return name, itemID, slotNum
end

-- Is this really not in the game anywhere?
local InventorySlotTable = {
    [INVSLOT_AMMO]      = AMMOSLOT,
    [INVSLOT_HEAD]      = HEADSLOT,
    [INVSLOT_NECK]      = NECKSLOT,
    [INVSLOT_SHOULDER]  = SHOULDERSLOT,
    [INVSLOT_BODY]      = SHIRTSLOT,
    [INVSLOT_CHEST]     = CHESTSLOT,
    [INVSLOT_WRIST]     = WRISTSLOT,
    [INVSLOT_HAND]      = HANDSSLOT,
    [INVSLOT_WAIST]     = WAISTSLOT,
    [INVSLOT_LEGS]      = LEGSSLOT,
    [INVSLOT_FEET]      = FEETSLOT,
    [INVSLOT_FINGER1]   = FINGER0SLOT .. " (1)",
    [INVSLOT_FINGER2]   = FINGER1SLOT .. " (2)",
    [INVSLOT_TRINKET1]  = TRINKET0SLOT .. " (1)",
    [INVSLOT_TRINKET2]  = TRINKET1SLOT .. " (2)",
    [INVSLOT_BACK]      = BACKSLOT,
    [INVSLOT_MAINHAND]  = MAINHANDSLOT,
    [INVSLOT_OFFHAND]   = SECONDARYHANDSLOT,
    [INVSLOT_RANGED]    = RANGEDSLOT,
    [INVSLOT_TABARD]    = TABARDSLOT,
}

local function ItemArgsToDisplay(args)
    local out = {}
    for _, v in ipairs(args:ParseList()) do
        local name, id, slot = UsableItemParse(v)
        if name then
            table.insert(out, string.format("%s (%d)", name, id))
        elseif slot then
            table.insert(out, InventorySlotTable[slot] or slot)
        else
            table.insert(out, v)
        end
    end
    return out
end

ACTIONS['Use'] = {
    name = L.LM_USE_ACTION,
    description = L.LM_USE_DESCRIPTION,
    argType = 'list',
    toDisplay = ItemArgsToDisplay,
    handler =
        function (args, context)
            for _, arg in ipairs(args:ParseList()) do
                local name, itemID, slotNum = UsableItemParse(arg)
                if slotNum then
                    LM.Debug('  * trying slot ' .. tostring(slotNum))
                    local s, d, e = GetInventoryItemCooldown('player', slotNum)
                    if s == 0 and e == 1 then
                        LM.Debug('  * Setting action to use slot ' .. slotNum)
                        return LM.SecureAction:Item(slotNum, context.rule.unit)
                    end
                else
                    LM.Debug('  * trying item ' .. tostring(name))
                    if name and IsCastableItem(itemID) then
                        LM.Debug('  * setting action to use item ' .. name)
                        return LM.SecureAction:Item(name, context.rule.unit)
                    end
                end
            end
        end
}

ACTIONS['PreUse'] = {
    name = L.LM_PREUSE_ACTION,
    description = L.LM_PREUSE_DESCRIPTION,
    argType = 'list',
    toDisplay = ItemArgsToDisplay,
    handler =
        function (args, context)
            local action = ACTIONS['Use'].handler(args, context)
            if action and action.item then
                LM.Debug("  * setting preCast to item " .. action.item)
                context.preCast = action.item
                return
            end
        end
}

do
    for a, info in pairs(ACTIONS) do
        info.action = a
    end
end

--[[------------------------------------------------------------------------]]--

LM.Actions = { }

local function GetDruidMountForms()
    local forms = {}
    for i = 1,GetNumShapeshiftForms() do
        local spell = select(4, GetShapeshiftFormInfo(i))
        if spell == LM.SPELL.TRAVEL_FORM or spell == LM.SPELL.MOUNT_FORM then
            tinsert(forms, i)
        end
    end
    return table.concat(forms, "/")
end

-- This is the macro that gets set as the default and will trigger if
-- we are in combat.  Don't put anything in here that isn't specifically
-- combat-only, because out of combat we've got proper code available.
-- Note that macros are limited to 255 chars, even inside a SecureActionButton.

function LM.Actions:DefaultCombatMacro()

    local mt = "/dismount [mounted]\n/stopmacro [mounted]\n"

    local _, playerClass = UnitClass("player")

    if playerClass ==  "DRUID" then
        local forms = GetDruidMountForms()
        local mount = LM.MountRegistry:GetMountBySpell(LM.SPELL.TRAVEL_FORM)
        if mount and mount:GetPriority() > 0 then
            mt = mt .. format("/cast [noform:%s] %s\n", forms, mount.name)
            mt = mt .. format("/cancelform [form:%s]\n", forms)
        end
    elseif playerClass == "SHAMAN" then
        local mount = LM.MountRegistry:GetMountBySpell(LM.SPELL.GHOST_WOLF)
        if mount and mount:GetPriority() > 0 then
            local s = GetSpellInfo(LM.SPELL.GHOST_WOLF)
            mt = mt .. "/cast [noform] " .. s .. "\n"
            mt = mt .. "/cancelform [form]\n"
        end
    end

    mt = mt .. "/leavevehicle\n"

    return mt
end

function LM.Actions:GetArgType(action)
    if FLOWCONTROLS[action] then
        return 'none'
    elseif ACTIONS[action] then
        return ACTIONS[action].argType
    end
end

function LM.Actions:GetFlowControlHandler(action)
    return FLOWCONTROLS[action]
end

function LM.Actions:GetHandler(action)
    local a = ACTIONS[action]
    if a then return a.handler end
end

function LM.Actions:IsFlowSkipped(context)
    return ContainsIf(context.flowControl, function (v) return v ~= 1 end)
end

-- This is really terrible and only works for a minimal amount of things
-- which rules might do, which is so far only one mount or group or type etc.
-- It will probably break if I ever make rules actions even slightly flexible.

function LM.Actions:ToDisplay(action, args)
    local a = ACTIONS[action]
    if a then
        local name = a.name or action
        if args == nil then
            return name
        elseif a.toDisplay then
            return name, table.concat(a.toDisplay(args), "\n")
        else
            return name, args:ToString()
        end
    end
end

function LM.Actions:GetDescription(action)
    local a = ACTIONS[action]
    if a then return a.description end
end
