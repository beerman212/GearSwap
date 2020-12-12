function user_setup()
	-- Options: Override default values
    state.OffenseMode:options('Normal','MaxAcc')
    state.WeaponskillMode:options('Match','Normal','MaxAcc')
    state.HybridMode:options('Normal','HybridDT')
    state.PhysicalDefenseMode:options('PDT')
    state.MagicalDefenseMode:options('MDT')
	state.ResistDefenseMode:options('MEVA')
	state.IdleMode:options('Normal', 'PDT','Refresh','Reraise')
    state.ExtraMeleeMode = M{['description']='Extra Melee Mode','None'}
	state.Passive = M{['description'] = 'Passive Mode','None','Twilight'}
	state.Weapons:options('Chango','Zulfiqar','Ragnarok','Naegling','NaeglingDW','Farsha','FarshaDW','ProcSword','ProcClub','ProcStaff','ProcGreatKatana','ProcDagger','ProcScythe','ProcKatana','ProcPolearm','ProcGreatsword')

	gear.cichol = {}
	gear.cichol.tp = {name="Cichol's Mantle",augments={'DEX+20','Accuracy+20 Attack+20','Accuracy+10','"Dbl.Atk."+10',}}
	gear.cichol.resolution = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
	gear.cichol.upheaval = {name="Cichol's Mantle",augments={'VIT+20','Accuracy+20 Attack+20','VIT+10','Weapon skill damage +10%'}}
	gear.cichol.justice = {name="Cichol's Mantle",augments={'STR+20','Accuracy+20 Attack+20','STR+10','Weapon skill damage +10%'}}

	-- Additional local binds
	send_command('bind ^` input /ja "Hasso" <me>')
	send_command('bind !` input /ja "Seigan" <me>')
	send_command('bind @` gs c cycle SkillchainMode')
	send_command('bind !r gs c weapons Ragnarok;gs c update')
	
	select_default_macro_book()
end

-- Define sets and vars used by this job file.
function init_gear_sets()
	--------------------------------------
	-- Start defining the sets
	--------------------------------------
	
	-- Weapons sets
	sets.weapons.Chango = {main="Chango",sub="Utu Grip"}
	sets.weapons.Ragnarok = {main="Ragnarok",sub="Utu Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Utu Grip"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Shield"}
	sets.weapons.NaeglingDW = {main="Naegling",sub="Firangi"}
	sets.weapons.Farsha = {main="Splinter",sub="Blurred Shield"}
	sets.weapons.FarshaDW = {main="Splinter",sub="Firangi"}

	-- Precast Sets

	sets.Enmity = {
		ammo="Sapience Orb",
		head="Pummeler's Mask +2",ear1="Friomisi Earring",
		hands="Pumm. Mufflers +2",ring1="Petrov Ring",
	}

	sets.Knockback = {}
	sets.passive.Twilight = {--[[head="Twilight Helm",body="Twilight Mail"]]}

	-- Precast sets to enhance JAs
	sets.precast.JA['Berserk'] = {body="Pumm. Lorica +2",back="Cichol's Mantle",feet="Agoge Calligae"}
	sets.precast.JA['Warcry'] = {head="Agoge Mask"}
	sets.precast.JA['Defender'] = {}
	sets.precast.JA['Aggressor'] = {head="Pummeler's Mask +2",body="Agoge Lorica"}
	sets.precast.JA['Mighty Strikes'] = {hands="War. Mufflers +2"}
	sets.precast.JA["Warrior's Charge"] = {legs="War. Cuisses +2"}
	sets.precast.JA['Tomahawk'] = {ammo="Thr. Tomahawk",feet="Agoge Calligae"}
	sets.precast.JA['Retaliation'] = {}
	sets.precast.JA['Restraint'] = {}
	sets.precast.JA['Blood Rage'] = {body="Boii Lorica +1"}
	sets.precast.JA['Brazen Rush'] = {}
	sets.precast.JA['Provoke'] = set_combine(sets.Enmity,{})
					
	-- Waltz set (chr and vit)
	sets.precast.Waltz = {}
					
	-- Don't need any special gear for Healing Waltz.
	sets.precast.Waltz['Healing Waltz'] = {}
			
	sets.precast.Step = {}

	sets.precast.Flourish1 = {}
			
	-- Fast cast sets for spells

	sets.precast.FC = {ammo="Sapience Orb",neck="Voltsurge Torque",ear1="Enchntr. Earring +1",ear2="Loquac. Earring",hands="Leyline Gloves",feet="Odyssean Greaves"}

	sets.precast.FC.Utsusemi = set_combine(sets.precast.FC, {neck="Magoraga Beads"})

	-- Midcast Sets
	sets.midcast.FastRecast = set_combine(sets.precast.FC, {waist="Ioskeha Belt",legs="Pumm. Cuisses +2"})

	sets.midcast.Utsusemi = set_combine(sets.midcast.FastRecast, {})
					
	sets.midcast.Cure = {}

	sets.Self_Healing = {waist="Gishdubar Sash"}
	sets.Cure_Received = {waist="Gishdubar Sash"}
											
	-- Weaponskill sets
	-- Default set for any weaponskill that isn't any more specifically defined
	sets.precast.WS = {
		ammo="Knobkierrie",
		head=gear.odyssean.helm.wsd,neck="Fotia Gorget",ear1="Thrud Earring",ear2="Moonshade Earring",
		body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Ilabrat Ring",
		back=gear.cichol.justice,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2"
	}

	sets.MaxTP = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.DayWSEars = {ear1="Thrud Earring",ear2="Moonshade Earring"} -- I think this needs to be in here even though it's the same as the base set.
	sets.DayMaxTPWSEars = {ear1="Thrud Earring",ear2="Ishvara Earring"}

	-- sets.precast.WS = {
	-- 	ammo="Seeth. Bomblet +1",
	-- 	head="Flam. Zucchetto +2",neck="Fotia Gorget",ear1="Brutal Earring",ear2="Cessance Earring",
	-- 	body="Pumm. Lorica +2",hands="Sulev. Gauntlets +2",ring1="Ifrit Ring",ring2="Flamma Ring",
	-- 	back=gear.cichol.resolution,waist="Fotia Belt",legs="Sulev. Cuisses +2",feet="Pumm. Calligae +3"
	-- }

	-- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.

	-- Great Sword
	sets.precast.WS.Resolution = set_combine(sets.precast.WS, {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",ear1="Lugra Earring +1",
		body="Dagon Breast.",ring2="Flamma Ring",
		back=gear.cichol.resolution,legs="Argosy Breeches +1",feet="Pumm. Calligae +3"
	})

	sets.MaxTP.Resolution = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.DayWSEars.Resolution = {ear1="Thrud Earring",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars.Resolution = {ear1="Brutal Earring",ear2="Thrud Earring"}

	sets.precast.WS.Scourge = set_combine(sets.precast.WS, {
		neck="Caro Necklace",ear1="Lugra Earring +1",ear2="Thrud Earring",
		waist="Caudata Belt"
	})

	sets.DayWSEars.Scourge = {ear1="Thrud Earring",ear2="Ishvara Earring"}

	sets.precast.WS["Ground Strike"] = set_combine(sets.precast.WS["Scourge"], {
		ear1="Thrud Earring",ear2="Moonshade Earring"
	})

	sets.precast.WS.Shockwave = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",
		hands="Flam. Manopolas +2",ring1="Stikini Ring",ring2="Flamma Ring",
		waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})

	sets.precast.WS["Herculean Slash"] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Sanctity Necklace",ear1="Friomisi Earring",
		hands="Flam. Manopolas +2",ring1="Shiva Ring +1",ring2="Gelatinous Ring +1",
		back=gear.cichol.upheaval,waist="Eschan Stone",legs="Flamma Dirs +2",feet="Flam. Gambieras +2"
	})

	sets.MaxTP["Herculean Slash"] = {ear1="Friomisi Earring",ear2="Thrud Earring"}

	-- Great Axe
	sets.precast.WS.Upheaval = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Caro Necklace",ear1="Lugra Earring +1",
		back=gear.cichol.upheaval,waist="Caudata Belt"
	})

	sets.MaxTP.Upheaval = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.DayWSEars.Upheaval = {ear1="Thrud Earring",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars.Upheaval = {ear1="Thrud Earring",ear2="Ishvara Earring"}

	sets.precast.WS["King's Justice"] = set_combine(sets.precast.WS.Upheaval, {back=gear.cichol.justice})

	sets.MaxTP["King's Justice"] = sets.MaxTP.Upheaval
	sets.DayWSEars["King's Justice"] = sets.DayWSEars.Upheaval
	sets.DayMaxTPWSEars["King's Justice"] = sets.DayMaxTPWSEars.Upheaval

	sets.precast.WS["Raging Rush"] = set_combine(sets.precast.WS.Resolution, {
		--ammo="Yetshila",
		head=gear.valorous.mask.crit,ear1="Lugra Earring +1",
		hands="Flam. Manopolas +2",
		feet="Boii Calligae +1"
	})

	sets.MaxTP["Raging Rush"] = {ear1="Lugra Earring +1",ear2="Lugra Earring"}
	sets.DayWSEars["Raging Rush"] = {ear1="Brutal Earring",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars["Raging Rush"] = {ear1="Brutal Earring",ear2="Thrud Earring"}

	sets.precast.WS["Ukko's Fury"] = set_combine(sets.precast.WS, {
		head="Flam. Zucchetto +2",neck="Caro Necklace +2",ear1="Lugra Earring +1",
		body="Dagon Breast.",hands="Flam. Manopolas +2",
		back=gear.cichol.justice,feet="Boii Calligae +1"
	})

	sets.MaxTP["Ukko's Fury"] = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.DayWSEars["Ukko's Fury"] = {ear1="Thrud Earring",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars["Ukko's Fury"] = {ear1="Brutal Earring",ear2="Thrud Earring"}

	sets.precast.WS["Steel Cyclone"] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",waist="Caudata Belt"
	})

	sets.MaxTP["Steel Cyclone"] = {ear1="Lugra Earring +1",ear2="Thrud Earring"}
	sets.DayWSEars["Steel Cyclone"] = {ear1="Thrud Earring",ear2="Moonshade Earring"}
	sets.DayMaxTPWSEars["Steel Cylcone"] = {ear1="Thrud Earring",ear2="Ishvara Earring"}

	sets.precast.WS["Fell Cleave"] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",ear1="Lugra Earring +1",ear2="Thrud Earring",
		waist="Caudata Belt"
	})

	sets.DayWSEars = {ear1="Thrud Earring",ear2="Ishvara Earring"}

	sets.precast.WS["Full Break"] = set_combine(sets.precast.WS.Shockwave, {})

	sets.MaxTP["Full Break"] = sets.MaxTP.Shockwave
	sets.DayWSEars["Full Break"] = sets.DayWSEars.Shockwave
	sets.DayMaxTPWSEars["Full Break"] = sets.DayMaxTPWSEars.Shockwave

	sets.precast.WS["Armor Break"] = sets.precast.WS["Full Break"]
	sets.precast.WS["Shield Break"] = sets.precast.WS["Full Break"]
	sets.precast.WS["Weapon Break"] = sets.precast.WS["Full Break"]

	-- Sword
	sets.precast.WS["Savage Blade"] = set_combine(sets.precast.WS, {
		neck="Caro Necklace",ring2="Apate Ring",
		waist="Caudata Belt"
	})

	sets.precast.WS["Vorpal Blade"] = set_combine(sets.precast.WS["Raging Rush"], {})

	sets.MaxTP["Vorpal Blade"] = sets.MaxTP["Raging Rush"]
	sets.DayWSEars["Vorpal Blade"] = sets.DayWSEars["Raging Rush"]
	sets.DayMaxTPWSEars["Vorpal Blade"] = sets.DayMaxTPWSEars["Raging Rush"]

	sets.precast.WS.Requiescat = set_combine(sets.precast.WS.Resolution, {
		ammo="Seeth. Bomblet +1",
	})

	sets.MaxTP.Requiescat = sets.MaxTP.Resolution
	sets.DayWSEars.Requiescat = sets.DayWSEars.Resolution
	sets.DayMaxTPWSEars.Requiescat = sets.DayMaxTPWSEars.Resolution
	
	sets.precast.WS["Sanguine Blade"] = set_combine(sets.precast.WS["Herculean Slash"], {
		head="Pixie Hairpin +1",ear2="Thrud Earring",
		ring2="Archon Ring"
	})

	-- Axe
	sets.precast.WS.Decimation = set_combine(sets.precast.WS.Resolution, {})

	sets.MaxTP.Decimation = sets.MaxTP.Resolution
	sets.DayWSEars.Decimation = sets.DayWSEars.Resolution
	sets.DayMaxTPWSEars.Decimation = sets.DayMaxTPWSEars.Resolution

	sets.precast.WS.Ruinator = set_combine(sets.precast.WS.Resolution, {})

	sets.MaxTP.Ruinator = sets.MaxTP.Resolution
	sets.DayWSEars.Ruinator = sets.DayWSEars.Resolution
	sets.DayMaxTPWSEars.Ruinator = sets.DayMaxTPWSEars.Resolution

	sets.precast.WS.Cloudsplitter = set_combine(sets.precast.WS["Herculean Slash"], {})

	sets.MaxTP.Cloudsplitter = sets.MaxTP["Herculean Slash"]
	
	sets.precast.WS["Mistral Axe"] = set_combine(sets.precast.WS["Savage Blade"], {})
	sets.precast.WS.Calamity = sets.precast.WS["Mistral Axe"]
	
	-- Polearm
	sets.precast.WS["Impulse Drive"] = set_combine(sets.precast.WS, {})
	sets.precast.WS.Stardiver = set_combine(sets.precast.WS.Resolution, {})
	sets.precast.WS["Sonic Thrust"] = set_combine(sets.precast.WS, {})

	-- Swap to these on Moonshade using WS if at 3000 TP
	-- sets.MaxTP = {}
	-- sets.AccMaxTP = {}
	-- sets.AccDayMaxTPWSEars = {}
	-- sets.DayMaxTPWSEars = {}
	-- sets.AccDayWSEars = {}
	-- sets.DayWSEars = {}

	-- Sets to return to when not performing an action.
		
	-- Resting sets
	sets.resting = {}
			
	-- Idle sets
	sets.idle = {
		ammo="Staunch Tathlum +1",
		head=gear.valorous.mask.crit,neck="Sanctity Necklace",ear1="Etiolation Earring",ear2="Eabani Earring",
		body="Sulevia's Plate. +1",hands="Pumm. Mufflers +2",ring1="Defending Ring",ring2="Gelatinous Ring +1",
		back="Solemnity Cape",waist="Flume Belt +1",legs="Sulev. Cuisses +2",feet="Sulev. Leggings +2",
	}
		
	sets.idle.Weak = set_combine(sets.idle, sets.passive.Twilight, {})
		
	sets.idle.Reraise = set_combine(sets.idle, sets.passive.Twilight, {})

	-- Defense sets
	sets.defense.PDT = {}
		
	sets.defense.PDTReraise = set_combine(sets.defense.PDT, sets.passive.Twilight, {})

	sets.defense.MDT = {}
		
	sets.defense.MDTReraise = set_combine(sets.defense.MDT, sets.passive.Twilight, {})
		
	sets.defense.MEVA = {}

	sets.Kiting = {}
	sets.Reraise = sets.passive.Twilight
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Sleep = {neck="Vim Torque"}
		
	-- Engaged sets
	sets.engaged = {
		ammo="Aurgelmir Orb",
		head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
		body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Flamma Ring",
		back=gear.cichol.tp,waist="Ioskeha Belt",legs="Pumm. Cuisses +2",feet="Pumm. Calligae +3"
	}
	sets.engaged.HybridDT = set_combine(sets.engaged, {
		ring1="Defending Ring",ring2="Gelatinous Ring +1"
	})

	sets.engaged.MaxAcc = set_combine(sets.engaged, {
		ear1="Zennaroi Earring",body="Pumm. Lorica +2",hands="Pumm. Mufflers +2"
	})
	sets.engaged.MaxAcc.HybridDT = set_combine(sets.engaged.HybridDT, {
		head="Pummeler's Mask +2",ear1="Zennaroi Earring",body="Pumm. Lorica +2",hands="Pumm. Mufflers +2"
	})

	sets.engaged.Ragnarok = set_combine(sets.engaged, {})
	sets.engaged.Ragnarok.HybridDT = set_combine(sets.engaged.Ragnarok, {})

	sets.engaged.Ragnarok.MaxAcc = set_combine(sets.engaged.Ragnarok, {})
	sets.engaged.Ragnarok.MaxAcc.HybridDT = set_combine(sets.engaged.Ragnarok.HybridDT, {})

	-- sets.engaged.Ragnarok = {
	-- 	ammo="Seething Bomblet",
	-- 	head="Flam. Zucchetto +2",neck="Clotharius Torque",ear1="Brutal Earring",ear2="Cessance Earring",
	-- 	body=gear.valorous.mail.tp,hands="Sulev. Gauntlets +2",ring1="Petrov Ring",ring2="Flamma Ring",
	-- 	back=gear.cichol.tp,waist="Ioskeha Belt",legs="Pumm. Cuisses +2",feet="Pumm. Calligae +3"
	-- }
	
	--Extra Special Sets
	
	sets.buff.Doom = set_combine(sets.buff.Doom, {})
	sets.buff.Retaliation = {}
	sets.buff.Restraint = {}
	sets.TreasureHunter = set_combine(sets.TreasureHunter, {})
	
	-- Weapons sets
	sets.weapons.Chango = {main="Chango",sub="Utu Grip"}
	sets.weapons.Ragnarok = {main="Ragnarok",sub="Utu Grip"}
	sets.weapons.Zulfiqar = {main="Zulfiqar",sub="Utu Grip"}
	sets.weapons.Naegling = {main="Naegling",sub="Blurred Shield"}
	sets.weapons.NaeglingDW = {main="Naegling",sub="Firangi"}
	sets.weapons.Farsha = {main="Splinter",sub="Blurred Shield"}
	sets.weapons.FarshaDW = {main="Splinter",sub="Firangi"}
end
	
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'SAM' then
        set_macro_page(1, 1)
    elseif player.sub_job == 'DNC' then
        set_macro_page(2, 1)
    elseif player.sub_job == 'NIN' then
        set_macro_page(3, 1)
    elseif player.sub_job == 'THF' then
        set_macro_page(4, 1)
    else
        set_macro_page(10, 1)
    end
end