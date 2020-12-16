function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','Acc','MaxAcc')
    state.WeaponskillMode:options('Match','Normal','Acc','MaxAcc')
    state.HybridMode:options('Normal','HybridDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal')
	state.Weapons:options('Montante','Caladbolg')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None'}
	state.DrainSwapWeaponMode = M{'Always','Never','300','1000'}

	gear.ankou = {}

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
	
	-- Weapons sets
	sets.weapons.Montante = {main="Montante +1",sub="Utu Grip"}
	sets.weapons.Caladbolg = {main="Albion",sub="Utu Grip"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Shield +1"}
	sets.weapons.NaeglingDW = {main="Naegling",sub=""}
	--sets.weapons.Anguta = {main="Anguta",sub="Utu Grip"}

	-- Precast Sets
	-- Precast sets to enhance JAs
	sets.precast.JA['Diabolic Eye'] = {}
	sets.precast.JA['Arcane Circle'] = {}
	sets.precast.JA['Souleater'] = {}
	sets.precast.JA['Weapon Bash'] = {}
	sets.precast.JA['Nether Void'] = {}
	sets.precast.JA['Blood Weapon'] = {}
	sets.precast.JA['Dark Seal'] = {}
	sets.precast.JA['Last Resort'] = {}
                   
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
                   
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
           
	sets.precast.Step = {}
	
	sets.precast.Flourish1 = {}
		   
	-- Fast cast sets for spells

	sets.precast.FC = {}

	sets.precast.FC.Impact = set_combine(sets.precast.FC, {head=empty,body="Twilight Cloak"})
		
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
	
	sets.midcast.Impact = set_combine(sets.midcast['Dark Magic'], {head=empty,body="Twilight Cloak"})
	
	sets.midcast.Cure = {}
	
	sets.Self_Healing = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Cure_Received = {hands="Buremte Gloves",waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {}
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.MaxAcc = set_combine(sets.precast.WS.Acc, {})

	sets.MaxTP = {}
	sets.AccMaxTP = {}
	sets.AccDayMaxTPWSEars = {}
	sets.DayMaxTPWSEars = {}
	sets.AccDayWSEars = {}
	sets.DayWSEars = {}

	-- sets.precast.WS.WSName = {}
	-- sets.precast.WS.WSName.Acc = set_combine(sets.precast.WS.WSName, {})
	-- sets.precast.WS.WSName.MaxAcc = set_combine(sets.precast.WS.WSName.Acc, {})

	-- sets.MaxTP.WSName = {}
	-- sets.AccMaxTP.WSName = {}
	-- sets.AccDayMaxTPWSEars.WSName = {}
	-- sets.DayMaxTPWSEars.WSName = {}
	-- sets.AccDayWSEars.WSName = {}
	-- sets.DayWSEars.WSName = {}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	-- Scythe
	sets.precast.WS.Catastrophe = set_combine(sets.precast.WS.WSName, {})
	sets.precast.WS.Catastrophe.Acc = set_combine(sets.precast.WS.Catastrophe, {})
	sets.precast.WS.Catastrophe.MaxAcc = set_combine(sets.precast.WS.Catastrophe.Acc, {})

	sets.MaxTP.Catastrophe = {}
	sets.AccMaxTP.Catastrophe = {}
	sets.AccDayMaxTPWSEars.Catastrophe = {}
	sets.DayMaxTPWSEars.Catastrophe = {}
	sets.AccDayWSEars.Catastrophe = {}
	sets.DayWSEars.Catastrophe = {}
	
	sets.precast.WS.Entropy = set_combine(sets.precast.WS.WSName, {})
	sets.precast.WS.Entropy.Acc = set_combine(sets.precast.WS.Entropy, {})
	sets.precast.WS.Entropy.MaxAcc = set_combine(sets.precast.WS.Entropy.Acc, {})

	sets.MaxTP.Entropy = {}
	sets.AccMaxTP.Entropy = {}
	sets.AccDayMaxTPWSEars.Entropy = {}
	sets.DayMaxTPWSEars.Entropy = {}
	sets.AccDayWSEars.Entropy = {}
	sets.DayWSEars.Entropy = {}
	
	-- Great Sword
	sets.precast.WS.Resolution = set_combine(sets.precast.WS.WSName, {})
	sets.precast.WS.Resolution.Acc = set_combine(sets.precast.WS.Resolution, {})
	sets.precast.WS.Resolution.MaxAcc = set_combine(sets.precast.WS.Resolution.Acc, {})

	sets.MaxTP.Resolution = {}
	sets.AccMaxTP.Resolution = {}
	sets.AccDayMaxTPWSEars.Resolution = {}
	sets.DayMaxTPWSEars.Resolution = {}
	sets.AccDayWSEars.Resolution = {}
	sets.DayWSEars.Resolution = {}
	
	sets.precast.WS.Torcleaver = set_combine(sets.precast.WS.WSName, {})
	sets.precast.WS.Torcleaver.Acc = set_combine(sets.precast.WS.Torcleaver, {})
	sets.precast.WS.Torcleaver.MaxAcc = set_combine(sets.precast.WS.Torcleaver.Acc, {})

	sets.MaxTP.Torcleaver = {}
	sets.AccMaxTP.Torcleaver = {}
	sets.AccDayMaxTPWSEars.Torcleaver = {}
	sets.DayMaxTPWSEars.Torcleaver = {}
	sets.AccDayWSEars.Torcleaver = {}
	sets.DayWSEars.Torcleaver = {}

	-- Sword
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS.WSName, {})
	sets.precast.WS["Savage Blade"].Acc = set_combine(sets.precast.WS["Savage Blade"], {})
	sets.precast.WS["Savage Blade"].MaxAcc = set_combine(sets.precast.WS["Savage Blade"].Acc, {})

	sets.MaxTP["Savage Blade"] = {}
	sets.AccMaxTP["Savage Blade"] = {}
	sets.AccDayMaxTPWSEars["Savage Blade"] = {}
	sets.DayMaxTPWSEars["Savage Blade"] = {}
	sets.AccDayWSEars["Savage Blade"] = {}
	sets.DayWSEars["Savage Blade"] = {}
           
	-- Sets to return to when not performing an action.
           
	-- Resting sets
	sets.resting = {}
           
	-- Swap to these on Moonshade using WS if at 3000 TP
	-- sets.MaxTP = {}
	-- sets.AccMaxTP = {}
	-- sets.AccDayMaxTPWSEars = {}
	-- sets.DayMaxTPWSEars = {}
	-- sets.AccDayWSEars = {}
	-- sets.DayWSEars = {}
     
	-- Idle sets
    sets.idle = {}

	sets.idle.Weak = set_combine(sets.idle, {--[[head="Twilight Helm",body="Twilight Mail"]]})
		
	sets.idle.Reraise = set_combine(sets.idle, {--[[head="Twilight Helm",body="Twilight Mail"]]})
           
    -- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {--[[head="Twilight Helm",body="Twilight Mail"]]})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {--[[head="Twilight Helm",body="Twilight Mail"]]})
		
	sets.defense.MEVA = {}
     
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.passive.Reraise = {--[[head="Twilight Helm",body="Twilight Mail"]]}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {--[[head="Frenzy Sallet"]]}
     
	-- Engaged sets
	sets.engaged = {}
	sets.engaged.HybridDT = set_combine(sets.engaged, {})

	sets.engaged.Acc = set_combine(sets.engaged, {})
	sets.engaged.Acc.HybridDT = set_combine(sets.engaged.HybridDT, {})

	sets.engaged.MaxAcc = set_combine(sets.engaged.Acc, {})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.Acc.HybridDT, {})

	sets.engaged.DW = set_combine(sets.engaged, {})
	sets.engaged.DW.HybridDT = set_combine(sets.engaged.DW, {})

	sets.engaged.DW.Acc = set_combine(sets.engaged.DW, {})
	sets.engaged.DW.Acc.HybridDT = set_combine(sets.engaged.DW.HybridDT, {})

	sets.engaged.DW.MaxAcc = set_combine(sets.engaged.DW.Acc, {})
	sets.engaged.DW.MaxAcc.HybridDT = set_combine(sets.engaged.DW.Acc.HybridDT, {})

	--Extra Special Sets
	
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {--[[head="Frenzy Sallet"]]}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})	
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'WAR' then
        set_macro_page(2, 15)
    elseif player.sub_job == 'SAM' then
        set_macro_page(3, 15)
    elseif player.sub_job == 'DNC' then
        set_macro_page(4, 15)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 15)
    else
        set_macro_page(5, 15)
    end
end