function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
	state.Weapons:options('GreatSword','GreatAxe','Scythe')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}
	state.DrainSwapWeaponMode = M{'Always','Never','300','1000'}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Diabolic Eye'] = {}
	sets.precast.JA['Arcane Circle'] = {}
	sets.precast.JA['Souleater'] = {}
	sets.precast.JA['Weapon Bash'] = {}
	sets.precast.JA['Nether Void'] = {}
	sets.precast.JA['Blood Weapon'] = {}
	sets.precast.JA['Dark Seal'] = {}
	sets.precast.JA['Last Resort'] = {back="Ankou's Mantle"}
                   
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
		   
	-- Fast cast sets for spells

	sets.precast.FC = {}

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {})
		
	-- Midcast Sets
	sets.midcast.FastRecast = {}
                   
	-- Specific spells
 
	sets.midcast['Dark Magic'] = {}
           
	sets.midcast['Enfeebling Magic'] = {}
		   
	sets.midcast['Dread Spikes'] = set_combine(sets.midcast['Dark Magic'], {})
	sets.midcast.Absorb = set_combine(sets.midcast['Dark Magic'], {})
           
	sets.midcast.Stun = {}
                   
	sets.midcast.Drain = set_combine(sets.midcast['Dark Magic'], {})
	
	sets.DrainWeapon = {}
                   
	sets.midcast.Aspir = sets.midcast.Drain
	
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {}
	sets.Cure_Received = {}
	sets.Self_Refresh = {}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.	
    sets.precast.WS['Catastrophe'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Catastrophe'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Catastrophe'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Catastrophe'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Catastrophe'].Fodder = set_combine(sets.precast.WS.Fodder, {})
	
    sets.precast.WS['Torcleaver'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Torcleaver'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Torcleaver'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Torcleaver'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Torcleaver'].Fodder = set_combine(sets.precast.WS.Fodder, {})

    sets.precast.WS['Entropy'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Entropy'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Entropy'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Entropy'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Entropy'].Fodder = set_combine(sets.precast.WS.Fodder, {})
     
    sets.precast.WS['Resolution'] = set_combine(sets.precast.WS, {})
    sets.precast.WS['Resolution'].SomeAcc = set_combine(sets.precast.WS.SomeAcc, {})
    sets.precast.WS['Resolution'].Acc = set_combine(sets.precast.WS.Acc, {})
    sets.precast.WS['Resolution'].FullAcc = set_combine(sets.precast.WS.FullAcc, {})
    sets.precast.WS['Resolution'].Fodder = set_combine(sets.precast.WS.Fodder, {})     
           
     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
           
	-- Swap to these on Moonshade using WS if at 3000 TP
	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}
     
            -- Idle sets
           
    sets.idle = {}
		
    sets.idle.PDT = {}

	sets.idle.Weak = set_combine(sets.idle, {})
		
	sets.idle.Reraise = set_combine(sets.idle, {})
           
    -- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {})
		
	sets.defense.MEVA = {}
     
	sets.Kiting = {}
	sets.passive.Reraise = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
     
	-- Engaged sets
	sets.engaged = {}
    sets.engaged.SomeAcc = {}
	sets.engaged.Acc = {}
    sets.engaged.FullAcc = {}
    sets.engaged.Fodder = {}
--[[
    sets.engaged.Adoulin = {}
	sets.engaged.SomeAcc.Adoulin = {}
	sets.engaged.Acc.Adoulin = {}
	sets.engaged.FullAcc.Adoulin = {}
	sets.engaged.Fodder.Adoulin = {}
	
	sets.engaged.PDT = {}
	sets.engaged.SomeAcc.PDT = {}
	sets.engaged.Acc.PDT = {}
	sets.engaged.FullAcc.PDT = {}
	sets.engaged.Fodder.PDT = {}
	
	sets.engaged.PDT.Adoulin = {}
	sets.engaged.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Acc.PDT.Adoulin = {}
	sets.engaged.FullAcc.PDT.Adoulin = {}
	sets.engaged.Fodder.PDT.Adoulin = {}
	
	sets.engaged.MDT = {}
	sets.engaged.SomeAcc.MDT = {}
	sets.engaged.Acc.MDT = {}
	sets.engaged.FullAcc.MDT = {}
	sets.engaged.Fodder.MDT = {}
	
	sets.engaged.MDT.Adoulin = {}
	sets.engaged.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Acc.MDT.Adoulin = {}
	sets.engaged.FullAcc.MDT.Adoulin = {}
	sets.engaged.Fodder.MDT.Adoulin = {}
	
            -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
            -- sets if more refined versions aren't defined.
            -- If you create a set with both offense and defense modes, the offense mode should be first.
            -- EG: sets.engaged.Dagger.Accuracy.Evasion

-- Liberator melee sets
    sets.engaged.Liberator = {}
	sets.engaged.Liberator.SomeAcc = {}
	sets.engaged.Liberator.Acc = {}
	sets.engaged.Liberator.FullAcc = {}
	sets.engaged.Liberator.Fodder = {}
	
    sets.engaged.Liberator.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.Adoulin = {}
	sets.engaged.Liberator.Acc.Adoulin = {}
	sets.engaged.Liberator.FullAcc.Adoulin = {}
	sets.engaged.Liberator.Fodder.Adoulin = {}
	
    sets.engaged.Liberator.AM = {}
	sets.engaged.Liberator.SomeAcc.AM = {}
	sets.engaged.Liberator.Acc.AM = {}
	sets.engaged.Liberator.FullAcc.AM = {}
	sets.engaged.Liberator.Fodder.AM = {}
	
    sets.engaged.Liberator.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.Adoulin.AM = {}

	sets.engaged.Liberator.PDT = {}
	sets.engaged.Liberator.SomeAcc.PDT = {}
	sets.engaged.Liberator.Acc.PDT = {}
	sets.engaged.Liberator.FullAcc.PDT = {}
	sets.engaged.Liberator.Fodder.PDT = {}
	
	sets.engaged.Liberator.PDT.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Liberator.Acc.PDT.Adoulin = {}
	sets.engaged.Liberator.FullAcc.PDT.Adoulin = {}
	sets.engaged.Liberator.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Liberator.PDT.AM = {}
	sets.engaged.Liberator.SomeAcc.PDT.AM = {}
	sets.engaged.Liberator.Acc.PDT.AM = {}
	sets.engaged.Liberator.FullAcc.PDT.AM = {}
	sets.engaged.Liberator.Fodder.PDT.AM = {}
	
	sets.engaged.Liberator.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Liberator.MDT = {}
	sets.engaged.Liberator.SomeAcc.MDT = {}
	sets.engaged.Liberator.Acc.MDT = {}
	sets.engaged.Liberator.FullAcc.MDT = {}
	sets.engaged.Liberator.Fodder.MDT = {}
	
	sets.engaged.Liberator.MDT.Adoulin = {}
	sets.engaged.Liberator.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Liberator.Acc.MDT.Adoulin = {}
	sets.engaged.Liberator.FullAcc.MDT.Adoulin = {}
	sets.engaged.Liberator.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Liberator.MDT.AM = {}
	sets.engaged.Liberator.SomeAcc.MDT.AM = {}
	sets.engaged.Liberator.Acc.MDT.AM = {}
	sets.engaged.Liberator.FullAcc.MDT.AM = {}
	sets.engaged.Liberator.Fodder.MDT.AM = {}
	
	sets.engaged.Liberator.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Liberator.Fodder.MDT.Adoulin.AM = {}
	
-- Apocalypse melee sets
    sets.engaged.Apocalypse = {}
	sets.engaged.Apocalypse.SomeAcc = {}
	sets.engaged.Apocalypse.Acc = {}
	sets.engaged.Apocalypse.FullAcc = {}
	sets.engaged.Apocalypse.Fodder = {}
	
    sets.engaged.Apocalypse.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.Adoulin = {}
	sets.engaged.Apocalypse.Acc.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.Adoulin = {}
	
    sets.engaged.Apocalypse.AM = {}
	sets.engaged.Apocalypse.SomeAcc.AM = {}
	sets.engaged.Apocalypse.Acc.AM = {}
	sets.engaged.Apocalypse.FullAcc.AM = {}
	sets.engaged.Apocalypse.Fodder.AM = {}
	
    sets.engaged.Apocalypse.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.Adoulin.AM = {}

	sets.engaged.Apocalypse.PDT = {}
	sets.engaged.Apocalypse.SomeAcc.PDT = {}
	sets.engaged.Apocalypse.Acc.PDT = {}
	sets.engaged.Apocalypse.FullAcc.PDT = {}
	sets.engaged.Apocalypse.Fodder.PDT = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin = {}
	
	sets.engaged.Apocalypse.PDT.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.AM = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.AM = {}
	
	sets.engaged.Apocalypse.PDT.Charge = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Charge = {}
	sets.engaged.Apocalypse.Acc.PDT.Charge = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Charge = {}
	sets.engaged.Apocalypse.Fodder.PDT.Charge = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.Charge = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.Charge = {}
	
	sets.engaged.Apocalypse.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Charge.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Charge.AM = {}
	
	sets.engaged.Apocalypse.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.SomeAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.Acc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.FullAcc.PDT.Adoulin.Charge.AM = {}
	sets.engaged.Apocalypse.Fodder.PDT.Adoulin.Charge.AM = {}

	sets.engaged.Apocalypse.MDT = {}
	sets.engaged.Apocalypse.SomeAcc.MDT = {}
	sets.engaged.Apocalypse.Acc.MDT = {}
	sets.engaged.Apocalypse.FullAcc.MDT = {}
	sets.engaged.Apocalypse.Fodder.MDT = {}
	
	sets.engaged.Apocalypse.MDT.Adoulin = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.Acc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.FullAcc.MDT.Adoulin = {}
	sets.engaged.Apocalypse.Fodder.MDT.Adoulin = {}
	
	sets.engaged.Apocalypse.MDT.AM = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.AM = {}
	sets.engaged.Apocalypse.Acc.MDT.AM = {}
	sets.engaged.Apocalypse.FullAcc.MDT.AM = {}
	sets.engaged.Apocalypse.Fodder.MDT.AM = {}
	
	sets.engaged.Apocalypse.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.SomeAcc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Acc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.FullAcc.MDT.Adoulin.AM = {}
	sets.engaged.Apocalypse.Fodder.MDT.Adoulin.AM = {}
]]--
	--Extra Special Sets
	
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {}
	sets.latent_refresh = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.GreatSword = {}
	sets.weapons.GreatAxe = {}
	sets.weapons.Scythe = {}
	
    end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 8)
    elseif player.sub_job == 'WAR' then
        set_macro_page(2, 8)
    elseif player.sub_job == 'DNC' then
        set_macro_page(3, 8)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 8)
    else
        set_macro_page(10, 8)
    end
end