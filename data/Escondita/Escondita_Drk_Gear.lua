function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.WeaponskillMode:options('Match','Normal','SomeAcc','Acc','FullAcc','Fodder')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT', 'PDTReraise')
    state.MagicalDefenseMode:options('MDT', 'MDTReraise')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
	state.Weapons:options('Ragnarok','Zulfiqar')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','MP','Twilight'}
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
	
	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
	sets.Self_Refresh = {waist="Gishdubar Sash"}
						                   
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = {}

	sets.precast.WS.SomeAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Acc = set_combine(sets.precast.WS, {})
	sets.precast.WS.FullAcc = set_combine(sets.precast.WS, {})
	sets.precast.WS.Fodder = set_combine(sets.precast.WS, {})

    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	sets.precast.WS["Torcleaver"] = {}
	sets.precast.WS["Torcleaver"].SomeAcc = set_combine(sets.precast.WS["Torcleaver"], {})
	sets.precast.WS["Torcleaver"].Acc = set_combine(sets.precast.WS["Torcleaver"].SomeAcc, {})
	sets.precast.WS["Torcleaver"].FullAcc = set_combine(sets.precast.WS["Torcleaver"].FullAcc, {})
	sets.precast.WS["Torcleaver"].Fodder = set_combine(sets.precast.WS["Torcleaver"], {})
	
	sets.precast.WS["Resolution"] = {}
	sets.precast.WS["Resolution"].SomeAcc = set_combine(sets.precast.WS["Resolution"], {})
	sets.precast.WS["Resolution"].Acc = set_combine(sets.precast.WS["Resolution"].SomeAcc, {})
	sets.precast.WS["Resolution"].FullAcc = set_combine(sets.precast.WS["Resolution"].FullAcc, {})
	sets.precast.WS["Resolution"].Fodder = set_combine(sets.precast.WS["Resolution"], {})
	
	sets.precast.WS["Ground Strike"] = {}
	sets.precast.WS["Ground Strike"].SomeAcc = set_combine(sets.precast.WS["Ground Strike"], {})
	sets.precast.WS["Ground Strike"].Acc = set_combine(sets.precast.WS["Ground Strike"].SomeAcc, {})
	sets.precast.WS["Ground Strike"].FullAcc = set_combine(sets.precast.WS["Ground Strike"].FullAcc, {})
	sets.precast.WS["Ground Strike"].Fodder = set_combine(sets.precast.WS["Ground Strike"], {})
	
	sets.precast.WS["Shockwave"] = {}
	sets.precast.WS["Shockwave"].SomeAcc = set_combine(sets.precast.WS["Shockwave"], {})
	sets.precast.WS["Shockwave"].Acc = set_combine(sets.precast.WS["Shockwave"].SomeAcc, {})
	sets.precast.WS["Shockwave"].FullAcc = set_combine(sets.precast.WS["Shockwave"].FullAcc, {})
	sets.precast.WS["Shockwave"].Fodder = set_combine(sets.precast.WS["Shockwave"], {})
	
	sets.precast.WS["Herculean Slash"] = {}
	sets.precast.WS["Herculean Slash"].SomeAcc = set_combine(sets.precast.WS["Herculean Slash"], {})
	sets.precast.WS["Herculean Slash"].Acc = set_combine(sets.precast.WS["Herculean Slash"].SomeAcc, {})
	sets.precast.WS["Herculean Slash"].FullAcc = set_combine(sets.precast.WS["Herculean Slash"].FullAcc, {})
	sets.precast.WS["Herculean Slash"].Fodder = set_combine(sets.precast.WS["Herculean Slash"], {})
	
	sets.precast.WS["Cross Slash"] = {}
	sets.precast.WS["Cross Slash"].SomeAcc = set_combine(sets.precast.WS["Cross Slash"], {})
	sets.precast.WS["Cross Slash"].Acc = set_combine(sets.precast.WS["Cross Slash"].SomeAcc, {})
	sets.precast.WS["Cross Slash"].FullAcc = set_combine(sets.precast.WS["Cross Slash"].FullAcc, {})
	sets.precast.WS["Cross Slash"].Fodder = set_combine(sets.precast.WS["Cross Slash"], {})
	
	sets.precast.WS["Quietus"] = {}
	sets.precast.WS["Quietus"].SomeAcc = set_combine(sets.precast.WS["Quietus"], {})
	sets.precast.WS["Quietus"].Acc = set_combine(sets.precast.WS["Quietus"].SomeAcc, {})
	sets.precast.WS["Quietus"].FullAcc = set_combine(sets.precast.WS["Quietus"].FullAcc, {})
	sets.precast.WS["Quietus"].Fodder = set_combine(sets.precast.WS["Quietus"], {})
	
	sets.precast.WS["Entropy"] = {}
	sets.precast.WS["Entropy"].SomeAcc = set_combine(sets.precast.WS["Entropy"], {})
	sets.precast.WS["Entropy"].Acc = set_combine(sets.precast.WS["Entropy"].SomeAcc, {})
	sets.precast.WS["Entropy"].FullAcc = set_combine(sets.precast.WS["Entropy"].FullAcc, {})
	sets.precast.WS["Entropy"].Fodder = set_combine(sets.precast.WS["Entropy"], {})
	
	sets.precast.WS["Insurgency"] = {}
	sets.precast.WS["Insurgency"].SomeAcc = set_combine(sets.precast.WS["Insurgency"], {})
	sets.precast.WS["Insurgency"].Acc = set_combine(sets.precast.WS["Insurgency"].SomeAcc, {})
	sets.precast.WS["Insurgency"].FullAcc = set_combine(sets.precast.WS["Insurgency"].FullAcc, {})
	sets.precast.WS["Insurgency"].Fodder = set_combine(sets.precast.WS["Insurgency"], {})
	
	sets.precast.WS["Infernal Scythe"] = {}
	sets.precast.WS["Infernal Scythe"].SomeAcc = set_combine(sets.precast.WS["Infernal Scythe"], {})
	sets.precast.WS["Infernal Scythe"].Acc = set_combine(sets.precast.WS["Infernal Scythe"].SomeAcc, {})
	sets.precast.WS["Infernal Scythe"].FullAcc = set_combine(sets.precast.WS["Infernal Scythe"].FullAcc, {})
	sets.precast.WS["Infernal Scythe"].Fodder = set_combine(sets.precast.WS["Infernal Scythe"], {})
           
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

	sets.idle.Weak = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.idle.Reraise = set_combine(sets.idle, {head="Twilight Helm",body="Twilight Mail"})
           
    -- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, {head="Twilight Helm",body="Twilight Mail"})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, {head="Twilight Helm",body="Twilight Mail"})
		
	sets.defense.MEVA = {}
     
	sets.Kiting = {legs="Carmine Cuisses +1"}
	sets.passive.Reraise = {head="Twilight Helm",body="Twilight Mail"}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque"}
     
	-- Engaged sets
	sets.engaged = {}
    sets.engaged.SomeAcc = {}
	sets.engaged.Acc = {}
    sets.engaged.FullAcc = {}
    sets.engaged.Fodder = {}

	--Extra Special Sets
	
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Ragnarok = {main="Ragnarok",sub="Duplus Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Duplus Grip"}
	
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