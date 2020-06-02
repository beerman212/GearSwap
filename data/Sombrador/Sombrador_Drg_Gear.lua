-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Weapons:options('Trishula')
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}

    select_default_macro_book()
	
	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind ^f11 gs c cycle MagicalDefenseMode')
	send_command('bind @f7 gs c toggle AutoJumpMode')
	send_command('bind @` gs c cycle SkillchainMode')
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA.Angon = {} --hands="Ptero. Fin. G. +1"
	sets.precast.JA.Jump = {}
	sets.precast.JA['Ancient Circle'] = {} --legs="Vishap Brais"
	sets.precast.JA['High Jump'] = {}
	sets.precast.JA['Soul Jump'] = {}
	sets.precast.JA['Spirit Jump'] = {}
	sets.precast.JA['Super Jump'] = {}
	sets.precast.JA['Spirit Link'] = {} --head="Vishap Armet",hands="Lnc. Vmbrc. +2"
	sets.precast.JA['Call Wyvern'] = {} --body="Ptero. Mail +1"
	sets.precast.JA['Deep Breathing'] = {} --hands="Ptero. Armet +1"
	sets.precast.JA['Spirit Surge'] = {} --body="Ptero. Mail +1"
	sets.precast.JA['Steady Wing'] = {}
	
	-- Breath sets
	sets.precast.JA['Restoring Breath'] = {}
	sets.precast.JA['Smiting Breath'] = {}
	sets.HealingBreath = {}
	sets.SmitingBreath = {}

	-- Fast cast sets for spells
	
	sets.precast.FC = {}
	
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
		
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}

	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
	
	-- Midcast Sets
	sets.midcast.FastRecast = {}
		
	-- Put HP+ gear and the AF head to make healing breath trigger more easily with this set.
	sets.midcast.HB_Trigger = set_combine(sets.midcast.FastRecast, {})
	
	-- Weaponskill sets

	-- Default set for any weaponskill that isn't any more specifically defined
	
	sets.precast.WS = {}
		
	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})
	
	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS['Stardiver'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Stardiver'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Stardiver'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Stardiver'].Fodder = set_combine(sets.precast.WS.Fodder, {})

	sets.precast.WS['Drakesbane'] = set_combine(sets.precast.WS, {})
	sets.precast.WS['Drakesbane'].SomeAcc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Drakesbane'].Acc = set_combine(sets.precast.WS.Acc, {})
	sets.precast.WS['Drakesbane'].Fodder = set_combine(sets.precast.WS.Fodder, {})


	
	-- Sets to return to when not performing an action.
	
	-- Resting sets
	sets.resting = {}

	-- Idle sets
	sets.idle = {}
		
	sets.idle.Refresh = {}

	sets.idle.Weak = set_combine(sets.idle, {})
		
	sets.idle.Reraise = set_combine(sets.idle, {})
	
	-- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {})
		
	sets.defense.MEVA = {}

	sets.Kiting = {}
	sets.Reraise = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	
    -- Extra defense sets.  Apply these on top of melee or defense sets.
    sets.passive.MP = {}
    sets.passive.Twilight = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Trishula = {}

	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}
	
	-- Engaged sets

	-- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
	-- sets if more refined versions aren't defined.
	-- If you create a set with both offense and defense modes, the offense mode should be first.
	-- EG: sets.engaged.Dagger.Accuracy.Evasion
	
	-- Normal melee group

	sets.engaged = {}
    sets.engaged.SomeAcc = {}
	sets.engaged.Acc = {}
    sets.engaged.FullAcc = {}
    sets.engaged.Fodder = {}

    sets.engaged.AM = {}
    sets.engaged.AM.SomeAcc = {}
	sets.engaged.AM.Acc = {}
    sets.engaged.AM.FullAcc = {}
    sets.engaged.AM.Fodder = {}
	
    sets.engaged.PDT = {}
    sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
    sets.engaged.FullAcc.PDT = {}
    sets.engaged.Fodder.PDT = {}
	
    sets.engaged.AM.PDT = {}
    sets.engaged.AM.SomeAcc.PDT = {}
	sets.engaged.AM.Acc.PDT = {}
    sets.engaged.AM.FullAcc.PDT = {}
    sets.engaged.AM.Fodder.PDT = {}
		
	--[[ Melee sets for in Adoulin, which has an extra 2% Haste from Ionis.
	
    sets.engaged.Adoulin = {}
    sets.engaged.Adoulin.SomeAcc = {}
	sets.engaged.Adoulin.Acc = {}
    sets.engaged.Adoulin.FullAcc = {}
    sets.engaged.Adoulin.Fodder = {}

    sets.engaged.Adoulin.AM = {}
    sets.engaged.Adoulin.AM.SomeAcc = {}
	sets.engaged.Adoulin.AM.Acc = {}
    sets.engaged.Adoulin.AM.FullAcc = {}
    sets.engaged.Adoulin.AM.Fodder = {}
	
    sets.engaged.Adoulin.PDT = {}
    sets.engaged.Adoulin.SomeAcc.PDT = {}
	sets.engaged.Adoulin.Acc.PDT = {}
    sets.engaged.Adoulin.FullAcc.PDT = {}
    sets.engaged.Adoulin.Fodder.PDT = {}
	
    sets.engaged.Adoulin.AM.PDT = {}
    sets.engaged.Adoulin.AM.SomeAcc.PDT = {}
	sets.engaged.Adoulin.AM.Acc.PDT = {}
    sets.engaged.Adoulin.AM.FullAcc.PDT = {}
    sets.engaged.Adoulin.AM.Fodder.PDT = {}
	]]

end

-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(1, 14)
    elseif player.sub_job == 'SAM' then
        set_macro_page(2, 14)
    elseif player.sub_job == 'BLU' then
        set_macro_page(3, 14)
    else
        set_macro_page(10, 14)
    end
end