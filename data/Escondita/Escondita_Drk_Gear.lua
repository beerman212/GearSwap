function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal')
    state.WeaponskillMode:options('Match','Normal')
    state.HybridMode:options('Normal')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal')
	state.Weapons:options('Zulfiqar','Ragnarok','Redemption','Caladbolg')
	state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	
	state.Passive = M{['description'] = 'Passive Mode','None'}
	state.DrainSwapWeaponMode = M{'Always','Never','300','1000'}

	gear.ankou = {}
	gear.ankou.tp = {name="Ankou's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','"Dbl.Atk."+10','Phys. dmg. taken-10%'}}
	gear.ankou.torc = {name="Ankou's Mantle",augments={'VIT+20','Accuracy+20 Attack+20','Weapon skill damage +10%'}}
	gear.ankou.reso = {name="Ankou's Mantle",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10'}}

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
	sets.weapons.Ragnarok = {main="Ragnarok",sub="Utu Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Utu Grip"}
	sets.weapons.Caladbolg = {main="Caladbolg",sub="Utu Grip"}
	sets.weapons.Redemption = {main="Stigma",sub="Utu Grip"}
	
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

	sets.precast.FC = {
		ammo="Sapience Orb",
		neck="Voltsurge Torque",ear1="Loquac. Earring",ear2="Etiolation Earring",
		ring1="Kishar Ring"
	}

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
    sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
		body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Apate Ring",
		back=gear.ankou.torc,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.MaxTP = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.AccMaxTP = {ear1="Thrud Earring",ear2="Lugra Earring +1"}
	sets.AccDayMaxTPWSEars = {ear1="Thrud Earring",ear2="Telos Earring"}
	sets.DayMaxTPWSEars = {ear1="Thrud Earring",ear2="Ishvara Earring"}
	sets.AccDayWSEars = {ear1="Thrud Earring",ear2="Telos Earring"}
	sets.DayWSEars = {ear1="Thrud Earring",ear2="Moonshade Earring"}

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
	-- Great Sword
	sets.precast.WS["Torcleaver"] = set_combine(sets.precast.WS, {
		ear2="Moonshade Earring",
		waist="Sailfi Belt +1"
	})
	
	sets.precast.WS["Resolution"] = set_combine(sets.precast.WS, {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",ear2="Moonshade Earring",
		ring2="Flamma Ring",
		back=gear.ankou.reso,feet="Flam. Gambieras +2"
	})

	sets.DayMaxTPWSEars.Resolution = {ear1="Brutal Earring",ear2="Thrud Earring"}
	sets.AccDayWSEars.Resolution = {ear1="Thrud Earring",ear2="Telos Earring"}
	sets.DayWSEars.Resolution = {ear1="Thrud Earring",ear2="Moonshade Earring"}
	
	sets.precast.WS["Ground Strike"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Shockwave"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Herculean Slash"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS.Scourge = set_combine(sets.precast.WS, {ear2="Ishvara Earring",waist="Sailfi Belt +1"})

	-- Scythe
	sets.precast.WS["Cross Slash"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Quietus"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Entropy"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Insurgency"] = set_combine(sets.precast.WS, {})
	
	sets.precast.WS["Infernal Scythe"] = set_combine(sets.precast.WS, {})
           
     -- Sets to return to when not performing an action.
           
     -- Resting sets
     sets.resting = {}
     
	-- Idle sets
           
    sets.idle = {
		ammo="Staunch Tathlum +1",
		head="Valorous Mask",neck="Twilight Torque",ear1="Odnowa Earring +1",ear2="Etiolation Earring",
		body="Jumalik Mail",hands="Sulev. Gauntlets +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back=gear.ankou.tp,waist="Flume Belt +1",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}
		
    sets.idle.PDT = {}

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
	sets.buff.Sleep = {neck="Vim Torque"}
     
	-- Engaged sets
	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.tp,hands="Flam. Manopolas +2",ring1="Petrov Ring",ring2="Flamma Ring",
		back=gear.ankou.tp,waist="Sailfi Belt +1",legs=gear.odyssean.cuisses.ta,feet="Flam. Gambieras +2"
	}

	--Extra Special Sets
	
	sets.buff.Souleater = {}
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {head="Frenzy Sallet"}
	sets.latent_refresh = {waist="Fucho-no-Obi"}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	
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